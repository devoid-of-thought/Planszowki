<?php
// add/dodaj_rozgrywke.php
session_start();
require_once '../api/db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: ../login/index.php");
    exit();
}

if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

$currentUserId = $_SESSION['user_id'];
$message = "";

try {
    // Pobieramy gry wraz z ich parametrami
    $sqlGry = "SELECT p.id_planszowki, p.tytul_planszowki, p.min_graczy, p.max_graczy,
                      p.min_dlugosc_rozgrywki, p.max_dlugosc_rozgrywki
               FROM planszowka p
               JOIN planszowka_w_kolekcji k ON p.id_planszowki = k.id_planszowki
               WHERE k.id_uzytkownika = :uid
               ORDER BY p.tytul_planszowki ASC";

    $stmtGry = $pdo->prepare($sqlGry);
    $stmtGry->execute(['uid' => $currentUserId]);
    $listaGier = $stmtGry->fetchAll();

    $sqlZnajomi = "SELECT u.id_uzytkownika, u.nazwa_uzytkownika
                   FROM uzytkownik u
                   JOIN relacje_uzytkownikow r ON
                   (u.id_uzytkownika = r.id_uzytkownika2 AND r.id_uzytkownika1 = :uid1) OR
                   (u.id_uzytkownika = r.id_uzytkownika1 AND r.id_uzytkownika2 = :uid2)";
    $stmtZnajomi = $pdo->prepare($sqlZnajomi);
    $stmtZnajomi->execute(['uid1' => $currentUserId, 'uid2' => $currentUserId]);
    $listaZnajomych = $stmtZnajomi->fetchAll();
} catch (PDOException $e) {
    die("Błąd bazy danych: " . $e->getMessage());
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die("Błąd bezpieczeństwa (CSRF).");
    }

    $id_planszowki = (int)$_POST['id_planszowki'];
    // NOWE: Pobieramy wybrane ID arkusza (pluginu)
    $id_arkusza = !empty($_POST['id_arkusza']) ? (int)$_POST['id_arkusza'] : null;
    
    $tytul_rozgrywki = trim($_POST['tytul_rozgrywki']);
    $data_rozgrywki = $_POST['data_rozgrywki'];
    $czas_trwania = (int)$_POST['czas_trwania'];
    $notatka = trim($_POST['notatka_do_gry']);
    $wybrani_gracze = $_POST['gracze'] ?? [];
    $tymczasowe_nazwy = $_POST['temp_name'] ?? [];

    try {
        $pdo->beginTransaction();

        $sqlInsertRozgrywka = "INSERT INTO rozgrywka (id_planszowki, id_organizatora, data_rozgrywki, tytul_rozgrywki, czas_trwania, notatka_do_gry)
                               VALUES (?, ?, ?, ?, ?, ?)";
        $stmtRozgrywka = $pdo->prepare($sqlInsertRozgrywka);
        $stmtRozgrywka->execute([$id_planszowki, $currentUserId, $data_rozgrywki, $tytul_rozgrywki, $czas_trwania, $notatka]);
        $id_nowej_rozgrywki = $pdo->lastInsertId();

        // ZMIANA: Dodano kolumnę `id_arkusza_uzytego`
        $sqlInsertUczestnik = "INSERT INTO uczestnicy_rozgrywki (id_rozgrywki, id_uzytkownika, nazwa_tymczasowa_gracza, wynik_koncowy, id_arkusza_uzytego) VALUES (?, ?, ?, 0, ?)";
        $stmtUczestnik = $pdo->prepare($sqlInsertUczestnik);

        $organizatorBralUdział = isset($_POST['organizator_bierze_udzial']);
        $organizatorTempName = !empty($_POST['organizator_temp_name']) ? trim($_POST['organizator_temp_name']) : null;

        if ($organizatorBralUdział) {
            // ZMIANA: Przekazujemy $id_arkusza
            $stmtUczestnik->execute([$id_nowej_rozgrywki, $currentUserId, $organizatorTempName, $id_arkusza]);
        }

        // Wybrani znajomi
        foreach ($wybrani_gracze as $id_znajomego) {
            $tempName = !empty($tymczasowe_nazwy[$id_znajomego]) ? trim($tymczasowe_nazwy[$id_znajomego]) : null;
            // ZMIANA: Przekazujemy $id_arkusza
            $stmtUczestnik->execute([$id_nowej_rozgrywki, (int)$id_znajomego, $tempName, $id_arkusza]);
        }

        $pdo->commit();
        header("Location: ../main/rozgrywki.php?success=1");
        exit();
    } catch (PDOException $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        $message = "<p class='error'>Błąd zapisu: " . $e->getMessage() . "</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <title>Dodaj rozgrywkę</title>
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .friends-list-container {
            max-height: 250px;
            overflow-y: auto;
            border: 1px solid #ccc;
            border-radius: 5px;
            background: #fff;
            padding: 10px;
        }

        .friend-item input[type="checkbox"] {
            display: none;
        }

        .friend-item {
            display: flex;
            align-items: center;
            padding: 10px 15px;
            margin-bottom: 5px;
            border: 1px solid transparent;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.2s;
            gap: 30px;
        }

        .friend-item:hover {
            background: #f0f0f0;
        }

        .friend-item:has(input:checked) {
            background: #eff6ff;
            border-color: #3b82f6;
            color: #1d4ed8;
        }

        .friend-name {
            min-width: 140px;
            font-weight: 500;
        }

        .temp-name-input {
            padding: 5px 10px;
            font-size: 0.85em;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 200px;
            display: none;
        }

        .friend-item:has(input:checked) .temp-name-input {
            display: block;
            margin-block: auto;
        }

        #game-info-box {
            margin: 10px 0;
            padding: 10px;
            background: #eef2f7;
            border-left: 4px solid #3498db;
            display: none;
            font-size: 0.9em;
        }
    </style>
</head>

<body>
    <div class="dashboard-wrapper">
        <div class="main-content">
            <div class="top-header">
                <h2>Dodaj nową rozgrywkę</h2>
                <button class="btn-small" onclick="window.location.href='../main/rozgrywki.php'">← Wróć</button>
            </div>

            <div class="form-container dodaj-gre">
                <?= $message ?>
                <form method="POST">

                    <label>Wyszukaj grę:</label>
                    <input type="text" id="gameSearchInput" onkeyup="filterGameSelect()" placeholder="Zacznij pisać nazwę gry...">

                    <label>Wybierz grę:</label>
                    <select name="id_planszowki" id="gameSelect" required onchange="showGameStats()">
                        <option value="">-- Wybierz z kolekcji --</option>
                        <?php foreach ($listaGier as $gra): ?>
                            <option value="<?= $gra['id_planszowki'] ?>"
                                data-min-p="<?= $gra['min_graczy'] ?>"
                                data-max-p="<?= $gra['max_graczy'] ?>"
                                data-min-t="<?= $gra['min_dlugosc_rozgrywki'] ?>"
                                data-max-t="<?= $gra['max_dlugosc_rozgrywki'] ?>">
                                <?= htmlspecialchars($gra['tytul_planszowki']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>

                    <div id="game-info-box">
                        <span id="game-stats-display"></span>
                    </div>

                    <label>Wybierz wariant punktacji:</label>
                    <select name="id_arkusza" id="arkuszSelect" disabled style="margin-bottom: 20px;">
                        <option value="">-- Najpierw wybierz grę --</option>
                    </select>

                    <label>Tytuł sesji (opcjonalny):</label>
                    <input type="text" name="tytul_rozgrywki" placeholder="np. Wieczór z Brassem">

                    <label>Data:</label>
                    <input type="date" name="data_rozgrywki" value="<?= date('Y-m-d') ?>" required>

                    <label>Czas trwania w minutach:</label>
                    <input type="number" name="czas_trwania" min="1" max="2147483647" required>

                    <label>Znajomi biorący udział:</label>
                    <input type="text" id="friendSearch" onkeyup="filterFriends()" placeholder="Szukaj znajomego..." style="margin-bottom:5px;">

                    <div class="friends-list-container">
                        <?php foreach ($listaZnajomych as $znajomy): ?>
                            <label class="friend-item" for="f_<?= $znajomy['id_uzytkownika'] ?>">
                                <input type="checkbox" name="gracze[]" value="<?= $znajomy['id_uzytkownika'] ?>" id="f_<?= $znajomy['id_uzytkownika'] ?>">

                                <span><?= htmlspecialchars($znajomy['nazwa_uzytkownika']) ?></span>

                                <input type="text"
                                    name="temp_name[<?= $znajomy['id_uzytkownika'] ?>]"
                                    class="temp-name-input"
                                    placeholder="Nazwa tymczasowa..."
                                    onclick="event.stopPropagation();"> </label>
                        <?php endforeach; ?>

                    </div>
                    <label>Twoje uczestnictwo:</label>
                    <div class="friends-list-container" style="margin-bottom: 20px;">
                        <label class="friend-item" for="org_uczestnik">
                            <input type="checkbox" name="organizator_bierze_udzial" id="org_uczestnik" checked>

                            <span class="friend-name">Brałem/am udział</span>

                            <input type="text"
                                name="organizator_temp_name"
                                class="temp-name-input"
                                placeholder="Twój nick w tej grze..."
                                onclick="event.stopPropagation();">
                        </label>
                    </div>

                    <label>Notatka:</label>
                    <textarea name="notatka_do_gry" rows="3"></textarea>

                    <input type="hidden" name="csrf_token" value="<?= $_SESSION['csrf_token'] ?>">
                    <button class="btn-small save" type="submit">Zapisz rozgrywkę</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Funkcja do pokazywania statystyk ORAZ ładowania pluginów
        function showGameStats() {
            const select = document.getElementById('gameSelect');
            const selectedOption = select.options[select.selectedIndex];
            const infoBox = document.getElementById('game-info-box');
            const statsSpan = document.getElementById('game-stats-display');
            const arkuszSelect = document.getElementById('arkuszSelect');

            if (selectedOption && selectedOption.value) {
                // 1. Pokaż statystyki
                const minP = selectedOption.getAttribute('data-min-p');
                const maxP = selectedOption.getAttribute('data-max-p');
                const minT = selectedOption.getAttribute('data-min-t');
                const maxT = selectedOption.getAttribute('data-max-t');

                statsSpan.innerHTML = `Gracze: <b>${minP}-${maxP}</b> | Czas: <b>${minT}-${maxT} min</b>`;
                infoBox.style.display = 'block';

                // 2. Pobierz pluginy (AJAX)
                const gameId = selectedOption.value;
                arkuszSelect.innerHTML = '<option value="">Ładowanie...</option>';
                arkuszSelect.disabled = true;

                fetch(`../api/get_plugins.php?id_planszowki=${gameId}`)
                    .then(response => response.json())
                    .then(data => {
                        arkuszSelect.innerHTML = '';
                        // Zawsze dodaj opcję domyślną (brak pluginu)
                        let defaultOption = document.createElement('option');
                        defaultOption.value = "";
                        defaultOption.text = "Tylko wynik końcowy (Brak szczegółowej punktacji)";
                        arkuszSelect.appendChild(defaultOption);

                        if (data.length > 0) {
                            data.forEach(plugin => {
                                let option = document.createElement('option');
                                option.value = plugin.id;
                                option.text = plugin.name;
                                arkuszSelect.appendChild(option);
                            });
                        }
                        arkuszSelect.disabled = false;
                    })
                    .catch(err => {
                        console.error('Błąd:', err);
                        arkuszSelect.innerHTML = '<option value="">Błąd ładowania</option>';
                    });

            } else {
                infoBox.style.display = 'none';
                arkuszSelect.innerHTML = '<option value="">-- Najpierw wybierz grę --</option>';
                arkuszSelect.disabled = true;
            }
        }

        function filterFriends() {
            let input = document.getElementById('friendSearch').value.toLowerCase();
            let items = document.querySelectorAll('.friend-item');
            items.forEach(item => {
                let text = item.querySelector('label').innerText.toLowerCase();
                // Sprawdzamy inputy wewnątrz labela, aby nie ukrywać samego pola input dla nazwy
                // Pobieramy tylko tekst bezpośredni z labela lub spana
                let spanText = item.querySelector('span').innerText.toLowerCase();
                
                item.style.display = spanText.includes(input) ? "flex" : "none";
            });
        }

        function filterGameSelect() {
            let input = document.getElementById('gameSearchInput').value.toLowerCase();
            let options = document.getElementById('gameSelect').options;
            for (let i = 1; i < options.length; i++) {
                let text = options[i].text.toLowerCase();
                options[i].style.display = text.includes(input) ? "" : "none";
            }
        }
    </script>
</body>
</html>