<?php
require_once 'db.php';
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    // Zabezpieczenie CSRF (z rozwiązania nr 2)
    if (!isset($_POST['csrf_token']) || !isset($_SESSION['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die("Błąd bezpieczeństwa (CSRF). Formularz wygasł lub próba ataku.");
    }

    $user = trim($_POST['username']);
    $email = trim($_POST['email']);
    $pass = $_POST['password'];

    if (empty($user) || empty($email) || empty($pass)) {
        die("Wypełnij wszystkie pola!");
    }

    // Sprawdzenie czy użytkownik istnieje
    $stmt = $pdo->prepare("SELECT id_uzytkownika FROM uzytkownik WHERE nazwa_uzytkownika = ? OR adres_email = ?");
    $stmt->execute([$user, $email]);
    
    if ($stmt->rowCount() > 0) {
        // --- POPRAWKA BŁĘDU NR 6 ---
        // Zamiast pisać "Taki użytkownik istnieje", wyświetlamy ogólny błąd.
        // Dzięki temu atakujący nie wie, czy trafił w istniejący email, czy wystąpił inny problem.
        die("Rejestracja nie powiodła się. Sprawdź wprowadzone dane i spróbuj ponownie. <a href='../login/register.php'>Wróć</a>");
    }

    $hashed_password = password_hash($pass, PASSWORD_DEFAULT);
    $role_id = 3; 

    try {
        $sql = "INSERT INTO uzytkownik (nazwa_uzytkownika, adres_email, haslo, id_uprawnien) VALUES (?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$user, $email, $hashed_password, $role_id]);
        
        $newUserId = $pdo->lastInsertId();

        $_SESSION['user_id'] = $newUserId;
        $_SESSION['username'] = $user;

        header("Location: ../main/dashboard.php");
        exit();

    } catch (PDOException $e) {
        // W produkcji nie należy wyświetlać $e->getMessage() użytkownikowi
        error_log("Błąd rejestracji SQL: " . $e->getMessage()); 
        die("Wystąpił błąd podczas tworzenia konta. Spróbuj ponownie później.");
    }
}
?>  