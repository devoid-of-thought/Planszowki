SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
SET NAMES utf8mb4;

-- Wyłączenie sprawdzania kluczy obcych na czas importu
SET FOREIGN_KEY_CHECKS = 0;

-- --------------------------------------------------------
-- 1. Użytkownicy
-- --------------------------------------------------------
INSERT INTO `uzytkownik` (`id_uzytkownika`, `nazwa_uzytkownika`, `adres_email`, `haslo`, `zdjecie`, `id_uprawnien`, `data_utworzenia`) VALUES
(1, 'User1', 'user1@user.com', '$2y$10$34/jdv3YOiEnWNZrKfcQyOBjlXKsxQayZHeiAdDrYDQvnKOSZT1l2', NULL, 3, '2026-02-02 00:44:09'),
(2, 'User2', 'user2@user.com', '$2y$10$okJnwU1PNXHjF3amAhKveuXzY.wXbR3az8gFnQpszZgS4zmfX6mLi', NULL, 3, '2026-02-02 00:44:31'),
(3, 'User3', 'user3@user.com', '$2y$10$ivJ0FLRjc3/PWK3IIXWKJufhJMZVcKaZ0p25MZ3Rz.4uNC6Mis6wy', NULL, 3, '2026-02-02 00:44:53'),
(4, 'User4', 'user4@user.com', '$2y$10$y3Ewq9.xx8zWoRn4RZu1o.VpQz5/RTyydF4zuPSpmFhgtb7ZjKQhy', NULL, 3, '2026-02-02 00:45:08'),
(5, 'User5', 'user5@user.com', '$2y$10$XpaRmhn5AWg8ovyyh8Dgv.Tub86XhUlHsz9l31LxNVN85PUg6mJeW', NULL, 3, '2026-02-02 00:45:59');

-- --------------------------------------------------------
-- 2. Kolekcja
-- --------------------------------------------------------
INSERT INTO `planszowka_w_kolekcji` (`id_planszowki_w_kolekcji`, `id_uzytkownika`, `id_planszowki`, `ocena`, `komentarz`, `id_statusu`, `data_dodania`) VALUES
(1, 1, 28, 5, '', 1, '2026-02-02 00:46:27'),
(2, 1, 101, NULL, 'Fajna', 1, '2026-02-02 00:46:41'),
(3, 1, 1, 8, 'Brakuje paru znaczników', 1, '2026-02-02 00:47:22'),
(4, 1, 54, 4, 'meh', 3, '2026-02-02 00:47:44'),
(5, 1, 69, 10, 'Peak!', 1, '2026-02-02 00:48:05'),
(6, 2, 29, NULL, '', 1, '2026-02-02 00:49:43'),
(7, 2, 37, NULL, '', 1, '2026-02-02 00:49:52'),
(8, 2, 124, NULL, '', 1, '2026-02-02 00:49:58'),
(9, 2, 132, NULL, '', 2, '2026-02-02 00:50:02'),
(10, 3, 15, NULL, '', 1, '2026-02-02 00:51:57'),
(11, 3, 19, NULL, '', 1, '2026-02-02 00:52:06'),
(12, 3, 113, NULL, '', 2, '2026-02-02 00:52:15'),
(13, 3, 96, NULL, '', 2, '2026-02-02 00:52:21'),
(14, 3, 30, NULL, '', 2, '2026-02-02 00:52:26'),
(15, 4, 21, NULL, '', 2, '2026-02-02 01:04:59'),
(16, 4, 84, NULL, '', 2, '2026-02-02 01:05:04'),
(17, 4, 32, NULL, '', 4, '2026-02-02 01:05:11'),
(18, 4, 93, NULL, '', 1, '2026-02-02 01:05:18'),
(20, 4, 29, NULL, '', 1, '2026-02-02 01:05:27');

-- --------------------------------------------------------
-- 3. Znajomi
-- --------------------------------------------------------
INSERT INTO `relacje_uzytkownikow` (`id_uzytkownika1`, `id_uzytkownika2`, `data_rozpoczecia`) VALUES
(1, 2, '2026-02-02 00:50:15'),
(1, 3, '2026-02-02 00:52:32'),
(2, 3, '2026-02-02 00:52:35'),
(4, 1, '2026-02-02 01:05:54'),
(2, 4, '2026-02-04 10:00:00'),
(2, 5, '2026-02-04 12:30:00'),
(3, 4, '2026-02-05 09:15:00'),
(3, 5, '2026-02-05 09:20:00'),
(5, 1, '2026-02-06 18:45:00');

-- --------------------------------------------------------
-- 4. Zaproszenia
-- --------------------------------------------------------
INSERT INTO `zaproszenia_do_znajomych` (`id_zaproszenia`, `id_uzytkownika1`, `id_uzytkownika2`) VALUES
(2, 1, 5),
(3, 5, 4),
(4, 4, 3);

-- --------------------------------------------------------
-- 5. Rozgrywki (IDs 2-25)
-- --------------------------------------------------------
INSERT INTO `rozgrywka` (`id_rozgrywki`, `id_planszowki`, `id_organizatora`, `data_rozgrywki`, `tytul_rozgrywki`, `czas_trwania`, `notatka_do_gry`) VALUES
(2, 15, 3, '2026-02-01 23:00:00', 'Smutna gra', 30, ''),
(3, 19, 3, '2026-02-01 23:00:00', 'Wieczór w niedzielę', 60, ''),
(4, 28, 1, '2026-02-03 23:00:00', '7 cudów z działem', 50, ''),
(6, 69, 1, '2026-01-13 23:00:00', 'Kocham Catan\'a', 33, ''),
(7, 69, 1, '2026-01-29 23:00:00', 'Kocham Catan\'a v2', 20, ''),
(8, 30, 4, '2026-02-04 18:30:00', 'Szybki Azul', 45, 'Bardzo wyrównana partia'),
(9, 54, 2, '2026-02-05 20:00:00', 'Marsjańska Ekspedycja', 120, ''),
(10, 1, 1, '2026-02-06 19:15:00', 'Klasyk na start', 40, 'Pierwsza gra dla nowych graczy'),
(11, 28, 1, '2026-02-07 15:00:00', 'Turniej 7 Cudów', 35, ''),
(12, 101, 3, '2026-02-08 12:00:00', 'Niedzielne granie', 90, ''),
(13, 15, 5, '2026-02-09 16:00:00', 'Popołudnie z Everdell', 75, 'User5 wygrał o włos'),
(14, 69, 2, '2026-02-10 21:00:00', 'Nocny Catan', 50, 'Dużo handlu, mało walki'),
(15, 28, 4, '2026-02-11 18:00:00', 'Szybka partia', 45, ''),
(16, 1, 5, '2026-02-12 14:00:00', 'Wsiąść do Pociągu: Europa', 60, ''),
(17, 30, 1, '2026-02-13 20:30:00', 'Azul', 55, ''),
-- NOWE PARTIE (Dużo wyników):
(18, 54, 1, '2026-02-14 10:00:00', 'Walentynkowa Terraformacja', 140, 'Pełny skład'),
(19, 1, 3, '2026-02-15 11:00:00', 'Poranne pociągi', 55, ''),
(20, 28, 2, '2026-02-16 19:00:00', '7 Cudów Świata', 30, ''),
(21, 69, 5, '2026-02-17 18:00:00', 'Osadnicy', 45, 'Bez handlu'),
(22, 101, 4, '2026-02-18 20:00:00', 'Wieczór strategii', 100, ''),
(23, 30, 2, '2026-02-19 17:30:00', 'Układanie kafelków', 40, ''),
(24, 15, 1, '2026-02-20 22:00:00', 'Everdell nocą', 80, ''),
(25, 28, 3, '2026-02-21 15:00:00', 'Szybki rewanż', 25, '');

-- --------------------------------------------------------
-- 6. Uczestnicy i Wyniki
-- --------------------------------------------------------
INSERT INTO `uczestnicy_rozgrywki` (`id_uczestnictwa`, `id_rozgrywki`, `id_uzytkownika`, `nazwa_tymczasowa_gracza`, `wynik_koncowy`, `id_arkusza_uzytego`, `dane_arkusza`) VALUES
(4, 2, 3, 'Wielki Przegrany', 0, 16, NULL),
(5, 2, 2, 'Wielki Wygrany', 0, 16, NULL),
(6, 3, 3, 'Michał', 0, NULL, NULL),
(7, 3, 1, 'Marcin', 0, NULL, NULL),
(8, 3, 2, 'Bartosz', 0, NULL, NULL),
(9, 4, 1, 'Latarnia Morska', 45, NULL, NULL),
(10, 4, 2, 'Piramidy', 63, NULL, NULL),
(11, 4, 3, 'Kolos z Rodos', 67, NULL, NULL),
(12, 4, 4, 'Posąg Zeusa', 55, NULL, NULL),
(15, 6, 1, 'Kocham cegły', 0, NULL, NULL),
(16, 6, 2, 'Wielka Owca', 0, NULL, NULL),
(17, 6, 3, 'Baron Kamienia', 0, NULL, NULL),
(18, 6, 4, 'Pszenicznik', 0, NULL, NULL),
(19, 7, 1, 'Michał', 9, 70, '{\"settlements\":2,\"cities\":4,\"cards\":1,\"longest_road\":2,\"largest_army\":0}'),
(20, 7, 2, 'Bartosz', 10, 70, '{\"settlements\":2,\"cities\":6,\"cards\":0,\"longest_road\":0,\"largest_army\":2}'),
(21, 7, 3, 'Baron Kamienia', 6, 70, '{\"settlements\":3,\"cities\":1,\"cards\":2,\"longest_road\":0,\"largest_army\":0}'),
-- (8) Azul
(22, 8, 4, 'User4', 85, NULL, NULL),
(23, 8, 1, 'User1', 72, NULL, NULL),
(24, 8, 2, 'User2', 78, NULL, NULL),
-- (9) Terraformacja
(25, 9, 2, 'Korporacja A', 95, NULL, NULL),
(26, 9, 3, 'Korporacja B', 102, NULL, NULL),
(27, 9, NULL, 'Gość: Tomek', 88, NULL, NULL),
-- (10) Wsiąść do Pociągu
(28, 10, 1, 'Mistrz', 150, NULL, NULL),
(29, 10, NULL, 'Kuzyn Mariusz', 110, NULL, NULL),
(30, 10, NULL, 'Ciocia Basia', 135, NULL, NULL),
-- (11) 7 Cudów
(31, 11, 1, 'User1', 58, NULL, NULL),
(32, 11, 2, 'User2', 62, NULL, NULL),
(33, 11, 3, 'User3', 55, NULL, NULL),
(34, 11, 4, 'User4', 49, NULL, NULL),
(35, 11, 5, 'User5', 65, NULL, NULL),
-- (12) Gra ID 101
(36, 12, 3, 'Gospodarz', 12, NULL, NULL),
(37, 12, 5, 'Gość', 15, NULL, NULL),
-- (13) Everdell
(38, 13, 5, 'User5', 60, NULL, NULL),
(39, 13, 2, 'User2', 55, NULL, NULL),
(40, 13, 1, 'User1', 48, NULL, NULL),
-- (14) Catan
(41, 14, 2, 'User2', 10, NULL, NULL),
(42, 14, 3, 'User3', 8, NULL, NULL),
(43, 14, 4, 'User4', 7, NULL, NULL),
(44, 14, NULL, 'Sąsiad', 5, NULL, NULL),
-- (15) 7 Cudów
(45, 15, 4, 'User4', 52, NULL, NULL),
(46, 15, 1, 'User1', 50, NULL, NULL),
(47, 15, 5, 'User5', 51, NULL, NULL),
-- (16) Wsiąść do Pociągu
(48, 16, 5, 'Konduktor', 110, NULL, NULL),
(49, 16, NULL, 'Mama', 95, NULL, NULL),
(50, 16, NULL, 'Tata', 80, NULL, NULL),
-- (17) Azul
(51, 17, 1, 'User1', 66, NULL, NULL),
(52, 17, 2, 'User2', 70, NULL, NULL),
-- (18) Terraformacja Marsa (4 graczy)
(53, 18, 1, 'User1', 88, NULL, NULL),
(54, 18, 2, 'User2', 92, NULL, NULL),
(55, 18, 3, 'User3', 75, NULL, NULL),
(56, 18, 4, 'User4', 105, NULL, NULL),
-- (19) Wsiąść do Pociągu (3 graczy)
(57, 19, 3, 'User3', 120, NULL, NULL),
(58, 19, 5, 'User5', 115, NULL, NULL),
(59, 19, 1, 'User1', 98, NULL, NULL),
-- (20) 7 Cudów (5 graczy)
(60, 20, 2, 'User2', 55, NULL, NULL),
(61, 20, 1, 'User1', 60, NULL, NULL),
(62, 20, 3, 'User3', 48, NULL, NULL),
(63, 20, 4, 'User4', 62, NULL, NULL),
(64, 20, 5, 'User5', 59, NULL, NULL),
-- (21) Catan (3 graczy)
(65, 21, 5, 'User5', 10, NULL, NULL),
(66, 21, 1, 'User1', 8, NULL, NULL),
(67, 21, 2, 'User2', 9, NULL, NULL),
-- (22) Gra ID 101 (2 graczy)
(68, 22, 4, 'User4', 150, NULL, NULL),
(69, 22, 3, 'User3', 145, NULL, NULL),
-- (23) Azul (2 graczy)
(70, 23, 2, 'User2', 85, NULL, NULL),
(71, 23, 5, 'User5', 82, NULL, NULL),
-- (24) Everdell (4 graczy)
(72, 24, 1, 'User1', 55, NULL, NULL),
(73, 24, 2, 'User2', 62, NULL, NULL),
(74, 24, 3, 'User3', 45, NULL, NULL),
(75, 24, 4, 'User4', 58, NULL, NULL),
-- (25) 7 Cudów (3 graczy)
(76, 25, 3, 'User3', 53, NULL, NULL),
(77, 25, 1, 'User1', 50, NULL, NULL),
(78, 25, 5, 'User5', 55, NULL, NULL);

-- --------------------------------------------------------
-- 6. Uczestnicy i Wyniki (Zaktualizowane o JSON i ID Arkusza)
-- --------------------------------------------------------

-- Czyszczenie tabeli przed importem (opcjonalne, jeśli importujesz na czysto)
DELETE FROM `uczestnicy_rozgrywki`;
ALTER TABLE `uczestnicy_rozgrywki` AUTO_INCREMENT = 1;

INSERT INTO `uczestnicy_rozgrywki` (`id_uczestnictwa`, `id_rozgrywki`, `id_uzytkownika`, `nazwa_tymczasowa_gracza`, `wynik_koncowy`, `id_arkusza_uzytego`, `dane_arkusza`) VALUES
-- Rozgrywka 2: 7 Wonders Duel (ID Gry: 15, Arkusz: 15)
(4, 2, 3, 'Wielki Przegrany', 52, 15, '{"blue":15, "green":10, "yellow":5, "guilds":10, "wonders":10, "progress":0, "money":2, "military":0}'),
(5, 2, 2, 'Wielki Wygrany', 65, 15, '{"blue":20, "green":15, "yellow":10, "guilds":10, "wonders":5, "progress":0, "money":0, "military":5}'),

-- Rozgrywka 3: Everdell (ID Gry: 19, Arkusz: 19)
(6, 3, 3, 'Michał', 48, 19, '{"cards_base":20, "cards_bonus":10, "journey":10, "events":8}'),
(7, 3, 1, 'Marcin', 55, 19, '{"cards_base":30, "cards_bonus":15, "journey":5, "events":5}'),
(8, 3, 2, 'Bartosz', 42, 19, '{"cards_base":20, "cards_bonus":10, "journey":12, "events":0}'),

-- Rozgrywka 4: 7 Wonders (ID Gry: 28, Arkusz: 28)
(9, 4, 1, 'Latarnia Morska', 45, 28, '{"military":5, "treasury":2, "wonder":10, "civilian":10, "scientific":10, "commercial":5, "guilds":3}'),
(10, 4, 2, 'Piramidy', 63, 28, '{"military":15, "treasury":5, "wonder":10, "civilian":18, "scientific":10, "commercial":0, "guilds":5}'),
(11, 4, 3, 'Kolos z Rodos', 67, 28, '{"military":8, "treasury":4, "wonder":15, "civilian":15, "scientific":15, "commercial":5, "guilds":5}'),
(12, 4, 4, 'Posąg Zeusa', 55, 28, '{"military":-2, "treasury":6, "wonder":10, "civilian":20, "scientific":16, "commercial":5, "guilds":0}'),

-- Rozgrywka 6: Catan (ID Gry: 69, Arkusz: 69)
(15, 6, 1, 'Kocham cegły', 10, 69, '{"settlements":4, "cities":4, "cards":0, "longest_road":2, "largest_army":0}'),
(16, 6, 2, 'Wielka Owca', 8, 69, '{"settlements":4, "cities":4, "cards":0, "longest_road":0, "largest_army":0}'),
(17, 6, 3, 'Baron Kamienia', 6, 69, '{"settlements":4, "cities":2, "cards":0, "longest_road":0, "largest_army":0}'),
(18, 6, 4, 'Pszenicznik', 5, 69, '{"settlements":3, "cities":2, "cards":0, "longest_road":0, "largest_army":0}'),

-- Rozgrywka 7: Catan (ID Gry: 69, Arkusz: 69) - Zachowano oryginalne JSONY, ale poprawiono format
(19, 7, 1, 'Michał', 9, 69, '{"settlements":2, "cities":4, "cards":1, "longest_road":2, "largest_army":0}'),
(20, 7, 2, 'Bartosz', 10, 69, '{"settlements":2, "cities":6, "cards":0, "longest_road":0, "largest_army":2}'),
(21, 7, 3, 'Baron Kamienia', 6, 69, '{"settlements":3, "cities":1, "cards":2, "longest_road":0, "largest_army":0}'),

-- Rozgrywka 8: Patchwork (ID Gry: 30, Arkusz: 30)
-- Uwaga: W tytule było "Szybki Azul", ale ID gry 30 wskazuje na Patchwork. Wyniki 85 są za wysokie na Patchwork, ale zachowuję spójność matematyczną.
(22, 8, 4, 'User4', 85, 30, '{"buttons":85, "empty":0, "special":0}'),
(23, 8, 1, 'User1', 72, 30, '{"buttons":72, "empty":0, "special":0}'),
(24, 8, 2, 'User2', 78, 30, '{"buttons":71, "empty":0, "special":7}'),

-- Rozgrywka 9: Barrage (ID Gry: 54, Arkusz: 54)
(25, 9, 2, 'Korporacja A', 95, 54, '{"vp_track":60, "objective":20, "resources":15}'),
(26, 9, 3, 'Korporacja B', 102, 54, '{"vp_track":70, "objective":20, "resources":12}'),
(27, 9, NULL, 'Gość: Tomek', 88, 54, '{"vp_track":55, "objective":15, "resources":18}'),

-- Rozgrywka 10: Brass: Birmingham (ID Gry: 1, Arkusz: 1)
(28, 10, 1, 'Mistrz', 150, 1, '{"tiles":70, "links":60, "money":20}'),
(29, 10, NULL, 'Kuzyn Mariusz', 110, 1, '{"tiles":50, "links":45, "money":15}'),
(30, 10, NULL, 'Ciocia Basia', 135, 1, '{"tiles":65, "links":55, "money":15}'),

-- Rozgrywka 11: 7 Wonders (ID Gry: 28, Arkusz: 28)
(31, 11, 1, 'User1', 58, 28, '{"military":10, "treasury":3, "wonder":10, "civilian":20, "scientific":10, "commercial":5, "guilds":0}'),
(32, 11, 2, 'User2', 62, 28, '{"military":-3, "treasury":5, "wonder":15, "civilian":25, "scientific":15, "commercial":5, "guilds":0}'),
(33, 11, 3, 'User3', 55, 28, '{"military":5, "treasury":5, "wonder":10, "civilian":10, "scientific":20, "commercial":5, "guilds":0}'),
(34, 11, 4, 'User4', 49, 28, '{"military":0, "treasury":2, "wonder":10, "civilian":15, "scientific":15, "commercial":7, "guilds":0}'),
(35, 11, 5, 'User5', 65, 28, '{"military":18, "treasury":2, "wonder":15, "civilian":15, "scientific":0, "commercial":5, "guilds":10}'),

-- Rozgrywka 12: Air, Land & Sea (ID Gry: 101, Arkusz: 101)
(36, 12, 3, 'Gospodarz', 12, 101, '{"score":12}'),
(37, 12, 5, 'Gość', 15, 101, '{"score":15}'),

-- Rozgrywka 13: 7 Wonders Duel (ID Gry: 15, Arkusz: 15)
-- Uwaga: Tytuł w oryginale "Everdell", ale ID 15 to Duel.
(38, 13, 5, 'User5', 60, 15, '{"blue":20, "green":15, "yellow":5, "guilds":10, "wonders":10, "progress":0, "money":0, "military":0}'),
(39, 13, 2, 'User2', 55, 15, '{"blue":15, "green":10, "yellow":10, "guilds":5, "wonders":10, "progress":0, "money":0, "military":5}'),
(40, 13, 1, 'User1', 48, 15, '{"blue":10, "green":18, "yellow":5, "guilds":5, "wonders":10, "progress":0, "money":0, "military":0}'),

-- Rozgrywka 14: Catan (ID Gry: 69, Arkusz: 69)
(41, 14, 2, 'User2', 10, 69, '{"settlements":4, "cities":4, "cards":0, "longest_road":2, "largest_army":0}'),
(42, 14, 3, 'User3', 8, 69, '{"settlements":4, "cities":4, "cards":0, "longest_road":0, "largest_army":0}'),
(43, 14, 4, 'User4', 7, 69, '{"settlements":3, "cities":4, "cards":0, "longest_road":0, "largest_army":0}'),
(44, 14, NULL, 'Sąsiad', 5, 69, '{"settlements":3, "cities":2, "cards":0, "longest_road":0, "largest_army":0}'),

-- Rozgrywka 15: 7 Wonders Duel (ID Gry: 28, Arkusz: 28)
-- W oryginale ID gry to 28 (7 Wonders), nie Duel (15). Stosuję schemat 7 Wonders.
(45, 15, 4, 'User4', 52, 28, '{"military":5, "treasury":2, "wonder":10, "civilian":15, "scientific":10, "commercial":5, "guilds":5}'),
(46, 15, 1, 'User1', 50, 28, '{"military":0, "treasury":5, "wonder":10, "civilian":20, "scientific":10, "commercial":5, "guilds":0}'),
(47, 15, 5, 'User5', 51, 28, '{"military":-2, "treasury":3, "wonder":15, "civilian":15, "scientific":15, "commercial":5, "guilds":0}'),

-- Rozgrywka 16: Brass (ID Gry: 1, Arkusz: 1)
(48, 16, 5, 'Konduktor', 110, 1, '{"tiles":50, "links":40, "money":20}'),
(49, 16, NULL, 'Mama', 95, 1, '{"tiles":45, "links":35, "money":15}'),
(50, 16, NULL, 'Tata', 80, 1, '{"tiles":40, "links":30, "money":10}'),

-- Rozgrywka 17: Patchwork (ID Gry: 30, Arkusz: 30)
(51, 17, 1, 'User1', 66, 30, '{"buttons":59, "empty":0, "special":7}'),
(52, 17, 2, 'User2', 70, 30, '{"buttons":70, "empty":0, "special":0}'),

-- Rozgrywka 18: Barrage (ID Gry: 54, Arkusz: 54)
(53, 18, 1, 'User1', 88, 54, '{"vp_track":50, "objective":20, "resources":18}'),
(54, 18, 2, 'User2', 92, 54, '{"vp_track":60, "objective":15, "resources":17}'),
(55, 18, 3, 'User3', 75, 54, '{"vp_track":45, "objective":15, "resources":15}'),
(56, 18, 4, 'User4', 105, 54, '{"vp_track":70, "objective":20, "resources":15}'),

-- Rozgrywka 19: Brass (ID Gry: 1, Arkusz: 1)
(57, 19, 3, 'User3', 120, 1, '{"tiles":60, "links":45, "money":15}'),
(58, 19, 5, 'User5', 115, 1, '{"tiles":55, "links":50, "money":10}'),
(59, 19, 1, 'User1', 98, 1, '{"tiles":50, "links":38, "money":10}'),

-- Rozgrywka 20: 7 Wonders (ID Gry: 28, Arkusz: 28)
(60, 20, 2, 'User2', 55, 28, '{"military":5, "treasury":5, "wonder":10, "civilian":15, "scientific":15, "commercial":5, "guilds":0}'),
(61, 20, 1, 'User1', 60, 28, '{"military":10, "treasury":5, "wonder":15, "civilian":15, "scientific":10, "commercial":5, "guilds":0}'),
(62, 20, 3, 'User3', 48, 28, '{"military":-2, "treasury":5, "wonder":10, "civilian":20, "scientific":10, "commercial":5, "guilds":0}'),
(63, 20, 4, 'User4', 62, 28, '{"military":15, "treasury":2, "wonder":15, "civilian":10, "scientific":15, "commercial":5, "guilds":0}'),
(64, 20, 5, 'User5', 59, 28, '{"military":10, "treasury":4, "wonder":10, "civilian":15, "scientific":10, "commercial":5, "guilds":5}'),

-- Rozgrywka 21: Catan (ID Gry: 69, Arkusz: 69)
(65, 21, 5, 'User5', 10, 69, '{"settlements":4, "cities":4, "cards":0, "longest_road":2, "largest_army":0}'),
(66, 21, 1, 'User1', 8, 69, '{"settlements":4, "cities":4, "cards":0, "longest_road":0, "largest_army":0}'),
(67, 21, 2, 'User2', 9, 69, '{"settlements":3, "cities":4, "cards":0, "longest_road":0, "largest_army":2}'),

-- Rozgrywka 22: Air, Land & Sea (ID Gry: 101, Arkusz: 101)
(68, 22, 4, 'User4', 150, 101, '{"score":150}'),
(69, 22, 3, 'User3', 145, 101, '{"score":145}'),

-- Rozgrywka 23: Patchwork (ID Gry: 30, Arkusz: 30)
(70, 23, 2, 'User2', 85, 30, '{"buttons":78, "empty":0, "special":7}'),
(71, 23, 5, 'User5', 82, 30, '{"buttons":82, "empty":0, "special":0}'),

-- Rozgrywka 24: 7 Wonders Duel (ID Gry: 15, Arkusz: 15)
(72, 24, 1, 'User1', 55, 15, '{"blue":15, "green":10, "yellow":10, "guilds":5, "wonders":10, "progress":0, "money":0, "military":5}'),
(73, 24, 2, 'User2', 62, 15, '{"blue":20, "green":15, "yellow":10, "guilds":5, "wonders":12, "progress":0, "money":0, "military":0}'),
(74, 24, 3, 'User3', 45, 15, '{"blue":10, "green":10, "yellow":5, "guilds":5, "wonders":10, "progress":0, "money":5, "military":0}'),
(75, 24, 4, 'User4', 58, 15, '{"blue":18, "green":12, "yellow":5, "guilds":8, "wonders":10, "progress":0, "money":0, "military":5}'),

-- Rozgrywka 25: 7 Wonders (ID Gry: 28, Arkusz: 28)
(76, 25, 3, 'User3', 53, 28, '{"military":5, "treasury":3, "wonder":10, "civilian":15, "scientific":10, "commercial":5, "guilds":5}'),
(77, 25, 1, 'User1', 50, 28, '{"military":0, "treasury":5, "wonder":10, "civilian":20, "scientific":10, "commercial":5, "guilds":0}'),
(78, 25, 5, 'User5', 55, 28, '{"military":10, "treasury":2, "wonder":15, "civilian":13, "scientific":10, "commercial":5, "guilds":0}');SET FOREIGN_KEY_CHECKS = 1;

COMMIT;