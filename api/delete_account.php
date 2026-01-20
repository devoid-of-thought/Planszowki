<?php
session_start();
require_once '../api/db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: ../login/index.php");
    exit();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die("Błąd bezpieczeństwa (CSRF).");
    }

    $userId = $_SESSION['user_id'];

    try {
        
        $pdo->beginTransaction();

        $stmtCollection = $pdo->prepare("DELETE FROM planszowka_w_kolekcji WHERE id_uzytkownika = ?");
        $stmtCollection->execute([$userId]);

        $stmtRelations = $pdo->prepare("DELETE FROM relacje_uzytkownikow WHERE id_uzytkownika1 = ? OR id_uzytkownika2 = ?");
        $stmtRelations->execute([$userId, $userId]);
        
        $stmtUser = $pdo->prepare("DELETE FROM uzytkownik WHERE id_uzytkownika = ?");
        $stmtUser->execute([$userId]);

        $pdo->commit();

        session_unset();
        session_destroy();

        header("Location: ../login/index.php?msg=account_deleted");
        exit();

    } catch (PDOException $e) {
        $pdo->rollBack();
        die("Błąd podczas usuwania konta: " . $e->getMessage());
    }
    header("Location: index.php");
} else {
    header("Location: profil.php");
    exit();
}
?>