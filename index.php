<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <title>Logowanie - Planszówki</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Tilt+Neon&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
    <div class="dashboard-wrapper">
        <div class="main-content">
            <div class="form-container">
                <h2>Zaloguj się</h2>

                <?php
                // Wyświetlanie błędów logowania, jeśli przekazano w URL
                if (isset($_GET['error'])) echo "<p class='error'>Błędny login lub hasło!</p>";
                ?>
<form action="api/login.php" method="POST" style="width: 100%;">
    <input type="text" name="login" placeholder="Login lub Email" required>
    <input type="password" name="password" placeholder="Hasło" required>
    
    <div style="display: flex; align-items: center; margin-bottom: 15px; gap: 10px;">
        <input type="checkbox" name="remember" id="remember" style="width: auto; margin: 0;">
        <label for="remember" style="margin: 0; font-weight: normal; font-size: 0.9em;">Zapamiętaj mnie</label>
        <a href="register.html" style="margin-left: auto; font-size: 0.9em; text-decoration: none; color: var(--color-magenta);">Nie masz konta? Zarejestruj się</a>
    </div>

    <button class="btn-small" type="submit" style="width: 100%;">Zaloguj</button>
</form>

            </div>

        
        </div>
    </div>
    </div>
</body>

</html>