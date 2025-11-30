<?php
session_start();
require_once 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $login = trim($_POST['login']);
    $pass = $_POST['password'];

    // Szukamy użytkownika po nazwie LUB emailu
    $sql = "SELECT id_uzytkownika, nazwa_uzytkownika, haslo, id_uprawnien FROM Użytkownik WHERE nazwa_uzytkownika = ? OR adres_email = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$login, $login]);
    $user = $stmt->fetch();

    // Weryfikacja hasła
    if ($user && password_verify($pass, $user['haslo'])) {
        // SUKCES - Ustawiamy zmienne sesyjne
        $_SESSION['user_id'] = $user['id_uzytkownika'];
        $_SESSION['username'] = $user['nazwa_uzytkownika'];
        $_SESSION['role'] = $user['id_uprawnien'];

        // Przekierowanie do Panelu Głównego (który zaraz stworzymy)
        header("Location: ../dashboard.php");
        exit();
    } else {
        // BŁĄD
        header("Location: ../index.php?error=1");
        exit();
    }
}
?>