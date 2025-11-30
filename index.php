<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Logowanie - Planszówki</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h2>Zaloguj się</h2>
        
        <?php 
        // Wyświetlanie błędów logowania, jeśli przekazano w URL
        if (isset($_GET['error'])) echo "<p class='error'>Błędny login lub hasło!</p>"; 
        ?>

        <form action="api/login.php" method="POST">
            <input type="text" name="login" placeholder="Login lub Email" required>
            <input type="password" name="password" placeholder="Hasło" required>
            <button type="submit">Zaloguj</button>
        </form>
        <a href="register.html">Nie masz konta? Zarejestruj się</a>
    </div>
</body>
</html>