<?php
session_start();
require_once 'api/db.php';

// 1. Sprawdzenie logowania
if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$currentUserId = $_SESSION['user_id'];
$userName = $_SESSION['username'];
$message = "";
                // --- LOGIKA DODAWANIA ZNAJOMEGO ---
                if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['search_name'])) {
                    $searchName = trim($_POST['search_name']);

                    try {
                        // 1. Znajdź ID osoby po nazwie (tutaj ? jest bezpieczne i proste)
                        $stmt = $pdo->prepare("SELECT id_uzytkownika FROM uzytkownik WHERE nazwa_uzytkownika = ?");
                        $stmt->execute([$searchName]);
                        $targetUser = $stmt->fetch();

                        if (!$targetUser) {
                            $message = "Użytkownik o takiej nazwie nie istnieje.";
                        } elseif ($targetUser['id_uzytkownika'] == $currentUserId) {
                            $message = "Nie możesz dodać samego siebie!";
                        } else {
                            $targetId = $targetUser['id_uzytkownika'];

                            // 2. Sprawdź czy relacja już istnieje - UŻYWAMY UNIKALNYCH NAZW PARAMETRÓW
                            $check = $pdo->prepare("SELECT 1 FROM relacje_uzytkownikow WHERE
                (id_uzytkownika1 = :u1 AND id_uzytkownika2 = :t1) OR
                (id_uzytkownika1 = :t2 AND id_uzytkownika2 = :u2)");

                            $check->execute([
                                'u1' => $currentUserId,
                                't1' => $targetId,
                                't2' => $targetId,
                                'u2' => $currentUserId
                            ]);

                            if ($check->fetch()) {
                                $message = "Jesteście już znajomymi!";
                            } else {
                                // 3. Dodaj relację
                                $ins = $pdo->prepare("INSERT INTO relacje_uzytkownikow (id_uzytkownika1, id_uzytkownika2) VALUES (?, ?)");
                                $ins->execute([$currentUserId, $targetId]);

                                // Odświeżamy stronę, aby nowy znajomy pojawił się na liście
                                header("Location: znajomi.php?added=1");
                                exit();
                            }
                        }
                    } catch (PDOException $e) {
                        $message = "Błąd bazy danych: " . $e->getMessage();
                    }
                }

                // Dodatkowa informacja o sukcesie po przeładowaniu
                if (isset($_GET['added'])) {
                    $message = "Pomyślnie dodano znajomego!";
                }
// 2. Pobranie listy znajomych
try {
    $sql = "SELECT
                u.nazwa_uzytkownika,
                r.data_rozpoczecia
            FROM relacje_uzytkownikow r
            JOIN uzytkownik u ON (
                (r.id_uzytkownika1 = :uid1 AND u.id_uzytkownika = r.id_uzytkownika2) OR
                (r.id_uzytkownika2 = :uid2 AND u.id_uzytkownika = r.id_uzytkownika1)
            )
            ORDER BY r.data_rozpoczecia DESC";

    $stmt = $pdo->prepare($sql);

    // Przekazujemy to samo ID pod dwiema nazwami
    $stmt->execute([
        'uid1' => $currentUserId,
        'uid2' => $currentUserId
    ]);

    $znajomi = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    // Zamiast die(), logujemy błąd i ustawiamy pustą tablicę, by strona "żyła"
    error_log("Błąd bazy: " . $e->getMessage());
    $znajomi = [];
    $message = "Wystąpił problem z ładowaniem listy znajomych.";
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
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

    <div class="dashboard-wrapper">

        <nav id="sidebar" class="sidebar">
            <div class="sidebar-header">
                Planszówki
            </div>

            <a href="dashboard.php">Moja Kolekcja</a>
            <a href="profil.php">Mój Profil</a>
            <a href="rozgrywki.php">Rozgrywki</a>
            <a href="znajomi.php" class="current">Znajomi</a>
            <a href="logout.php" class="logout-link"> Wyloguj się</a>
        </nav>

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
                    <button type="submit" class="btn-small">Dodaj znajomego</button>
                </form>
                <?php if ($message): ?>
                    <p style="margin-top: 10px; color: 1a1a1a; font-weight: bold;"><?php echo htmlspecialchars($message); ?></p>
                <?php endif; ?>
            </div>
            <main>
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