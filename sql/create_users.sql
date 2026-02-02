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
-- 2. Kolekcja (Zaktualizowane ID zgodnie z nową tabelą planszowka)
-- --------------------------------------------------------
INSERT INTO `planszowka_w_kolekcji` (`id_planszowki_w_kolekcji`, `id_uzytkownika`, `id_planszowki`, `ocena`, `komentarz`, `id_statusu`, `data_dodania`) VALUES
(1, 1, 28, 5, '', 1, '2026-02-02 00:46:27'),  -- 7 Wonders
(2, 1, 101, NULL, 'Fajna', 1, '2026-02-02 00:46:41'), -- Air, Land & Sea
(3, 1, 25, 8, 'Brakuje paru znaczników', 1, '2026-02-02 00:47:22'), -- Ticket to Ride (USA)
(4, 1, 7, 4, 'meh', 3, '2026-02-02 00:47:44'),   -- Terraformacja Marsa
(5, 1, 69, 10, 'Peak!', 1, '2026-02-02 00:48:05'), -- Catan
(6, 2, 29, NULL, '', 1, '2026-02-02 00:49:43'),   -- Azul
(7, 2, 37, NULL, '', 1, '2026-02-02 00:49:52'),   -- Decrypto
(8, 2, 124, NULL, '', 1, '2026-02-02 00:49:58'),  -- 6. nimmt!
(9, 2, 132, NULL, '', 2, '2026-02-02 00:50:02'),  -- UNO
(10, 3, 19, NULL, '', 1, '2026-02-02 00:51:57'),  -- Everdell
(11, 3, 25, NULL, '', 1, '2026-02-02 00:52:06'),  -- Ticket to Ride (USA)
(12, 3, 113, NULL, '', 2, '2026-02-02 00:52:15'), -- Monopoly
(13, 3, 96, NULL, '', 2, '2026-02-02 00:52:21'),  -- Dixit
(14, 3, 29, NULL, '', 2, '2026-02-02 00:52:26'),  -- Azul
(15, 4, 21, NULL, '', 2, '2026-02-02 01:04:59'),  -- A Feast for Odin
(16, 4, 84, NULL, '', 2, '2026-02-02 01:05:04'),  -- Battlestar Galactica
(17, 4, 32, NULL, '', 4, '2026-02-02 01:05:11'),  -- Carcassonne
(18, 4, 93, NULL, '', 1, '2026-02-02 01:05:18'),  -- Biblios
(20, 4, 29, NULL, '', 1, '2026-02-02 01:05:27');  -- Azul

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
-- 5. Rozgrywki (ID z nowej tabeli planszowka)
-- --------------------------------------------------------
INSERT INTO `rozgrywka` (`id_rozgrywki`, `id_planszowki`, `id_organizatora`, `data_rozgrywki`, `tytul_rozgrywki`, `czas_trwania`, `notatka_do_gry`) VALUES
(2, 19, 3, '2026-02-01 23:00:00', 'Smutna gra', 30, ''), -- Everdell
(3, 25, 3, '2026-02-01 23:00:00', 'Wieczór w niedzielę', 60, ''), -- Ticket to Ride
(4, 28, 1, '2026-02-03 23:00:00', '7 cudów z działem', 50, ''), -- 7 Wonders
(6, 69, 1, '2026-01-13 23:00:00', 'Kocham Catan\'a', 33, ''), -- Catan
(7, 69, 1, '2026-01-29 23:00:00', 'Kocham Catan\'a v2', 20, ''), -- Catan
(8, 29, 4, '2026-02-04 18:30:00', 'Szybki Azul', 45, 'Bardzo wyrównana partia'), -- Azul
(9, 7, 2, '2026-02-05 20:00:00', 'Marsjańska Ekspedycja', 120, ''), -- Terraformacja Marsa
(10, 25, 1, '2026-02-06 19:15:00', 'Klasyk na start', 40, 'Pierwsza gra dla nowych graczy'), -- Ticket to Ride
(11, 28, 1, '2026-02-07 15:00:00', 'Turniej 7 Cudów', 35, ''), -- 7 Wonders
(12, 101, 3, '2026-02-08 12:00:00', 'Niedzielne granie', 90, ''), -- Air, Land & Sea
(13, 19, 5, '2026-02-09 16:00:00', 'Popołudnie z Everdell', 75, 'User5 wygrał o włos'), -- Everdell
(14, 69, 2, '2026-02-10 21:00:00', 'Nocny Catan', 50, 'Dużo handlu, mało walki'), -- Catan
(15, 28, 4, '2026-02-11 18:00:00', 'Szybka partia', 45, ''), -- 7 Wonders
(16, 129, 5, '2026-02-12 14:00:00', 'Wsiąść do Pociągu: Europa', 60, ''), -- Ticket to Ride: Europe
(17, 29, 1, '2026-02-13 20:30:00', 'Azul', 55, ''), -- Azul
(18, 7, 1, '2026-02-14 10:00:00', 'Walentynkowa Terraformacja', 140, 'Pełny skład'), -- Terraformacja Marsa
(19, 25, 3, '2026-02-15 11:00:00', 'Poranne pociągi', 55, ''), -- Ticket to Ride
(20, 28, 2, '2026-02-16 19:00:00', '7 Cudów Świata', 30, ''), -- 7 Wonders
(21, 69, 5, '2026-02-17 18:00:00', 'Osadnicy', 45, 'Bez handlu'), -- Catan
(22, 101, 4, '2026-02-18 20:00:00', 'Wieczór strategii', 100, ''), -- Air, Land & Sea
(23, 29, 2, '2026-02-19 17:30:00', 'Układanie kafelków', 40, ''), -- Azul
(24, 19, 1, '2026-02-20 22:00:00', 'Everdell nocą', 80, ''), -- Everdell
(25, 28, 3, '2026-02-21 15:00:00', 'Szybki rewanż', 25, ''); -- 7 Wonders

-- --------------------------------------------------------
-- 6. Uczestnicy i Wyniki (Arkusz = ID Planszowki + 1)
-- --------------------------------------------------------
DELETE FROM `uczestnicy_rozgrywki`;
ALTER TABLE `uczestnicy_rozgrywki` AUTO_INCREMENT = 1;

INSERT INTO `uczestnicy_rozgrywki` (`id_uczestnictwa`, `id_rozgrywki`, `id_uzytkownika`, `nazwa_tymczasowa_gracza`, `wynik_koncowy`, `id_arkusza_uzytego`, `dane_arkusza`) VALUES
-- Gra ID 2 (Everdell ID 19): Arkusz 20
(4, 2, 3, 'Wielki Przegrany', 42, 20, '{"blue": 0, "green": 7, "yellow": 0, "guilds": 0, "wonders": 5, "progress": 12, "money": 2, "military": 16}'),
(5, 2, 2, 'Wielki Wygrany', 42, 20, '{"blue": 18, "green": 6, "yellow": 0, "guilds": 9, "wonders": 0, "progress": 0, "money": 3, "military": 6}'),

-- Gra ID 3 (TtR ID 25): Arkusz 26
(6, 3, 3, 'Michał', 67, 26, '{"cards_base": 7, "cards_bonus": 4, "journey": 9, "events": 47}'),
(7, 3, 1, 'Marcin', 42, 26, '{"cards_base": 5, "cards_bonus": 5, "journey": 1, "events": 31}'),
(8, 3, 2, 'Bartosz', 71, 26, '{"cards_base": 7, "cards_bonus": 35, "journey": 12, "events": 17}'),

-- Gra ID 4 (7 Wonders ID 28): Arkusz 29
(9, 4, 1, 'Latarnia Morska', 45, 29, '{"military": 23, "treasury": 13, "wonder": 1, "civilian": 3, "scientific": 1, "commercial": 0, "guilds": 4}'),
(10, 4, 2, 'Piramidy', 63, 29, '{"military": 5, "treasury": 16, "wonder": 6, "civilian": 13, "scientific": 5, "commercial": 7, "guilds": 11}'),
(11, 4, 3, 'Kolos z Rodos', 67, 29, '{"military": 18, "treasury": 3, "wonder": 3, "civilian": 13, "scientific": 4, "commercial": 10, "guilds": 16}'),
(12, 4, 4, 'Posąg Zeusa', 55, 29, '{"military": 13, "treasury": 21, "wonder": 9, "civilian": 5, "scientific": 1, "commercial": 0, "guilds": 6}'),

-- Gra ID 6 (Catan ID 69): Arkusz 70
(15, 6, 1, 'Kocham cegły', 7, 70, '{"settlements": 1, "cities": 3, "cards": 0, "longest_road": 0, "largest_army": 0}'),
(16, 6, 2, 'Wielka Owca', 3, 70, '{"settlements": 1, "cities": 0, "cards": 0, "longest_road": 2, "largest_army": 0}'),
(17, 6, 3, 'Baron Kamienia', 9, 70, '{"settlements": 1, "cities": 4, "cards": 0, "longest_road": 0, "largest_army": 0}'),
(18, 6, 4, 'Pszenicznik', 10, 70, '{"settlements": 0, "cities": 4, "cards": 0, "longest_road": 2, "largest_army": 0}'),

-- Gra ID 7 (Catan ID 69): Arkusz 70
(19, 7, 1, 'Michał', 9, 70, '{"settlements": 1, "cities": 4, "cards": 0, "longest_road": 0, "largest_army": 0}'),
(20, 7, 2, 'Bartosz', 10, 70, '{"settlements": 0, "cities": 5, "cards": 0, "longest_road": 0, "largest_army": 0}'),
(21, 7, 3, 'Baron Kamienia', 6, 70, '{"settlements": 0, "cities": 3, "cards": 0, "longest_road": 0, "largest_army": 0}'),

-- Gra ID 8 (Azul ID 29): Arkusz 30
(22, 8, 4, 'User4', 85, 30, '{"buttons": 85, "empty": 0, "special": 0}'),
(23, 8, 1, 'User1', 72, 30, '{"buttons": 72, "empty": 0, "special": 0}'),
(24, 8, 2, 'User2', 78, 30, '{"buttons": 78, "empty": 0, "special": 0}'),

-- Gra ID 9 (Terraformacja ID 7): Arkusz 8
(25, 9, 2, 'Korporacja A', 95, 8, '{"vp_track": 49, "objective": 22, "resources": 24}'),
(26, 9, 3, 'Korporacja B', 102, 8, '{"vp_track": 4, "objective": 51, "resources": 47}'),
(27, 9, NULL, 'Gość: Tomek', 88, 8, '{"vp_track": 32, "objective": 11, "resources": 45}'),

-- Gra ID 10 (TtR ID 25): Arkusz 26
(28, 10, 1, 'Mistrz', 150, 26, '{"tiles": 62, "links": 4, "money": 84}'),
(29, 10, NULL, 'Kuzyn Mariusz', 110, 26, '{"tiles": 22, "links": 20, "money": 68}'),
(30, 10, NULL, 'Ciocia Basia', 135, 26, '{"tiles": 79, "links": 10, "money": 46}'),

-- Gra ID 11 (7 Wonders ID 28): Arkusz 29
(31, 11, 1, 'User1', 58, 29, '{"military": 30, "treasury": 3, "wonder": 11, "civilian": 8, "scientific": 3, "commercial": 1, "guilds": 2}'),
(32, 11, 2, 'User2', 62, 29, '{"military": 27, "treasury": 16, "wonder": 5, "civilian": 8, "scientific": 3, "commercial": 1, "guilds": 2}'),
(33, 11, 3, 'User3', 55, 29, '{"military": 18, "treasury": 5, "wonder": 16, "civilian": 4, "scientific": 6, "commercial": 0, "guilds": 6}'),
(34, 11, 4, 'User4', 49, 29, '{"military": 28, "treasury": 0, "wonder": 8, "civilian": 2, "scientific": 0, "commercial": 0, "guilds": 11}'),
(35, 11, 5, 'User5', 65, 29, '{"military": 25, "treasury": 5, "wonder": 17, "civilian": 3, "scientific": 9, "commercial": 0, "guilds": 6}'),

-- Gra ID 12 (ALS ID 101): Arkusz 102
(36, 12, 3, 'Gospodarz', 12, 102, '{"score": 12}'),
(37, 12, 5, 'Gość', 15, 102, '{"score": 15}'),

-- Gra ID 13 (Everdell ID 19): Arkusz 20
(38, 13, 5, 'User5', 60, 20, '{"blue": 15, "green": 23, "yellow": 12, "guilds": 4, "wonders": 2, "progress": 0, "money": 2, "military": 2}'),
(39, 13, 2, 'User2', 55, 20, '{"blue": 29, "green": 1, "yellow": 3, "guilds": 1, "wonders": 3, "progress": 6, "money": 5, "military": 7}'),
(40, 13, 1, 'User1', 48, 20, '{"blue": 21, "green": 1, "yellow": 10, "guilds": 4, "wonders": 5, "progress": 4, "money": 0, "military": 3}'),

-- Gra ID 14 (Catan ID 69): Arkusz 70
(41, 14, 2, 'User2', 10, 70, '{"settlements": 0, "cities": 5, "cards": 0, "longest_road": 0, "largest_army": 0}'),
(42, 14, 3, 'User3', 8, 70, '{"settlements": 0, "cities": 3, "cards": 0, "longest_road": 2, "largest_army": 0}'),
(43, 14, 4, 'User4', 7, 70, '{"settlements": 1, "cities": 2, "cards": 0, "longest_road": 2, "largest_army": 0}'),
(44, 14, NULL, 'Sąsiad', 5, 70, '{"settlements": 1, "cities": 2, "cards": 0, "longest_road": 0, "largest_army": 0}'),

-- Gra ID 15 (7 Wonders ID 28): Arkusz 29
(45, 15, 4, 'User4', 52, 29, '{"military": 15, "treasury": 13, "wonder": 2, "civilian": 0, "scientific": 7, "commercial": 8, "guilds": 7}'),
(46, 15, 1, 'User1', 50, 29, '{"military": 22, "treasury": 3, "wonder": 13, "civilian": 5, "scientific": 4, "commercial": 1, "guilds": 2}'),
(47, 15, 5, 'User5', 51, 29, '{"military": 25, "treasury": 11, "wonder": 9, "civilian": 2, "scientific": 0, "commercial": 0, "guilds": 4}'),

-- Gra ID 16 (TtR Europa ID 129): Arkusz 130
(48, 16, 5, 'Konduktor', 110, 130, '{"tiles": 39, "links": 14, "money": 57}'),
(49, 16, NULL, 'Mama', 95, 130, '{"tiles": 11, "links": 18, "money": 66}'),
(50, 16, NULL, 'Tata', 80, 130, '{"tiles": 3, "links": 34, "money": 43}'),

-- Gra ID 17 (Azul ID 29): Arkusz 30
(51, 17, 1, 'User1', 66, 30, '{"buttons": 66, "empty": 0, "special": 0}'),
(52, 17, 2, 'User2', 70, 30, '{"buttons": 70, "empty": 0, "special": 0}'),

-- Gra ID 18 (Terraformacja ID 7): Arkusz 8
(53, 18, 1, 'User1', 88, 8, '{"vp_track": 39, "objective": 3, "resources": 46}'),
(54, 18, 2, 'User2', 92, 8, '{"vp_track": 19, "objective": 16, "resources": 57}'),
(55, 18, 3, 'User3', 75, 8, '{"vp_track": 3, "objective": 10, "resources": 62}'),
(56, 18, 4, 'User4', 105, 8, '{"vp_track": 20, "objective": 43, "resources": 42}'),

-- Gra ID 19 (TtR ID 25): Arkusz 26
(57, 19, 3, 'User3', 120, 26, '{"tiles": 1, "links": 50, "money": 69}'),
(58, 19, 5, 'User5', 115, 26, '{"tiles": 58, "links": 22, "money": 35}'),
(59, 19, 1, 'User1', 98, 26, '{"tiles": 35, "links": 2, "money": 61}'),

-- Gra ID 20 (7 Wonders ID 28): Arkusz 29
(60, 20, 2, 'User2', 55, 29, '{"military": 13, "treasury": 23, "wonder": 1, "civilian": 7, "scientific": 2, "commercial": 2, "guilds": 7}'),
(61, 20, 1, 'User1', 60, 29, '{"military": 5, "treasury": 1, "wonder": 17, "civilian": 0, "scientific": 0, "commercial": 17, "guilds": 20}'),
(62, 20, 3, 'User3', 48, 29, '{"military": 8, "treasury": 10, "wonder": 14, "civilian": 4, "scientific": 2, "commercial": 6, "guilds": 4}'),
(63, 20, 4, 'User4', 62, 29, '{"military": 10, "treasury": 28, "wonder": 6, "civilian": 4, "scientific": 4, "commercial": 6, "guilds": 4}'),
(64, 20, 5, 'User5', 59, 29, '{"military": 1, "treasury": 25, "wonder": 8, "civilian": 0, "scientific": 12, "commercial": 6, "guilds": 7}'),

-- Gra ID 21 (Catan ID 69): Arkusz 70
(65, 21, 5, 'User5', 10, 70, '{"settlements": 0, "cities": 5, "cards": 0, "longest_road": 0, "largest_army": 0}'),
(66, 21, 1, 'User1', 8, 70, '{"settlements": 0, "cities": 4, "cards": 0, "longest_road": 0, "largest_army": 0}'),
(67, 21, 2, 'User2', 9, 70, '{"settlements": 1, "cities": 3, "cards": 0, "longest_road": 2, "largest_army": 0}'),

-- Gra ID 22 (ALS ID 101): Arkusz 102
(68, 22, 4, 'User4', 150, 102, '{"score": 150}'),
(69, 22, 3, 'User3', 145, 102, '{"score": 145}'),

-- Gra ID 23 (Azul ID 29): Arkusz 30
(70, 23, 2, 'User2', 85, 30, '{"buttons": 85, "empty": 0, "special": 0}'),
(71, 23, 5, 'User5', 82, 30, '{"buttons": 82, "empty": 0, "special": 0}'),

-- Gra ID 24 (Everdell ID 19): Arkusz 20
(72, 24, 1, 'User1', 55, 20, '{"blue": 18, "green": 13, "yellow": 13, "guilds": 3, "wonders": 3, "progress": 1, "money": 1, "military": 3}'),
(73, 24, 2, 'User2', 62, 20, '{"blue": 5, "green": 0, "yellow": 30, "guilds": 12, "wonders": 8, "progress": 2, "money": 3, "military": 2}'),
(74, 24, 3, 'User3', 45, 20, '{"blue": 25, "green": 1, "yellow": 7, "guilds": 7, "wonders": 0, "progress": 0, "money": 1, "military": 4}'),
(75, 24, 4, 'User4', 58, 20, '{"blue": 5, "green": 16, "yellow": 18, "guilds": 5, "wonders": 4, "progress": 5, "money": 1, "military": 4}'),

-- Gra ID 25 (7 Wonders ID 28): Arkusz 29
(76, 25, 3, 'User3', 53, 29, '{"military": 18, "treasury": 5, "wonder": 14, "civilian": 9, "scientific": 2, "commercial": 1, "guilds": 4}'),
(77, 25, 1, 'User1', 50, 29, '{"military": 23, "treasury": 12, "wonder": 1, "civilian": 0, "scientific": 3, "commercial": 1, "guilds": 10}'),
(78, 25, 5, 'User5', 55, 29, '{"military": 21, "treasury": 16, "wonder": 4, "civilian": 1, "scientific": 5, "commercial": 4, "guilds": 4}');
-- --------------------------------------------------------
-- 7. Komentarze (3-6 losowych na rozgrywkę)
-- --------------------------------------------------------
INSERT INTO `komentarz` (`id_rozgrywki`, `id_autora`, `zawartosc`, `data_dodania`) VALUES
-- Rozgrywka 2
(2, 1, 'Przykładowy komentarz!', '2026-02-02 09:15:00'),
(2, 4, 'Przykładowy komentarz!', '2026-02-02 09:20:00'),
(2, 5, 'Przykładowy komentarz!', '2026-02-02 10:05:00'),
(2, 2, 'Przykładowy komentarz!', '2026-02-02 11:30:00'),

-- Rozgrywka 3
(3, 3, 'Przykładowy komentarz!', '2026-02-02 12:00:00'),
(3, 1, 'Przykładowy komentarz!', '2026-02-02 12:15:00'),
(3, 2, 'Przykładowy komentarz!', '2026-02-02 13:45:00'),

-- Rozgrywka 4
(4, 5, 'Przykładowy komentarz!', '2026-02-04 10:00:00'),
(4, 2, 'Przykładowy komentarz!', '2026-02-04 10:30:00'),
(4, 3, 'Przykładowy komentarz!', '2026-02-04 11:15:00'),
(4, 4, 'Przykładowy komentarz!', '2026-02-04 12:00:00'),
(4, 1, 'Przykładowy komentarz!', '2026-02-04 14:20:00'),

-- Rozgrywka 6
(6, 2, 'Przykładowy komentarz!', '2026-01-14 10:00:00'),
(6, 4, 'Przykładowy komentarz!', '2026-01-14 11:30:00'),
(6, 3, 'Przykładowy komentarz!', '2026-01-14 15:45:00'),

-- Rozgrywka 7
(7, 1, 'Przykładowy komentarz!', '2026-01-30 09:20:00'),
(7, 5, 'Przykładowy komentarz!', '2026-01-30 10:45:00'),
(7, 2, 'Przykładowy komentarz!', '2026-01-30 12:10:00'),
(7, 3, 'Przykładowy komentarz!', '2026-01-30 14:00:00'),

-- Rozgrywka 8
(8, 4, 'Przykładowy komentarz!', '2026-02-05 08:00:00'),
(8, 2, 'Przykładowy komentarz!', '2026-02-05 08:30:00'),
(8, 1, 'Przykładowy komentarz!', '2026-02-05 09:15:00'),
(8, 5, 'Przykładowy komentarz!', '2026-02-05 10:20:00'),
(8, 3, 'Przykładowy komentarz!', '2026-02-05 11:00:00'),
(8, 4, 'Przykładowy komentarz!', '2026-02-05 12:30:00'),

-- Rozgrywka 9
(9, 3, 'Przykładowy komentarz!', '2026-02-06 09:45:00'),
(9, 5, 'Przykładowy komentarz!', '2026-02-06 10:30:00'),
(9, 1, 'Przykładowy komentarz!', '2026-02-06 11:15:00'),

-- Rozgrywka 10
(10, 2, 'Przykładowy komentarz!', '2026-02-07 08:00:00'),
(10, 4, 'Przykładowy komentarz!', '2026-02-07 09:30:00'),
(10, 5, 'Przykładowy komentarz!', '2026-02-07 10:45:00'),
(10, 1, 'Przykładowy komentarz!', '2026-02-07 13:00:00'),

-- Rozgrywka 11
(11, 3, 'Przykładowy komentarz!', '2026-02-08 16:00:00'),
(11, 4, 'Przykładowy komentarz!', '2026-02-08 17:15:00'),
(11, 2, 'Przykładowy komentarz!', '2026-02-08 18:30:00'),
(11, 5, 'Przykładowy komentarz!', '2026-02-08 19:45:00'),
(11, 1, 'Przykładowy komentarz!', '2026-02-08 20:10:00'),

-- Rozgrywka 12
(12, 5, 'Przykładowy komentarz!', '2026-02-09 14:00:00'),
(12, 1, 'Przykładowy komentarz!', '2026-02-09 15:30:00'),
(12, 3, 'Przykładowy komentarz!', '2026-02-09 16:45:00'),

-- Rozgrywka 13
(13, 2, 'Przykładowy komentarz!', '2026-02-10 18:00:00'),
(13, 4, 'Przykładowy komentarz!', '2026-02-10 18:45:00'),
(13, 1, 'Przykładowy komentarz!', '2026-02-10 19:30:00'),
(13, 5, 'Przykładowy komentarz!', '2026-02-10 20:15:00'),

-- Rozgrywka 14
(14, 3, 'Przykładowy komentarz!', '2026-02-11 22:30:00'),
(14, 1, 'Przykładowy komentarz!', '2026-02-11 23:00:00'),
(14, 2, 'Przykładowy komentarz!', '2026-02-11 23:15:00'),
(14, 4, 'Przykładowy komentarz!', '2026-02-11 23:45:00'),

-- Rozgrywka 15
(15, 5, 'Przykładowy komentarz!', '2026-02-12 19:30:00'),
(15, 3, 'Przykładowy komentarz!', '2026-02-12 20:00:00'),
(15, 2, 'Przykładowy komentarz!', '2026-02-12 21:15:00'),

-- Rozgrywka 16
(16, 4, 'Przykładowy komentarz!', '2026-02-13 16:00:00'),
(16, 1, 'Przykładowy komentarz!', '2026-02-13 17:30:00'),
(16, 5, 'Przykładowy komentarz!', '2026-02-13 18:45:00'),
(16, 3, 'Przykładowy komentarz!', '2026-02-13 19:20:00'),

-- Rozgrywka 17
(17, 2, 'Przykładowy komentarz!', '2026-02-14 21:15:00'),
(17, 1, 'Przykładowy komentarz!', '2026-02-14 21:30:00'),
(17, 4, 'Przykładowy komentarz!', '2026-02-14 22:00:00'),

-- Rozgrywka 18
(18, 3, 'Przykładowy komentarz!', '2026-02-15 12:00:00'),
(18, 5, 'Przykładowy komentarz!', '2026-02-15 13:15:00'),
(18, 2, 'Przykładowy komentarz!', '2026-02-15 14:30:00'),
(18, 1, 'Przykładowy komentarz!', '2026-02-15 16:00:00'),
(18, 4, 'Przykładowy komentarz!', '2026-02-15 17:45:00'),

-- Rozgrywka 19
(19, 1, 'Przykładowy komentarz!', '2026-02-16 13:00:00'),
(19, 3, 'Przykładowy komentarz!', '2026-02-16 14:30:00'),
(19, 5, 'Przykładowy komentarz!', '2026-02-16 15:45:00'),

-- Rozgrywka 20
(20, 2, 'Przykładowy komentarz!', '2026-02-17 20:30:00'),
(20, 4, 'Przykładowy komentarz!', '2026-02-17 21:00:00'),
(20, 3, 'Przykładowy komentarz!', '2026-02-17 21:45:00'),
(20, 5, 'Przykładowy komentarz!', '2026-02-17 22:15:00'),

-- Rozgrywka 21
(21, 1, 'Przykładowy komentarz!', '2026-02-18 19:30:00'),
(21, 5, 'Przykładowy komentarz!', '2026-02-18 20:00:00'),
(21, 2, 'Przykładowy komentarz!', '2026-02-18 20:45:00'),

-- Rozgrywka 22
(22, 4, 'Przykładowy komentarz!', '2026-02-19 21:30:00'),
(22, 3, 'Przykładowy komentarz!', '2026-02-19 22:00:00'),
(22, 1, 'Przykładowy komentarz!', '2026-02-19 22:30:00'),
(22, 2, 'Przykładowy komentarz!', '2026-02-19 23:00:00'),

-- Rozgrywka 23
(23, 5, 'Przykładowy komentarz!', '2026-02-20 18:30:00'),
(23, 2, 'Przykładowy komentarz!', '2026-02-20 19:00:00'),
(23, 4, 'Przykładowy komentarz!', '2026-02-20 19:45:00'),

-- Rozgrywka 24
(24, 1, 'Przykładowy komentarz!', '2026-02-21 23:30:00'),
(24, 3, 'Przykładowy komentarz!', '2026-02-21 23:45:00'),
(24, 5, 'Przykładowy komentarz!', '2026-02-22 00:15:00'),
(24, 2, 'Przykładowy komentarz!', '2026-02-22 01:00:00'),

-- Rozgrywka 25
(25, 4, 'Przykładowy komentarz!', '2026-02-22 16:30:00'),
(25, 1, 'Przykładowy komentarz!', '2026-02-22 17:00:00'),
(25, 3, 'Przykładowy komentarz!', '2026-02-22 17:30:00'),
(25, 5, 'Przykładowy komentarz!', '2026-02-22 18:00:00'),
(25, 2, 'Przykładowy komentarz!', '2026-02-22 18:30:00');
SET FOREIGN_KEY_CHECKS = 1;
COMMIT;