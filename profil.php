<?php
// profil.php
session_start();
require_once 'api/db.php';

// 1. Sprawdzenie logowania
if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$userId = $_SESSION['user_id'];
$message = "";

// 2A. Obsługa zmiany hasła
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['change_password'])) {
    $oldPass = $_POST['old_password'];
    $newPass = $_POST['new_password'];
    $confirmPass = $_POST['confirm_password'];

    if (empty($oldPass) || empty($newPass) || empty($confirmPass)) {
        $message = "<p class='error' style='color: red;'>Wszystkie pola hasła są wymagane.</p>";
    } elseif ($newPass !== $confirmPass) {
        $message = "<p class='error' style='color: red;'>Nowe hasła nie są identyczne.</p>";
    } else {
        $stmt = $pdo->prepare("SELECT haslo FROM uzytkownik WHERE id_uzytkownika = ?");
        $stmt->execute([$userId]);
        $user = $stmt->fetch();

        if ($user && password_verify($oldPass, $user['haslo'])) {
            $newHash = password_hash($newPass, PASSWORD_DEFAULT);
            $updateStmt = $pdo->prepare("UPDATE uzytkownik SET haslo = ? WHERE id_uzytkownika = ?");
            if ($updateStmt->execute([$newHash, $userId])) {
                $message = "<p class='success' style='color: green; font-weight: bold;'>Hasło zostało zmienione.</p>";
            } else {
                $message = "<p class='error' style='color: red;'>Błąd bazy danych.</p>";
            }
        } else {
            $message = "<p class='error' style='color: red;'>Stare hasło jest nieprawidłowe.</p>";
        }
    }
}

// 2B. Obsługa zmiany danych (Login / Email)
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['update_profile'])) {
    $newUsername = trim($_POST['new_username']);
    $newEmail = trim($_POST['new_email']);

    if (empty($newUsername) || empty($newEmail)) {
        $message = "<p class='error' style='color: red;'>Nazwa użytkownika i email są wymagane.</p>";
    } else {
        try {
            $updateStmt = $pdo->prepare("UPDATE uzytkownik SET nazwa_uzytkownika = ?, adres_email = ? WHERE id_uzytkownika = ?");
            if ($updateStmt->execute([$newUsername, $newEmail, $userId])) {
                $_SESSION['username'] = $newUsername; // Aktualizacja sesji
                $message = "<p class='success' style='color: green; font-weight: bold;'>Dane zostały zaktualizowane.</p>";
            }
        } catch (PDOException $e) {
            $message = "<p class='error' style='color: red;'>Błąd: " . $e->getMessage() . "</p>";
        }
    }
}

// 3. Pobranie aktualnych danych użytkownika
try {
    // Upewnij się, że w bazie masz kolumnę 'adres_email'. Jeśli nazywa się 'email', zmień to poniżej.
    $sqlUser = "SELECT nazwa_uzytkownika, adres_email FROM uzytkownik WHERE id_uzytkownika = ?";
    $stmtUser = $pdo->prepare($sqlUser);
    $stmtUser->execute([$userId]);
    $userData = $stmtUser->fetch();

    $sqlCount = "SELECT COUNT(*) as total FROM planszowka_w_kolekcji WHERE id_uzytkownika = ?";
    $stmtCount = $pdo->prepare($sqlCount);
    $stmtCount->execute([$userId]);
    $stats = $stmtCount->fetch();
} catch (PDOException $e) {
    die("Błąd: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <title>Mój Profil</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&family=Tilt+Neon&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

    <div class="dashboard-wrapper">

        <nav id="sidebar" class="sidebar">
            <div class="sidebar-header">
                Planszówki
            </div>

            <a href="dashboard.php">Moja Kolekcja</a>
            <a href="profil.php" style="background-color: var(--color-magenta); color: var(--color-white); border-left: 4px solid var(--color-mauve);">Mój Profil</a>
            <a href="rozgrywki.php">Rozgrywki</a>
            <a href="znajomi.php">Znajomi</a>
            <a href="logout.php" class="logout-link">Wyloguj się</a>
        </nav>

        <div class="main-content">

            <div class="top-header">
                <button type="button" id="sidebarCollapse" class="toggle-btn">
                    ☰ Menu
                </button>
                <h2>Twój Profil</h2>
            </div>

            <div class="profile-section">
                <div class="profile-header">
                    <div class="avatar-placeholder">
                        <?= strtoupper(substr($userData['nazwa_uzytkownika'], 0, 1)) ?>
                    </div>
                    <div>
                        <h3 style="margin: 0 0 5px 0;"><?= htmlspecialchars($userData['nazwa_uzytkownika']) ?></h3>
                        <p style="margin: 0; color: gray;"><?= htmlspecialchars($userData['adres_email'] ?? 'Brak emaila') ?></p>
                    </div>
                </div>

                <div>
                    <h4>Statystyki</h4>
                    <div class="stat-box">
                        <span class="stat-number"><?= $stats['total'] ?></span>
                        Gier w kolekcji
                    </div>
                </div>
            </div>

            <?php if (!empty($message)) echo $message; ?>

            <div class="profile-section forms-section">

                <div class="form-profile">
                    <h3>Zmiana hasła</h3>
                    <form action="profil.php" method="POST">
                        <input type="hidden" name="change_password" value="1">

                        <label>Stare hasło</label>
                        <input type="password" name="old_password" required>

                        <label>Nowe hasło</label>
                        <input type="password" name="new_password" required>

                        <label>Potwierdź nowe hasło</label>
                        <input type="password" name="confirm_password" required>

                        <button type="submit" class="btn-small">Zmień hasło</button>
                    </form>
                </div>

                <div class="form-profile">
                    <h3>Edytuj dane</h3>
                    <form action="profil.php" method="POST">
                        <input type="hidden" name="update_profile" value="1">

                        <label>Nazwa użytkownika</label>
                        <input type="text" name="new_username" value="<?= htmlspecialchars($userData['nazwa_uzytkownika']) ?>" required>

                        <label>Adres email</label>
                        <input type="email" name="new_email" value="<?= htmlspecialchars($userData['adres_email'] ?? '') ?>" required>

                        <button type="submit" class="btn-small">Zapisz zmiany</button>
                    </form>
                </div>

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