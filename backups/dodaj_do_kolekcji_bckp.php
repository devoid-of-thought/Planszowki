<?php
// dodaj_do_kolekcji.php
session_start();
require_once 'api/db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$message = "";

// 1. Pobranie listy gier do formularza (dropdown)
$stmt = $pdo->query("SELECT id_planszowki, tytul_planszowki FROM Planszowka ORDER BY tytul_planszowki ASC");
$gry = $stmt->fetchAll();

// 2. Pobranie listy statusów do formularza
$stmt = $pdo->query("SELECT id_statusu, nazwa_statusu FROM Status");
$statusy = $stmt->fetchAll();

// 3. Obsługa wysłania formularza
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id_gry = $_POST['id_planszowki'];
    $id_statusu = $_POST['id_statusu'];
    $ocena = !empty($_POST['ocena']) ? (int)$_POST['ocena'] : null;
    $komentarz = trim($_POST['komentarz']);

    try {
        $sql = "INSERT INTO Planszowka_w_kolekcji (id_uzytkownika, id_planszowki, ocena, komentarz, id_statusu) 
                VALUES (?, ?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$_SESSION['user_id'], $id_gry, $ocena, $komentarz, $id_statusu]);

        $message = "<p class='success'>Dodano grę do Twojej kolekcji!</p>";
    } catch (PDOException $e) {
        // Obsługa błędów SQL
        if ($e->getCode() == '23000') {
            // Błąd unikalności (Duplicate entry) - zdefiniowany w indeksie unique_user_game
            $message = "<p class='error'>Masz już tę grę w swojej kolekcji!</p>";
        } elseif ($e->getCode() == '45000') {
            // Błąd z Triggera (Walidacja_Oceny_Insert)
            $message = "<p class='error'>Błąd walidacji: Ocena musi być w zakresie 1-10.</p>";
        } else {
            $message = "<p class='error'>Wystąpił błąd: " . $e->getMessage() . "</p>";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Dodaj do kolekcji</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container" style="width: 500px;">
        <h2>Dodaj grę do kolekcji</h2>
        <a href="dashboard.php">← Wróć do Panelu</a>
        <hr>

        <?= $message ?>

        <form action="dodaj_do_kolekcji.php" method="POST">
            
            <label>Wybierz grę z bazy:</label>
            <select name="id_planszowki" required style="width: 100%; padding: 10px; margin-bottom: 10px;">
                <option value="">-- Wybierz grę --</option>
                <?php foreach ($gry as $gra): ?>
                    <option value="<?= $gra['id_planszowki'] ?>">
                        <?= htmlspecialchars($gra['tytul_planszowki']) ?>
                    </option>
                <?php endforeach; ?>
            </select>
            <p style="font-size: 0.8em;">Nie ma Twojej gry? <a href="dodaj_gre.php">Dodaj ją do bazy globalnej</a></p>

            <label>Twój status:</label>
            <select name="id_statusu" required style="width: 100%; padding: 10px; margin-bottom: 10px;">
                <?php foreach ($statusy as $status): ?>
                    <option value="<?= $status['id_statusu'] ?>">
                        <?= htmlspecialchars($status['nazwa_statusu']) ?>
                    </option>
                <?php endforeach; ?>
            </select>

            <label>Twoja ocena (1-10):</label>
            <input type="number" name="ocena" min="1" max="10" placeholder="Opcjonalnie">

            <label>Komentarz:</label>
            <textarea name="komentarz" rows="3" style="width: 100%; padding: 10px; margin-bottom: 10px;" placeholder="Twój komentarz do gry..."></textarea>

            <button type="submit">Dodaj do kolekcji</button>
        </form>
    </div>
</body>
</html>