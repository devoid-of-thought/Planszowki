<?php
session_start();
require_once '../api/db.php';

// 1. Weryfikacja logowania
if (!isset($_SESSION['user_id'])) {
    header("Location: ../login/index.php");
    exit();
}

$userId = $_SESSION['user_id'];
$message = "";
$error = "";

// 2. Pobranie ID edytowanej gry
if (!isset($_GET['game_id']) && !isset($_POST['game_id'])) {
    die("Błąd: Nie wybrano gry do edycji.");
}

$collectionId = $_GET['game_id'] ?? $_POST['game_id'];

// 3. OBSŁUGA FORMULARZA (POST)
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    // A. Usuwanie gry z kolekcji
    if (isset($_POST['action']) && $_POST['action'] === 'delete') {
        try {
            $sqlDelete = "DELETE FROM planszowka_w_kolekcji 
                          WHERE id_planszowki_w_kolekcji = ? AND id_uzytkownika = ?";
            $stmtDel = $pdo->prepare($sqlDelete);
            $stmtDel->execute([$collectionId, $userId]);
            
            header("Location: ../main/dashboard.php?msg=deleted");
            exit();
        } catch (PDOException $e) {
            $error = "Błąd podczas usuwania: " . $e->getMessage();
        }
    } 
    // B. Aktualizacja danych (Edycja)
    else {
        $newStatus = $_POST['status'];
        $newRating = !empty($_POST['rating']) ? $_POST['rating'] : null;
        $newComment = trim($_POST['comment']);

        // --- WALIDACJA OCENY (WARSTWA PHP) ---
        if ($newRating !== null && ($newRating < 1 || $newRating > 10)) {
            $error = "Błąd: Ocena musi być liczbą całkowitą z przedziału od 1 do 10.";
        } else {
            try {
                $sqlUpdate = "UPDATE planszowka_w_kolekcji 
                              SET id_statusu = ?, ocena = ?, komentarz = ? 
                              WHERE id_planszowki_w_kolekcji = ? AND id_uzytkownika = ?";
                $stmtUpd = $pdo->prepare($sqlUpdate);
                $stmtUpd->execute([$newStatus, $newRating, $newComment, $collectionId, $userId]);

                $message = "Dane zostały zaktualizowane pomyślnie!";
                
                // Odświeżenie widoku (dane zostaną pobrane ponownie w sekcji 4)
            } catch (PDOException $e) {
                // --- WALIDACJA OCENY (WARSTWA BAZY DANYCH - TRIGGER) ---
                if ($e->getCode() == '45000') {
                    $error = "Błąd walidacji: Ocena musi być w przedziale od 1 do 10.";
                } else {
                    $error = "Błąd aktualizacji: " . $e->getMessage();
                }
            }
        }
    }
}

// 4. POBRANIE DANYCH DO FORMULARZA
try {
    $sqlData = "SELECT k.*, p.tytul_planszowki 
                FROM planszowka_w_kolekcji k
                JOIN planszowka p ON k.id_planszowki = p.id_planszowki
                WHERE k.id_planszowki_w_kolekcji = ? AND k.id_uzytkownika = ?";
    $stmtData = $pdo->prepare($sqlData);
    $stmtData->execute([$collectionId, $userId]);
    $gameData = $stmtData->fetch();

    if (!$gameData) {
        die("Nie znaleziono gry w Twojej kolekcji lub brak uprawnień.");
    }

    $stmtStatus = $pdo->query("SELECT * FROM status");
    $statuses = $stmtStatus->fetchAll();

} catch (PDOException $e) {
    die("Błąd bazy danych: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Edycja: <?php echo htmlspecialchars($gameData['tytul_planszowki']); ?></title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&family=Tilt+Neon&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        /* Styl lokalny specyficzny dla tego widoku */
        .btn-delete {
            background-color: var(--color-mauve);
            color: var(--color-white);
            margin-top: 20px;
            width: 100%;
            border: none;
            padding: 12px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        .btn-delete:hover {
            background-color: #d046de;
            box-shadow: 0 4px 10px rgba(231, 104, 243, 0.4);
        }

        .form-header-info {
            border-bottom: 2px solid var(--color-platinum);
            margin-bottom: 20px;
            padding-bottom: 10px;
        }
        
        .form-header-info h2 {
            margin: 5px 0 0 0;
            color: var(--color-black);
        }
        
        /* Nadpisanie szerokości inputów, aby pasowały do kontenera */
        textarea, select, input[type="number"] {
            width: 100%;
            box-sizing: border-box;
        }
    </style>
</head>
<body>

    <div class="dashboard-wrapper">
        <div class="main-content">
            
            <div class="top-header">
                <h2>Edycja Gry</h2>
                <button class="btn-small" onclick="window.location.href='../main/dashboard.php'">← Wróć do Kolekcji</button>
            </div>

            <div class="form-container">
                
                <?php if ($message): ?>
                    <p class="success" style="color: green; font-weight: bold; text-align:center;"><?php echo htmlspecialchars($message); ?></p>
                <?php endif; ?>

                <?php if ($error): ?>
                    <p class="error" style="color: red; font-weight: bold; text-align:center;"><?php echo htmlspecialchars($error); ?></p>
                <?php endif; ?>

                <form method="POST" action="">
                    <input type="hidden" name="game_id" value="<?php echo htmlspecialchars($collectionId); ?>">

                    <div class="form-header-info">
                        <h2><?php echo htmlspecialchars($gameData['tytul_planszowki']); ?></h2>
                    </div>

                    <label for="status">Status:</label>
                    <select name="status" id="status" required>
                        <?php foreach ($statuses as $status): ?>
                            <option value="<?php echo $status['id_statusu']; ?>" 
                                <?php echo ($status['id_statusu'] == $gameData['id_statusu']) ? 'selected' : ''; ?>>
                                <?php echo htmlspecialchars($status['nazwa_statusu']); ?>
                            </option>
                        <?php endforeach; ?>
                    </select>

                    <label for="rating">Twoja ocena (1-10):</label>
                    <input type="number" name="rating" id="rating" min="1" max="10" placeholder="Brak oceny"
                           value="<?php echo htmlspecialchars($gameData['ocena']); ?>">

                    <label for="comment">Twój komentarz:</label>
                    <textarea name="comment" id="comment" rows="4" placeholder="Własne notatki..."><?php echo htmlspecialchars($gameData['komentarz']); ?></textarea>

                    <button type="submit" class="btn-small save" style="margin-top: 10px;">Zapisz zmiany</button>

                    <button type="submit" name="action" value="delete" class="btn-delete" 
                            onclick="return confirm('Czy na pewno chcesz usunąć tę grę z kolekcji? Operacja jest nieodwracalna.');">
                        Usuń z kolekcji
                    </button>
                </form>

            </div>
        </div>
    </div>

    <script>
        document.getElementById('sidebarCollapse').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('collapsed');
        });
    </script>

</body>
</html>