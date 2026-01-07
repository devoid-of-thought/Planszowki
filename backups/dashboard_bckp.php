<?php
session_start();
require_once 'api/db.php'; // Upewnij się, że masz ten plik skonfigurowany

// 1. Sprawdzenie logowania
if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$userName = $_SESSION['username'];

// 2. Pobranie danych z Twojego WIDOKU SQL (View)
// Widok_Kolekcji_Uzytkownika łączy tabele: Planszowka, Status i Uzytkownik
try {
    $sql = "SELECT tytul_planszowki, nazwa_statusu, ocena, komentarz 
            FROM Widok_Kolekcji_Uzytkownika 
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
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Dodatkowy styl dla tabeli kolekcji */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #007bff; color: white; }
        tr:nth-child(even) { background-color: #f2f2f5; }
        tr:hover { background-color: #e6e6e6; }
        .empty-msg { text-align: center; color: #666; margin-top: 20px; }
        .actions { margin-bottom: 20px; }
        .btn-small { padding: 5px 10px; font-size: 0.9em; background-color: #28a745; text-decoration: none; color: white; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container" style="width: 800px;"> <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2>Kolekcja gracza: <?php echo htmlspecialchars($userName); ?></h2>
            <a href="logout.php" style="color: red;">Wyloguj się</a>
        </header>

        <div class="actions">
            <a href="dodaj_gre.php" class="btn-small">➕ Dodaj nową grę do bazy</a>
            <a href="dodaj_do_kolekcji.php" class="btn-small" style="background-color: #17a2b8;">📥 Dodaj grę do kolekcji</a>
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
                            
                            <td style="
                                color: <?php 
                                    echo match($gra['nazwa_statusu']) {
                                        'Posiadam' => 'green',
                                        'Chcę zagrać' => 'blue',
                                        'Sprzedane' => 'gray',
                                        default => 'black'
                                    };
                                ?>; font-weight: bold;">
                                <?php echo htmlspecialchars($gra['nazwa_statusu']); ?>
                            </td>

                            <td>
                                <?php 
                                if ($gra['ocena']) {
                                    echo htmlspecialchars($gra['ocena']) . "/10"; 
                                } else {
                                    echo "<span style='color: #ccc;'>-</span>";
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
                    <h3>Twoja kolekcja jest pusta! 🎲</h3>
                    <p>Skorzystaj z przycisków powyżej, aby dodać pierwsze gry.</p>
                </div>
            <?php endif; ?>
        </main>
    </div>
</body>
</html>