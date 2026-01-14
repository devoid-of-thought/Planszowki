<?php
session_start();
require_once 'api/db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$currentUserId = $_SESSION['user_id'];
$message = "";

// 1. Pobranie listy gier
try {
    // Tabela: planszowka
    $stmtGry = $pdo->query("SELECT id_planszowki, tytul_planszowki FROM planszowka ORDER BY tytul_planszowki ASC");
    $listaGier = $stmtGry->fetchAll();

    // 2. Pobranie listy znajomych
    // Tabela: uzytkownik
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

// 3. Obsługa formularza
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}
    $id_planszowki = (int)$_POST['id_planszowki'];
    $data_rozgrywki = $_POST['data_rozgrywki'];
    $czas_trwania = (int)$_POST['czas_trwania'];
    $notatka = trim($_POST['notatka_do_gry']);
    $wybrani_gracze = $_POST['gracze'] ?? [];

    try {
        // Tabela: planszowka
        $stmtCheck = $pdo->prepare("SELECT min_dlugosc_rozgrywki, max_dlugosc_rozgrywki, tytul_planszowki FROM planszowka WHERE id_planszowki = ?");
        $stmtCheck->execute([$id_planszowki]);
        $graInfo = $stmtCheck->fetch();

        if ($graInfo) {
            $min = $graInfo['min_dlugosc_rozgrywki'];
            $max = $graInfo['max_dlugosc_rozgrywki'];

            if ($czas_trwania < 0) {
                $message = "<p class='error'>Błąd: Czas trwania rozgrywki nie może być mniejszy niż 0. Gra: " . htmlspecialchars($graInfo['tytul_planszowki']) . " (Sugerowany: $min-$max min).</p>";
            } else {
                $pdo->beginTransaction();

                // Tabela: rozgrywka
                $sqlInsertRozgrywka = "INSERT INTO rozgrywka (id_planszowki, id_organizatora, data_rozgrywki, czas_trwania, notatka_do_gry)
                                       VALUES (?, ?, ?, ?, ?)";
                $stmtRozgrywka = $pdo->prepare($sqlInsertRozgrywka);
                $stmtRozgrywka->execute([$id_planszowki, $currentUserId, $data_rozgrywki, $czas_trwania, $notatka]);

                $id_nowej_rozgrywki = $pdo->lastInsertId();

                // --- NAPRAWA BŁĘDU 1364 ---
                // Dodajemy 'wynik_koncowy' do zapytania i ustawiamy wartość 0
                $sqlInsertUczestnik = "INSERT INTO uczestnicy_rozgrywki (id_rozgrywki, id_uzytkownika, wynik_koncowy) VALUES (?, ?, 0)";
                $stmtUczestnik = $pdo->prepare($sqlInsertUczestnik);

                // Dodajemy organizatora
                $stmtUczestnik->execute([$id_nowej_rozgrywki, $currentUserId]);

                // Dodajemy wybranych znajomych
                foreach ($wybrani_gracze as $id_znajomego) {
                    $stmtUczestnik->execute([$id_nowej_rozgrywki, (int)$id_znajomego]);
                }

                $pdo->commit();
                header("Location: rozgrywki.php?success=1");
                exit();
            }
        }
    } catch (PDOException $e) {
        if($pdo->inTransaction()) $pdo->rollBack();
        $message = "<p class='error'>Błąd bazy danych: " . $e->getMessage() . "</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Dodaj rozgrywkę</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .search-box { margin-bottom: 5px; padding: 5px; width: 100%; box-sizing: border-box; }
        .friends-list { max-height: 150px; overflow-y: auto; border: 1px solid #ccc; padding: 10px; border-radius: 5px; background: #fff; text-align: center; }
        .friend-item { display: flex; justify-content: center; align-items: center; gap: 10px; color: #1a1a1a; }
        .friend-item input[type="checkbox"] { display: none; }
        .friend-item:hover { background: #f0f0f0; }
        .friend-item:has(input:checked) { background: #eff6ff; border-color: #3b82f6; color: #1d4ed8; }
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
                    <label>Gra:</label>
                    <select name="id_planszowki" required>
                        <option value="">-- Wybierz grę --</option>
                        <?php foreach ($listaGier as $gra): ?>
                            <option value="<?= $gra['id_planszowki'] ?>"><?= htmlspecialchars($gra['tytul_planszowki']) ?></option>
                        <?php endforeach; ?>
                    </select>

                    <label>Data i czas:</label>
                    <div style="display: flex; gap: 10px;">
                        <input type="date" name="data_rozgrywki" required value="<?= date('Y-m-d') ?>">
                        <input type="number" name="czas_trwania" placeholder="Czas (min)" required>
                    </div>

                    <label>Dodaj graczy (znajomi):</label>
                    <input type="text" id="friendSearch" class="search-box" placeholder="Szukaj znajomego..." onkeyup="filterFriends()">
                    <div class="friends-list" id="friendsList">
                        <?php foreach ($listaZnajomych as $znajomy): ?>
                            <label class="friend-item">
                                <input type="checkbox" name="gracze[]" value="<?= $znajomy['id_uzytkownika'] ?>" style="width: 15px; height: 15px; margin: 5px">
                                <span><?= htmlspecialchars($znajomy['nazwa_uzytkownika']) ?></span>
                            </label>
                        <?php endforeach; ?>
                    </div>

                    <label>Notatka:</label>
                    <textarea name="notatka_do_gry"></textarea>

                    <button class="btn-small save" type="submit">Zapisz rozgrywkę</button>
                
                
                <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">
                </form>
            </div>
        </div>
    </div>
    <script>
        function filterFriends() {
            let input = document.getElementById('friendSearch').value.toLowerCase();
            let items = document.querySelectorAll('.friend-item');
            items.forEach(item => {
                let text = item.innerText.toLowerCase();
                item.style.display = text.includes(input) ? "flex" : "none";
            });
        }
    </script>
</body>
</html>