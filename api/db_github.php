<?php
$host = 'localhost';
$db   = 'baza_planszowek';
$user = 'UŻYTKOWNIK'; // Zmień na swojego użytkownika bazy danych
$pass = 'HASŁO'; // Zmień na swoje hasło
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
    // W produkcji nie wyświetlaj szczegółów błędu użytkownikowi!
    throw new \PDOException($e->getMessage(), (int)$e->getCode());
}
?>ż masz)
│   ├── register.php   (utworzym