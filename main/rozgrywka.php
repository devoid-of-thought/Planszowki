<?php
// main/rozgrywka.php
session_start();
require_once '../api/db.php';

// 1. Sprawdzenie logowania
if (!isset($_SESSION['user_id'])) {
    header("Location: ../login/index.php");
    exit();
}

// 2. Weryfikacja ID rozgrywki
if (!isset($_GET['id_rozgrywki']) || empty($_GET['id_rozgrywki'])) {
    die("Błąd: Nie podano ID rozgrywki.");
}

$rozgrywkaId = intval($_GET['id_rozgrywki']);
$currentUserId = $_SESSION['user_id'];
$errorMsg = "";
$successMsg = "";

try {
    // A. Pobranie roli zalogowanego użytkownika
    // Relacja: uzytkownik(id_uprawnien) -> uprawnienia(id_uprawnien)
    $sqlRole = "SELECT up.typ_uprawnienia
                FROM uzytkownik u
                JOIN uprawnienia up ON u.id_uprawnien = up.id_uprawnien
                WHERE u.id_uzytkownika = :id";

    $stmtRole = $pdo->prepare($sqlRole);
    $stmtRole->execute(['id' => $currentUserId]);
    $currentUserRole = $stmtRole->fetchColumn(); // np. 'admin', 'moderator'

    $isGlobalAdmin = ($currentUserRole === 'admin' || $currentUserRole === 'moderator');

    // B. Pobranie szczegółów rozgrywki
    // ZGODNIE Z BAZĄ: planszowka.tytul_planszowki, uzytkownik.nazwa_uzytkownika
    $sqlGame = "SELECT r.id_rozgrywki, r.data_rozgrywki, r.tytul_rozgrywki, r.czas_trwania, r.notatka_do_gry,
                       r.id_organizatora,
                       p.id_planszowki, p.tytul_planszowki,
                       u.nazwa_uzytkownika as organizator_nazwa
                FROM rozgrywka r
                JOIN planszowka p ON r.id_planszowki = p.id_planszowki
                JOIN uzytkownik u ON r.id_organizatora = u.id_uzytkownika
                WHERE r.id_rozgrywki = :id";

    $stmt = $pdo->prepare($sqlGame);
    $stmt->execute(['id' => $rozgrywkaId]);
    $rozgrywka = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$rozgrywka) {
        die("Rozgrywka nie istnieje.");
    }

    $isOrganizer = ($rozgrywka['id_organizatora'] == $currentUserId);

    // C. Pobranie struktury JSON (z tabeli plugin przez arkusz_punktacji)
    $arkuszJson = null;
    $sqlPlugin = "SELECT pl.struktura_json
                  FROM arkusz_punktacji ap
                  JOIN plugin pl ON ap.id_pluginu = pl.id_pluginu
                  WHERE ap.id_planszowki = :pid
                  LIMIT 1";
    $stmtPlugin = $pdo->prepare($sqlPlugin);
    $stmtPlugin->execute(['pid' => $rozgrywka['id_planszowki']]);
    $pluginData = $stmtPlugin->fetch(PDO::FETCH_ASSOC);

    if ($pluginData && !empty($pluginData['struktura_json'])) {
        $arkuszJson = json_decode($pluginData['struktura_json'], true);
    }

    // D. OBSŁUGA ZAPISU (POST)
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'save_score') {
        $targetPlayerId = intval($_POST['player_id']);

        // Uprawnienia: Admin, Moderator, Organizator lub Właściciel wyniku
        $hasPermission = ($isGlobalAdmin || $isOrganizer || $targetPlayerId == $currentUserId);

        if ($hasPermission) {
            if ($arkuszJson) {
                $scoresInput = $_POST['scores'] ?? [];
                $finalScore = 0;
                $dataToSave = [];

                foreach ($arkuszJson['categories'] as $cat) {
                    $catId = $cat['id'];
                    $val = isset($scoresInput[$catId]) ? intval($scoresInput[$catId]) : ($cat['default'] ?? 0);

                    // Walidacja ujemnych wartości (chyba że JSON pozwala)
                    if (empty($cat['allow_negative']) && $val < 0) {
                        $val = 0;
                    }

                    $dataToSave[$catId] = $val;
                    $finalScore += $val;
                }

                if ($finalScore < 0) $finalScore = 0;

                $jsonToDb = json_encode($dataToSave);

                // Zapis do tabeli uczestnicy_rozgrywki
                $sqlUpdate = "UPDATE uczestnicy_rozgrywki
                              SET wynik_koncowy = :score, dane_arkusza = :details
                              WHERE id_rozgrywki = :gid AND id_uzytkownika = :uid";
                $stmtUp = $pdo->prepare($sqlUpdate);
                $stmtUp->execute([
                    'score' => $finalScore,
                    'details' => $jsonToDb,
                    'gid' => $rozgrywkaId,
                    'uid' => $targetPlayerId
                ]);

                $successMsg = "Zapisano punktację.";
            }
        } else {
            $errorMsg = "Brak uprawnień do edycji.";
        }
    }

    // OBSŁUGA KOMENTARZY (POST)
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['tresc_komentarza'])) {
        $tresc = trim($_POST['tresc_komentarza']);
        if (!empty($tresc)) {
            $sqlAddCom = "INSERT INTO komentarz (id_autora, id_rozgrywki, zawartosc, data_dodania)
                          VALUES (:autor, :rozgrywka, :tresc, NOW())";
            $stmtAddCom = $pdo->prepare($sqlAddCom);
            $stmtAddCom->execute([
                'autor' => $currentUserId,
                'rozgrywka' => $rozgrywkaId,
                'tresc' => $tresc
            ]);
            header("Location: rozgrywka.php?id_rozgrywki=" . $rozgrywkaId);
            exit();
        }
    }

    // E. Pobranie uczestników
    // ZGODNIE Z BAZĄ: u.nazwa_uzytkownika
    // USUNIĘTO: pole `miejsce` (nie istnieje w bazie)
    $sqlPlayers = "SELECT ur.id_uzytkownika, u.nazwa_uzytkownika, ur.wynik_koncowy, ur.dane_arkusza
                   FROM uczestnicy_rozgrywki ur
                   JOIN uzytkownik u ON ur.id_uzytkownika = u.id_uzytkownika
                   WHERE ur.id_rozgrywki = :id
                   ORDER BY ur.wynik_koncowy DESC, u.nazwa_uzytkownika ASC";
    $stmtPlayers = $pdo->prepare($sqlPlayers);
    $stmtPlayers->execute(['id' => $rozgrywkaId]);
    $uczestnicy = $stmtPlayers->fetchAll(PDO::FETCH_ASSOC);

    // F. Pobranie komentarzy
    // ZGODNIE Z BAZĄ: u.nazwa_uzytkownika
    $sqlCom = "SELECT k.zawartosc, k.data_dodania, u.nazwa_uzytkownika
               FROM komentarz k
               JOIN uzytkownik u ON k.id_autora = u.id_uzytkownika
               WHERE k.id_rozgrywki = :id
               ORDER BY k.data_dodania DESC";
    $stmtCom = $pdo->prepare($sqlCom);
    $stmtCom->execute(['id' => $rozgrywkaId]);
    $komentarze = $stmtCom->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Błąd bazy danych: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <title><?php echo htmlspecialchars($rozgrywka['tytul_planszowki']); ?> - Punktacja</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* --- Style Arkusza --- */
        .score-sheet-wrapper {
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 15px;
            margin-top: 10px;
            display: none;
        }

        .score-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
            padding: 8px;
            background: #fff;
            border-radius: 4px;
            border-left: 5px solid #ccc;
        }

        .score-row label {
            font-weight: 500;
            flex-grow: 1;
        }

        .score-row .description {
            font-size: 0.85em;
            color: #6c757d;
            margin-right: 15px;
            text-align: right;
            max-width: 50%;
        }

        .score-row input[type="number"] {
            width: 70px;
            padding: 5px;
            text-align: center;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-weight: bold;
        }

        .total-score-live {
            font-size: 1.1em;
            font-weight: bold;
            color: var(--color-magenta);
            text-align: right;
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px solid #ddd;
        }

        .toggle-sheet-btn {
            background: none;
            border: none;
            color: var(--color-magenta);
            cursor: pointer;
            text-decoration: underline;
            font-size: 0.9em;
        }

        .toggle-sheet-btn:hover {
            color: var(--color-mauve);
        }

        /* Tabela uczestników */
        .table-participants {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .table-participants th {
            background-color: var(--color-black);
            color: #fff;
            padding: 10px;
            text-align: left;
        }

        .table-participants td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            vertical-align: middle;
        }

        /* Komentarze */
        .comment-item {
            border-bottom: 1px solid #eee;
            padding: 15px 0;
            display: flex;
            gap: 15px;
        }

        .comment-avatar {
            width: 40px;
            height: 40px;
            background: #eee;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #888;
        }

        .comment-content {
            flex: 1;
        }

        .comment-meta {
            font-size: 0.85em;
            color: #666;
            margin-bottom: 5px;
        }
    </style>
</head>

<body>
    <div class="dashboard-wrapper">
        <div class="sidebar">
            <div class="logo">Planszówki<span style="color: var(--color-mauve);">App</span></div>
            <nav class="menu">
                <a href="dashboard.php"><i class="fas fa-home"></i> Pulpit</a>
                <a href="gry.php"><i class="fas fa-chess-board"></i> Baza Gier</a>
                <a href="rozgrywki.php" class="active"><i class="fas fa-dice"></i> Rozgrywki</a>
                <a href="uzytkownicy.php"><i class="fas fa-users"></i> Społeczność</a>
                <a href="../logout.php"><i class="fas fa-sign-out-alt"></i> Wyloguj</a>
            </nav>
        </div>

        <div class="dashboard-main">
            <header class="top-bar">
                <div class="user-info">
                    Zalogowany: <strong><?php echo htmlspecialchars($_SESSION['username'] ?? 'Użytkownik'); ?></strong>
                </div>
            </header>

            <div class="content">
                <div class="header-action">
                    <a href="rozgrywki.php" class="btn-secondary"><i class="fas fa-arrow-left"></i> Wróć</a>
                    <h1><?php echo htmlspecialchars($rozgrywka['tytul_planszowki']); ?></h1>
                </div>

                <?php if ($errorMsg): ?>
                    <div style="background:#f8d7da; color:#721c24; padding:10px; margin-bottom:15px; border-radius:4px;">
                        <?php echo $errorMsg; ?>
                    </div>
                <?php endif; ?>

                <?php if ($successMsg): ?>
                    <div style="background:#d4edda; color:#155724; padding:10px; margin-bottom:15px; border-radius:4px;">
                        <?php echo $successMsg; ?>
                    </div>
                <?php endif; ?>

                <div style="background:white; padding:20px; border-radius:8px; box-shadow:0 2px 4px rgba(0,0,0,0.1);">
                    <h2><?php echo htmlspecialchars($rozgrywka['tytul_rozgrywki']); ?></h2>
                    <p><i class="fas fa-user-tie"></i> Organizator: <strong><?php echo htmlspecialchars($rozgrywka['organizator_nazwa']); ?></strong></p>
                    <p><i class="far fa-calendar-alt"></i> Data: <?php echo date("d.m.Y H:i", strtotime($rozgrywka['data_rozgrywki'])); ?></p>

                    <?php if ($rozgrywka['notatka_do_gry']): ?>
                        <div style="margin-top:10px; font-style:italic; color:#555; background:#f1f1f1; padding:10px; border-left:4px solid var(--color-magenta);">
                            "<?php echo nl2br(htmlspecialchars($rozgrywka['notatka_do_gry'])); ?>"
                        </div>
                    <?php endif; ?>
                </div>

                <h3 style="margin-top:30px;">Wyniki</h3>
                <table class="table-participants">
                    <thead>
                        <tr>
                            <th style="width: 50px;">#</th>
                            <th>Gracz</th>
                            <th>Wynik</th>
                            <th>Opcje</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $rank = 1;
                        foreach ($uczestnicy as $u): ?>
                            <?php
                            $isEditable = ($isGlobalAdmin || $isOrganizer || $u['id_uzytkownika'] == $currentUserId);
                            $sheetData = !empty($u['dane_arkusza']) ? json_decode($u['dane_arkusza'], true) : [];
                            ?>
                            <tr>
                                <td><?php echo $rank++; ?></td>
                                <td>
                                    <strong><?php echo htmlspecialchars($u['nazwa_uzytkownika']); ?></strong>
                                    <?php if ($u['id_uzytkownika'] == $rozgrywka['id_organizatora']) echo ' <i class="fas fa-crown" title="Organizator" style="color:gold;"></i>'; ?>
                                </td>
                                <td>
                                    <span style="background:var(--color-magenta); color:white; padding:5px 10px; border-radius:15px; font-weight:bold;">
                                        <?php echo intval($u['wynik_koncowy']); ?> pkt
                                    </span>
                                </td>
                                <td>
                                    <?php if ($arkuszJson && $isEditable): ?>
                                        <button class="toggle-sheet-btn" onclick="toggleSheet(<?php echo $u['id_uzytkownika']; ?>)">
                                            <i class="fas fa-edit"></i> Edytuj
                                        </button>
                                    <?php elseif (!$arkuszJson): ?>
                                        <small style="color:#999;">Brak arkusza</small>
                                    <?php endif; ?>
                                </td>
                            </tr>

                            <?php if ($arkuszJson && $isEditable): ?>
                                <tr id="sheet-<?php echo $u['id_uzytkownika']; ?>" style="display:none;">
                                    <td colspan="4">
                                        <div class="score-sheet-wrapper">
                                            <form method="POST" action="rozgrywka.php?id_rozgrywki=<?php echo $rozgrywkaId; ?>">
                                                <input type="hidden" name="action" value="save_score">
                                                <input type="hidden" name="player_id" value="<?php echo $u['id_uzytkownika']; ?>">

                                                <?php foreach ($arkuszJson['categories'] as $cat):
                                                    $catId = $cat['id'];
                                                    $val = isset($sheetData[$catId]) ? $sheetData[$catId] : ($cat['default'] ?? 0);
                                                    $catColor = $cat['color'] ?? '#ccc';
                                                ?>
                                                    <div class="score-row" style="border-left-color: <?php echo htmlspecialchars($catColor); ?>">
                                                        <label><?php echo htmlspecialchars($cat['name']); ?></label>
                                                        <span class="description"><?php echo htmlspecialchars($cat['description']); ?></span>
                                                        <input type="number"
                                                            class="input-score-<?php echo $u['id_uzytkownika']; ?>"
                                                            name="scores[<?php echo $catId; ?>]"
                                                            value="<?php echo $val; ?>"
                                                            oninput="calcTotal(<?php echo $u['id_uzytkownika']; ?>)"
                                                            <?php echo (isset($cat['allow_negative']) && $cat['allow_negative']) ? '' : 'min="0"'; ?>>
                                                    </div>
                                                <?php endforeach; ?>

                                                <div class="total-score-live">
                                                    Suma: <span id="total-<?php echo $u['id_uzytkownika']; ?>"><?php echo intval($u['wynik_koncowy']); ?></span>
                                                </div>
                                                <div style="text-align:right; margin-top:10px;">
                                                    <button type="submit" class="btn-secondary" style="background:var(--color-magenta); color:white; border:none; padding:8px 16px;">
                                                        Zapisz wynik
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            <?php endif; ?>

                        <?php endforeach; ?>
                    </tbody>
                </table>

                <h3 style="margin-top:40px;">Dyskusja</h3>
                <form method="POST" class="comment-form" style="margin-bottom:20px;">
                    <textarea name="tresc_komentarza" rows="3" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:4px;" placeholder="Dodaj komentarz..." required></textarea>
                    <button type="submit" class="btn-secondary" style="margin-top:10px;">Wyślij</button>
                </form>

                <div class="comment-list">
                    <?php if (empty($komentarze)): ?>
                        <p style="color:#777;">Brak komentarzy.</p>
                    <?php else: ?>
                        <?php foreach ($komentarze as $k): ?>
                            <div class="comment-item">
                                <div class="comment-avatar">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div class="comment-content">
                                    <div class="comment-meta">
                                        <strong><?php echo htmlspecialchars($k['nazwa_uzytkownika']); ?></strong>
                                        &bull; <?php echo $k['data_dodania']; ?>
                                    </div>
                                    <div class="comment-text">
                                        <?php echo nl2br(htmlspecialchars($k['zawartosc'])); ?>
                                    </div>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </div>

            </div>
        </div>
    </div>

    <script>
        function toggleSheet(userId) {
            var row = document.getElementById('sheet-' + userId);
            row.style.display = (row.style.display === 'none') ? 'table-row' : 'none';
        }

        function calcTotal(userId) {
            var inputs = document.querySelectorAll('.input-score-' + userId);
            var sum = 0;
            inputs.forEach(function(inp) {
                var val = parseInt(inp.value);
                if (!isNaN(val)) {
                    sum += val;
                }
            });
            if (sum < 0) sum = 0;
            document.getElementById('total-' + userId).innerText = sum;
        }
    </script>
</body>

</html>