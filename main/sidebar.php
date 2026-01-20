<?php
// Pobieramy nazwę bieżącego pliku (np. 'dashboard.php')
$activePage = basename($_SERVER['PHP_SELF']);
?>

<nav id="sidebar" class="sidebar">
    <div class="sidebar-header">
        Planszówki
    </div>

    <a href="dashboard.php" class="<?= $activePage == 'dashboard.php' ? 'current' : '' ?>">
        Moja Kolekcja
    </a>
    
    <a href="profil.php" class="<?= $activePage == 'profil.php' ? 'current' : '' ?>">
        Mój Profil
    </a>
    
    <a href="rozgrywki.php" class="<?= $activePage == 'rozgrywki.php' ? 'current' : '' ?>">
        Rozgrywki
    </a>
    
    <a href="znajomi.php" class="<?= $activePage == 'znajomi.php' ? 'current' : '' ?>">
        Znajomi
    </a>
    <a href="planszowki.php" class="<?= $activePage == 'planszowki.php' ? 'current' : '' ?>">
        Planszówki
    </a>

    <a href="../login/logout.php" class="logout-link">Wyloguj się</a>
</nav>