-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sty 25, 2026 at 07:20 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12
DROP 'baza_planszowek' IF EXISTS;
CREATE DATABASE IF NOT EXISTS `baza_planszowek` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `baza_planszowek`;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+01:00"; 

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `baza_planszowek`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Archiwizuj_Stare_Rozgrywki` ()   BEGIN
    DECLARE data_graniczna DATETIME;


    -- Obsługa błędów (rollback w razie awarii)
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Błąd podczas archiwizacji rozgrywek.';
    END;

    -- Przenoszenie rozgrywek starszych niż 5 lat
    SET data_graniczna = DATE_SUB(NOW(), INTERVAL 5 YEAR);

    START TRANSACTION;

    -- Kopiowanie uczestników rozgrywek, które zostaną zarchwizowane
    INSERT INTO `uczestnicy_historyczni` (id_uczestnictwa, id_rozgrywki, id_uzytkownika, nazwa_tymczasowa_gracza, wynik_koncowy, id_arkusza_uzytego, dane_arkusza)
    SELECT u.id_uczestnictwa, u.id_rozgrywki, u.id_uzytkownika, u.nazwa_tymczasowa_gracza, u.wynik_koncowy, u.id_arkusza_uzytego, u.dane_arkusza
    FROM `uczestnicy_rozgrywki` u
    JOIN `rozgrywka` r ON u.id_rozgrywki = r.id_rozgrywki
    WHERE r.data_rozgrywki < data_graniczna;

    --  Kopiowanie rozgrywek
    INSERT INTO `Rozgrywka_Historyczna` (id_rozgrywki, id_planszowki, id_organizatora, data_rozgrywki, czas_trwania, notatka_do_gry)
    SELECT id_rozgrywki, id_planszowki, id_organizatora, data_rozgrywki, czas_trwania, notatka_do_gry
    FROM `rozgrywka`
    WHERE data_rozgrywki < data_graniczna;

    -- Usuwanie z tabel głównych
    DELETE FROM `rozgrywka`
    WHERE data_rozgrywki < data_graniczna;

    COMMIT;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `Formatuj_Czas_Gry` (`min_czas` INT, `max_czas` INT) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci DETERMINISTIC BEGIN
    IF min_czas IS NULL OR max_czas IS NULL THEN RETURN 'Brak danych'; END IF;
    IF min_czas = max_czas THEN
        RETURN CONCAT(min_czas, ' min');
    ELSE
        RETURN CONCAT(min_czas, '-', max_czas, ' min');
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `arkusz_punktacji`
--

CREATE TABLE `arkusz_punktacji` (
  `id_arkusza` int(11) NOT NULL,
  `id_planszowki` int(11) NOT NULL,
  `id_pluginu` int(11) NOT NULL,
  `nazwa_arkusza` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `gatunek`
--

CREATE TABLE `gatunek` (
  `id_gatunku` int(11) NOT NULL,
  `nazwa_gatunku` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `opis` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gatunek`
--
-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `komentarz`
--

CREATE TABLE `komentarz` (
  `id_komentarza` int(11) NOT NULL,
  `id_rozgrywki` int(11) DEFAULT NULL,
  `id_autora` int(11) DEFAULT NULL,
  `zawartosc` text DEFAULT NULL,
  `data_dodania` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `planszowka`
--

CREATE TABLE `planszowka` (
  `id_planszowki` int(11) NOT NULL,
  `tytul_planszowki` varchar(255) NOT NULL,
  `data_wydania` int(11) DEFAULT NULL,
  `wydawca` varchar(255) DEFAULT NULL,
  `designer` varchar(255) DEFAULT NULL,
  `min_graczy` int(11) DEFAULT NULL,
  `max_graczy` int(11) DEFAULT NULL,
  `min_dlugosc_rozgrywki` int(11) DEFAULT NULL,
  `max_dlugosc_rozgrywki` int(11) DEFAULT NULL,
  `waga` float DEFAULT NULL,
  `rekomendowany_wiek` int(11) DEFAULT NULL,
  `bgg_id` varchar(255) DEFAULT NULL,
  `stworzone_przez_id_uzytkownika` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `planszowka`
--


-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `planszowka_gatunek`
--

CREATE TABLE `planszowka_gatunek` (
  `id_planszowki` int(11) NOT NULL,
  `id_gatunku` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `planszowka_w_kolekcji`
--

CREATE TABLE `planszowka_w_kolekcji` (
  `id_planszowki_w_kolekcji` int(11) NOT NULL,
  `id_uzytkownika` int(11) NOT NULL,
  `id_planszowki` int(11) NOT NULL,
  `ocena` int(11) DEFAULT NULL,
  `komentarz` text DEFAULT NULL,
  `id_statusu` int(11) NOT NULL,
  `data_dodania` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Wyzwalacze `planszowka_w_kolekcji`
--
DELIMITER $$
CREATE TRIGGER `Walidacja_Oceny_Insert` BEFORE INSERT ON `planszowka_w_kolekcji` FOR EACH ROW BEGIN
    IF NEW.ocena IS NOT NULL AND (NEW.ocena < 1 OR NEW.ocena > 10) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Błąd: Ocena musi być w przedziale od 1 do 10.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Walidacja_Oceny_Update` BEFORE UPDATE ON `planszowka_w_kolekcji` FOR EACH ROW BEGIN
    IF NEW.ocena IS NOT NULL AND (NEW.ocena < 1 OR NEW.ocena > 10) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Błąd: Ocena musi być w przedziale od 1 do 10.';
    END IF;
END
$$
DELIMITER ;
-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `plugin`
--

CREATE TABLE `plugin` (
  `id_pluginu` int(11) NOT NULL,
  `nazwa_pluginu` varchar(255) NOT NULL,
  `struktura_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`struktura_json`)),
  `stworzone_przez_id_uzytkownika` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `relacje_uzytkownikow`
--

CREATE TABLE `relacje_uzytkownikow` (
  `id_uzytkownika1` int(11) NOT NULL,
  `id_uzytkownika2` int(11) NOT NULL,
  `data_rozpoczecia` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rozgrywka`
--

CREATE TABLE `rozgrywka` (
  `id_rozgrywki` int(11) NOT NULL,
  `id_planszowki` int(11) DEFAULT NULL,
  `id_organizatora` int(11) DEFAULT NULL,
  `data_rozgrywki` timestamp NOT NULL DEFAULT current_timestamp(),
  `tytul_rozgrywki` varchar(255) DEFAULT NULL,
  `czas_trwania` int(11) DEFAULT NULL,
  `notatka_do_gry` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rozgrywka_historyczna`
--

CREATE TABLE `rozgrywka_historyczna` (
  `id_rozgrywki` int(11) NOT NULL DEFAULT 0,
  `id_planszowki` int(11) DEFAULT NULL,
  `id_organizatora` int(11) DEFAULT NULL,
  `data_rozgrywki` timestamp NOT NULL DEFAULT current_timestamp(),
  `czas_trwania` int(11) DEFAULT NULL,
  `notatka_do_gry` text DEFAULT NULL,
  `data_archiwizacji` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `status`
--

CREATE TABLE `status` (
  `id_statusu` int(11) NOT NULL,
  `nazwa_statusu` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `status`
--



-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uczestnicy_historyczni`
--

CREATE TABLE `uczestnicy_historyczni` (
  `id_uczestnictwa` int(11) NOT NULL DEFAULT 0,
  `id_rozgrywki` int(11) NOT NULL,
  `id_uzytkownika` int(11) DEFAULT NULL,
  `nazwa_tymczasowa_gracza` varchar(255) DEFAULT NULL,
  `wynik_koncowy` int(11) NOT NULL,
  `id_arkusza_uzytego` int(11) DEFAULT NULL,
  `dane_arkusza` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `data_archiwizacji` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uczestnicy_rozgrywki`
--

CREATE TABLE `uczestnicy_rozgrywki` (
  `id_uczestnictwa` int(11) NOT NULL,
  `id_rozgrywki` int(11) NOT NULL,
  `id_uzytkownika` int(11) DEFAULT NULL,
  `nazwa_tymczasowa_gracza` varchar(255) DEFAULT NULL,
  `wynik_koncowy` int(11) NOT NULL,
  `id_arkusza_uzytego` int(11) DEFAULT NULL,
  `dane_arkusza` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`dane_arkusza`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uprawnienia`
--

CREATE TABLE `uprawnienia` (
  `id_uprawnien` int(11) NOT NULL,
  `typ_uprawnienia` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownik`
--

CREATE TABLE `uzytkownik` (
  `id_uzytkownika` int(11) NOT NULL,
  `nazwa_uzytkownika` varchar(255) NOT NULL,
  `adres_email` varchar(255) DEFAULT NULL,
  `haslo` varchar(255) DEFAULT NULL,
  `zdjecie` blob DEFAULT NULL,
  `id_uprawnien` int(11) NOT NULL,
  `data_utworzenia` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `widok_kolekcji_uzytkownika`
-- (See below for the actual view)
--
CREATE TABLE `widok_kolekcji_uzytkownika` (
`nazwa_uzytkownika` varchar(255)
,`tytul_planszowki` varchar(255)
,`nazwa_statusu` varchar(255)
,`ocena` int(11)
,`komentarz` text
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zaproszenia_do_znajomych`
--

CREATE TABLE `zaproszenia_do_znajomych` (
  `id_zaproszenia` int(11) NOT NULL,
  `id_uzytkownika1` int(11) NOT NULL,
  `id_uzytkownika2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura widoku `widok_kolekcji_uzytkownika`
--
DROP TABLE IF EXISTS `widok_kolekcji_uzytkownika`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `widok_kolekcji_uzytkownika`  AS SELECT `u`.`nazwa_uzytkownika` AS `nazwa_uzytkownika`, `p`.`tytul_planszowki` AS `tytul_planszowki`, `s`.`nazwa_statusu` AS `nazwa_statusu`, `pwk`.`ocena` AS `ocena`, `pwk`.`komentarz` AS `komentarz` FROM (((`planszowka_w_kolekcji` `pwk` join `uzytkownik` `u` on(`pwk`.`id_uzytkownika` = `u`.`id_uzytkownika`)) join `planszowka` `p` on(`pwk`.`id_planszowki` = `p`.`id_planszowki`)) join `status` `s` on(`pwk`.`id_statusu` = `s`.`id_statusu`)) ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `arkusz_punktacji`
--
ALTER TABLE `arkusz_punktacji`
  ADD PRIMARY KEY (`id_arkusza`),
  ADD KEY `idx_arkusz_gra` (`id_planszowki`),
  ADD KEY `idx_arkusz_plugin` (`id_pluginu`);

--
-- Indeksy dla tabeli `gatunek`
--
ALTER TABLE `gatunek`
  ADD PRIMARY KEY (`id_gatunku`),
  ADD UNIQUE KEY `nazwa_gatunku` (`nazwa_gatunku`);

--
-- Indeksy dla tabeli `komentarz`
--
ALTER TABLE `komentarz`
  ADD PRIMARY KEY (`id_komentarza`),
  ADD KEY `idx_kom_rozgrywka` (`id_rozgrywki`),
  ADD KEY `idx_kom_autor` (`id_autora`);

--
-- Indeksy dla tabeli `planszowka`
--
ALTER TABLE `planszowka`
  ADD PRIMARY KEY (`id_planszowki`),
  ADD KEY `idx_planszowka_tworca` (`stworzone_przez_id_uzytkownika`);

--
-- Indeksy dla tabeli `planszowka_gatunek`
--
ALTER TABLE `planszowka_gatunek`
  ADD PRIMARY KEY (`id_planszowki`,`id_gatunku`),
  ADD KEY `idx_pg_gatunek` (`id_gatunku`);

--
-- Indeksy dla tabeli `planszowka_w_kolekcji`
--
ALTER TABLE `planszowka_w_kolekcji`
  ADD PRIMARY KEY (`id_planszowki_w_kolekcji`),
  ADD UNIQUE KEY `unique_user_game` (`id_uzytkownika`,`id_planszowki`),
  ADD KEY `idx_pk_status` (`id_statusu`),
  ADD KEY `fk_pk_game` (`id_planszowki`);

--
-- Indeksy dla tabeli `plugin`
--
ALTER TABLE `plugin`
  ADD PRIMARY KEY (`id_pluginu`),
  ADD KEY `idx_plugin_tworca` (`stworzone_przez_id_uzytkownika`);

--
-- Indeksy dla tabeli `relacje_uzytkownikow`
--
ALTER TABLE `relacje_uzytkownikow`
  ADD KEY `fk_zaproszenie_nadawca` (`id_uzytkownika1`),
  ADD KEY `fk_zaproszenie_odbiorca` (`id_uzytkownika2`);

--
-- Indeksy dla tabeli `rozgrywka`
--
ALTER TABLE `rozgrywka`
  ADD PRIMARY KEY (`id_rozgrywki`),
  ADD KEY `idx_rozgrywka_gra` (`id_planszowki`),
  ADD KEY `idx_rozgrywka_org` (`id_organizatora`);

--
-- Indeksy dla tabeli `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id_statusu`),
  ADD UNIQUE KEY `nazwa_statusu` (`nazwa_statusu`);

--
-- Indeksy dla tabeli `uczestnicy_rozgrywki`
--
ALTER TABLE `uczestnicy_rozgrywki`
  ADD PRIMARY KEY (`id_uczestnictwa`),
  ADD KEY `idx_uczestnik_rozgrywka` (`id_rozgrywki`),
  ADD KEY `idx_uczestnik_user` (`id_uzytkownika`),
  ADD KEY `idx_uczestnik_arkusz` (`id_arkusza_uzytego`);

--
-- Indeksy dla tabeli `uprawnienia`
--
ALTER TABLE `uprawnienia`
  ADD PRIMARY KEY (`id_uprawnien`),
  ADD UNIQUE KEY `typ_uprawnienia` (`typ_uprawnienia`);

--
-- Indeksy dla tabeli `uzytkownik`
--
ALTER TABLE `uzytkownik`
  ADD PRIMARY KEY (`id_uzytkownika`),
  ADD UNIQUE KEY `nazwa_uzytkownika` (`nazwa_uzytkownika`),
  ADD KEY `idx_uzytkownik_uprawnienia` (`id_uprawnien`);

--
-- Indeksy dla tabeli `zaproszenia_do_znajomych`
--
ALTER TABLE `zaproszenia_do_znajomych`
  ADD PRIMARY KEY (`id_zaproszenia`),
  ADD KEY `id_uzytkownika1` (`id_uzytkownika1`),
  ADD KEY `id_uzytkownika2` (`id_uzytkownika2`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `arkusz_punktacji`
--
ALTER TABLE `arkusz_punktacji`
  MODIFY `id_arkusza` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gatunek`
--
ALTER TABLE `gatunek`
  MODIFY `id_gatunku` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `komentarz`
--
ALTER TABLE `komentarz`
  MODIFY `id_komentarza` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `planszowka`
--
ALTER TABLE `planszowka`
  MODIFY `id_planszowki` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `planszowka_w_kolekcji`
--
ALTER TABLE `planszowka_w_kolekcji`
  MODIFY `id_planszowki_w_kolekcji` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plugin`
--
ALTER TABLE `plugin`
  MODIFY `id_pluginu` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rozgrywka`
--
ALTER TABLE `rozgrywka`
  MODIFY `id_rozgrywki` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `id_statusu` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uczestnicy_rozgrywki`
--
ALTER TABLE `uczestnicy_rozgrywki`
  MODIFY `id_uczestnictwa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uprawnienia`
--
ALTER TABLE `uprawnienia`
  MODIFY `id_uprawnien` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uzytkownik`
--
ALTER TABLE `uzytkownik`
  MODIFY `id_uzytkownika` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `zaproszenia_do_znajomych`
--
ALTER TABLE `zaproszenia_do_znajomych`
  MODIFY `id_zaproszenia` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `arkusz_punktacji`
--
ALTER TABLE `planszowka_w_kolekcji`
  ADD CONSTRAINT `fk_kolekcja_user` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownik` (`id_uzytkownika`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_kolekcja_gra` FOREIGN KEY (`id_planszowki`) REFERENCES `planszowka` (`id_planszowki`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_kolekcja_status` FOREIGN KEY (`id_statusu`) REFERENCES `status` (`id_statusu`);

ALTER TABLE `rozgrywka`
  ADD CONSTRAINT `fk_rozgrywka_gra` FOREIGN KEY (`id_planszowki`) REFERENCES `planszowka` (`id_planszowki`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rozgrywka_org` FOREIGN KEY (`id_organizatora`) REFERENCES `uzytkownik` (`id_uzytkownika`) ON DELETE SET NULL;

ALTER TABLE `uczestnicy_rozgrywki`
  ADD CONSTRAINT `fk_uczestnik_rozgrywka` FOREIGN KEY (`id_rozgrywki`) REFERENCES `rozgrywka` (`id_rozgrywki`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_uczestnik_user` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownik` (`id_uzytkownika`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_uczestnik_plugin` FOREIGN KEY (`id_arkusza_uzytego`) REFERENCES `plugin` (`id_pluginu`) ON DELETE SET NULL;

ALTER TABLE `planszowka_gatunek`
  ADD CONSTRAINT `fk_pg_gra` FOREIGN KEY (`id_planszowki`) REFERENCES `planszowka` (`id_planszowki`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pg_gatunek` FOREIGN KEY (`id_gatunku`) REFERENCES `gatunek` (`id_gatunku`) ON DELETE CASCADE;

ALTER TABLE `komentarz`
  DROP FOREIGN KEY `fk_kom_autor`,
  ADD CONSTRAINT `fk_kom_autor` FOREIGN KEY (`id_autora`) REFERENCES `uzytkownik` (`id_uzytkownika`) ON DELETE SET NULL;

ALTER TABLE `uzytkownik`
  ADD CONSTRAINT `fk_user_role` FOREIGN KEY (`id_uprawnien`) REFERENCES `uprawnienia` (`id_uprawnien`);

ALTER TABLE `planszowka`
  ADD CONSTRAINT `fk_gra_tworca` FOREIGN KEY (`stworzone_przez_id_uzytkownika`) REFERENCES `uzytkownik` (`id_uzytkownika`) ON DELETE SET NULL;

ALTER TABLE `plugin`
  ADD CONSTRAINT `fk_plugin_tworca` FOREIGN KEY (`stworzone_przez_id_uzytkownika`) REFERENCES `uzytkownik` (`id_uzytkownika`) ON DELETE SET NULL;
  /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
  /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
  /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
