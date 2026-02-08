    <?php
    // main/profil.php
    session_start();
    require_once '../api/db.php';

    // 1. Sprawdzenie logowania
    if (!isset($_SESSION['user_id'])) {
        header("Location: ../login/index.php");
        exit();
    }

    // Zabezpieczenie: Generowanie tokena CSRF
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }

    $userId = $_SESSION['user_id'];
    $message = "";

    // 2. Obsługa formularzy (POST)
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        
        // --- WERYFIKACJA CSRF ---
        if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
            die("Błąd bezpieczeństwa (CSRF). Odśwież stronę i spróbuj ponownie.");
        }

        // 2A. Obsługa zmiany hasła
        if (isset($_POST['change_password'])) {
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
        if (isset($_POST['update_profile'])) {
            $newUsername = trim($_POST['new_username']);
            $newEmail = trim($_POST['new_email']);

            if (empty($newUsername) || empty($newEmail)) {
                $message = "<p class='error' style='color: red;'>Nazwa użytkownika i email są wymagane.</p>";
            } else {
                try {
                    // KROK 1: Sprawdzenie czy nazwa lub email są już zajęte przez KOGOŚ INNEGO
                    $checkStmt = $pdo->prepare("SELECT id_uzytkownika FROM uzytkownik WHERE (nazwa_uzytkownika = ? OR adres_email = ?) AND id_uzytkownika != ?");
                    $checkStmt->execute([$newUsername, $newEmail, $userId]);

                    if ($checkStmt->rowCount() > 0) {
                        $message = "<p class='error' style='color: red;'>Ta nazwa użytkownika lub adres email są już zajęte przez inną osobę.</p>";
                    } else {
                        // KROK 2: Aktualizacja danych
                        $updateStmt = $pdo->prepare("UPDATE uzytkownik SET nazwa_uzytkownika = ?, adres_email = ? WHERE id_uzytkownika = ?");
                        if ($updateStmt->execute([$newUsername, $newEmail, $userId])) {
                            $_SESSION['username'] = $newUsername; 
                            $message = "<p class='success' style='color: green; font-weight: bold;'>Dane zostały zaktualizowane.</p>";
                        }
                    }
                } catch (PDOException $e) {
                    // Dodatkowe zabezpieczenie na wypadek błędu bazy
                    if ($e->getCode() == '23000') {
                        $message = "<p class='error' style='color: red;'>Nazwa lub email są już zajęte.</p>";
                    } else {
                        $message = "<p class='error' style='color: red;'>Błąd: " . $e->getMessage() . "</p>";
                    }
                }
            }
        }
    }

    // 3. Pobranie aktualnych danych użytkownika
    try {
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
        <link rel="stylesheet" href="../css/style.css">
    </head>

    <body>

        <div class="dashboard-wrapper">

            <?php include 'sidebar.php'; ?>

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
                    <div class="delete-account-container">
                    <div>
                        <strong>Uwaga:</strong> Usunięcie konta jest nieodwracalne i spowoduje utratę wszystkich danych.
                    </div>
                    <div style="align-self: flex-end;">
                        <form action="../api/delete_account.php" method="POST" onsubmit="return confirm('Czy na pewno chcesz usunąć swoje konto? Ta operacja jest nieodwracalna.');">
                            <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">
                            <button type="submit" class="btn-small" >Usuń konto</button>
                        </form >
</div>
                    </div>
                </div>

                <?php if (!empty($message)) echo $message; ?>

                <div class="profile-section forms-section">

                    <div class="form-profile">
                        <h3>Zmiana hasła</h3>
                        <form action="profil.php" method="POST">
                            <input type="hidden" name="change_password" value="1">
                            <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">

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
                            <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">

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