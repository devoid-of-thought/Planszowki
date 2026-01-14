<?php
// add/dodaj_gre.php
session_start();
require_once '../api/db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: ../login/index.php");
    exit();
}
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}
$message = "";

// 1. Pobranie listy gatunków z bazy do wyświetlenia w formularzu
try {
    $stmtGatunki = $pdo->query("SELECT id_gatunku, nazwa_gatunku FROM gatunek ORDER BY nazwa_gatunku ASC");
    $listaGatunkow = $stmtGatunki->fetchAll();
} catch (PDOException $e) {
    die("Błąd bazy danych (pobieranie gatunków): " . $e->getMessage());
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die("Błąd bezpieczeństwa (CSRF).");
    }

    $tytul = trim($_POST['tytul']);
    // Pobieranie danych opcjonalnych
    $rok = !empty($_POST['rok']) ? (int)$_POST['rok'] : null;
    $wydawca = !empty($_POST['wydawca']) ? trim($_POST['wydawca']) : null;
    $designer = !empty($_POST['designer']) ? trim($_POST['designer']) : null;
    $min_graczy = !empty($_POST['min_graczy']) ? (int)$_POST['min_graczy'] : null;
    $max_graczy = !empty($_POST['max_graczy']) ? (int)$_POST['max_graczy'] : null;
    $min_czas = !empty($_POST['min_czas']) ? (int)$_POST['min_czas'] : null;
    $max_czas = !empty($_POST['max_czas']) ? (int)$_POST['max_czas'] : null;
    $waga = !empty($_POST['waga']) ? (float)$_POST['waga'] : null;
    $wiek = !empty($_POST['wiek']) ? (int)$_POST['wiek'] : null;

    // Pobranie zaznaczonych gatunków (tablica ID)
    // Jeśli nic nie zaznaczono, będzie to pusta tablica
    $wybraneGatunki = $_POST['gatunki'] ?? [];

    $domyslny_status_id = 1; // Posiadam

    if (empty($tytul)) {
        $message = "<p class='error'>Tytuł gry jest wymagany!</p>";
    } else {
        try {
            // Rozpoczęcie transakcji
            $pdo->beginTransaction();

            // A. Dodanie gry do bazy GLOBALNEJ (Tabela planszowka)
            $sqlGlobal = "INSERT INTO planszowka (
                        tytul_planszowki, data_wydania, wydawca, designer, 
                        min_graczy, max_graczy, min_dlugosc_rozgrywki, max_dlugosc_rozgrywki, 
                        waga, rekomendowany_wiek, stworzone_przez_id_uzytkownika
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            $stmt = $pdo->prepare($sqlGlobal);
            $stmt->execute([
                $tytul, $rok, $wydawca, $designer, 
                $min_graczy, $max_graczy, $min_czas, $max_czas, 
                $waga, $wiek, $_SESSION['user_id']
            ]);

            // Pobranie ID nowej gry
            $nowe_id_gry = $pdo->lastInsertId();

            // B. Automatyczne dodanie do KOLEKCJI użytkownika
            $sqlKolekcja = "INSERT INTO planszowka_w_kolekcji 
                            (id_uzytkownika, id_planszowki, id_statusu, ocena, komentarz) 
                            VALUES (?, ?, ?, NULL, 'Dodano automatycznie przy tworzeniu gry')";

            $stmtKolekcja = $pdo->prepare($sqlKolekcja);
            $stmtKolekcja->execute([
                $_SESSION['user_id'],
                $nowe_id_gry,
                $domyslny_status_id
            ]);

            // C. Dodanie GATUNKÓW (Relacja wiele-do-wielu)
            if (!empty($wybraneGatunki)) {
                $sqlGatunek = "INSERT INTO planszowka_gatunek (id_planszowki, id_gatunku) VALUES (?, ?)";
                $stmtGatunek = $pdo->prepare($sqlGatunek);

                foreach ($wybraneGatunki as $idGatunku) {
                    // Wykonujemy INSERT dla każdego zaznaczonego gatunku
                    $stmtGatunek->execute([$nowe_id_gry, (int)$idGatunku]);
                }
            }

            // Zatwierdzenie transakcji (Commit)
            $pdo->commit();

            $message = "<p class='success'>Sukces! Gra <strong>" . htmlspecialchars($tytul) . "</strong> została dodana do bazy (wraz z gatunkami) i Twojej kolekcji.</p>";
        } catch (PDOException $e) {
            // Wycofanie zmian w razie błędu (Rollback)
            $pdo->rollBack();
            $message = "<p class='error'>Błąd bazy danych: " . $e->getMessage() . "</p>";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <title>Dodaj grę</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Tilt+Neon&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        /* Prosty styl CSS dla listy gatunków, żeby wyświetlały się schludnie */
        .genres-wrapper {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            gap: 10px;
            margin: 10px 0 20px 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .genre-option {
            display: flex;
            align-items: center;
            font-size: 0.9em;
            cursor: pointer;
        }
        .genre-option input {
            width: auto;
            margin-right: 8px;
        }
    </style>
</head>

<body>
    <div class="dashboard-wrapper">
        <div class="main-content">
            <div class="top-header">
                <div>
                <h2>Dodaj nową grę</h2>
                <p>Gra zostanie automatycznie dodana do Twojej kolekcji jako "Posiadam".</p>
                </div>
                <button class="btn-small" onclick="window.location.href='../main/dashboard.php'">← Wróć do Panelu</button>
            </div>
            <div class="form-container dodaj-gre">
                <?= $message ?>

                <form action="dodaj_gre.php" method="POST">
                    <input type="text" name="tytul" placeholder="Tytuł gry (wymagane)" required>

                    <label>Wybierz gatunki:</label>
                    <div class="genres-wrapper">
                        <?php foreach ($listaGatunkow as $gatunek): ?>
                            <label class="genre-option">
                                <input type="checkbox" name="gatunki[]" value="<?= $gatunek['id_gatunku'] ?>">
                                <?= htmlspecialchars($gatunek['nazwa_gatunku']) ?>
                            </label>
                        <?php endforeach; ?>
                    </div>

                    <div>
                        <input type="number" name="rok" placeholder="Rok wydania">
                        <input type="number" step="0.01" name="waga" placeholder="Waga (np. 2.5)">
                    </div>

                    <input type="text" name="wydawca" placeholder="Wydawca">
                    <input type="text" name="designer" placeholder="Projektant">

                    <label>Liczba graczy (min - max):</label>
                    <div>
                        <input type="number" name="min_graczy" placeholder="Od">
                        <input type="number" name="max_graczy" placeholder="Do">
                    </div>

                    <label>Czas gry w minutach (min - max):</label>
                    <div>
                        <input type="number" name="min_czas" placeholder="Od">
                        <input type="number" name="max_czas" placeholder="Do">
                    </div>

                    <input type="number" name="wiek" placeholder="Rekomendowany wiek (np. 12)">

                    <button class="btn-small save" type="submit">Zapisz i dodaj do kolekcji</button>
                    <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">
                </form>
            </div>
        </div>
    </div>
</body>

</html>