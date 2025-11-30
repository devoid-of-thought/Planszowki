<?php
require_once 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $user = trim($_POST['username']);
    $email = trim($_POST['email']);
    $pass = $_POST['password'];

    // 1. Walidacja podstawowa
    if (empty($user) || empty($email) || empty($pass)) {
        die("Wypełnij wszystkie pola!");
    }

    // 2. Sprawdzenie czy user już istnieje
    $stmt = $pdo->prepare("SELECT id_uzytkownika FROM Użytkownik WHERE nazwa_uzytkownika = ? OR adres_email = ?");
    $stmt->execute([$user, $email]);
    
    if ($stmt->rowCount() > 0) {
        die("Taki użytkownik lub email już istnieje! <a href='../register.html'>Wróć</a>");
    }

    // 3. Haszowanie hasła (BEZPIECZEŃSTWO)
    $hashed_password = password_hash($pass, PASSWORD_DEFAULT);

    // 4. Przypisanie domyślnej roli (3 = Gracz, sprawdź ID w tabeli Uprawnienia!)
    // Zakładamy, że ID 3 to 'Gracz' w Twojej bazie
    $role_id = 3; 

    // 5. Zapis do bazy
    try {
        $sql = "INSERT INTO Użytkownik (nazwa_uzytkownika, adres_email, haslo, id_uprawnien) VALUES (?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$user, $email, $hashed_password, $role_id]);
        
        echo "Rejestracja udana! <a href='../index.php'>Zaloguj się teraz</a>";
    } catch (PDOException $e) {
        echo "Błąd bazy danych: " . $e->getMessage();
    }
}
?>