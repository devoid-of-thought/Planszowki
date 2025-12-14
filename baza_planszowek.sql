-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 30, 2025 at 12:59 AM
-- Server version: 8.0.44-0ubuntu0.22.04.1
-- PHP Version: 8.1.2-1ubuntu2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `baza_planszowek`
--

-- --------------------------------------------------------

--
-- Table structure for table `Arkusz_Punktacji`
--

CREATE TABLE `Arkusz_Punktacji` (
  `id_arkusza` int NOT NULL,
  `id_planszowki` int NOT NULL,
  `id_pluginu` int NOT NULL,
  `nazwa_arkusza` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Gatunek`
--

CREATE TABLE `Gatunek` (
  `id_gatunku` int NOT NULL,
  `nazwa_gatunku` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `opis` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Komentarz`
--

CREATE TABLE `Komentarz` (
  `id_komentarza` int NOT NULL,
  `id_rozgrywki` int DEFAULT NULL,
  `id_autora` int DEFAULT NULL,
  `zawartosc` text,
  `data_dodania` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Planszowka_Gatunek`
--

CREATE TABLE `Planszowka_Gatunek` (
  `id_planszowki` int NOT NULL,
  `id_gatunku` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Planszowka_w_kolekcji`
--

CREATE TABLE `Planszowka_w_kolekcji` (
  `id_planszowki_w_kolekcji` int NOT NULL,
  `id_uzytkownika` int NOT NULL,
  `id_planszowki` int NOT NULL,
  `ocena` int DEFAULT NULL,
  `komentarz` text,
  `id_statusu` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Planszowka`
--

CREATE TABLE `Planszowka` (
  `id_planszowki` int NOT NULL,
  `tytul_planszowki` varchar(255) DEFAULT NULL,
  `data_wydania` int DEFAULT NULL,
  `wydawca` varchar(255) DEFAULT NULL,
  `designer` varchar(255) DEFAULT NULL,
  `min_graczy` int DEFAULT NULL,
  `max_graczy` int DEFAULT NULL,
  `min_dlugosc_rozgrywki` int DEFAULT NULL,
  `max_dlugosc_rozgrywki` int DEFAULT NULL,
  `waga` float DEFAULT NULL,
  `rekomendowany_wiek` int DEFAULT NULL,
  `bgg_id` varchar(255) DEFAULT NULL,
  `stworzone_przez_id_uzytkownika` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Plugin`
--

CREATE TABLE `Plugin` (
  `id_pluginu` int NOT NULL,
  `nazwa_pluginu` varchar(255) NOT NULL,
  `struktura_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `stworzone_przez_id_uzytkownika` int DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `Rozgrywka`
--

CREATE TABLE `Rozgrywka` (
  `id_rozgrywki` int NOT NULL,
  `id_planszowki` int DEFAULT NULL,
  `id_organizatora` int DEFAULT NULL,
  `data_rozgrywki` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `czas_trwania` int DEFAULT NULL,
  `notatka_do_gry` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Status`
--

CREATE TABLE `Status` (
  `id_statusu` int NOT NULL,
  `nazwa_statusu` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Status`
--

INSERT INTO `Status` (`id_statusu`, `nazwa_statusu`) VALUES
(2, 'Chcę zagrać'),
(1, 'Posiadam'),
(4, 'Pożyczone'),
(3, 'Sprzedane');

-- --------------------------------------------------------

--
-- Table structure for table `Uczestnicy_Rozgrywki`
--

CREATE TABLE `Uczestnicy_Rozgrywki` (
  `id_uczestnictwa` int NOT NULL,
  `id_rozgrywki` int NOT NULL,
  `id_uzytkownika` int DEFAULT NULL,
  `nazwa_tymczasowa_gracza` varchar(255) DEFAULT NULL,
  `wynik_koncowy` int NOT NULL,
  `id_arkusza_uzytego` int DEFAULT NULL,
  `dane_arkusza` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
) ;

-- --------------------------------------------------------

--
-- Table structure for table `Uprawnienia`
--

CREATE TABLE `Uprawnienia` (
  `id_uprawnien` int NOT NULL,
  `typ_uprawnienia` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Uprawnienia`
--

INSERT INTO `Uprawnienia` (`id_uprawnien`, `typ_uprawnienia`) VALUES
(1, 'Administrator'),
(3, 'Gracz'),
(2, 'Kolekcjoner');

-- --------------------------------------------------------

--
-- Table structure for table `Uzytkownik`
--

CREATE TABLE `Uzytkownik` (
  `id_uzytkownika` int NOT NULL,
  `nazwa_uzytkownika` varchar(255) NOT NULL,
  `adres_email` varchar(255) DEFAULT NULL,
  `haslo` varchar(255) DEFAULT NULL,
  `zdjecie` blob,
  `id_uprawnien` int NOT NULL,
  `data_utworzenia` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Uzytkownik`
--

INSERT INTO `Uzytkownik` (`id_uzytkownika`, `nazwa_uzytkownika`, `adres_email`, `haslo`, `zdjecie`, `id_uprawnien`, `data_utworzenia`) VALUES
(1, 'SweetSummerChild', 'sw33ts00merch1ld@gmail.com', '$2y$10$rdlHyJqfbqebUkiYJkFaYu1ka8CX6lmgaklhaRuh6zyPZ20zSCRYa', NULL, 3, '2025-11-29 17:07:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Arkusz_Punktacji`
--
ALTER TABLE `Arkusz_Punktacji`
  ADD PRIMARY KEY (`id_arkusza`),
  ADD KEY `idx_arkusz_gra` (`id_planszowki`),
  ADD KEY `idx_arkusz_plugin` (`id_pluginu`);

--
-- Indexes for table `Gatunek`
--
ALTER TABLE `Gatunek`
  ADD PRIMARY KEY (`id_gatunku`),
  ADD UNIQUE KEY `nazwa_gatunku` (`nazwa_gatunku`);

--
-- Indexes for table `Komentarz`
--
ALTER TABLE `Komentarz`
  ADD PRIMARY KEY (`id_komentarza`),
  ADD KEY `idx_kom_rozgrywka` (`id_rozgrywki`),
  ADD KEY `idx_kom_autor` (`id_autora`);

--
-- Indexes for table `Planszowka_Gatunek`
--
ALTER TABLE `Planszowka_Gatunek`
  ADD PRIMARY KEY (`id_planszowki`,`id_gatunku`),
  ADD KEY `idx_pg_gatunek` (`id_gatunku`);

--
-- Indexes for table `Planszowka_w_kolekcji`
--
ALTER TABLE `Planszowka_w_kolekcji`
  ADD PRIMARY KEY (`id_planszowki_w_kolekcji`),
  ADD UNIQUE KEY `unique_user_game` (`id_uzytkownika`,`id_planszowki`),
  ADD KEY `idx_pk_status` (`id_statusu`),
  ADD KEY `fk_pk_game` (`id_planszowki`);

--
-- Indexes for table `Planszowka`
--
ALTER TABLE `Planszowka`
  ADD PRIMARY KEY (`id_planszowki`),
  ADD KEY `idx_planszowka_tworca` (`stworzone_przez_id_uzytkownika`);

--
-- Indexes for table `Plugin`
--
ALTER TABLE `Plugin`
  ADD PRIMARY KEY (`id_pluginu`),
  ADD KEY `idx_plugin_tworca` (`stworzone_przez_id_uzytkownika`);

--
-- Indexes for table `Rozgrywka`
--
ALTER TABLE `Rozgrywka`
  ADD PRIMARY KEY (`id_rozgrywki`),
  ADD KEY `idx_rozgrywka_gra` (`id_planszowki`),
  ADD KEY `idx_rozgrywka_org` (`id_organizatora`);

--
-- Indexes for table `Status`
--
ALTER TABLE `Status`
  ADD PRIMARY KEY (`id_statusu`),
  ADD UNIQUE KEY `nazwa_statusu` (`nazwa_statusu`);

--
-- Indexes for table `Uczestnicy_Rozgrywki`
--
ALTER TABLE `Uczestnicy_Rozgrywki`
  ADD PRIMARY KEY (`id_uczestnictwa`),
  ADD KEY `idx_uczestnik_rozgrywka` (`id_rozgrywki`),
  ADD KEY `idx_uczestnik_user` (`id_uzytkownika`),
  ADD KEY `idx_uczestnik_arkusz` (`id_arkusza_uzytego`);

--
-- Indexes for table `Uprawnienia`
--
ALTER TABLE `Uprawnienia`
  ADD PRIMARY KEY (`id_uprawnien`),
  ADD UNIQUE KEY `typ_uprawnienia` (`typ_uprawnienia`);

--
-- Indexes for table `Uzytkownik`
--
ALTER TABLE `Uzytkownik`
  ADD PRIMARY KEY (`id_uzytkownika`),
  ADD UNIQUE KEY `nazwa_uzytkownika` (`nazwa_uzytkownika`),
  ADD KEY `idx_uzytkownik_uprawnienia` (`id_uprawnien`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Arkusz_Punktacji`
--
ALTER TABLE `Arkusz_Punktacji`
  MODIFY `id_arkusza` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Gatunek`
--
ALTER TABLE `Gatunek`
  MODIFY `id_gatunku` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Komentarz`
--
ALTER TABLE `Komentarz`
  MODIFY `id_komentarza` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Planszowka_w_kolekcji`
--
ALTER TABLE `Planszowka_w_kolekcji`
  MODIFY `id_planszowki_w_kolekcji` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Planszowka`
--
ALTER TABLE `Planszowka`
  MODIFY `id_planszowki` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Plugin`
--
ALTER TABLE `Plugin`
  MODIFY `id_pluginu` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Rozgrywka`
--
ALTER TABLE `Rozgrywka`
  MODIFY `id_rozgrywki` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Status`
--
ALTER TABLE `Status`
  MODIFY `id_statusu` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Uczestnicy_Rozgrywki`
--
ALTER TABLE `Uczestnicy_Rozgrywki`
  MODIFY `id_uczestnictwa` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Uprawnienia`
--
ALTER TABLE `Uprawnienia`
  MODIFY `id_uprawnien` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Uzytkownik`
--
ALTER TABLE `Uzytkownik`
  MODIFY `id_uzytkownika` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Arkusz_Punktacji`
--
ALTER TABLE `Arkusz_Punktacji`
  ADD CONSTRAINT `fk_arkusz_gra` FOREIGN KEY (`id_planszowki`) REFERENCES `Planszowka` (`id_planszowki`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_arkusz_plugin` FOREIGN KEY (`id_pluginu`) REFERENCES `Plugin` (`id_pluginu`) ON DELETE CASCADE;

--
-- Constraints for table `Komentarz`
--
ALTER TABLE `Komentarz`
  ADD CONSTRAINT `fk_kom_autor` FOREIGN KEY (`id_autora`) REFERENCES `Uzytkownik` (`id_uzytkownika`),
  ADD CONSTRAINT `fk_kom_rozgrywka` FOREIGN KEY (`id_rozgrywki`) REFERENCES `Rozgrywka` (`id_rozgrywki`) ON DELETE CASCADE;

--
-- Constraints for table `Planszowka_Gatunek`
--
ALTER TABLE `Planszowka_Gatunek`
  ADD CONSTRAINT `fk_pg_gatunek` FOREIGN KEY (`id_gatunku`) REFERENCES `Gatunek` (`id_gatunku`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pg_planszowka` FOREIGN KEY (`id_planszowki`) REFERENCES `Planszowka` (`id_planszowki`) ON DELETE CASCADE;

--
-- Constraints for table `Planszowka_w_kolekcji`
--
ALTER TABLE `Planszowka_w_kolekcji`
  ADD CONSTRAINT `fk_pk_game` FOREIGN KEY (`id_planszowki`) REFERENCES `Planszowka` (`id_planszowki`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pk_status` FOREIGN KEY (`id_statusu`) REFERENCES `Status` (`id_statusu`),
  ADD CONSTRAINT `fk_pk_user` FOREIGN KEY (`id_uzytkownika`) REFERENCES `Uzytkownik` (`id_uzytkownika`) ON DELETE CASCADE;

--
-- Constraints for table `Planszowka`
--
ALTER TABLE `Planszowka`
  ADD CONSTRAINT `fk_planszowka_tworca` FOREIGN KEY (`stworzone_przez_id_uzytkownika`) REFERENCES `Uzytkownik` (`id_uzytkownika`) ON DELETE SET NULL;

--
-- Constraints for table `Plugin`
--
ALTER TABLE `Plugin`
  ADD CONSTRAINT `fk_plugin_tworca` FOREIGN KEY (`stworzone_przez_id_uzytkownika`) REFERENCES `Uzytkownik` (`id_uzytkownika`) ON DELETE SET NULL;

--
-- Constraints for table `Rozgrywka`
--
ALTER TABLE `Rozgrywka`
  ADD CONSTRAINT `fk_rozgrywka_gra` FOREIGN KEY (`id_planszowki`) REFERENCES `Planszowka` (`id_planszowki`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_rozgrywka_org` FOREIGN KEY (`id_organizatora`) REFERENCES `Uzytkownik` (`id_uzytkownika`);

--
-- Constraints for table `Uczestnicy_Rozgrywki`
--
ALTER TABLE `Uczestnicy_Rozgrywki`
  ADD CONSTRAINT `fk_uczestnik_arkusz` FOREIGN KEY (`id_arkusza_uzytego`) REFERENCES `Arkusz_Punktacji` (`id_arkusza`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_uczestnik_rozgrywka` FOREIGN KEY (`id_rozgrywki`) REFERENCES `Rozgrywka` (`id_rozgrywki`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_uczestnik_user` FOREIGN KEY (`id_uzytkownika`) REFERENCES `Uzytkownik` (`id_uzytkownika`) ON DELETE SET NULL;

--
-- Constraints for table `Uzytkownik`
--
ALTER TABLE `Uzytkownik`
  ADD CONSTRAINT `fk_uzytkownik_uprawnienia` FOREIGN KEY (`id_uprawnien`) REFERENCES `Uprawnienia` (`id_uprawnien`);
COMMIT;

--
-- Widok - lista kolekcji
--
CREATE VIEW `Widok_Kolekcji_Uzytkownika` AS
SELECT
    u.nazwa_uzytkownika,
    p.tytul_planszowki,
    s.nazwa_statusu,
    pwk.ocena,
    pwk.komentarz
FROM Planszowka_w_kolekcji pwk
JOIN Uzytkownik u ON pwk.id_uzytkownika = u.id_uzytkownika
JOIN Planszowka p ON pwk.id_planszowki = p.id_planszowki
JOIN Status s ON pwk.id_statusu = s.id_statusu;

--
-- Funkcja - Formatowanie czasu gry
--
DELIMITER //
CREATE FUNCTION `Formatuj_Czas_Gry`(min_czas INT, max_czas INT)
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
    IF min_czas IS NULL OR max_czas IS NULL THEN RETURN 'Brak danych'; END IF;
    IF min_czas = max_czas THEN
        RETURN CONCAT(min_czas, ' min');
    ELSE
        RETURN CONCAT(min_czas, '-', max_czas, ' min');
    END IF;
END //
DELIMITER ;
--
-- Trigger - Walidacja oceny (1-10)
--
DELIMITER //
CREATE TRIGGER `Walidacja_Oceny_Insert`
BEFORE INSERT ON `Planszowka_w_kolekcji`
FOR EACH ROW
BEGIN
    IF NEW.ocena IS NOT NULL AND (NEW.ocena < 1 OR NEW.ocena > 10) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Błąd: Ocena musi być w przedziale od 1 do 10.';
    END IF;
END //
DELIMITER ;

--
--  Archwiwizacja danych
--

-- Utworzenie tabel archiwalnych
CREATE TABLE `Rozgrywka_Historyczna` AS SELECT * FROM `Rozgrywka` WHERE 1=0;
ALTER TABLE `Rozgrywka_Historyczna` ADD COLUMN `data_archiwizacji` DATETIME DEFAULT CURRENT_TIMESTAMP;

CREATE TABLE `Uczestnicy_Historyczni` AS SELECT * FROM `Uczestnicy_Rozgrywki` WHERE 1=0;
ALTER TABLE `Uczestnicy_Historyczni` ADD COLUMN `data_archiwizacji` DATETIME DEFAULT CURRENT_TIMESTAMP;

-- Procedura migracji
DELIMITER //

CREATE PROCEDURE `Archiwizuj_Stare_Rozgrywki`()
BEGIN
    DECLARE data_graniczna DATETIME;
    -- Przenoszenie rozgrywek starszych niż 5 lat
    SET data_graniczna = DATE_SUB(NOW(), INTERVAL 5 YEAR);

    -- Obsługa błędów (rollback w razie awarii)
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Błąd podczas archiwizacji rozgrywek.';
    END;

    START TRANSACTION;

    -- Kopiowanie uczestników rozgrywek, które zostaną zarchwizowane
    INSERT INTO `Uczestnicy_Historyczni` (id_uczestnictwa, id_rozgrywki, id_uzytkownika, nazwa_tymczasowa_gracza, wynik_koncowy, id_arkusza_uzytego, dane_arkusza)
    SELECT u.id_uczestnictwa, u.id_rozgrywki, u.id_uzytkownika, u.nazwa_tymczasowa_gracza, u.wynik_koncowy, u.id_arkusza_uzytego, u.dane_arkusza
    FROM `Uczestnicy_Rozgrywki` u
    JOIN `Rozgrywka` r ON u.id_rozgrywki = r.id_rozgrywki
    WHERE r.data_rozgrywki < data_graniczna;

    --  Kopiowanie rozgrywek
    INSERT INTO `Rozgrywka_Historyczna` (id_rozgrywki, id_planszowki, id_organizatora, data_rozgrywki, czas_trwania, notatka_do_gry)
    SELECT id_rozgrywki, id_planszowki, id_organizatora, data_rozgrywki, czas_trwania, notatka_do_gry
    FROM `Rozgrywka`
    WHERE data_rozgrywki < data_graniczna;

    -- Usuwanie z tabel głównych
    DELETE FROM `Rozgrywka`
    WHERE data_rozgrywki < data_graniczna;

    COMMIT;
END //
DELIMITER ;

-- Automatyczne uruchamianie archiwizacji raz na miesiąc
SET GLOBAL event_scheduler = ON;
CREATE EVENT `Auto_Archiwizacja_Co_Miesiac`
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_TIMESTAMP
DO
    CALL Archiwizuj_Stare_Rozgrywki();

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
