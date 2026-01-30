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

// 2. Sprawdzenie czy ID gry zostało podane
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
            
            // Przekierowanie z komunikatem
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

        try {
            $sqlUpdate = "UPDATE planszowka_w_kolekcji 
                          SET id_statusu = ?, ocena = ?, komentarz = ? 
                          WHERE id_planszowki_w_kolekcji = ? AND id_uzytkownika = ?";
            $stmtUpd = $pdo->prepare($sqlUpdate);
            $stmtUpd->execute([$newStatus, $newRating, $newComment, $collectionId, $userId]);

            $message = "Dane zostały zaktualizowane pomyślnie!";
        } catch (PDOException $e) {
            $error = "Błąd aktualizacji: " . $e->getMessage();
        }
    }
}

// 4. POBRANIE DANYCH DO FORMULARZA
try {
    // Pobieramy dane wpisu w kolekcji ORAZ tytuł gry
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

    // Pobranie listy statusów
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
        /* Styl dla przycisku usuwania - kolor MAUVE (zgodny z systemem) */
        .btn-delete {
            background-color: var(--color-mauve, #cba6f7); /* Fallback jeśli zmienna nie zadziała */
            color: #fff; /* Biały tekst dla kontrastu */
            margin-top: 30px;
            width: 100%;
            border: none;
            cursor: pointer;
            transition: filter 0.2s ease;
        }
        
        .btn-delete:hover {
            /* Przyciemnienie przycisku po najechaniu, zamiast zmiany na inny kolor */
            filter: brightness(0.85);
        }
        
        .form-header-info {
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .form-header-info h2 {
            margin-top: 0;
            color: var(--color-text);
        }
    </style>
</head>
<body>

    <div class="dashboard-wrapper">
        <div class="main-content">
            
            <div class="top-header">
                <div>
                    <h2>Edycja gry</h2>
                    <p>Zmień status, ocenę lub usuń grę z kolekcji.</p>
                </div>
                <button class="btn-small" onclick="window.location.href='../main/dashboard.php'">← Wróć do Panelu</button>
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
                        <label>Edytujesz grę:</label>
                        <h2 style="margin: 5px 0 0 0; font-size: 1.5em;">
                            <?php echo htmlspecialchars($gameData['tytul_planszowki']); ?>
                        </h2>
                    </div>

                    <label for="status">Status w kolekcji:</label>
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
                    <textarea name="comment" id="comment" rows="4" placeholder="Np. kupiona w 2023, brakuje jednego pionka..."><?php echo htmlspecialchars($gameData['komentarz']); ?></textarea>

                    <button type="submit" class="btn-small save">Zapisz zmiany</button>

                    <hr style="width: 100%; border: 0; border-top: 1px solid #eee; margin: 30px 0 10px 0;">
                    
                    <button type="submit" name="action" value="delete" class="btn-small btn-delete" 
                            onclick="return confirm('Czy na pewno chcesz usunąć tę grę ze swojej kolekcji?');">
                        Usuń grę z kolekcji
                    </button>
                </form>

            </div>
        </div>
    </div>

</body>
</html>