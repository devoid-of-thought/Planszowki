<?php
// main/baza_gier.php
session_start();
require_once '../api/db.php';

// 1. Sprawdzenie logowania (strona dostępna tylko dla zalogowanych)
if (!isset($_SESSION['user_id'])) {
    header("Location: ../login/index.php");
    exit();
}

$userName = $_SESSION['username'];

try {
    // A. Pobranie list do filtrów (Gatunki)
    $stmtGatunki = $pdo->query("SELECT id_gatunku, nazwa_gatunku FROM gatunek ORDER BY nazwa_gatunku ASC");
    $allGenres = $stmtGatunki->fetchAll();

    // B. GŁÓWNE ZAPYTANIE - BAZA GLOBALNA
    // Pobieramy gry stworzone przez użytkownika 1 (admin) lub NULL (systemowe)
    $sql = "SELECT 
                k.id_planszowki,
                k.tytul_planszowki, 
                k.data_wydania,
                k.min_graczy, 
                k.max_graczy, 
                k.min_dlugosc_rozgrywki, 
                k.max_dlugosc_rozgrywki,
                k.waga,
                k.bgg_id,
                GROUP_CONCAT(g.nazwa_gatunku SEPARATOR ', ') as gatunki
            FROM planszowka k
            LEFT JOIN planszowka_gatunek pg ON k.id_planszowki = pg.id_planszowki
            LEFT JOIN gatunek g ON pg.id_gatunku = g.id_gatunku
            WHERE k.stworzone_przez_id_uzytkownika = 1 
               OR k.stworzone_przez_id_uzytkownika IS NULL
               OR k.stworzone_przez_id_uzytkownika = :userId
            GROUP BY k.id_planszowki
            ORDER BY k.tytul_planszowki ASC";

    $stmt = $pdo->prepare($sql);

    $stmt->execute([':userId' => $_SESSION['user_id']]);  
      $globalnaBaza = $stmt->fetchAll();

} catch (PDOException $e) {
    die("Błąd pobierania danych: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <title>Globalna Baza Gier - Planszówki</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&family=Tilt+Neon&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <style>

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
                <h2>Globalna Baza Gier</h2>
            </div>

            <div class="actions">
                <a href="../add/dodaj_gre.php" class="btn-small">Dodaj nową grę do bazy</a>
            </div>

            <div class="filters">
                <div class="filter-group search-gry">
                    <label>Szukaj gry:</label>
                    <input type="text" id="searchTitle" placeholder="Wpisz tytuł..." onkeyup="applyFilters()">
                </div>
                
                <div class="filter-group gracze-filter">
                    <label>Ilość Graczy:</label>
                    <div class="input-row">
                        <input type="number" id="minPlayers" placeholder="Min" min="1" oninput="applyFilters()">
                        <input type="number" id="maxPlayers" placeholder="Max" min="1" oninput="applyFilters()">
                    </div>
                </div>

                <div class="filter-group gatunek-filter">
                    <label>Gatunek:</label>
                    <select id="filterGenre" onchange="applyFilters()">
                        <option value="">Wszystkie</option>
                        <?php foreach ($allGenres as $genre): ?>
                            <option value="<?= htmlspecialchars($genre['nazwa_gatunku']) ?>">
                                <?= htmlspecialchars($genre['nazwa_gatunku']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="filter-group sortowanie-filter">
                    <label>Sortuj według:</label>
                    <select id="sortOrder" onchange="applySort()">
                        <option value="title_asc">Tytuł (A-Z)</option>
                        <option value="title_desc">Tytuł (Z-A)</option>
                        <option value="date_desc">Data wydania (od najnowszych)</option>
                        <option value="date_asc">Data wydania (od najstarszych)</option>
                        <option value="waga_desc">Waga (od najwyższej)</option>
                        <option value="waga_asc">Waga (od najniższej)</option>
                    </select>
                </div>
            </div>

            <main class="planszowki-main">
                <?php if (count($globalnaBaza) > 0): ?>
                    <table id="collectionTable">
                        <thead>
                            <tr>
                                <th>Tytuł gry</th>
                                <th>Gatunki</th>
                                <th>Ilość Graczy</th>
                                <th>Długość Rozgrywki</th>
                                <th>Złożoność</th>
                                <th>Opis</th>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                            <?php foreach ($globalnaBaza as $gra): ?>
                                <?php 
                                    // Przygotowanie danych do sortowania
                                    $sortTitle = strtolower($gra['tytul_planszowki']);
                                    $sortDate = $gra['data_wydania'] ? strtotime($gra['data_wydania']) : 0;
                                    $sortWaga = $gra['waga'] ? $gra['waga'] : 0;
                                ?>
                                <tr class="game-row" 
                                    data-title="<?= htmlspecialchars($sortTitle) ?>"
                                    data-date="<?= $sortDate ?>"
                                    data-waga="<?= $sortWaga ?>"
                                    data-min-players="<?= $gra['min_graczy'] ?>"
                                    data-max-players="<?= $gra['max_graczy'] ?>">
                                    
                                    <td class="col-title">
                                        <strong><?php echo htmlspecialchars($gra['tytul_planszowki']); ?></strong>
                                    </td>
                                    
                                    <td class="col-genre">
                                        <?php echo !empty($gra['gatunki']) ? htmlspecialchars($gra['gatunki']) : '<span style="color:#ccc">-</span>'; ?>
                                    </td>

                                    <td class="col-gracze"> 
                                        <?php echo htmlspecialchars($gra['min_graczy'] . ' - ' . $gra['max_graczy']); ?>
                                    </td>

                                    <td class="col-length">
                                        <?php echo htmlspecialchars($gra['min_dlugosc_rozgrywki'] . ' - ' . $gra['max_dlugosc_rozgrywki']); ?> min
                                    </td>

                                    <td class="col-waga">
                                        <?php echo htmlspecialchars($gra['waga']); ?>
                                    </td>

                                    <td>
                                        <?php if(!empty($gra['bgg_id'])): ?>
                                            <a href="https://boardgamegeek.com/boardgame/<?= htmlspecialchars($gra['bgg_id']) ?>" target="_blank" class="link-bgg">BGG</a>
                                        <?php else: ?>
                                            -
                                        <?php endif; ?>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                <?php else: ?>
                    <div class="empty-msg">
                        <h3>Baza gier jest pusta!</h3>
                        <p>Wygląda na to, że w systemie nie ma jeszcze zdefiniowanych gier.</p>
                    </div>
                <?php endif; ?>
            </main>

        </div>
    </div>

    <script>
        document.getElementById('sidebarCollapse').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('collapsed');
        });

        // 1. Funkcja Filtrująca
        function applyFilters() {
            let searchText = document.getElementById('searchTitle').value.toLowerCase();
            let genreFilter = document.getElementById('filterGenre').value.toLowerCase();
            let filterMin = parseInt(document.getElementById('minPlayers').value);
            let filterMax = parseInt(document.getElementById('maxPlayers').value);

            let rows = document.querySelectorAll('.game-row');

            rows.forEach(row => {
                let title = row.querySelector('.col-title').innerText.toLowerCase();
                let genres = row.querySelector('.col-genre').innerText.toLowerCase();
                
                let gameMin = parseInt(row.dataset.minPlayers);
                let gameMax = parseInt(row.dataset.maxPlayers);

                let matchesTitle = title.includes(searchText);
                let matchesGenre = genreFilter === "" || genres.includes(genreFilter);
                
                let matchesPlayers = true;
                // Logika: 
                // Jeśli wpiszesz "Min: 3", pokazujemy gry, które mogą obsłużyć >= 3 (wg ich max).
                // Jeśli wpiszesz "Max: 5", pokazujemy gry, które mogą obsłużyć <= 5 (wg ich min).
                if (!isNaN(filterMin) && gameMax < filterMin) matchesPlayers = false;
                if (!isNaN(filterMax) && gameMin > filterMax) matchesPlayers = false;

                if (matchesTitle && matchesGenre && matchesPlayers) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }

        // 2. Funkcja Sortująca
        function applySort() {
            let sortBy = document.getElementById('sortOrder').value;
            let tableBody = document.getElementById('tableBody');
            let rows = Array.from(tableBody.querySelectorAll('.game-row'));

            rows.sort((a, b) => {
                switch (sortBy) {
                    case 'title_asc':
                        return a.dataset.title.localeCompare(b.dataset.title);
                    case 'title_desc':
                        return b.dataset.title.localeCompare(a.dataset.title);
                    case 'date_desc': 
                        return parseInt(b.dataset.date) - parseInt(a.dataset.date);
                    case 'date_asc': 
                        return parseInt(a.dataset.date) - parseInt(b.dataset.date);
                    case 'waga_desc': 
                        return parseFloat(b.dataset.waga) - parseFloat(a.dataset.waga);
                    case 'waga_asc': 
                        return parseFloat(a.dataset.waga) - parseFloat(b.dataset.waga);
                    default:
                        return 0;
                }
            });

            rows.forEach(row => tableBody.appendChild(row));
        }
    </script>
</body>
</html>