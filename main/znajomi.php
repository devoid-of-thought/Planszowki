<?php
// main/znajomi.php
session_start();
require_once '../api/db.php';

// 1. Sprawdzenie logowania
if (!isset($_SESSION['user_id'])) {
    header("Location: ../login/index.php");
    exit();
}

// Zabezpieczenie: Generowanie tokena CSRF
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(string: random_bytes(32));
}

$currentUserId = $_SESSION['user_id'];
$message = "";

// --- LOGIKA AKCJI (DODAWANIE / AKCEPTACJA / ODRZUCENIE) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // Weryfikacja CSRF dla wszystkich akcji POST
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die("Błąd bezpieczeństwa (CSRF).");
    }

    // 1. WYSYŁANIE NOWEGO ZAPROSZENIA
    if (isset($_POST['search_name'])) {
        $searchName = trim($_POST['search_name']);
        try {
            $stmt = $pdo->prepare("SELECT id_uzytkownika FROM uzytkownik WHERE nazwa_uzytkownika = ?");
            $stmt->execute([$searchName]);
            $targetUser = $stmt->fetch();

            if (!$targetUser) {
                $message = "Użytkownik o takiej nazwie nie istnieje.";
            } elseif ($targetUser['id_uzytkownika'] == $currentUserId) {
                $message = "Nie możesz dodać samego siebie!";
            } else {
                $targetId = $targetUser['id_uzytkownika'];

                // Sprawdź czy relacja lub zaproszenie już istnieje
                $check = $pdo->prepare("SELECT 1 FROM zaproszenia_do_znajomych WHERE
                    (id_uzytkownika1 = :u1 AND id_uzytkownika2 = :t1) OR
                    (id_uzytkownika1 = :t2 AND id_uzytkownika2 = :u2)");
                $check->execute(['u1' => $currentUserId, 't1' => $targetId, 't2' => $targetId, 'u2' => $currentUserId]);

                if ($check->fetch()) {
                    $message = "Zaproszenie zostało już wysłane lub jesteście znajomymi.";
                } else {
                    $ins = $pdo->prepare("INSERT INTO zaproszenia_do_znajomych (id_uzytkownika1, id_uzytkownika2) VALUES (?, ?)");
                    $ins->execute([$currentUserId, $targetId]);
                    header("Location: znajomi.php?status=sent");
                    exit();
                }
            }
        } catch (PDOException $e) {
            $message = "Błąd: " . $e->getMessage();
        }
    }

    // 2. AKCEPTACJA LUB ODRZUCENIE ZAPROSZENIA
    if (isset($_POST['action']) && isset($_POST['sender_id'])) {
        $senderId = $_POST['sender_id'];

        if ($_POST['action'] === 'accept') {
            try {
                $pdo->beginTransaction();
                // Dodaj do relacji (znajomi)
                $ins = $pdo->prepare("INSERT INTO relacje_uzytkownikow (id_uzytkownika1, id_uzytkownika2, data_rozpoczecia) VALUES (?, ?, NOW())");
                $ins->execute([$senderId, $currentUserId]);

                // Usuń zaproszenie
                $del = $pdo->prepare("DELETE FROM zaproszenia_do_znajomych WHERE id_uzytkownika1 = ? AND id_uzytkownika2 = ?");
                $del->execute([$senderId, $currentUserId]);

                $pdo->commit();
                header("Location: znajomi.php?status=accepted");
                exit();
            } catch (Exception $e) {
                $pdo->rollBack();
                $message = "Błąd akceptacji.";
            }
        }

        if ($_POST['action'] === 'reject') {
            $del = $pdo->prepare("DELETE FROM zaproszenia_do_znajomych WHERE id_uzytkownika1 = ? AND id_uzytkownika2 = ?");
            $del->execute([$senderId, $currentUserId]);
            header("Location: znajomi.php?status=rejected");
            exit();
        }
    }
}

// Komunikaty statusu
if (isset($_GET['status'])) {
    if ($_GET['status'] == 'sent') $message = "Zaproszenie wysłane!";
    if ($_GET['status'] == 'accepted') $message = "Zaproszenie zaakceptowane!";
    if ($_GET['status'] == 'rejected') $message = "Zaproszenie odrzucone.";
}

// 3. POBRANIE DANYCH DO WIDOKU
try {
    // Pobierz otrzymane zaproszenia
    $stmtZaproszenia = $pdo->prepare("SELECT u.id_uzytkownika, u.nazwa_uzytkownika FROM zaproszenia_do_znajomych z
                                      JOIN uzytkownik u ON z.id_uzytkownika1 = u.id_uzytkownika
                                      WHERE z.id_uzytkownika2 = ?");
    $stmtZaproszenia->execute([$currentUserId]);
    $listaZaproszen = $stmtZaproszenia->fetchAll(PDO::FETCH_ASSOC);

    // Pobierz listę znajomych
    $sqlZnajomi = "SELECT u.nazwa_uzytkownika, r.data_rozpoczecia FROM relacje_uzytkownikow r
                   JOIN uzytkownik u ON ((r.id_uzytkownika1 = :uid1 AND u.id_uzytkownika = r.id_uzytkownika2) OR
                                        (r.id_uzytkownika2 = :uid2 AND u.id_uzytkownika = r.id_uzytkownika1))
                   ORDER BY r.data_rozpoczecia DESC";
    $stmtZnajomi = $pdo->prepare($sqlZnajomi);
    $stmtZnajomi->execute(['uid1' => $currentUserId, 'uid2' => $currentUserId]);
    $znajomi = $stmtZnajomi->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $znajomi = [];
    $listaZaproszen = [];
}
?>

<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <title>Moi Znajomi - Planszówki</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&family=Tilt+Neon&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .invitation-box {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
        }

        .invitation-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

        .invitation-item:last-child {
            border-bottom: none;
        }

        .btn-accept {
            background: #28a745;
            color: white;
            border: none;
            padding: 10px 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-reject {
            background: #dc3545;
            color: white;
            border: none;
            padding: 10px 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        details {
            background: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        summary {
            padding: 12px;
            cursor: pointer;
            font-weight: bold;
            list-style: none;
            display: flex;
            justify-content: space-between;
        }

        summary::after {
            content: '▶';
            transition: 0.3s;
        }

        details[open] summary::after {
            transform: rotate(90deg);
        }

        .inv-row {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border-top: 1px solid #eee;
        }

        .badge {
            background: #e74c3c;
            color: white;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.8em;
            margin-right: 1em;
        }
    </style>
</head>

<body>

    <div class="dashboard-wrapper">

        <?php include 'sidebar.php'; ?>

        <div class="main-content">

            <div class="top-header">
                <button type="button" id="sidebarCollapse" class="toggle-btn">
                    ☰ Menu
                </button>
                <h2>Twoi Znajomi</h2>
            </div>

            <div class="actions">
                <form method="POST" style="display: flex; gap: 10px; align-items: center;">
                    <input type="text" name="search_name" placeholder="Wpisz nick znajomego..." required
                        style="padding: 8px; border-radius: 5px; border: 1px solid #ccc;">

                    <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">

                    <button type="submit" class="btn-small">Dodaj znajomego</button>
                </form>
                <?php if ($message): ?>
                    <p style="margin-top: 10px; color: 1a1a1a; font-weight: bold;"><?php echo htmlspecialchars($message); ?></p>
                <?php endif; ?>
            </div>

            <main>
                <?php if (!empty($listaZaproszen)): ?>
                    <details>
                        <summary>
                            <div><span class="badge"><?= count($listaZaproszen) ?></span>Otrzymane zaproszenia</div>
                        </summary>
                        <?php foreach ($listaZaproszen as $z): ?>
                            <div class="inv-row">
                                <span><?= htmlspecialchars($z['nazwa_uzytkownika']) ?></span>
                                <form method="POST" style="display: flex; flex-direction:row; gap: 5px;">
                                    <input type="hidden" name="csrf_token" value="<?= $_SESSION['csrf_token'] ?>">
                                    <input type="hidden" name="sender_id" value="<?= $z['id_uzytkownika'] ?>">
                                    <button type="submit" name="action" value="accept" class="btn-small" style="background:#2ecc71;">Akceptuj</button>
                                    <button type="submit" name="action" value="reject" class="btn-small" style="background:#e74c3c;">Odrzuć</button>
                                </form>
                            </div>
                        <?php endforeach; ?>
                    </details>
                <?php endif; ?>

                <?php if (!empty($znajomi)): ?>
                    <table>
                        <thead>
                            <tr>
                                <th>Użytkownik</th>
                                <th>Znajomi od</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($znajomi as $znajomy): ?>
                                <tr>
                                    <td style="display: flex; align-items: center; gap: 15px;">
                                        <div class="avatar-placeholder">
                                            <?php
                                            $pierwszaLitera = !empty($znajomy['nazwa_uzytkownika']) ? substr($znajomy['nazwa_uzytkownika'], 0, 1) : '?';
                                            echo strtoupper($pierwszaLitera);
                                            ?>
                                        </div>
                                        <strong><?php echo htmlspecialchars($znajomy['nazwa_uzytkownika']); ?></strong>
                                    </td>

                                    <td>
                                        <?php
                                        // Bezpieczne formatowanie daty
                                        echo $znajomy['data_rozpoczecia'] ? date("d.m.Y", strtotime($znajomy['data_rozpoczecia'])) : '-';
                                        ?>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                <?php else: ?>
                    <div class="empty-msg">
                        <h3>Nie masz jeszcze znajomych</h3>
                        <p>Użyj powyższego formularza, aby dodać kogoś po nazwie użytkownika.</p>
                    </div>
                <?php endif; ?>
            </main>

        </div>
    </div>
    <script>
        document.getElementById('sidebarCollapse').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('collapsed');
        });
    </script>
</body>

</html>