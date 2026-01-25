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
$userId = $_SESSION['user_id'];
$rozgrywka = null;
$uczestnicy = [];
$komentarze = [];
$errorMsg = "";

try {
    // A. Pobranie szczegółów rozgrywki
    $sqlGame = "SELECT r.id_rozgrywki, r.data_rozgrywki, r.tytul_rozgrywki, r.czas_trwania, r.notatka_do_gry,
                       p.tytul_planszowki
                FROM rozgrywka r
                JOIN planszowka p ON r.id_planszowki = p.id_planszowki
                WHERE r.id_rozgrywki = :id";

    $stmt = $pdo->prepare($sqlGame);
    $stmt->execute(['id' => $rozgrywkaId]);
    $rozgrywka = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$rozgrywka) {
        die("Nie znaleziono rozgrywki.");
    }

    // B. Pobranie uczestników (posortowanych po wyniku malejąco)
    $sqlPlayers = "SELECT u.nazwa_uzytkownika, ur.wynik_koncowy, ur.id_uzytkownika
                   FROM uczestnicy_rozgrywki ur
                   JOIN uzytkownik u ON ur.id_uzytkownika = u.id_uzytkownika
                   WHERE ur.id_rozgrywki = :id
                   ORDER BY ur.wynik_koncowy DESC";

    $stmtPlayers = $pdo->prepare($sqlPlayers);
    $stmtPlayers->execute(['id' => $rozgrywkaId]);
    $uczestnicy = $stmtPlayers->fetchAll(PDO::FETCH_ASSOC);

    // C. Obsługa dodawania komentarza (POST)
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'add_comment') {
        $tresc = trim($_POST['tresc_komentarza'] ?? '');

        if (!empty($tresc)) {
            // POPRAWKA: Używamy kolumny 'zawartosc' zamiast 'tresc_komentarza'
            $sqlInsert = "INSERT INTO komentarz (id_autora, id_rozgrywki, zawartosc, data_dodania)
                          VALUES (:autor, :rozgrywka, :tresc, NOW())";
            $stmtInsert = $pdo->prepare($sqlInsert);
            $stmtInsert->execute([
                'autor' => $userId,
                'rozgrywka' => $rozgrywkaId,
                'tresc' => $tresc
            ]);

            // Przeładowanie strony (PRG Pattern)
            header("Location: rozgrywka.php?id_rozgrywki=" . $rozgrywkaId);
            exit();
        } else {
            $errorMsg = "Komentarz nie może być pusty.";
        }
    }

    // D. Pobranie komentarzy (od najnowszych)
    // POPRAWKA: Używamy kolumny 'k.zawartosc'
    $sqlComments = "SELECT k.zawartosc, k.data_dodania, u.nazwa_uzytkownika
                    FROM komentarz k
                    JOIN uzytkownik u ON k.id_autora = u.id_uzytkownika
                    WHERE k.id_rozgrywki = :id
                    ORDER BY k.data_dodania DESC";
    $stmtComments = $pdo->prepare($sqlComments);
    $stmtComments->execute(['id' => $rozgrywkaId]);
    $komentarze = $stmtComments->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Błąd bazy danych: " . $e->getMessage());
}

// Wyznaczenie najwyższego wyniku w celu wyróżnienia
$maxScore = null;
if (!empty($uczestnicy)) {
    $maxScore = $uczestnicy[0]['wynik_koncowy'];
}
?>

<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <title>Szczegóły Rozgrywki - <?php echo htmlspecialchars($rozgrywka['tytul_planszowki']); ?></title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&family=Tilt+Neon&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        /* Lokalne style specyficzne dla widoku szczegółów */
        .game-details-header {
            background-color: var(--color-white);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            border-left: 5px solid var(--color-magenta);
        }

        .game-meta {
            display: flex;
            gap: 20px;
            color: var(--color-grey-dark);
            margin-top: 10px;
            font-size: 0.9em;
        }

        .game-note {
            margin-top: 15px;
            font-style: italic;
            background: var(--color-platinum);
            padding: 10px;
            border-radius: 5px;
        }

        /* Tabela wyników */
        .results-table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--color-white);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .results-table th,
        .results-table td {
            padding: 15px 20px;
            text-align: left;
            border-bottom: 1px solid var(--color-platinum);
        }

        .results-table th {
            background-color: var(--color-black);
            color: var(--color-white);
            text-transform: uppercase;
            font-size: 0.85em;
            letter-spacing: 1px;
        }

        /* Wyróżnienie zwycięzcy */
        .winner-row {
            background-color: rgba(128, 26, 134, 0.1);
            /* Lekki fiolet */
            font-weight: bold;
            position: relative;
        }

        .winner-row td:first-child::before {
            content: '👑 ';
        }

        .winner-row td {
            color: var(--color-magenta);
            border-bottom: 1px solid var(--color-mauve);
        }

        /* Sekcja Pluginu (Placeholder) */
        .plugin-section {
            margin-bottom: 30px;
            padding: 20px;
            border: 2px dashed var(--color-grey-border);
            border-radius: 10px;
            text-align: center;
            color: var(--color-grey-dark);
        }

        /* Sekcja Komentarzy */
        .comments-section {
            background-color: var(--color-white);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .comment-form {
            display: flex;
            flex-direction: column;
            margin-bottom: 30px;
        }

        .comment-form textarea {
            width: 100%;
            min-height: 80px;
            padding: 10px;
            border: 1px solid var(--color-grey-border);
            border-radius: 5px;
            margin-bottom: 10px;
            font-family: inherit;
            resize: vertical;
        }

        .comment-form button {
            align-self: flex-end;
            background-color: var(--color-magenta);
            color: var(--color-white);
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s;
        }

        .comment-form button:hover {
            background-color: var(--color-mauve);
        }

        .comment-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .comment-item {
            border-bottom: 1px solid var(--color-platinum);
            padding: 15px 0;
        }

        .comment-item:last-child {
            border-bottom: none;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
            font-size: 0.85em;
            color: var(--color-grey-dark);
        }

        .comment-author {
            font-weight: bold;
            color: var(--color-black);
        }

        .comment-text {
            white-space: pre-wrap;
            /* Zachowuje nowe linie */
            line-height: 1.4;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: var(--color-grey-dark);
            font-weight: bold;
            transition: color 0.3s;
        }

        .back-btn:hover {
            color: var(--color-magenta);
        }

        .alert-error {
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>

<body>
    <div class="dashboard-wrapper">
        <?php include 'sidebar.php'; ?>

        <div class="main-content">
            <div class="top-header">
                <button type="button" id="sidebarCollapse" class="toggle-btn">☰</button>
                <h2>Szczegóły Rozgrywki</h2>
            </div>

            <a href="rozgrywki.php" class="back-btn">← Powrót do listy rozgrywek</a>

            <?php if ($errorMsg): ?>
                <div class="alert-error"><?php echo htmlspecialchars($errorMsg); ?></div>
            <?php endif; ?>

            <div class="game-details-header">
                <h1 style="margin: 0; color: var(--color-black);">
                    <?php echo htmlspecialchars($rozgrywka['tytul_planszowki']); ?>
                    <?php if (!empty($rozgrywka['tytul_rozgrywki'])): ?>
                        <small style="color: var(--color-grey-dark); font-weight: normal;">
                            - <?php echo htmlspecialchars($rozgrywka['tytul_rozgrywki']); ?>
                        </small>
                    <?php endif; ?>
                </h1>

                <div class="game-meta">
                    <span>📅 Data: <b><?php echo htmlspecialchars($rozgrywka['data_rozgrywki']); ?></b></span>
                    <span>⏳ Czas: <b><?php echo htmlspecialchars($rozgrywka['czas_trwania']); ?> min</b></span>
                </div>

                <?php if (!empty($rozgrywka['notatka_do_gry'])): ?>
                    <div class="game-note">
                        Notatka: <?php echo nl2br(htmlspecialchars($rozgrywka['notatka_do_gry'])); ?>
                    </div>
                <?php endif; ?>
            </div>

            <h3 style="margin-bottom: 15px;">Ranking Graczy</h3>
            <table class="results-table">
                <thead>
                    <tr>
                        <th>Miejsce</th>
                        <th>Gracz</th>
                        <th style="text-align: right;">Wynik</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $rank = 1;
                    foreach ($uczestnicy as $gracz):
                        $isWinner = ($gracz['wynik_koncowy'] === $maxScore);
                        $rowClass = $isWinner ? 'winner-row' : '';
                    ?>
                        <tr class="<?php echo $rowClass; ?>">
                            <td><?php echo $rank++; ?></td>
                            <td><?php echo htmlspecialchars($gracz['nazwa_uzytkownika']); ?></td>
                            <td style="text-align: right;"><?php echo htmlspecialchars($gracz['wynik_koncowy']); ?> pkt</td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>

            <div class="plugin-section" id="pluginContainer">
                <h3>Szczegóły punktacji</h3>
                <p>W przyszłości tutaj pojawi się szczegółowy podgląd punktacji z wybranego pluginu.</p>
            </div>

            <h3 style="margin-bottom: 15px;">Komentarze do rozgrywki</h3>
            <div class="comments-section">

                <form method="POST" action="" class="comment-form">
                    <input type="hidden" name="action" value="add_comment">
                    <label for="tresc_komentarza" style="margin-bottom: 5px; font-weight: bold;">Dodaj komentarz:</label>
                    <textarea name="tresc_komentarza" id="tresc_komentarza" placeholder="Napisz coś o tej rozgrywce..." required></textarea>
                    <button type="submit">Opublikuj komentarz</button>
                </form>

                <ul class="comment-list">
                    <?php if (empty($komentarze)): ?>
                        <li style="color: var(--color-grey-dark); padding: 10px 0;">Brak komentarzy. Bądź pierwszy!</li>
                    <?php else: ?>
                        <?php foreach ($komentarze as $kom): ?>
                            <li class="comment-item">
                                <div class="comment-header">
                                    <span class="comment-author"><?php echo htmlspecialchars($kom['nazwa_uzytkownika']); ?></span>
                                    <span class="comment-date"><?php echo htmlspecialchars($kom['data_dodania']); ?></span>
                                </div>
                                <div class="comment-text"><?php echo nl2br(htmlspecialchars($kom['zawartosc'])); ?></div>
                            </li>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </ul>
            </div>

        </div>
    </div>

    <script>
        document.getElementById('sidebarCollapse').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('collapsed');
        });
    </script>
</body>

</html>