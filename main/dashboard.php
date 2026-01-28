<?php
// main/dashboard.php
session_start();
require_once '../api/db.php';

// 1. Sprawdzenie logowania
if (!isset($_SESSION['user_id'])) {
    header("Location: ../login/index.php");
    exit();
}

$userName = $_SESSION['username'];
$userId = $_SESSION['user_id'];

try {
    // A. Pobranie list do filtrów
    $stmtGatunki = $pdo->query("SELECT id_gatunku, nazwa_gatunku FROM gatunek ORDER BY nazwa_gatunku ASC");
    $allGenres = $stmtGatunki->fetchAll();

    $stmtStatusy = $pdo->query("SELECT id_statusu, nazwa_statusu FROM status");
    $allStatuses = $stmtStatusy->fetchAll();

    // B. GŁÓWNE ZAPYTANIE
    // Pobieramy dane. Domyślne sortowanie w SQL to data dodania (malejąco),
    // ale JS i tak to może zmienić.
    $sql = "SELECT 
                p.tytul_planszowki, 
                s.nazwa_statusu, 
                k.ocena, 
                k.komentarz,
                k.data_dodania,
                GROUP_CONCAT(g.nazwa_gatunku SEPARATOR ', ') as gatunki
            FROM planszowka_w_kolekcji k
            JOIN planszowka p ON k.id_planszowki = p.id_planszowki
            JOIN status s ON k.id_statusu = s.id_statusu
            LEFT JOIN planszowka_gatunek pg ON p.id_planszowki = pg.id_planszowki
            LEFT JOIN gatunek g ON pg.id_gatunku = g.id_gatunku
            WHERE k.id_uzytkownika = ?
            GROUP BY k.id_planszowki_w_kolekcji
            ORDER BY k.data_dodania DESC";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([$userId]);
    $kolekcja = $stmt->fetchAll();
} catch (PDOException $e) {
    die("Błąd pobierania danych: " . $e->getMessage());
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

        <?php include 'sidebar.php'; ?>

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
                <a href="../add/dodaj_plugin.php" class="btn-small">Dodaj plugin punktacji</a>
            </div>
            <div class="filters">
                <div class="filter-group szukaj">
                    <label>Szukaj gry:</label>
                    <input type="text" id="searchTitle" placeholder="Wpisz tytuł..." onkeyup="applyFilters()">
                </div>

                <div class="filter-group status">
                    <label>Status:</label>
                    <select id="filterStatus" onchange="applyFilters()">
                        <option value="">Wszystkie</option>
                        <?php foreach ($allStatuses as $status): ?>
                            <option value="<?= htmlspecialchars($status['nazwa_statusu']) ?>">
                                <?= htmlspecialchars($status['nazwa_statusu']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="filter-group gatunki-dashboard">
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

                <div class="filter-group sortowanie-dashboard">
                    <label>Sortuj według:</label>
                    <select id="sortOrder" onchange="applySort()">
                        <option value="date_desc">Data dodania (od najnowszych)</option>
                        <option value="date_asc">Data dodania (od najstarszych)</option>
                        <option value="title_asc">Tytuł (A-Z)</option>
                        <option value="title_desc">Tytuł (Z-A)</option>
                        <option value="rating_desc">Ocena (od najwyższej)</option>
                        <option value="rating_asc">Ocena (od najniższej)</option>
                    </select>
                </div>
            </div>

            <main class="dashboard-main">
                <?php if (count($kolekcja) > 0): ?>
                    <table id="collectionTable">
                        <thead>
                            <tr>
                                <th>Tytuł gry</th>
                                <th>Gatunki</th>
                                <th>Status</th>
                                <th>Ocena</th>
                                <th>Data dodania</th>
                                <th>Komentarz</th>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                            <?php foreach ($kolekcja as $gra): ?>
                                <?php
                                // Przygotowanie danych do sortowania (data attributes)
                                $sortTitle = strtolower($gra['tytul_planszowki']);
                                $sortRating = $gra['ocena'] ? $gra['ocena'] : 0; // Brak oceny to 0
                                $sortDate = $gra['data_dodania'] ? strtotime($gra['data_dodania']) : 0;
                                ?>
                                <tr class="game-row"
                                    data-title="<?= htmlspecialchars($sortTitle) ?>"
                                    data-rating="<?= $sortRating ?>"
                                    data-date="<?= $sortDate ?>">

                                    <td class="col-title-dashboard">
                                        <strong><?php echo htmlspecialchars($gra['tytul_planszowki']); ?></strong>
                                    </td>

                                    <td class="col-genre-dashboard">
                                        <?php echo !empty($gra['gatunki']) ? htmlspecialchars($gra['gatunki']) : '<span style="color:#ccc">-</span>'; ?>
                                    </td>

                                    <td class="col-status-dashboard">
                                        <?php echo htmlspecialchars($gra['nazwa_statusu']); ?>
                                    </td>

                                    <td class="col-rating-dashboard">
                                        <?php echo $gra['ocena'] ? htmlspecialchars($gra['ocena']) . "/10" : "-"; ?>
                                    </td>

                                    <td class="col-date-dashboard">
                                        <?php echo !empty($gra['data_dodania']) ? date("d.m.Y", strtotime($gra['data_dodania'])) : '-'; ?>
                                    </td>

                                    <td class="col-comment-dashboard"><?php echo htmlspecialchars($gra['komentarz'] ?? ''); ?></td>
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

        // 1. Funkcja Filtrująca
        function applyFilters() {
            let searchText = document.getElementById('searchTitle').value.toLowerCase();
            let statusFilter = document.getElementById('filterStatus').value.toLowerCase();
            let genreFilter = document.getElementById('filterGenre').value.toLowerCase();

            let rows = document.querySelectorAll('.game-row');

            rows.forEach(row => {
                let title = row.querySelector('.col-title').innerText.toLowerCase();
                let status = row.querySelector('.col-status').innerText.toLowerCase();
                let genres = row.querySelector('.col-genre').innerText.toLowerCase();

                let matchesTitle = title.includes(searchText);
                let matchesStatus = statusFilter === "" || status === statusFilter;
                let matchesGenre = genreFilter === "" || genres.includes(genreFilter);

                if (matchesTitle && matchesStatus && matchesGenre) {
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
                let valA, valB;

                switch (sortBy) {
                    case 'title_asc':
                        return a.dataset.title.localeCompare(b.dataset.title);
                    case 'title_desc':
                        return b.dataset.title.localeCompare(a.dataset.title);

                    case 'rating_desc': // Od najwyższej
                        return parseFloat(b.dataset.rating) - parseFloat(a.dataset.rating);
                    case 'rating_asc': // Od najniższej
                        return parseFloat(a.dataset.rating) - parseFloat(b.dataset.rating);

                    case 'date_desc': // Od najnowszych
                        return parseInt(b.dataset.date) - parseInt(a.dataset.date);
                    case 'date_asc': // Od najstarszych
                        return parseInt(a.dataset.date) - parseInt(b.dataset.date);

                    default:
                        return 0;
                }
            });

            // Wstawiamy posortowane wiersze z powrotem do tabeli
            rows.forEach(row => tableBody.appendChild(row));
        }
    </script>
</body>

</html>