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
    $sql = "SELECT r.id_rozgrywki, r.data_rozgrywki, r.tytul_rozgrywki, r.czas_trwania, r.notatka_do_gry, p.tytul_planszowki
            FROM rozgrywka r
            JOIN planszowka p ON r.id_planszowki = p.id_planszowki
            JOIN uczestnicy_rozgrywki u ON r.id_rozgrywki = u.id_rozgrywki
            WHERE u.id_uzytkownika = :userId
            ORDER BY r.data_rozgrywki DESC";

    $stmt = $pdo->prepare($sql);
    $stmt->execute(['userId' => $userId]);
    $rozgrywki = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
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
    <style>
        /* Style dla paska akcji i sortowania */
        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .sort-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .sort-group select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-family: inherit;
        }

        .btn-details {
            display: inline-block;
            padding: 6px 12px;
            background-color: #4f46e5;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 0.85rem;
            transition: background 0.3s;
        }

        .btn-details:hover  {
            background-color: #3730a3;
        }
    </style>
    </style>
</head>

<body>

    <div class="dashboard-wrapper">

        <?php include 'sidebar.php'; ?>

        <div class="main-content">

            <div class="top-header">
                <button type="button" id="sidebarCollapse" class="toggle-btn">
                    ☰ Menu
                </button>
                <h2>Twoje Rozgrywki</h2>
            </div>

            <div class="actions-bar">
                <button class="btn-small" onclick="window.location.href='../add/dodaj_rozgrywke.php'">Dodaj nową rozgrywkę</button>

                <div class="sort-group">
                    <label for="sortOrder">Sortuj według:</label>
                    <select id="sortOrder" onchange="applySort()">
                        <option value="date_desc">Data (od najnowszych)</option>
                        <option value="date_asc">Data (od najstarszych)</option>
                        <option value="game_asc">Gra (A-Z)</option>
                        <option value="game_desc">Gra (Z-A)</option>
                        <option value="time_desc">Czas (najdłuższe)</option>
                        <option value="time_asc">Czas (najkrótsze)</option>
                    </select>
                </div>
            </div>

            <main>
                <?php if (!empty($rozgrywki)): ?>
                    <table>
                        <thead>
                            <tr>
                                <th>Tytuł</th>
                                <th>Data</th>
                                <th>Gra</th>
                                <th>Czas trwania</th>
                                <th>Akcja</th>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                            <?php foreach ($rozgrywki as $gra): ?>
                                <?php
                                // Przygotowanie danych do sortowania
                                $sortDate = strtotime($gra['data_rozgrywki']); // Timestamp
                                $sortGame = strtolower($gra['tytul_planszowki']); // Małe litery
                                $sortTime = (int)$gra['czas_trwania'];
                                ?>
                                <tr class="game-row"
                                    data-date="<?= $sortDate ?>"
                                    data-game="<?= htmlspecialchars($sortGame) ?>"
                                    data-time="<?= $sortTime ?>">

                                    <td><?= htmlspecialchars($gra['tytul_rozgrywki'] ?? '') ?></td>
                                    <td><?= htmlspecialchars(date("d.m.Y", strtotime($gra['data_rozgrywki']))) ?></td>
                                    <td><strong><?= htmlspecialchars($gra['tytul_planszowki']) ?></strong></td>
                                    <td><?= htmlspecialchars($gra['czas_trwania']) ?> min</td>
                                    <td><a href="rozgrywka.php?id=<?= $gra['id_rozgrywki'] ?>" class="btn-details"> Wyświetl szczegóły </a></td>
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

        function applySort() {
            let sortBy = document.getElementById('sortOrder').value;
            let tableBody = document.getElementById('tableBody');
            let rows = Array.from(tableBody.querySelectorAll('.game-row'));

            rows.sort((a, b) => {
                switch (sortBy) {
                    case 'date_desc': // Od najnowszych
                        return parseInt(b.dataset.date) - parseInt(a.dataset.date);
                    case 'date_asc': // Od najstarszych
                        return parseInt(a.dataset.date) - parseInt(b.dataset.date);

                    case 'game_asc': // A-Z
                        return a.dataset.game.localeCompare(b.dataset.game);
                    case 'game_desc': // Z-A
                        return b.dataset.game.localeCompare(a.dataset.game);

                    case 'time_desc': // Najdłuższe
                        return parseInt(b.dataset.time) - parseInt(a.dataset.time);
                    case 'time_asc': // Najkrótsze
                        return parseInt(a.dataset.time) - parseInt(b.dataset.time);

                    default:
                        return 0;
                }
            });

            // Ponowne wstawienie posortowanych wierszy
            rows.forEach(row => tableBody.appendChild(row));
        }
    </script>
</body>

</html>