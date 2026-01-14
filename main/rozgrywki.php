<?php
// main/rozgrywki.php
session_start();
require_once '../api/db.php';

// 1. Sprawdzenie logowania
if (!isset($_SESSION['user_id'])) {
    header("Location: ../login/index.php");
    exit();
}

$userId = $_SESSION['user_id'];
$rozgrywki = [];
$error = "";

try {
    // Pobieramy rozgrywki, w których użytkownik brał udział
    $sql = "SELECT r.id_rozgrywki, r.data_rozgrywki, r.czas_trwania, r.notatka_do_gry, p.tytul_planszowki
            FROM rozgrywka r
            JOIN planszowka p ON r.id_planszowki = p.id_planszowki
            JOIN uczestnicy_rozgrywki u ON r.id_rozgrywki = u.id_rozgrywki
            WHERE u.id_uzytkownika = :userId
            ORDER BY r.data_rozgrywki DESC";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['userId' => $userId]);
    $rozgrywki = $stmt->fetchAll(PDO::FETCH_ASSOC);

} catch (PDOException $e) {
    // W razie błędu można go zalogować lub wyświetlić komunikat
    $error = "Błąd pobierania danych: " . $e->getMessage();
}
?>

<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <title>Moje Rozgrywki</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&family=Tilt+Neon&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
</head>

<body>

    <div class="dashboard-wrapper">

        <?php include '../templates/sidebar.php'; ?>

        <div class="main-content">

            <div class="top-header">
                <button type="button" id="sidebarCollapse" class="toggle-btn">
                    ☰ Menu
                </button>
                <h2>Twoje Rozgrywki</h2>
            </div>

            <div class="actions">
                <button class="btn-small" onclick="window.location.href='../add/dodaj_rozgrywke.php'">Dodaj nową rozgrywkę</button>
            </div>

            <main>
                <?php if (!empty($rozgrywki)): ?>
                    <table>
                        <thead>
                            <tr>
                                <th>Data</th>
                                <th>Gra</th>
                                <th>Czas trwania</th>
                                <th>Notatka</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($rozgrywki as $gra): ?>
                                <tr>
                                    <td><?= htmlspecialchars(date("d.m.Y", strtotime($gra['data_rozgrywki']))) ?></td>
                                    <td><strong><?= htmlspecialchars($gra['tytul_planszowki']) ?></strong></td>
                                    <td><?= htmlspecialchars($gra['czas_trwania']) ?> min</td>
                                    <td><?= htmlspecialchars($gra['notatka_do_gry'] ?? '') ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                <?php else: ?>
                    <div class="empty-msg">
                        <h3>Brak zarejestrowanych rozgrywek</h3>
                        <p>Kliknij przycisk powyżej, aby dodać pierwszą grę.</p>
                    </div>
                <?php endif; ?>
                
                <?php if (!empty($error)) echo "<p class='error'>$error</p>"; ?>
            </main>

        </div>
    </div>
    <script>
        document.getElementById('sidebarCollapse').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('collapsed');
        });
    </script>
</body>

</html>