<?php
// add/dodaj_plugin.php
session_start();
require_once '../api/db.php';

// 1. Sprawdzenie logowania
if (!isset($_SESSION['user_id'])) {
    header("Location: ../login/index.php");
    exit();
}

if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

$message = "";
$defaultJson = '{
    "meta": {
        "version": "1.0",
        "author": "Twoje Imie"
    },
    "categories": [
        { 
            "id": "punkty_zwyciestwa",
            "name": "Punkty Zwycięstwa",
            "color": "#4CAF50",
            "input_type": "number",
            "default": 0,
            "description": "Główne punkty"
        }
    ]
}';

// 2. Pobranie listy gier
try {
    $stmt = $pdo->query("SELECT id_planszowki, tytul_planszowki FROM planszowka ORDER BY tytul_planszowki ASC");
    $listaGier = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Błąd bazy danych: " . $e->getMessage());
}

// 3. Obsługa formularza
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die("Błąd bezpieczeństwa (CSRF).");
    }

    $nazwaPluginu = trim($_POST['nazwa_pluginu']);
    $jsonContent = trim($_POST['struktura_json']);
    $idPlanszowki = !empty($_POST['id_planszowki']) ? (int)$_POST['id_planszowki'] : null;

    // Walidacja JSON
    $decoded = json_decode($jsonContent);
    if ($decoded === null && json_last_error() !== JSON_ERROR_NONE) {
        $message = "<p class='error'>Błąd: Nieprawidłowy format JSON!</p>";
    } elseif (empty($nazwaPluginu)) {
        $message = "<p class='error'>Nazwa pluginu jest wymagana.</p>";
    } else {
        try {
            $pdo->beginTransaction();

            // A. Dodanie pluginu do tabeli `plugin`
            $sqlPlugin = "INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika) VALUES (?, ?, ?)";
            $stmt = $pdo->prepare($sqlPlugin);
            $stmt->execute([$nazwaPluginu, $jsonContent, $_SESSION['user_id']]);
            $newPluginId = $pdo->lastInsertId();

            // B. (Opcjonalnie) Przypisanie do gry w tabeli `arkusz_punktacji`
            if ($idPlanszowki) {
                // Sprawdź, czy gra nie ma już przypisanego arkusza (opcjonalne, zależne od logiki)
                // W tym kodzie po prostu dodajemy nowy wpis.
                $sqlArkusz = "INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (?, ?, ?)";
                $stmtArkusz = $pdo->prepare($sqlArkusz);
                // Używamy nazwy pluginu jako nazwy arkusza
                $stmtArkusz->execute([$idPlanszowki, $newPluginId, $nazwaPluginu]);
            }

            $pdo->commit();
            $message = "<p class='success'>Plugin został dodany pomyślnie" . ($idPlanszowki ? " i przypisany do gry." : ".") . "</p>";

        } catch (PDOException $e) {
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
    <title>Dodaj Plugin (Arkusz Punktacji)</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&family=Tilt+Neon&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        textarea {
            font-family: 'Courier New', Courier, monospace;
            background-color: #2b2b2b;
            color: #f8f8f2;
            min-height: 300px;
            font-size: 14px;
            line-height: 1.4;
        }
        .json-helper {
            font-size: 0.85em;
            color: #666;
            margin-top: -15px;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>
    <div class="dashboard-wrapper">
        <div class="main-content">
            <div class="top-header">
                <h2>Dodaj Plugin (Szablon Punktacji)</h2>
                <button class="btn-small" onclick="window.location.href='../main/dashboard.php'">← Wróć do Panelu</button>
            </div>

            <div class="form-container" style="max-width: 800px;">
                <?= $message ?>
                
                <form method="POST">
                    <label>Nazwa Pluginu:</label>
                    <input type="text" name="nazwa_pluginu" placeholder="np. Standardowa punktacja do Catan" required>

                    <label>Przypisz do gry (opcjonalne):</label>
                    <select name="id_planszowki">
                        <option value="">-- Nie przypisuj teraz --</option>
                        <?php foreach ($listaGier as $gra): ?>
                            <option value="<?= $gra['id_planszowki'] ?>">
                                <?= htmlspecialchars($gra['tytul_planszowki']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                    <p class="json-helper">Jeśli wybierzesz grę, ten szablon będzie używany podczas dodawania rozgrywek tej gry.</p>

                    <label>Struktura JSON:</label>
                    <textarea class="struktura_json" name="struktura_json" required spellcheck="false"><?= htmlspecialchars($defaultJson) ?></textarea>
                    
                    <input type="hidden" name="csrf_token" value="<?= $_SESSION['csrf_token'] ?>">
                    <button class="btn-small save" type="submit" style="margin-top: 20px;">Zapisz Plugin</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>