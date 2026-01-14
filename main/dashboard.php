<?php
session_start();
// Zmiana ścieżki do API (wychodzimy z 'main' do roota, potem do 'api')
require_once '../api/db.php';

// 1. Sprawdzenie logowania
if (!isset($_SESSION['user_id'])) {
    // Przekierowanie do logowania (wychodzimy z 'main', wchodzimy do 'login')
    header("Location: ../login/index.php");
    exit();
}

$userName = $_SESSION['username'];

// 2. Pobranie danych
try {
    $sql = "SELECT tytul_planszowki, nazwa_statusu, ocena, komentarz
            FROM widok_kolekcji_uzytkownika
            WHERE nazwa_uzytkownika = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$userName]);
    $kolekcja = $stmt->fetchAll();
} catch (PDOException $e) {
    die("Błąd pobierania kolekcji: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Moja Kolekcja - Planszówki</title>
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
                <h2>Witaj, <?php echo htmlspecialchars($userName); ?>!</h2>
            </div>

            <div class="actions">
                <a href="../add/dodaj_gre.php" class="btn-small">Dodaj nową grę do bazy</a>
                <a href="../add/dodaj_do_kolekcji.php" class="btn-small">Dodaj grę do kolekcji</a>
            </div>

            <main>
                <?php if (count($kolekcja) > 0): ?>
                    <table>
                        <thead>
                            <tr>
                                <th>Tytuł gry</th>
                                <th>Status</th>
                                <th>Twoja Ocena</th>
                                <th>Komentarz</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($kolekcja as $gra): ?>
                                <tr>
                                    <td><strong><?php echo htmlspecialchars($gra['tytul_planszowki']); ?></strong></td>

                                    <td>
                                        <?php echo htmlspecialchars($gra['nazwa_statusu']); ?>
                                    </td>

                                    <td>
                                        <?php
                                        if ($gra['ocena']) {
                                            echo htmlspecialchars($gra['ocena']) . "/10";
                                        } else {
                                            echo "-";
                                        }
                                        ?>
                                    </td>
                                    <td><?php echo htmlspecialchars($gra['komentarz'] ?? ''); ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                <?php else: ?>
                    <div class="empty-msg">
                        <h3>Twoja kolekcja jest pusta!</h3>
                        <p>Skorzystaj z przycisków powyżej, aby dodać pierwsze gry.</p>
                    </div>
                <?php endif; ?>
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