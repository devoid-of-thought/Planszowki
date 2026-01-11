<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <title>Moje Rozgrywki</title>
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

            <a href="dashboard.php" style="background-color: #1a1a1a; color: white;">Moja Kolekcja</a>
            <a href="profil.php">Mój Profil</a>
            <a href="rozgrywki.php">Rozgrywki</a>
            <a href="znajomi.php">Znajomi</a>

            <a href="logout.php" class="logout-link"> Wyloguj się</a> <!-- Dodać ekran główny i przekierowanie tam po wylogowaniu -->
        </nav>

        <div class="main-content">

            <div class="top-header">
                <button type="button" id="sidebarCollapse" class="toggle-btn">
                    ☰ Menu
                </button>
            </div>

            <div class="actions">
                <button class="btn-small" onclick="window.location.href='dodaj_rozgrywke.php'">Dodaj nową rozgrywke</button>
            </div>

            <main>

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