<?php
session_start();

// Sprawdzamy, czy użytkownik jest zalogowany
if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Moja Kolekcja</title>
    <style>
        body { font-family: sans-serif; padding: 20px; }
        header { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #ccc; padding-bottom: 10px; }
    </style>
</head>
<body>
    <header>
        <h1>Witaj, <?php echo htmlspecialchars($_SESSION['username']); ?>!</h1>
        <a href="api/logout.php" style="color: red;">Wyloguj się</a>
    </header>

    <main>
        <h3>Tu będzie Twoja kolekcja gier (Etap 3)</h3>
        <p>Jesteś zalogowany. Twoje ID to: <?php echo $_SESSION['user_id']; ?></p>
    </main>
</body>
</html>