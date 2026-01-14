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
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="dashboard-wrapper">
    <div class="main-content">
        <div class="form-container">
        <h2>Zarejestruj się</h2>
        <form action="../api/register.php" method="POST">
            <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">

            <input type="text" name="username" placeholder="Nazwa użytkownika" required>
            <input type="email" name="email" placeholder="Adres e-mail" required>
            <input type="password" name="password" placeholder="Hasło" required>
            <button class="btn-small save" type="submit">Załóż konto</button>
        </form>
        <a href="index.php">Masz już konto? Zaloguj się</a>
    
        </div>
    </div>
    </div>
</body>
</html>