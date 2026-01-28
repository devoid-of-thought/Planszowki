<?php
// api/delete_account.php
session_start();
require_once '../api/db.php';

// 1. Sprawdzenie czy użytkownik jest zalogowany
if (!isset($_SESSION['user_id'])) {
    header("Location: ../login/index.php");
    exit();
}

// 2. Obsługa żądania POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die("Błąd bezpieczeństwa (CSRF).");
    }

    $userId = $_SESSION['user_id'];

    try {
        $pdo->beginTransaction();

        // KROK A: Usuwanie danych ściśle prywatnych (które nie mają wartości dla społeczności)
        
        // 1. Usuwamy kolekcję gier (to prywatna lista posiadania)
        $stmtCollection = $pdo->prepare("DELETE FROM planszowka_w_kolekcji WHERE id_uzytkownika = ?");
        $stmtCollection->execute([$userId]);

        // 2. Usuwamy znajomych i zaproszenia (to relacje prywatne)
        $stmtRel = $pdo->prepare("DELETE FROM relacje_uzytkownikow WHERE id_uzytkownika1 = ? OR id_uzytkownika2 = ?");
        $stmtRel->execute([$userId, $userId]);

        $stmtInv = $pdo->prepare("DELETE FROM zaproszenia_do_znajomych WHERE id_uzytkownika1 = ? OR id_uzytkownika2 = ?");
        $stmtInv->execute([$userId, $userId]);


        // KROK B: Anonimizacja konta (zamiast usuwania)
        // Zmieniamy dane osobowe, ale zostawiamy ID, dzięki czemu:
        // - Plugin nadal należy do tego ID
        // - Komentarze nadal należą do tego ID
        // - Wyniki w grach nadal są przypisane do tego ID

        // Uwaga: Nazwa użytkownika w bazie jest UNIQUE, więc musimy nadać unikalną nazwę, np. "Usunięty_[ID]"
        $newAnonName = "Użytkownik usunięty #" . $userId;

        $stmtAnon = $pdo->prepare("
            UPDATE uzytkownik SET 
                nazwa_uzytkownika = ?, 
                adres_email = NULL, 
                haslo = NULL, 
                zdjecie = NULL,
                id_uprawnien = 3  -- Degradujemy do zwykłego usera (jeśli był adminem)
            WHERE id_uzytkownika = ?
        ");
        
        $stmtAnon->execute([$newAnonName, $userId]);


        $pdo->commit();

        // Wylogowanie
        session_unset();
        session_destroy();

        header("Location: ../login/index.php?msg=account_anonymized");
        exit();

    } catch (PDOException $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        error_log("Błąd anonimizacji konta: " . $e->getMessage());
        die("Wystąpił błąd podczas usuwania konta. Spróbuj ponownie później.");
    }
} else {
    header("Location: ../main/profil.php");
    exit();
}
?>