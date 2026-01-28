<?php
// api/get_plugins.php
require_once 'db.php';
session_start();

header('Content-Type: application/json');

if (!isset($_GET['id_planszowki']) || !isset($_SESSION['user_id'])) {
    echo json_encode([]);
    exit;
}

$idGry = (int)$_GET['id_planszowki'];
$userId = $_SESSION['user_id'];

try {
    // Pobieramy pluginy:
    // 1. Globalne (stworzone przez ID 1 lub NULL)
    // 2. Lokalne (stworzone przez zalogowanego użytkownika)
    $sql = "SELECT 
                p.id_pluginu, 
                p.nazwa_pluginu,
                p.stworzone_przez_id_uzytkownika
            FROM plugin p
            JOIN arkusz_punktacji ap ON p.id_pluginu = ap.id_pluginu
            WHERE ap.id_planszowki = :idGry
            AND (
                p.stworzone_przez_id_uzytkownika IS NULL 
                OR p.stworzone_przez_id_uzytkownika = 1
                OR p.stworzone_przez_id_uzytkownika = :userId
            )";

    $stmt = $pdo->prepare($sql);
    $stmt->execute(['idGry' => $idGry, 'userId' => $userId]);
    $plugins = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Formatujemy dane dla frontendu
    $result = [];
    foreach ($plugins as $p) {
        $type = ($p['stworzone_przez_id_uzytkownika'] == $userId) ? "[Twój]" : "[Globalny]";
        $result[] = [
            'id' => $p['id_pluginu'],
            'name' => "$type " . $p['nazwa_pluginu']
        ];
    }

    echo json_encode($result);

} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}