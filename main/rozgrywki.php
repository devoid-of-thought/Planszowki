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
    // ZMIANA: Dodano JOIN do pobrania listy WSZYSTKICH graczy w danej rozgrywce
    $sql = "SELECT 
                r.id_rozgrywki, 
                r.data_rozgrywki, 
                r.tytul_rozgrywki, 
                r.czas_trwania, 
                r.notatka_do_gry, 
                p.tytul_planszowki,
                GROUP_CONCAT(u_all.nazwa_uzytkownika ORDER BY u_all.nazwa_uzytkownika ASC SEPARATOR ', ') as lista_graczy
            FROM rozgrywka r
            JOIN planszowka p ON r.id_planszowki = p.id_planszowki
            JOIN uczestnicy_rozgrywki ur_me ON r.id_rozgrywki = ur_me.id_rozgrywki
            LEFT JOIN uczestnicy_rozgrywki ur_all ON r.id_rozgrywki = ur_all.id_rozgrywki
            LEFT JOIN uzytkownik u_all ON ur_all.id_uzytkownika = u_all.id_uzytkownika
            WHERE ur_me.id_uzytkownika = :userId
            GROUP BY r.id_rozgrywki
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

            <div class="actions">
                <button class="btn-small" onclick="window.location.href='../add/dodaj_rozgrywke.php'">Dodaj nową rozgrywkę</button>
            </div>

            <div class="filters">
                <div class="filter-group game-search">
                    <label>Szukaj gry:</label>
                    <input type="text" id="filterGame" placeholder="Np. Brass..." onkeyup="applyFilters()">
                </div>

                <div class="filter-group player-search">
                    <label>Szukaj gracza:</label>
                    <input type="text" id="filterPlayer" placeholder="Np. Jan..." onkeyup="applyFilters()">
                </div>

                <div class="filter-group sort-select">
                    <label>Sortuj według:</label>
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
                    <table class="rozgrywki-table">
                        <thead>
                            <tr>
                                <th>Tytuł sesji</th>
                                <th>Data</th>
                                <th>Gra</th>
                                <th>Gracze</th>
                                <th>Czas</th>
                                <th>Akcja</th>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                            <?php foreach ($rozgrywki as $gra): ?>
                                <?php
                                // Przygotowanie danych do sortowania i filtrowania
                                $sortDate = strtotime($gra['data_rozgrywki']);
                                $sortGame = strtolower($gra['tytul_planszowki']);
                                $sortTime = (int)$gra['czas_trwania'];
                                // Dodajemy listę graczy do atrybutu (do filtrowania JS)
                                $filterPlayers = strtolower($gra['lista_graczy']);
                                ?>
                                <tr class="game-row"
                                    data-date="<?= $sortDate ?>"
                                    data-game="<?= htmlspecialchars($sortGame) ?>"
                                    data-players="<?= htmlspecialchars($filterPlayers) ?>"
                                    data-time="<?= $sortTime ?>">

                                    <td><?= htmlspecialchars($gra['tytul_rozgrywki'] ?? '-') ?></td>
                                    <td><?= htmlspecialchars(date("d.m.Y", strtotime($gra['data_rozgrywki']))) ?></td>
                                    <td><strong><?= htmlspecialchars($gra['tytul_planszowki']) ?></strong></td>
                                    
                                    <td style="font-size: 0.9em; color: #555;">
                                        <?= htmlspecialchars($gra['lista_graczy']) ?>
                                    </td>
                                    
                                    <td><?= htmlspecialchars($gra['czas_trwania']) ?> min</td>
                                    <td style="text-align: right;">
                                        <a href="rozgrywka.php?id_rozgrywki=<?= $gra['id_rozgrywki'] ?>" class="btn-small details">Szczegóły</a>
                                    </td>
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

        // Funkcja filtrująca
        function applyFilters() {
            let gameInput = document.getElementById('filterGame').value.toLowerCase();
            let playerInput = document.getElementById('filterPlayer').value.toLowerCase();
            
            let rows = document.querySelectorAll('.game-row');

            rows.forEach(row => {
                let gameText = row.getAttribute('data-game');
                let playersText = row.getAttribute('data-players');

                let matchGame = gameText.includes(gameInput);
                let matchPlayer = playersText.includes(playerInput);

                if (matchGame && matchPlayer) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }

        // Funkcja sortująca
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