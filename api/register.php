<?php
require_once 'db.php';
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    // Funkcja pomocnicza do przekierowania z błędem
    function redirectWithError($message) {
        $_SESSION['register_error'] = $message;
        header("Location: ../login/register.php");
        exit();
    }

    // Zabezpieczenie CSRF
    if (!isset($_POST['csrf_token']) || !isset($_SESSION['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        redirectWithError("Błąd bezpieczeństwa (CSRF). Spróbuj ponownie.");
    }

    $user = trim($_POST['username']);
    $email = trim($_POST['email']);
    $pass = $_POST['password'];
    $repeatpass = $_POST['repeat_password'];

    // Walidacja danych
    if (empty($user) || empty($email) || empty($pass)) {
        redirectWithError("Wypełnij wszystkie pola!");
    }

    if ($pass !== $repeatpass) {
        redirectWithError("Hasła nie są identyczne.");
    }

    // Sprawdzenie czy użytkownik istnieje
    $stmt = $pdo->prepare("SELECT id_uzytkownika FROM uzytkownik WHERE nazwa_uzytkownika = ? OR adres_email = ?");
    $stmt->execute([$user, $email]);
    
    if ($stmt->rowCount() > 0) {
        redirectWithError("Użytkownik o podanej nazwie lub adresie e-mail już istnieje.");
    }

    $hashed_password = password_hash($pass, PASSWORD_DEFAULT);
    $role_id = 3; 

    try {
        $sql = "INSERT INTO uzytkownik (nazwa_uzytkownika, adres_email, haslo, id_uprawnien) VALUES (?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$user, $email, $hashed_password, $role_id]);
        
        $newUserId = $pdo->lastInsertId();

        session_regenerate_id(true);
        $_SESSION['user_id'] = $newUserId;
        $_SESSION['username'] = $user;

        header("Location: ../main/dashboard.php");
        exit();

    } catch (PDOException $e) {
        error_log("Błąd rejestracji SQL: " . $e->getMessage()); 
        redirectWithError("Wystąpił błąd podczas tworzenia konta. Spróbuj ponownie później.");
    }
}
?>