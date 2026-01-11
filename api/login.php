<?php
// api/login.php
require_once 'db.php';

// 1. Sprawdzamy, czy użytkownik zaznaczył "Zapamiętaj mnie"
// Robimy to PRZED session_start()
if (isset($_POST['remember'])) {
    // Ustawiamy czas życia ciasteczka na 30 dni (w sekundach)
    $lifetime = 30 * 24 * 60 * 60; // 2 592 000 sekund
} else {
    // Domyślnie: 0 (ciasteczko wygasa po zamknięciu przeglądarki)
    $lifetime = 0;
}

// 2. Konfiguracja parametrów ciasteczka sesyjnego
session_set_cookie_params([
    'lifetime' => $lifetime,
    'path' => '/',           // Dostępne w całej domenie
    'domain' => '',          // Domyślna domena
    'secure' => false,       // Ustaw na true, jeśli masz HTTPS
    'httponly' => true,      // Ważne dla bezpieczeństwa (JS nie ma dostępu)
    'samesite' => 'Strict'   // Ochrona przed CSRF
]);

// 3. Dopiero teraz startujemy sesję
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $login = trim($_POST['login']);
    $password = trim($_POST['password']);

    // Pobranie użytkownika z bazy (logowanie po nazwie LUB emailu)
    $stmt = $pdo->prepare("SELECT id_uzytkownika, nazwa_uzytkownika, haslo FROM Uzytkownik WHERE nazwa_uzytkownika = ? OR adres_email = ?");
    $stmt->execute(params: [$login, $login]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['haslo'])) {
        // Logowanie poprawne

        // Regeneracja ID sesji dla bezpieczeństwa (chroni przed session fixation)
        session_regenerate_id(delete_old_session: true);

        $_SESSION['user_id'] = $user['id_uzytkownika'];
        $_SESSION['username'] = $user['nazwa_uzytkownika'];

        header(header: "Location: ../dashboard.php");
        exit();
    } else {
        // Błąd logowania
        header("Location: ../index.php?error=1");
        exit();
    }
} else {
    header("Location: ../index.php");
    exit();
}
?>