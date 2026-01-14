-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sty 11, 2026 at 10:30 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

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
    INSERT INTO `Uczestnicy_Historyczni` (id_uczestnictwa, id_rozgrywki, id_uzytkownika, nazwa_tymczasowa_gracza, wynik_koncowy, id_arkusza_uzytego, dane_arkusza)
    SELECT u.id_uczestnictwa, u.id_rozgrywki, u.id_uzytkownika, u.nazwa_tymczasowa_gracza, u.wynik_koncowy, u.id_arkusza_uzytego, u.dane_arkusza
    FROM `Uczestnicy_Rozgrywki` u
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

INSERT INTO `gatunek` (`id_gatunku`, `nazwa_gatunku`, `url`, `opis`) VALUES
(1, 'Kooperacja', 'https://boardgamegeek.com/boardgamemechanic/2023/cooperative-game', 'Gracze współpracują przeciwko grze'),
(2, 'Strategia', 'https://boardgamegeek.com/boardgamesubdomain/5497/strategy-games', 'Gry wymagające planowania i taktyki'),
(3, 'Przygoda', 'https://boardgamegeek.com/boardgamecategory/1022/adventure', 'Eksploracja, fabuła i rozwój postaci'),
(4, 'Ekonomia', 'https://boardgamegeek.com/boardgamecategory/1021/economic', 'Zarządzanie zasobami i finansami'),
(5, 'Rodzinna', 'https://boardgamegeek.com/boardgamesubdomain/5499/family-games', 'Przystępne gry dla całych rodzin'),
(6, 'Karty', 'https://boardgamegeek.com/boardgamecategory/1002/card-game', 'Głównym elementem są karty'),
(7, 'Fantasy', 'https://boardgamegeek.com/boardgamecategory/1010/fantasy', 'Magia i fikcyjne światy'),
(8, 'Sci-Fi', 'https://boardgamegeek.com/boardgamecategory/1016/science-fiction', 'Kosmos i technologia'),
(9, 'Horror', 'https://boardgamegeek.com/boardgamecategory/1024/horror', 'Groza i mroczny klimat'),
(10, 'Logika', 'https://boardgamegeek.com/boardgamecategory/1028/puzzle', 'Zagadki logiczne i łamigłówki'),
(11, 'Kości', 'https://boardgamegeek.com/boardgamecategory/1017/dice', 'Gry oparte na rzutach kośćmi'),
(12, 'Abstrakcja', 'https://boardgamegeek.com/boardgamecategory/1009/abstract-strategy', 'Brak tematu, czysta taktyka'),
(13, 'Wojna', 'https://boardgamegeek.com/boardgamecategory/1019/wargame', 'Symulacja konfliktów militarnych'),
(14, 'RPG', 'https://boardgamegeek.com/boardgamemechanic/2028/role-playing', 'Elementy gier fabularnych'),
(15, 'Eurogra', 'https://boardgamegeek.com/wiki/page/Eurogame', 'Strategiczne gry w stylu europejskim'),
(16, 'Impreza', 'https://boardgamegeek.com/boardgamecategory/1030/party-game', 'Szybkie gry dla dużych grup'),
(17, 'Dorośli', 'https://boardgamegeek.com/boardgamecategory/1118/mature-adult', 'Tematyka 18+'),
(18, 'Dzieci', 'https://boardgamegeek.com/boardgamecategory/1041/childrens-game', 'Gry dla najmłodszych'),
(19, 'Tematyczna', 'https://boardgamegeek.com/boardgamesubdomain/5496/thematic-games', 'Gry z silnym klimatem i narracją'),
(20, 'Rozwój i budowa obszaru', 'https://boardgamegeek.com/boardgamecategory/1086/territory-building', 'Rozwój obszaru i budowa obszaru np. miasta '),
(21, 'Figurki', 'https://boardgamegeek.com/boardgamecategory/1047/miniatures', 'Gry z modelami'),
(22, 'Kontrola Terytorium', 'https://boardgamegeek.com/boardgamemechanic/2080/area-majority-influence', 'Kontrola obszarów (Area Control)'),
(23, 'Słowa', 'https://boardgamegeek.com/boardgamecategory/1025/word', 'Gry słowne'),
(24, 'Zręczność', 'https://boardgamegeek.com/boardgamecategory/1032/action-dexterity', 'Wymagające sprawności manualnej'),
(25, 'Przemysł', 'https://boardgamegeek.com/boardgamecategory/1088/industry-manufacturing', 'Produkcja i fabryki'),
(26, 'Historia', 'https://boardgamegeek.com/boardgamecategory/1035/medieval', 'Gry historyczne (np. średniowiecze)'),
(27, 'Mitologia', 'https://boardgamegeek.com/boardgamecategory/1082/mythology', 'Mity i legendy'),
(28, 'Ekologia', 'https://boardgamegeek.com/boardgamecategory/1084/environmental', 'Natura i środowisko'),
(29, 'Zarządzanie Ręką', 'https://boardgamegeek.com/boardgamemechanic/2040/hand-management', 'Optymalizacja kart na ręce'),
(30, 'Klasyk', 'https://boardgamegeek.com/browse/boardgame?sort=numvoters&sortdir=desc', 'Klasyki'),
(31, 'Kafelki', 'https://boardgamegeek.com/boardgamemechanic/2002/tile-placement', 'Układanie planszy z kafelków'),
(32, 'Negocjacje', 'https://boardgamegeek.com/boardgamecategory/1026/negotiation', 'Gry skupiające się na negocjacjach między graczami'),
(33, 'Tworzenie Zestawów', 'https://boardgamegeek.com/boardgamemechanic/2004/set-collection', 'Zbieranie zestawów elementów'),
(34, 'Dobieranie Wzorów', 'https://boardgamegeek.com/boardgamemechanic/2048/pattern-building', 'Układanie wzorów'),
(35, 'Budowanie Talii', 'https://boardgamegeek.com/boardgamemechanic/2664/deck-bag-and-pool-building', 'Tworzenie talii w trakcie gry'),
(36, 'Blef', 'https://boardgamegeek.com/boardgamecategory/1023/bluffing', 'Blefowanie przeciwników'),
(37, 'Dedukcja', 'https://boardgamegeek.com/boardgamecategory/1039/deduction', 'Wyciąganie logicznych wniosków'),
(38, 'Quiz', 'https://boardgamegeek.com/boardgamecategory/1027/trivia', 'Gry wiedzowe'),
(39, 'Pojedynek', 'https://boardgamegeek.com/boardgamefamily/61979/players-two-player-only-games', 'Gry jedynie dla dwóch graczy'),
(40, 'Eksploracja', 'https://boardgamegeek.com/boardgamecategory/1020/exploration', 'Odkrywanie mapy'),
(41, 'Edukacja', 'https://boardgamegeek.com/boardgamecategory/1094/educational', 'Gry edukacyjne'),
(42, 'Draft', 'https://boardgamegeek.com/boardgamemechanic/2041/card-drafting', 'Wybieranie kart z puli'),
(43, 'Wyścig', 'https://boardgamegeek.com/boardgamemechanic/2876/race', 'Wyścig do mety'),
(44, 'Ustawianie Robotników', 'https://boardgamegeek.com/boardgamemechanic/2082/worker-placement', 'Wysyłanie pracowników na pola akcji'),
(45, 'Wysokie Ryzyko', 'https://boardgamegeek.com/boardgamemechanic/2661/push-your-luck', 'Igranie z losem'),
(46, 'Licytacja', 'https://boardgamegeek.com/boardgamemechanic/2012/auction-bidding', 'Licytowanie dóbr'),
(47, 'Asymetria', 'https://boardgamegeek.com/boardgamemechanic/2015/variable-player-powers', 'Różne umiejętności graczy'),
(48, 'Zdrajca', 'https://boardgamegeek.com/boardgamemechanic/2686/traitor-game', 'Ukryty wróg wewnątrz drużyny działający na jej szkodę');
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
  `tytul_planszowki` varchar(255) DEFAULT NULL,
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

INSERT INTO `planszowka` 
(`id_planszowki`, `tytul_planszowki`, `data_wydania`, `wydawca`, `designer`, `min_graczy`, `max_graczy`, `min_dlugosc_rozgrywki`, `max_dlugosc_rozgrywki`, `waga`, `rekomendowany_wiek`, `bgg_id`) 
VALUES
(1, 'Brass: Birmingham', 2018, 'Roxley', 'Gavan Brown, Martin Wallace', 2, 4, 60, 120, 3.90, 14, '224517'),
(2, 'Pandemic Legacy: Season 1', 2015, 'Z-Man Games', 'Rob Daviau, Matt Leacock', 2, 4, 60, 60, 2.84, 13, '161936'),
(3, 'Gloomhaven', 2017, 'Cephalofair Games', 'Isaac Childres', 1, 4, 60, 120, 3.90, 14, '174430'),
(4, 'Ark Nova', 2021, 'Feuerland Spiele', 'Mathias Wigge', 1, 4, 90, 150, 3.70, 14, '342942'),
(5, 'Twilight Imperium: Fourth Edition', 2017, 'Fantasy Flight Games', 'Dane Beltrami', 3, 6, 240, 480, 4.30, 14, '233078'),
(6, 'Dune: Imperium', 2020, 'Dire Wolf', 'Paul Dennen', 1, 4, 60, 120, 3.00, 14, '316554'),
(7, 'Terraforming Mars', 2016, 'FryxGames', 'Jacob Fryxelius', 1, 5, 120, 120, 3.20, 12, '167791'),
(8, 'War of the Ring: Second Edition', 2012, 'Ares Games', 'Roberto Di Meglio', 2, 4, 150, 180, 4.20, 13, '115746'),
(9, 'Spirit Island', 2017, 'Greater Than Games', 'R. Eric Reuss', 1, 4, 90, 120, 4.00, 13, '162886'),
(10, 'Gaia Project', 2017, 'Feuerland Spiele', 'Jens Drögemüller', 1, 4, 60, 150, 4.40, 12, '220308'),
(11, 'Star Wars: Rebellion', 2016, 'Fantasy Flight Games', 'Corey Konieczka', 2, 4, 180, 240, 3.70, 14, '187645'),
(12, 'Scythe', 2016, 'Stonemaier Games', 'Jamey Stegmaier', 1, 5, 90, 115, 3.40, 14, '169786'),
(13, 'Great Western Trail', 2016, 'eggertspiele', 'Alexander Pfister', 2, 4, 75, 150, 3.70, 12, '193738'),
(14, 'The Castles of Burgundy', 2011, 'ale', 'Stefan Feld', 2, 4, 30, 90, 3.00, 12, '84876'),
(15, '7 Wonders Duel', 2015, 'Repos Production', 'Antoine Bauza, Bruno Cathala', 2, 2, 30, 30, 2.20, 10, '173346'),
(16, 'Concordia', 2013, 'PD-Verlag', 'Mac Gerdts', 2, 5, 100, 100, 3.00, 13, '124361'),
(17, 'Wingspan', 2019, 'Stonemaier Games', 'Elizabeth Hargrave', 1, 5, 40, 70, 2.45, 10, '266192'),
(18, 'Viticulture Essential Edition', 2015, 'Stonemaier Games', 'Jamey Stegmaier', 1, 6, 45, 90, 2.90, 13, '183394'),
(19, 'Everdell', 2018, 'Starling Games', 'James A. Wilson', 1, 4, 40, 80, 2.80, 13, '199792'),
(20, 'Orléans', 2014, 'dlp games', 'Reiner Stockhausen', 2, 4, 90, 90, 3.00, 12, '164928'),
(21, 'A Feast for Odin', 2016, 'Feuerland Spiele', 'Uwe Rosenberg', 1, 4, 30, 120, 3.80, 12, '177736'),
(22, 'Blood Rage', 2015, 'CMON', 'Eric M. Lang', 2, 4, 60, 90, 2.80, 14, '170216'),
(23, 'Root', 2018, 'Leder Games', 'Cole Wehrle', 2, 4, 60, 90, 3.80, 10, '237182'),
(24, 'The Crew: The Quest for Planet Nine', 2019, 'KOSMOS', 'Thomas Sing', 2, 5, 20, 20, 1.90, 10, '284083'),
(25, 'Ticket to Ride', 2004, 'Days of Wonder', 'Alan R. Moon', 2, 5, 30, 60, 1.80, 8, '9209'),
(26, 'Cascadia', 2021, 'Flatout Games', 'Randy Flynn', 1, 4, 30, 45, 1.80, 10, '295947'),
(27, 'Codenames', 2015, 'Czech Games Edition', 'Vlaada Chvátil', 2, 8, 15, 15, 1.20, 14, '178900'),
(28, '7 Wonders', 2010, 'Repos Production', 'Antoine Bauza', 2, 7, 30, 30, 2.30, 10, '68448'),
(29, 'Azul', 2017, 'Plan B Games', 'Michael Kiesling', 2, 4, 30, 45, 1.70, 8, '230802'),
(30, 'Patchwork', 2014, 'Lookout Games', 'Uwe Rosenberg', 2, 2, 15, 30, 1.60, 8, '163412'),
(31, 'Splendor', 2014, 'Space Cowboys', 'Marc André', 2, 4, 30, 30, 1.70, 10, '148228'),
(32, 'Carcassonne', 2000, 'Hans im Glück', 'Klaus-Jürgen Wrede', 2, 5, 30, 45, 1.90, 7, '822'),
(33, 'King of Tokyo', 2011, 'IELLO', 'Richard Garfield', 2, 6, 30, 30, 1.50, 8, '70323'),
(34, 'Love Letter', 2012, 'AEG', 'Seiji Kanai', 2, 4, 20, 20, 1.10, 10, '129622'),
(35, 'The Mind', 2018, 'Nürnberger-Spielkarten-Verlag', 'Wolfgang Warsch', 2, 4, 20, 20, 1.00, 8, '244992'),
(36, 'Crokinole', 1876, 'Public Domain', '(Uncredited)', 2, 4, 30, 30, 1.20, 8, '521'),
(37, 'Decrypto', 2018, 'Le Scorpion Masqué', 'Thomas Dagenais-Lespérance', 3, 8, 15, 45, 1.80, 12, '225694'),
(38, 'Sushi Go!', 2013, 'Gamewright', 'Phil Walker-Harding', 2, 5, 15, 15, 1.10, 8, '133473'),
(39, 'Clank! A Deck-Building Adventure', 2016, 'Renegade Game Studios', 'Paul Dennen', 2, 4, 30, 60, 2.20, 12, '201808'),
(40, 'The Quacks of Quedlinburg', 2018, 'Schmidt Spiele', 'Wolfgang Warsch', 2, 4, 45, 45, 1.90, 10, '244521'),
(41, 'Cartographers', 2019, 'Thunderworks Games', 'Jordy Adan', 1, 100, 30, 45, 1.80, 10, '263918'),
(42, 'The Resistance: Avalon', 2012, 'Indie Boards & Cards', 'Don Eskridge', 5, 10, 30, 30, 1.70, 13, '128882'),
(43, 'Just One', 2018, 'Repos Production', 'Ludovic Roudy', 3, 7, 20, 20, 1.00, 8, '254640'),
(44, 'Heat: Pedal to the Metal', 2022, 'Days of Wonder', 'Asger Harding Granerud', 1, 6, 30, 60, 2.20, 10, '366013'),
(45, 'Lost Ruins of Arnak', 2020, 'CGE', 'Mín & Elwen', 1, 4, 30, 120, 2.90, 12, '312484'),
(46, 'Marvel Champions: The Card Game', 2019, 'Fantasy Flight Games', 'Michael Boggs', 1, 4, 45, 90, 2.90, 14, '285774'),
(47, 'Le Havre', 2008, 'Lookout Games', 'Uwe Rosenberg', 1, 5, 30, 150, 3.70, 12, '35677'),
(48, 'Mage Knight Board Game', 2011, 'WizKids', 'Vlaada Chvátil', 1, 4, 60, 240, 4.30, 14, '96848'),
(49, 'Nemesis', 2018, 'Awaken Realms', 'Adam Kwapiński', 1, 5, 90, 180, 3.40, 12, '167355'),
(50, 'Mansions of Madness: Second Edition', 2016, 'Fantasy Flight Games', 'Nikki Valens', 1, 5, 120, 180, 2.60, 14, '205059'),
(51, 'Through the Ages: A New Story of Civilization', 2015, 'Czech Games Edition', 'Vlaada Chvátil', 2, 4, 120, 240, 4.43, 14, '182028'),
(52, 'Agricola', 2007, 'Lookout Games', 'Uwe Rosenberg', 1, 5, 30, 150, 3.64, 12, '31260'),
(53, 'Power Grid', 2004, '2F-Spiele', 'Friedemann Friese', 2, 6, 120, 120, 3.26, 12, '2651'),
(54, 'Barrage', 2019, 'Cranio Creations', 'Tommaso Battista', 1, 4, 60, 120, 4.09, 14, '251247'),
(55, 'The Gallerist', 2015, 'Eagle-Gryphon Games', 'Vital Lacerda', 1, 4, 60, 150, 4.27, 13, '125153'),
(56, 'Tzolk''in: The Mayan Calendar', 2012, 'Czech Games Edition', 'Simone Luciani', 2, 4, 90, 90, 3.67, 13, '126163'),
(57, 'Anachrony', 2017, 'Mindclash Games', 'Dávid Turczi', 1, 4, 30, 120, 3.99, 15, '185343'),
(58, 'Kingdom Death: Monster', 2015, 'Kingdom Death', 'Adam Poots', 1, 4, 60, 180, 4.26, 18, '55690'),
(59, 'Rising Sun', 2018, 'CMON', 'Eric M. Lang', 3, 5, 90, 120, 3.23, 14, '205896'),
(60, 'Inis', 2016, 'Matagot', 'Christian Martinez', 2, 4, 60, 90, 2.89, 14, '155821'),
(61, 'Cosmic Encounter', 2008, 'Fantasy Flight Games', 'Bill Eberle', 3, 5, 60, 120, 2.57, 12, '39463'),
(62, 'Sheriff of Nottingham', 2014, 'Arcane Wonders', 'Sérgio Halaban', 3, 5, 60, 60, 1.65, 13, '157969'),
(63, 'Five Tribes', 2014, 'Days of Wonder', 'Bruno Cathala', 2, 4, 40, 80, 2.84, 13, '157354'),
(64, 'Istanbul', 2014, 'Pegasus Spiele', 'Rüdiger Dorn', 2, 5, 40, 60, 2.58, 10, '148949'),
(65, 'Raiders of the North Sea', 2015, 'Garphill Games', 'Shem Phillips', 2, 4, 60, 80, 2.60, 12, '170042'),
(66, 'Architects of the West Kingdom', 2018, 'Garphill Games', 'Shem Phillips', 1, 5, 60, 80, 2.76, 12, '236457'),
(67, 'Sagrada', 2017, 'Floodgate Games', 'Daryl Andrews', 1, 4, 30, 45, 1.93, 13, '199561'),
(68, 'Kingdomino', 2016, 'Blue Orange Games', 'Bruno Cathala', 2, 4, 15, 15, 1.21, 8, '204583'),
(69, 'Catan', 1995, 'KOSMOS', 'Klaus Teuber', 3, 4, 60, 120, 2.30, 10, '13'),
(70, 'Small World', 2009, 'Days of Wonder', 'Philippe Keyaerts', 2, 5, 40, 80, 2.34, 8, '40692'),
(71, 'Takenoko', 2011, 'Matagot', 'Antoine Bauza', 2, 4, 45, 45, 1.97, 8, '70919'),
(72, 'Jaipur', 2009, 'GameWorks', 'Sébastien Pauchon', 2, 2, 30, 30, 1.48, 12, '54043'),
(73, 'Hive', 2001, 'Gen42 Games', 'John Yianni', 2, 2, 20, 20, 2.33, 9, '2655'),
(74, 'Santorini', 2016, 'Roxley', 'Gord!', 2, 4, 20, 20, 1.72, 8, '194655'),
(75, 'Star Realms', 2014, 'White Wizard Games', 'Robert Dougherty', 2, 2, 20, 20, 1.93, 12, '147020'),
(76, 'Dominion', 2008, 'Rio Grande Games', 'Donald X. Vaccarino', 2, 4, 30, 30, 2.35, 13, '36218'),
(77, 'Race for the Galaxy', 2007, 'Rio Grande Games', 'Thomas Lehmann', 2, 4, 30, 60, 2.99, 12, '28143'),
(78, 'Sherlock Holmes Consulting Detective', 1981, 'Ystari Games', 'Raymond Edwards', 1, 8, 60, 120, 2.68, 13, '2511'),
(79, 'Robinson Crusoe: Adventures on the Cursed Island', 2012, 'Portal Games', 'Ignacy Trzewiczek', 1, 4, 60, 120, 3.82, 14, '121921'),
(80, 'El Grande', 1995, 'Hans im Glück', 'Wolfgang Kramer', 2, 5, 60, 120, 3.05, 12, '93'),
(81, 'Tigris & Euphrates', 1997, 'Hans im Glück', 'Reiner Knizia', 2, 4, 90, 90, 3.52, 12, '42'),
(82, 'Eclipse: Second Dawn for the Galaxy', 2020, 'Lautapelit.fi', 'Touko Tahkokallio', 2, 6, 60, 200, 3.61, 14, '246900'),
(83, 'A Game of Thrones: The Board Game (2nd Ed)', 2011, 'Fantasy Flight Games', 'Christian T. Petersen', 3, 6, 120, 240, 3.73, 14, '103343'),
(84, 'Battlestar Galactica: The Board Game', 2008, 'Fantasy Flight Games', 'Corey Konieczka', 3, 6, 120, 180, 3.24, 14, '37111'),
(85, 'Puerto Rico', 2002, 'alea', 'Andreas Seyfarth', 3, 5, 90, 150, 3.27, 12, '3076'),
(86, 'Caverna: The Cave Farmers', 2013, 'Lookout Games', 'Uwe Rosenberg', 1, 7, 30, 210, 3.79, 12, '102794'),
(87, 'Food Chain Magnate', 2015, 'Splotter Spellen', 'Jeroen Doumen', 2, 5, 120, 240, 4.22, 14, '175914'),
(88, 'Grand Austria Hotel', 2015, 'Lookout Games', 'Virginio Gigli', 2, 4, 60, 120, 3.23, 12, '182874'),
(89, 'Yokohama', 2016, 'Tasty Minstrel Games', 'Hisashi Hayashi', 2, 4, 90, 90, 3.31, 12, '196340'),
(90, 'Champions of Midgard', 2015, 'Grey Fox Games', 'Ole Steiness', 2, 4, 60, 90, 2.56, 10, '172287'),
(91, 'Lords of Waterdeep', 2012, 'Wizards of the Coast', 'Peter Lee', 2, 5, 60, 120, 2.45, 12, '110327'),
(92, 'Stone Age', 2008, 'Hans im Glück', 'Bernd Brunnhofer', 2, 4, 60, 90, 2.47, 10, '34635'),
(93, 'Biblios', 2007, 'IELLO', 'Steve Finn', 2, 4, 30, 30, 1.67, 10, '34219'),
(94, 'Bohnanza', 1997, 'Amigo', 'Uwe Rosenberg', 2, 7, 45, 45, 1.61, 10, '11'),
(95, 'Skull', 2011, 'Lui-même', 'Hervé Marly', 3, 6, 15, 45, 1.13, 10, '92415'),
(96, 'Dixit', 2008, 'Libellud', 'Jean-Louis Roubira', 3, 6, 30, 30, 1.21, 8, '39856'),
(97, 'Mysterium', 2015, 'Libellud', 'Oleksandr Nevskiy', 2, 7, 42, 42, 1.90, 10, '181304'),
(98, 'Hanabi', 2010, 'Abacusspiele', 'Antoine Bauza', 2, 5, 25, 25, 1.69, 8, '98778'),
(99, 'No Thanks!', 2004, 'Amigo', 'Thorsten Gimmler', 3, 7, 20, 20, 1.13, 8, '12942'),
(100, 'For Sale', 1997, 'Uberplay', 'Stefan Dorra', 3, 6, 20, 30, 1.25, 8, '172');
-- --------------------------------------------------------


--
-- Struktura tabeli dla tabeli `planszowka_gatunek`
--

CREATE TABLE `planszowka_gatunek` (
  `id_planszowki` int(11) NOT NULL,
  `id_gatunku` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `planszowka_gatunek` (`id_planszowki`, `id_gatunku`) VALUES
-- 1. Brass: Birmingham (Ekonomia, Przemysł, Strategia)
(1, 4), (1, 25), (1, 2),
-- 2. Pandemic Legacy (Kooperacja, Strategia)
(2, 1), (2, 2),
-- 3. Gloomhaven (Przygoda, Fantasy, Walka/Pojedynek, Kooperacja)
(3, 3), (3, 7), (3, 39), (3, 1),
-- 4. Ark Nova (Strategia, Ekologia/Zwierzęta, Ekonomia)
(4, 2), (4, 28), (4, 4),
-- 5. Twilight Imperium (Sci-Fi, Strategia, Polityka/Negocjacje, Wojna)
(5, 8), (5, 2), (5, 32), (5, 13),
-- 6. Dune: Imperium (Sci-Fi, Worker Placement, Deck Building)
(6, 8), (6, 44), (6, 35),
-- 7. Terraforming Mars (Sci-Fi, Ekonomia, Strategia)
(7, 8), (7, 4), (7, 2),
-- 8. War of the Ring (Wojna, Fantasy, Figurki)
(8, 13), (8, 7), (8, 21),
-- 9. Spirit Island (Kooperacja, Strategia, Fantasy)
(9, 1), (9, 2), (9, 7),
-- 10. Gaia Project (Sci-Fi, Ekonomia)
(10, 8), (10, 4),
-- 11. Star Wars Rebellion (Sci-Fi, Wojna, Figurki)
(11, 8), (11, 13), (11, 21),
-- 12. Scythe (Strategia, Ekonomia, Figurki)
(12, 2), (12, 4), (12, 21),
-- 13. Great Western Trail (Strategia, Western/Historia)
(13, 2), (13, 26),
-- 14. Castles of Burgundy (Kości, Strategia)
(14, 11), (14, 2),
-- 15. 7 Wonders Duel (Karty, Draft, Pojedynek)
(15, 6), (15, 42), (15, 39),
-- 16. Concordia (Strategia, Ekonomia)
(16, 2), (16, 4),
-- 17. Wingspan (Karty, Ekologia, Rodzinna)
(17, 6), (17, 28), (17, 5),
-- 18. Viticulture (Worker Placement, Ekonomia)
(18, 44), (18, 4),
-- 19. Everdell (Worker Placement, Karty, Zwierzęta/Fantasy)
(19, 44), (19, 6), (19, 7),
-- 20. Orleans (Strategia, Bag building/Deck Building)
(20, 2), (20, 35),
-- 21. Feast for Odin (Worker Placement, Wikingowie/Historia)
(21, 44), (21, 26),
-- 22. Blood Rage (Figurki, Wojna, Fantasy, Draft)
(22, 21), (22, 13), (22, 7), (22, 42),
-- 23. Root (Wojna, Asymetria, Zwierzęta/Fantasy)
(23, 13), (23, 47), (23, 7),
-- 24. The Crew (Karty, Kooperacja)
(24, 6), (24, 1),
-- 25. Ticket to Ride (Rodzinna, Pociągi/Klasyk)
(25, 5), (25, 30),
-- 26. Cascadia (Rodzinna, Ekologia, Kafelki)
(26, 5), (26, 28), (26, 31),
-- 27. Codenames (Impreza, Słowa, Dedukcja)
(27, 16), (27, 23), (27, 37),
-- 28. 7 Wonders (Draft, Karty, Rodzinna)
(28, 42), (28, 6), (28, 5),
-- 29. Azul (Abstrakcja, Rodzinna, Kafelki)
(29, 12), (29, 5), (29, 31),
-- 30. Patchwork (Rodzinna, Kafelki, 2 graczy)
(30, 5), (30, 31),
-- 31. Splendor (Rodzinna, Ekonomia)
(31, 5), (31, 4),
-- 32. Carcassonne (Rodzinna, Kafelki, Klasyk)
(32, 5), (32, 31), (32, 30),
-- 33. King of Tokyo (Kości, Rodzinna, Walka)
(33, 11), (33, 5), (33, 39),
-- 34. Love Letter (Karty, Rodzinna, Dedukcja)
(34, 6), (34, 5), (34, 37),
-- 35. The Mind (Karty, Kooperacja)
(35, 6), (35, 1),
-- 36. Crokinole (Zręczność, Abstrakcja)
(36, 24), (36, 12),
-- 37. Decrypto (Słowa, Dedukcja, Impreza)
(37, 23), (37, 37), (37, 16),
-- 38. Sushi Go (Draft, Karty, Rodzinna)
(38, 42), (38, 6), (38, 5),
-- 39. Clank! (Deck Building, Przygoda)
(39, 35), (39, 3),
-- 40. Quacks of Quedlinburg (Ryzyko, Rodzinna)
(40, 45), (40, 5),
-- 41. Cartographers (Wykreślanka, Fantasy - brak ID wykreślanki, dam Rodzinna)
(41, 5), (41, 7),
-- 42. The Resistance (Blef, Impreza, Dedukcja)
(42, 36), (42, 16), (42, 37),
-- 43. Just One (Impreza, Słowa, Kooperacja)
(43, 16), (43, 23), (43, 1),
-- 44. Heat (Wyścig, Karty)
(44, 43), (44, 6),
-- 45. Lost Ruins of Arnak (Przygoda, Worker Placement, Deck Building)
(45, 3), (45, 44), (45, 35),
-- 46. Marvel Champions (Karty, Kooperacja, Superbohaterowie)
(46, 6), (46, 1),
-- 47. Le Havre (Ekonomia, Przemysł)
(47, 4), (47, 25),
-- 48. Mage Knight (Przygoda, Fantasy, Strategia)
(48, 3), (48, 7), (48, 2),
-- 49. Nemesis (Sci-Fi, Horror, Figurki)
(49, 8), (49, 9), (49, 21),
-- 50. Mansions of Madness (Horror, Przygoda, Kooperacja)
(50, 9), (50, 3), (50, 1),
-- 51. Through the Ages (Rozwój/Cywilizacja, Strategia, Ekonomia)
(51, 20), (51, 2), (51, 4),
-- 52. Agricola (Robotnicy, Ekonomia, Klasyk)
(52, 44), (52, 4), (52, 30),
-- 53. Power Grid (Ekonomia, Licytacja, Przemysł)
(53, 4), (53, 46), (53, 25),
-- 54. Barrage (Ekonomia, Przemysł, Terytorium)
(54, 4), (54, 25), (54, 22),
-- 55. The Gallerist (Ekonomia, Robotnicy, Sztuka/Eurogra)
(55, 4), (55, 44), (55, 15),
-- 56. Tzolk'in (Robotnicy, Eurogra, Strategia)
(56, 44), (56, 15), (56, 2),
-- 57. Anachrony (Sci-Fi, Robotnicy, Czas)
(57, 8), (57, 44), (57, 2),
-- 58. Kingdom Death Monster (Horror, Figurki, RPG, Kooperacja)
(58, 9), (58, 21), (58, 14), (58, 1),
-- 59. Rising Sun (Figurki, Terytorium, Japonia/Mitologia, Negocjacje)
(59, 21), (59, 22), (59, 27), (59, 32),
-- 60. Inis (Terytorium, Draft, Mitologia celtycka)
(60, 22), (60, 42), (60, 27),
-- 61. Cosmic Encounter (Sci-Fi, Negocjacje, Asymetria)
(61, 8), (61, 32), (61, 47),
-- 62. Sheriff of Nottingham (Blef, Impreza, Negocjacje)
(62, 36), (62, 16), (62, 32),
-- 63. Five Tribes (Strategia, Mancala/Abstrakcja)
(63, 2), (63, 12),
-- 64. Istanbul (Wyścig, Strategia, Ekonomia)
(64, 43), (64, 2), (64, 4),
-- 65. Raiders of the North Sea (Robotnicy, Wikingowie/Historia)
(65, 44), (65, 26),
-- 66. Architects of West Kingdom (Robotnicy, Strategia)
(66, 44), (66, 2),
-- 67. Sagrada (Kości, Logika, Abstrakcja)
(67, 11), (67, 10), (67, 12),
-- 68. Kingdomino (Rodzinna, Kafelki)
(68, 5), (68, 31),
-- 69. Catan (Rodzinna, Negocjacje, Klasyk)
(69, 5), (69, 32), (69, 30),
-- 70. Small World (Terytorium, Fantasy, Asymetria)
(70, 22), (70, 7), (70, 47),
-- 71. Takenoko (Rodzinna, Zwierzęta, Kafelki)
(71, 5), (71, 31),
-- 72. Jaipur (Karty, Ekonomia, Pojedynek)
(72, 6), (72, 4), (72, 39),
-- 73. Hive (Abstrakcja, Owady, Pojedynek)
(73, 12), (73, 39),
-- 74. Santorini (Abstrakcja, Mitologia, Logika)
(74, 12), (74, 27), (74, 10),
-- 75. Star Realms (Deck Building, Sci-Fi, Pojedynek)
(75, 35), (75, 8), (75, 39),
-- 76. Dominion (Deck Building, Klasyk, Karty)
(76, 35), (76, 30), (76, 6),
-- 77. Race for the Galaxy (Karty, Sci-Fi, Ekonomia)
(77, 6), (77, 8), (77, 4),
-- 78. Sherlock Holmes CD (Dedukcja, Kooperacja, Kryminał)
(78, 37), (78, 1),
-- 79. Robinson Crusoe (Przygoda, Kooperacja, Trudna)
(79, 3), (79, 1), (79, 45),
-- 80. El Grande (Terytorium, Klasyk, Strategia)
(80, 22), (80, 30), (80, 2),
-- 81. Tigris & Euphrates (Terytorium, Abstrakcja, Klasyk)
(81, 22), (81, 12), (81, 30),
-- 82. Eclipse (Sci-Fi, Strategia, Wojna)
(82, 8), (82, 2), (82, 13),
-- 83. Game of Thrones (Wojna, Negocjacje, Strategia)
(83, 13), (83, 32), (83, 2),
-- 84. Battlestar Galactica (Zdrajca/Blef, Sci-Fi, Kooperacja)
(84, 36), (84, 8), (84, 1),
-- 85. Puerto Rico (Ekonomia, Strategia, Klasyk)
(85, 4), (85, 2), (85, 30),
-- 86. Caverna (Robotnicy, Ekonomia)
(86, 44), (86, 4),
-- 87. Food Chain Magnate (Ekonomia, Strategia, Biznes)
(87, 4), (87, 2),
-- 88. Grand Austria Hotel (Kości, Ekonomia)
(88, 11), (88, 4),
-- 89. Yokohama (Strategia, Robotnicy)
(89, 2), (89, 44),
-- 90. Champions of Midgard (Robotnicy, Kości, Wikingowie)
(90, 44), (90, 11),
-- 91. Lords of Waterdeep (Robotnicy, Fantasy, Rodzinna)
(91, 44), (91, 7), (91, 5),
-- 92. Stone Age (Robotnicy, Kości, Rodzinna, Klasyk)
(92, 44), (92, 11), (92, 5), (92, 30),
-- 93. Biblios (Licytacja, Karty)
(93, 46), (93, 6),
-- 94. Bohnanza (Negocjacje, Karty, Rodzinna)
(94, 32), (94, 6), (94, 5),
-- 95. Skull (Blef, Impreza)
(95, 36), (95, 16),
-- 96. Dixit (Impreza, Słowa/Skojarzenia, Rodzinna)
(96, 16), (96, 5),
-- 97. Mysterium (Kooperacja, Dedukcja, Obrazy)
(97, 1), (97, 37),
-- 98. Hanabi (Kooperacja, Karty, Dedukcja/Logika)
(98, 1), (98, 6), (98, 10),
-- 99. No Thanks! (Ryzyko, Karciana, Rodzinna)
(99, 45), (99, 6), (99, 5),
-- 100. For Sale (Licytacja, Ekonomia, Rodzinna)
(100, 46), (100, 4), (100, 5);

INSERT INTO `planszowka_gatunek` (`id_planszowki`, `id_gatunku`) VALUES
(42, 48),
(49, 48),
(84, 48);
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

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `plugin`
--

CREATE TABLE `plugin` (
  `id_pluginu` int(11) NOT NULL,
  `nazwa_pluginu` varchar(255) NOT NULL,
  `struktura_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
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

INSERT INTO `status` (`id_statusu`, `nazwa_statusu`) VALUES
(2, 'Chcę zagrać'),
(1, 'Posiadam'),
(4, 'Pożyczone'),
(3, 'Sprzedane');

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
  `dane_arkusza` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uprawnienia`
--

CREATE TABLE `uprawnienia` (
  `id_uprawnien` int(11) NOT NULL,
  `typ_uprawnienia` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uprawnienia`
--

INSERT INTO `uprawnienia` (`id_uprawnien`, `typ_uprawnienia`) VALUES
(1, 'Administrator'),
(2, 'Moderator'),
(3, 'Użytkownik');

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
  MODIFY `id_statusu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `uczestnicy_rozgrywki`
--
ALTER TABLE `uczestnicy_rozgrywki`
  MODIFY `id_uczestnictwa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uprawnienia`
--
ALTER TABLE `uprawnienia`
  MODIFY `id_uprawnien` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `uzytkownik`
--
ALTER TABLE `uzytkownik`
  MODIFY `id_uzytkownika` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `arkusz_punktacji`
--
ALTER TABLE `arkusz_punktacji`
  ADD CONSTRAINT `fk_arkusz_gra` FOREIGN KEY (`id_planszowki`) REFERENCES `planszowka` (`id_planszowki`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_arkusz_plugin` FOREIGN KEY (`id_pluginu`) REFERENCES `plugin` (`id_pluginu`) ON DELETE CASCADE;

--
-- Constraints for table `komentarz`
--
ALTER TABLE `komentarz`
  ADD CONSTRAINT `fk_kom_autor` FOREIGN KEY (`id_autora`) REFERENCES `uzytkownik` (`id_uzytkownika`),
  ADD CONSTRAINT `fk_kom_rozgrywka` FOREIGN KEY (`id_rozgrywki`) REFERENCES `rozgrywka` (`id_rozgrywki`) ON DELETE CASCADE;

--
-- Constraints for table `planszowka`
--
ALTER TABLE `planszowka`
  ADD CONSTRAINT `fk_planszowka_tworca` FOREIGN KEY (`stworzone_przez_id_uzytkownika`) REFERENCES `uzytkownik` (`id_uzytkownika`) ON DELETE SET NULL;

--
-- Constraints for table `planszowka_gatunek`
--
ALTER TABLE `planszowka_gatunek`
  ADD CONSTRAINT `fk_pg_gatunek` FOREIGN KEY (`id_gatunku`) REFERENCES `gatunek` (`id_gatunku`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pg_planszowka` FOREIGN KEY (`id_planszowki`) REFERENCES `planszowka` (`id_planszowki`) ON DELETE CASCADE;

--
-- Constraints for table `planszowka_w_kolekcji`
--
ALTER TABLE `planszowka_w_kolekcji`
  ADD CONSTRAINT `fk_pk_game` FOREIGN KEY (`id_planszowki`) REFERENCES `planszowka` (`id_planszowki`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pk_status` FOREIGN KEY (`id_statusu`) REFERENCES `status` (`id_statusu`),
  ADD CONSTRAINT `fk_pk_user` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownik` (`id_uzytkownika`) ON DELETE CASCADE;

--
-- Constraints for table `plugin`
--
ALTER TABLE `plugin`
  ADD CONSTRAINT `fk_plugin_tworca` FOREIGN KEY (`stworzone_przez_id_uzytkownika`) REFERENCES `uzytkownik` (`id_uzytkownika`) ON DELETE SET NULL;

--
-- Constraints for table `rozgrywka`
--
ALTER TABLE `rozgrywka`
  ADD CONSTRAINT `fk_rozgrywka_gra` FOREIGN KEY (`id_planszowki`) REFERENCES `planszowka` (`id_planszowki`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_rozgrywka_org` FOREIGN KEY (`id_organizatora`) REFERENCES `uzytkownik` (`id_uzytkownika`);

--
-- Constraints for table `uczestnicy_rozgrywki`
--
ALTER TABLE `uczestnicy_rozgrywki`
  ADD CONSTRAINT `fk_uczestnik_arkusz` FOREIGN KEY (`id_arkusza_uzytego`) REFERENCES `arkusz_punktacji` (`id_arkusza`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_uczestnik_rozgrywka` FOREIGN KEY (`id_rozgrywki`) REFERENCES `rozgrywka` (`id_rozgrywki`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_uczestnik_user` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownik` (`id_uzytkownika`) ON DELETE SET NULL;

--
-- Constraints for table `uzytkownik`
--
ALTER TABLE `uzytkownik`
  ADD CONSTRAINT `fk_uzytkownik_uprawnienia` FOREIGN KEY (`id_uprawnien`) REFERENCES `uprawnienia` (`id_uprawnien`);



DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `Auto_Archiwizacja_Co_Miesiac` ON SCHEDULE EVERY 1 MONTH STARTS '2026-01-11 13:46:13' ON COMPLETION NOT PRESERVE ENABLE DO CALL Archiwizuj_Stare_Rozgrywki()$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
