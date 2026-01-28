<?php
// main/rozgrywka.php
session_start();
require_once '../api/db.php';

// WYMUSZENIE KODOWANIA UTF-8 DLA POŁĄCZENIA
$pdo->exec("SET NAMES 'utf8mb4'");

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
    $sqlRole = "SELECT up.typ_uprawnienia
                FROM uzytkownik u
                JOIN uprawnienia up ON u.id_uprawnien = up.id_uprawnien
                WHERE u.id_uzytkownika = :id";

    $stmtRole = $pdo->prepare($sqlRole);
    $stmtRole->execute(['id' => $currentUserId]);
    $currentUserRole = $stmtRole->fetchColumn();

    $isGlobalAdmin = ($currentUserRole === 'Administrator' || $currentUserRole === 'Moderator');

    // B. Pobranie szczegółów rozgrywki
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

    // C. Pobranie struktury JSON (POPRAWIONE)
    $arkuszJson = null;

    // Pobieramy plugin, którego użyto w TEJ KONKRETNEJ rozgrywce.
    // Sprawdzamy tabelę uczestników (zakładamy, że wszyscy w sesji mają ten sam arkusz).
    $sqlPlugin = "SELECT pl.struktura_json
                  FROM uczestnicy_rozgrywki ur
                  JOIN plugin pl ON ur.id_arkusza_uzytego = pl.id_pluginu
                  WHERE ur.id_rozgrywki = :gid
                  AND ur.id_arkusza_uzytego IS NOT NULL
                  LIMIT 1";
                  
    $stmtPlugin = $pdo->prepare($sqlPlugin);
    $stmtPlugin->execute(['gid' => $rozgrywkaId]); // Używamy ID rozgrywki, nie planszówki!
    $pluginData = $stmtPlugin->fetch(PDO::FETCH_ASSOC);

    if ($pluginData && !empty($pluginData['struktura_json'])) {
        $arkuszJson = json_decode($pluginData['struktura_json'], true);
    }

    // D. OBSŁUGA ZAPISU (POST)
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'save_score') {
        $targetPlayerId = intval($_POST['player_id']);
        $hasPermission = ($isGlobalAdmin || $isOrganizer || $targetPlayerId == $currentUserId);

        if ($hasPermission) {
            if ($arkuszJson) {
                $scoresInput = $_POST['scores'] ?? [];
                $finalScore = 0;
                $dataToSave = [];

                foreach ($arkuszJson['categories'] as $cat) {
                    $catId = $cat['id'];
                    $val = isset($scoresInput[$catId]) ? intval($scoresInput[$catId]) : ($cat['default'] ?? 0);

                    if (empty($cat['allow_negative']) && $val < 0) {
                        $val = 0;
                    }

                    $dataToSave[$catId] = $val;
                    $finalScore += $val;
                }

                if ($finalScore < 0) $finalScore = 0;

                $jsonToDb = json_encode($dataToSave);

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
    // ZMIANA: Dodano ur.nazwa_tymczasowa_gracza do SELECT
    $sqlPlayers = "SELECT ur.id_uzytkownika, u.nazwa_uzytkownika, ur.wynik_koncowy, ur.dane_arkusza, ur.nazwa_tymczasowa_gracza
                   FROM uczestnicy_rozgrywki ur
                   JOIN uzytkownik u ON ur.id_uzytkownika = u.id_uzytkownika
                   WHERE ur.id_rozgrywki = :id
                   ORDER BY ur.wynik_koncowy DESC, u.nazwa_uzytkownika ASC";
    $stmtPlayers = $pdo->prepare($sqlPlayers);
    $stmtPlayers->execute(['id' => $rozgrywkaId]);
    $uczestnicy = $stmtPlayers->fetchAll(PDO::FETCH_ASSOC);

    // F. Pobranie komentarzy
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
    <title><?php echo htmlspecialchars($rozgrywka['tytul_planszowki']); ?> - Szczegóły</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&family=Tilt+Neon&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body>
    <div class="dashboard-wrapper">

        <?php include 'sidebar.php'; ?>

        <div class="main-content">

            <div class="top-header">
                <div style="display:flex; align-items:center; gap:15px;">
                    <button type="button" id="sidebarCollapse" class="toggle-btn">
                        ☰
                    </button>
                    <h2><?php echo htmlspecialchars($rozgrywka['tytul_planszowki']); ?></h2>
                </div>
                <button class="btn-small" onclick="window.location.href='rozgrywki.php'">← Wróć</button>
            </div>

            <?php if ($errorMsg): ?>
                <div class="alert alert-error">
                    <?php echo $errorMsg; ?>
                </div>
            <?php endif; ?>
            <div class="content-box">
                <h3 style="margin-top:0; color: var(--color-black);"><?php echo htmlspecialchars($rozgrywka['tytul_rozgrywki']); ?></h3>

                <p><i class="fas fa-user-tie" style="width:20px; color:var(--color-magenta);"></i> Organizator: <strong><?php echo htmlspecialchars($rozgrywka['organizator_nazwa']); ?></strong></p>
                <p><i class="far fa-calendar-alt" style="width:20px; color:var(--color-magenta);"></i> Data: <?php echo date("d.m.Y H:i", strtotime($rozgrywka['data_rozgrywki'])); ?></p>
                <p><i class="far fa-clock" style="width:20px; color:var(--color-magenta);"></i> Czas trwania: <?php echo $rozgrywka['czas_trwania']; ?> min</p>

                <?php if ($rozgrywka['notatka_do_gry']): ?>
                    <div class="game-note">
                        "<?php echo nl2br(htmlspecialchars($rozgrywka['notatka_do_gry'])); ?>"
                    </div>
                <?php endif; ?>
            </div>

            <div class="content-box">
                <h3 style="margin-top:0;">Wyniki</h3>
                <table>
                    <thead>
                        <tr>
                            <th style="width: 50px; text-align:center;">#</th>
                            <th>Gracz</th>
                            <th style="width: 120px; text-align:center;">Wynik</th>
                            <th style="width: 150px; text-align:right;">Opcje</th>
                        </tr>
                    </thead>
                    <tbody>
                       <?php
                        $rank = 1;
                        foreach ($uczestnicy as $u): ?>
                            <?php
                            // Sprawdzamy uprawnienia do edycji
                            $isEditable = ($isGlobalAdmin || $isOrganizer || $u['id_uzytkownika'] == $currentUserId);
                            $sheetData = !empty($u['dane_arkusza']) ? json_decode($u['dane_arkusza'], true) : [];
                            ?>
                            <tr>
                                <td style="text-align:center;"><?php echo $rank++; ?></td>
                                <td>
                                    <?php
                                    if (!empty($u['nazwa_tymczasowa_gracza'])) {
                                        echo '<strong>' . htmlspecialchars($u['nazwa_tymczasowa_gracza']) . '</strong>';
                                        echo ' <small style="color:#888;">(' . htmlspecialchars($u['nazwa_uzytkownika']) . ')</small>';
                                    } else {
                                        echo '<strong>' . htmlspecialchars($u['nazwa_uzytkownika']) . '</strong>';
                                    }

                                    if ($u['id_uzytkownika'] == $rozgrywka['id_organizatora']) {
                                        echo ' <i class="fas fa-crown" title="Organizator" style="color:#f1c40f; margin-left:5px;"></i>';
                                    }
                                    ?>
                                </td>
                                <td style="text-align:center;">
                                    <span style="background:var(--color-magenta); color:white; padding:5px 15px; border-radius:15px; font-weight:bold; display:inline-block;">
                                        <?php echo intval($u['wynik_koncowy']); ?>
                                    </span>
                                </td>
                                <td style="text-align:right;">
                                    <?php if ($arkuszJson): ?>
                                        <button class="toggle-sheet-btn" onclick="toggleSheet(<?php echo $u['id_uzytkownika']; ?>)">
                                            <?php if ($isEditable): ?>
                                                <i class="fas fa-edit"></i> Edytuj
                                            <?php else: ?>
                                                <i class="fas fa-eye"></i> Podgląd
                                            <?php endif; ?>
                                        </button>
                                    <?php else: ?>
                                        <small style="color:#999;">Brak arkusza</small>
                                    <?php endif; ?>
                                </td>
                            </tr>

                            <?php 
                            // ZMIANA: Warunek if ($arkuszJson && $isEditable) zmieniony na if ($arkuszJson)
                            // Dzięki temu arkusz generuje się dla każdego, ale pola będą zablokowane niżej
                            if ($arkuszJson): 
                            ?>
                                <tr id="sheet-<?php echo $u['id_uzytkownika']; ?>" style="display:none;">
                                    <td colspan="4" style="background-color: #fdfdfd;">
                                        <div class="score-sheet-wrapper">
                                            <form method="POST" action="rozgrywka.php?id_rozgrywki=<?php echo $rozgrywkaId; ?>">
                                                <input type="hidden" name="action" value="save_score">
                                                <input type="hidden" name="player_id" value="<?php echo $u['id_uzytkownika']; ?>">
                                                <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token'] ?? ''; ?>">

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
                                                            <?php echo (isset($cat['allow_negative']) && $cat['allow_negative']) ? '' : 'min="0"'; ?>
                                                            <?php echo $isEditable ? '' : 'disabled style="background-color:#eee; color:#555;"'; ?>>
                                                    </div>
                                                <?php endforeach; ?>

                                                <div class="total-score-live">
                                                    Suma: <span id="total-<?php echo $u['id_uzytkownika']; ?>"><?php echo intval($u['wynik_koncowy']); ?></span>
                                                </div>
                                                
                                                <?php if ($isEditable): ?>
                                                <div style="text-align:right; margin-top:20px;">
                                                    <button type="submit" class="btn-small" style="width:auto; display:inline-block; margin-left:auto;">
                                                        Zapisz wynik
                                                    </button>
                                                </div>
                                                <?php endif; ?>
                                                
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            <?php endif; ?>

                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>

            <div class="content-box">
                <h3 style="margin-top:0;">Dyskusja</h3>

                <form method="POST" style="margin-bottom:30px;">
                    <textarea name="tresc_komentarza" rows="3" placeholder="Dodaj komentarz..." required></textarea>
                    <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token'] ?? ''; ?>">
                    <button type="submit" class="btn-small" style="width:auto;">Wyślij komentarz</button>
                </form>

                <div class="comment-list">
                    <?php if (empty($komentarze)): ?>
                        <p style="color:#777; font-style:italic;">Brak komentarzy. Bądź pierwszy!</p>
                    <?php else: ?>
                        <?php foreach ($komentarze as $k): ?>
                            <div class="comment-item">
                                <div class="comment-avatar">
                                    <?= strtoupper(substr($k['nazwa_uzytkownika'], 0, 1)) ?>
                                </div>
                                <div class="comment-content">
                                    <div class="comment-meta">
                                        <strong><?php echo htmlspecialchars($k['nazwa_uzytkownika']); ?></strong>
                                        &bull; <?php echo date("d.m.Y H:i", strtotime($k['data_dodania'])); ?>
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
        // Obsługa sidebara
        document.getElementById('sidebarCollapse').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('collapsed');
        });

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