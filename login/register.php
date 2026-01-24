<?php
// login/register.php
session_start();

// Generowanie tokena CSRF, jeśli nie istnieje
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}
?>
<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <title>Rejestracja - Planszówki</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Tilt+Neon&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
</head>

<body>
    <div class="dashboard-wrapper">
        <div class="main-content">
            <div class="form-container">
                <h2>Zarejestruj się</h2>
                
                <form action="../api/register.php" method="POST" style="width: 100%;">
                    <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">

                    <input type="text" name="username" placeholder="Nazwa użytkownika" required>
                    <input type="email" name="email" placeholder="Adres e-mail" required>
                    <input type="password" name="password" placeholder="Hasło" required>
                    <button class="btn-small" type="submit" style="width: 100%;">Załóż konto</button>

                    <div style="display: flex; align-items: center; margin-bottom: 15px; gap: 10px;">
                        <a href="index.php" style="margin-left: auto; font-size: 0.9em; text-decoration: none; color: var(--color-magenta);">Masz już konto? Zaloguj się</a>
                    </div>

                </form>

            </div>
        </div>
    </div>
</body>

</html>