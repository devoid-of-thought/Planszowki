SET FOREIGN_KEY_CHECKS=0;

-- 1. Statusy
INSERT INTO `status` (`id_statusu`, `nazwa_statusu`) VALUES
(2, 'Chcę zagrać'),
(1, 'Posiadam'),
(4, 'Pożyczone'),
(3, 'Sprzedane');

-- 2. Uprawnienia
INSERT INTO `uprawnienia` (`id_uprawnien`, `typ_uprawnienia`) VALUES
(1, 'Administrator'),
(2, 'Moderator'),
(3, 'Użytkownik');

-- 3. Gatunki
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

-- 4. Planszówki
INSERT INTO `planszowka` (`id_planszowki`, `tytul_planszowki`, `data_wydania`, `wydawca`, `designer`, `min_graczy`, `max_graczy`, `min_dlugosc_rozgrywki`, `max_dlugosc_rozgrywki`, `waga`, `rekomendowany_wiek`, `bgg_id`, `stworzone_przez_id_uzytkownika`) VALUES
(1, 'Brass: Birmingham', 2018, 'Roxley', 'Gavan Brown, Martin Wallace', 2, 4, 60, 120, 3.9, 14, '224517', NULL),
(2, 'Pandemic Legacy: Season 1', 2015, 'Z-Man Games', 'Rob Daviau, Matt Leacock', 2, 4, 60, 60, 2.84, 13, '161936', NULL),
(3, 'Gloomhaven', 2017, 'Cephalofair Games', 'Isaac Childres', 1, 4, 60, 120, 3.9, 14, '174430', NULL),
(4, 'Ark Nova', 2021, 'Feuerland Spiele', 'Mathias Wigge', 1, 4, 90, 150, 3.7, 14, '342942', NULL),
(5, 'Twilight Imperium: Fourth Edition', 2017, 'Fantasy Flight Games', 'Dane Beltrami', 3, 6, 240, 480, 4.3, 14, '233078', NULL),
(6, 'Dune: Imperium', 2020, 'Dire Wolf', 'Paul Dennen', 1, 4, 60, 120, 3, 14, '316554', NULL),
(7, 'Terraforming Mars', 2016, 'FryxGames', 'Jacob Fryxelius', 1, 5, 120, 120, 3.2, 12, '167791', NULL),
(8, 'War of the Ring: Second Edition', 2012, 'Ares Games', 'Roberto Di Meglio', 2, 4, 150, 180, 4.2, 13, '115746', NULL),
(9, 'Spirit Island', 2017, 'Greater Than Games', 'R. Eric Reuss', 1, 4, 90, 120, 4, 13, '162886', NULL),
(10, 'Gaia Project', 2017, 'Feuerland Spiele', 'Jens Drögemüller', 1, 4, 60, 150, 4.4, 12, '220308', NULL),
(11, 'Star Wars: Rebellion', 2016, 'Fantasy Flight Games', 'Corey Konieczka', 2, 4, 180, 240, 3.7, 14, '187645', NULL),
(12, 'Scythe', 2016, 'Stonemaier Games', 'Jamey Stegmaier', 1, 5, 90, 115, 3.4, 14, '169786', NULL),
(13, 'Great Western Trail', 2016, 'eggertspiele', 'Alexander Pfister', 2, 4, 75, 150, 3.7, 12, '193738', NULL),
(14, 'The Castles of Burgundy', 2011, 'ale', 'Stefan Feld', 2, 4, 30, 90, 3, 12, '84876', NULL),
(15, '7 Wonders Duel', 2015, 'Repos Production', 'Antoine Bauza, Bruno Cathala', 2, 2, 30, 30, 2.2, 10, '173346', NULL),
(16, 'Concordia', 2013, 'PD-Verlag', 'Mac Gerdts', 2, 5, 100, 100, 3, 13, '124361', NULL),
(17, 'Wingspan', 2019, 'Stonemaier Games', 'Elizabeth Hargrave', 1, 5, 40, 70, 2.45, 10, '266192', NULL),
(18, 'Viticulture Essential Edition', 2015, 'Stonemaier Games', 'Jamey Stegmaier', 1, 6, 45, 90, 2.9, 13, '183394', NULL),
(19, 'Everdell', 2018, 'Starling Games', 'James A. Wilson', 1, 4, 40, 80, 2.8, 13, '199792', NULL),
(20, 'Orléans', 2014, 'dlp games', 'Reiner Stockhausen', 2, 4, 90, 90, 3, 12, '164928', NULL),
(21, 'A Feast for Odin', 2016, 'Feuerland Spiele', 'Uwe Rosenberg', 1, 4, 30, 120, 3.8, 12, '177736', NULL),
(22, 'Blood Rage', 2015, 'CMON', 'Eric M. Lang', 2, 4, 60, 90, 2.8, 14, '170216', NULL),
(23, 'Root', 2018, 'Leder Games', 'Cole Wehrle', 2, 4, 60, 90, 3.8, 10, '237182', NULL),
(24, 'The Crew: The Quest for Planet Nine', 2019, 'KOSMOS', 'Thomas Sing', 2, 5, 20, 20, 1.9, 10, '284083', NULL),
(25, 'Ticket to Ride', 2004, 'Days of Wonder', 'Alan R. Moon', 2, 5, 30, 60, 1.8, 8, '9209', NULL),
(26, 'Cascadia', 2021, 'Flatout Games', 'Randy Flynn', 1, 4, 30, 45, 1.8, 10, '295947', NULL),
(27, 'Codenames', 2015, 'Czech Games Edition', 'Vlaada Chvátil', 2, 8, 15, 15, 1.2, 14, '178900', NULL),
(28, '7 Wonders', 2010, 'Repos Production', 'Antoine Bauza', 2, 7, 30, 30, 2.3, 10, '68448', NULL),
(29, 'Azul', 2017, 'Plan B Games', 'Michael Kiesling', 2, 4, 30, 45, 1.7, 8, '230802', NULL),
(30, 'Patchwork', 2014, 'Lookout Games', 'Uwe Rosenberg', 2, 2, 15, 30, 1.6, 8, '163412', NULL),
(31, 'Splendor', 2014, 'Space Cowboys', 'Marc André', 2, 4, 30, 30, 1.7, 10, '148228', NULL),
(32, 'Carcassonne', 2000, 'Hans im Glück', 'Klaus-Jürgen Wrede', 2, 5, 30, 45, 1.9, 7, '822', NULL),
(33, 'King of Tokyo', 2011, 'IELLO', 'Richard Garfield', 2, 6, 30, 30, 1.5, 8, '70323', NULL),
(34, 'Love Letter', 2012, 'AEG', 'Seiji Kanai', 2, 4, 20, 20, 1.1, 10, '129622', NULL),
(35, 'The Mind', 2018, 'Nürnberger-Spielkarten-Verlag', 'Wolfgang Warsch', 2, 4, 20, 20, 1, 8, '244992', NULL),
(36, 'Crokinole', 1876, 'Public Domain', '(Uncredited)', 2, 4, 30, 30, 1.2, 8, '521', NULL),
(37, 'Decrypto', 2018, 'Le Scorpion Masqué', 'Thomas Dagenais-Lespérance', 3, 8, 15, 45, 1.8, 12, '225694', NULL),
(38, 'Sushi Go!', 2013, 'Gamewright', 'Phil Walker-Harding', 2, 5, 15, 15, 1.1, 8, '133473', NULL),
(39, 'Clank! A Deck-Building Adventure', 2016, 'Renegade Game Studios', 'Paul Dennen', 2, 4, 30, 60, 2.2, 12, '201808', NULL),
(40, 'The Quacks of Quedlinburg', 2018, 'Schmidt Spiele', 'Wolfgang Warsch', 2, 4, 45, 45, 1.9, 10, '244521', NULL),
(41, 'Cartographers', 2019, 'Thunderworks Games', 'Jordy Adan', 1, 100, 30, 45, 1.8, 10, '263918', NULL),
(42, 'The Resistance: Avalon', 2012, 'Indie Boards & Cards', 'Don Eskridge', 5, 10, 30, 30, 1.7, 13, '128882', NULL),
(43, 'Just One', 2018, 'Repos Production', 'Ludovic Roudy', 3, 7, 20, 20, 1, 8, '254640', NULL),
(44, 'Heat: Pedal to the Metal', 2022, 'Days of Wonder', 'Asger Harding Granerud', 1, 6, 30, 60, 2.2, 10, '366013', NULL),
(45, 'Lost Ruins of Arnak', 2020, 'CGE', 'Mín & Elwen', 1, 4, 30, 120, 2.9, 12, '312484', NULL),
(46, 'Marvel Champions: The Card Game', 2019, 'Fantasy Flight Games', 'Michael Boggs', 1, 4, 45, 90, 2.9, 14, '285774', NULL),
(47, 'Le Havre', 2008, 'Lookout Games', 'Uwe Rosenberg', 1, 5, 30, 150, 3.7, 12, '35677', NULL),
(48, 'Mage Knight Board Game', 2011, 'WizKids', 'Vlaada Chvátil', 1, 4, 60, 240, 4.3, 14, '96848', NULL),
(49, 'Nemesis', 2018, 'Awaken Realms', 'Adam Kwapiński', 1, 5, 90, 180, 3.4, 12, '167355', NULL),
(50, 'Mansions of Madness: Second Edition', 2016, 'Fantasy Flight Games', 'Nikki Valens', 1, 5, 120, 180, 2.6, 14, '205059', NULL),
(51, 'Through the Ages: A New Story of Civilization', 2015, 'Czech Games Edition', 'Vlaada Chvátil', 2, 4, 120, 240, 4.43, 14, '182028', NULL),
(52, 'Agricola', 2007, 'Lookout Games', 'Uwe Rosenberg', 1, 5, 30, 150, 3.64, 12, '31260', NULL),
(53, 'Power Grid', 2004, '2F-Spiele', 'Friedemann Friese', 2, 6, 120, 120, 3.26, 12, '2651', NULL),
(54, 'Barrage', 2019, 'Cranio Creations', 'Tommaso Battista', 1, 4, 60, 120, 4.09, 14, '251247', NULL),
(55, 'The Gallerist', 2015, 'Eagle-Gryphon Games', 'Vital Lacerda', 1, 4, 60, 150, 4.27, 13, '125153', NULL),
(56, 'Tzolk\'in: The Mayan Calendar', 2012, 'Czech Games Edition', 'Simone Luciani', 2, 4, 90, 90, 3.67, 13, '126163', NULL),
(57, 'Anachrony', 2017, 'Mindclash Games', 'Dávid Turczi', 1, 4, 30, 120, 3.99, 15, '185343', NULL),
(58, 'Kingdom Death: Monster', 2015, 'Kingdom Death', 'Adam Poots', 1, 4, 60, 180, 4.26, 18, '55690', NULL),
(59, 'Rising Sun', 2018, 'CMON', 'Eric M. Lang', 3, 5, 90, 120, 3.23, 14, '205896', NULL),
(60, 'Inis', 2016, 'Matagot', 'Christian Martinez', 2, 4, 60, 90, 2.89, 14, '155821', NULL),
(61, 'Cosmic Encounter', 2008, 'Fantasy Flight Games', 'Bill Eberle', 3, 5, 60, 120, 2.57, 12, '39463', NULL),
(62, 'Sheriff of Nottingham', 2014, 'Arcane Wonders', 'Sérgio Halaban', 3, 5, 60, 60, 1.65, 13, '157969', NULL),
(63, 'Five Tribes', 2014, 'Days of Wonder', 'Bruno Cathala', 2, 4, 40, 80, 2.84, 13, '157354', NULL),
(64, 'Istanbul', 2014, 'Pegasus Spiele', 'Rüdiger Dorn', 2, 5, 40, 60, 2.58, 10, '148949', NULL),
(65, 'Raiders of the North Sea', 2015, 'Garphill Games', 'Shem Phillips', 2, 4, 60, 80, 2.6, 12, '170042', NULL),
(66, 'Architects of the West Kingdom', 2018, 'Garphill Games', 'Shem Phillips', 1, 5, 60, 80, 2.76, 12, '236457', NULL),
(67, 'Sagrada', 2017, 'Floodgate Games', 'Daryl Andrews', 1, 4, 30, 45, 1.93, 13, '199561', NULL),
(68, 'Kingdomino', 2016, 'Blue Orange Games', 'Bruno Cathala', 2, 4, 15, 15, 1.21, 8, '204583', NULL),
(69, 'Catan', 1995, 'KOSMOS', 'Klaus Teuber', 3, 4, 60, 120, 2.3, 10, '13', NULL),
(70, 'Small World', 2009, 'Days of Wonder', 'Philippe Keyaerts', 2, 5, 40, 80, 2.34, 8, '40692', NULL),
(71, 'Takenoko', 2011, 'Matagot', 'Antoine Bauza', 2, 4, 45, 45, 1.97, 8, '70919', NULL),
(72, 'Jaipur', 2009, 'GameWorks', 'Sébastien Pauchon', 2, 2, 30, 30, 1.48, 12, '54043', NULL),
(73, 'Hive', 2001, 'Gen42 Games', 'John Yianni', 2, 2, 20, 20, 2.33, 9, '2655', NULL),
(74, 'Santorini', 2016, 'Roxley', 'Gord!', 2, 4, 20, 20, 1.72, 8, '194655', NULL),
(75, 'Star Realms', 2014, 'White Wizard Games', 'Robert Dougherty', 2, 2, 20, 20, 1.93, 12, '147020', NULL),
(76, 'Dominion', 2008, 'Rio Grande Games', 'Donald X. Vaccarino', 2, 4, 30, 30, 2.35, 13, '36218', NULL),
(77, 'Race for the Galaxy', 2007, 'Rio Grande Games', 'Thomas Lehmann', 2, 4, 30, 60, 2.99, 12, '28143', NULL),
(78, 'Sherlock Holmes Consulting Detective', 1981, 'Ystari Games', 'Raymond Edwards', 1, 8, 60, 120, 2.68, 13, '2511', NULL),
(79, 'Robinson Crusoe: Adventures on the Cursed Island', 2012, 'Portal Games', 'Ignacy Trzewiczek', 1, 4, 60, 120, 3.82, 14, '121921', NULL),
(80, 'El Grande', 1995, 'Hans im Glück', 'Wolfgang Kramer', 2, 5, 60, 120, 3.05, 12, '93', NULL),
(81, 'Tigris & Euphrates', 1997, 'Hans im Glück', 'Reiner Knizia', 2, 4, 90, 90, 3.52, 12, '42', NULL),
(82, 'Eclipse: Second Dawn for the Galaxy', 2020, 'Lautapelit.fi', 'Touko Tahkokallio', 2, 6, 60, 200, 3.61, 14, '246900', NULL),
(83, 'A Game of Thrones: The Board Game (2nd Ed)', 2011, 'Fantasy Flight Games', 'Christian T. Petersen', 3, 6, 120, 240, 3.73, 14, '103343', NULL),
(84, 'Battlestar Galactica: The Board Game', 2008, 'Fantasy Flight Games', 'Corey Konieczka', 3, 6, 120, 180, 3.24, 14, '37111', NULL),
(85, 'Puerto Rico', 2002, 'alea', 'Andreas Seyfarth', 3, 5, 90, 150, 3.27, 12, '3076', NULL),
(86, 'Caverna: The Cave Farmers', 2013, 'Lookout Games', 'Uwe Rosenberg', 1, 7, 30, 210, 3.79, 12, '102794', NULL),
(87, 'Food Chain Magnate', 2015, 'Splotter Spellen', 'Jeroen Doumen', 2, 5, 120, 240, 4.22, 14, '175914', NULL),
(88, 'Grand Austria Hotel', 2015, 'Lookout Games', 'Virginio Gigli', 2, 4, 60, 120, 3.23, 12, '182874', NULL),
(89, 'Yokohama', 2016, 'Tasty Minstrel Games', 'Hisashi Hayashi', 2, 4, 90, 90, 3.31, 12, '196340', NULL),
(90, 'Champions of Midgard', 2015, 'Grey Fox Games', 'Ole Steiness', 2, 4, 60, 90, 2.56, 10, '172287', NULL),
(91, 'Lords of Waterdeep', 2012, 'Wizards of the Coast', 'Peter Lee', 2, 5, 60, 120, 2.45, 12, '110327', NULL),
(92, 'Stone Age', 2008, 'Hans im Glück', 'Bernd Brunnhofer', 2, 4, 60, 90, 2.47, 10, '34635', NULL),
(93, 'Biblios', 2007, 'IELLO', 'Steve Finn', 2, 4, 30, 30, 1.67, 10, '34219', NULL),
(94, 'Bohnanza', 1997, 'Amigo', 'Uwe Rosenberg', 2, 7, 45, 45, 1.61, 10, '11', NULL),
(95, 'Skull', 2011, 'Lui-même', 'Hervé Marly', 3, 6, 15, 45, 1.13, 10, '92415', NULL),
(96, 'Dixit', 2008, 'Libellud', 'Jean-Louis Roubira', 3, 6, 30, 30, 1.21, 8, '39856', NULL),
(97, 'Mysterium', 2015, 'Libellud', 'Oleksandr Nevskiy', 2, 7, 42, 42, 1.9, 10, '181304', NULL),
(98, 'Hanabi', 2010, 'Abacusspiele', 'Antoine Bauza', 2, 5, 25, 25, 1.69, 8, '98778', NULL),
(99, 'No Thanks!', 2004, 'Amigo', 'Thorsten Gimmler', 3, 7, 20, 20, 1.13, 8, '12942', NULL),
(100, 'For Sale', 1997, 'Uberplay', 'Stefan Dorra', 3, 6, 20, 30, 1.25, 8, '172', NULL),
(101, 'Air, Land, & Sea', 2019, 'Arcane Wonders', 'Jon Perry', 2, 2, 15, 30, 1.68, 14, '247367', 1),
(102, 'Arboretum', 2015, 'Renegade Game Studios', 'Dan Cassar', 2, 4, 30, 30, 2.15, 8, '140934', 1),
(103, 'Carcassonne: Inns & Cathedrals', 2002, 'Hans im Glück', 'Klaus-Jürgen Wrede', 2, 6, 60, 60, 2.08, 8, '2993', 1),
(104, 'Coloretto', 2003, 'Abacusspiele', 'Michael Schacht', 2, 5, 30, 30, 1.71, 8, '5782', 1),
(105, 'Hanamikoji', 2013, 'EmperorS4', 'Kota Nakayama', 2, 2, 15, 15, 1.71, 10, '158600', 1),
(106, 'Herd Mentality', 2020, 'Big Potato', 'Rich Coombes', 4, 10, 20, 20, 1.05, 10, '306735', 1),
(107, 'High Society', 1995, 'Osprey Games', 'Reiner Knizia', 3, 5, 15, 30, 1.76, 10, '220', 1),
(108, 'The Hobbit Card Game', 2012, 'Fantasy Flight Games', 'Martin Wallace', 2, 5, 30, 30, 1.6, 10, '111467', 1),
(109, 'Innovation', 2010, 'Asmadi Games', 'Carl Chudyk', 2, 4, 60, 60, 2.74, 12, '63888', 1),
(110, 'Lewis & Clark: The Expedition', 2013, 'Ludonaute', 'Cédrick Chaboussit', 1, 5, 120, 120, 3.32, 14, '140620', 1),
(111, 'Magical Athlete', 2002, 'Z-Man Games', 'Takashi Ishida', 4, 5, 45, 60, 1.4, 8, '24565', 1),
(112, 'Mal Trago', 2019, 'Rocket Lemon Games', 'Jose Manuel Fernandez', 4, 10, 15, 20, 1.1, 8, '295627', 1),
(113, 'Monopoly: European Edition', 1991, 'Parker Brothers', '(Uncredited)', 2, 8, 60, 180, 1.65, 8, '11029', 1),
(114, 'Munchkin', 2001, 'Steve Jackson Games', 'Steve Jackson', 3, 6, 60, 120, 1.79, 10, '1927', 1),
(115, 'Oath: Chronicles of Empire and Exile', 2021, 'Leder Games', 'Cole Wehrle', 1, 6, 45, 120, 4.07, 10, '291572', 1),
(116, 'Oh My Gods!', 2016, 'Gamewright', 'Tim Armstrong', 3, 5, 30, 30, 1.3, 10, '198948', 1),
(117, 'Pax Renaissance', 2016, 'Sierra Madre Games', 'Phil Eklund', 2, 4, 60, 120, 4.22, 14, '198953', 1),
(118, 'Radlands', 2021, 'Roxley', 'Daniel Piechnick', 2, 2, 20, 40, 2.26, 14, '322703', 1),
(119, 'The Red Cathedral', 2020, 'Devir', 'Israel Cendrero', 1, 4, 50, 80, 2.8, 10, '227224', 1),
(120, 'Scrabble', 1948, 'Mattel', 'Alfred Mosher Butts', 2, 4, 90, 90, 2.07, 10, '320', 1),
(121, 'Spicy', 2020, 'HeidelBÄR Games', 'Zoltán Győri', 2, 6, 15, 20, 1.18, 10, '299169', 1),
(122, 'Splito', 2022, 'Blam!', 'Luc Rémond', 3, 8, 15, 15, 1.3, 8, '369656', 1),
(123, 'Sushi Go! 10th Anniversary', 2023, 'Gamewright', 'Phil Walker-Harding', 2, 5, 15, 15, 1.2, 8, '392181', 1),
(124, 'Take 5 (6. nimmt!)', 1994, 'Amigo', 'Wolfgang Kramer', 2, 10, 45, 45, 1.19, 8, '432', 1),
(125, 'Talisman: Revised 4th Edition', 2007, 'Fantasy Flight Games', 'Bob Harris', 2, 6, 90, 90, 2.15, 9, '27627', 1),
(126, 'Targi', 2012, 'KOSMOS', 'Andreas Steiger', 2, 2, 60, 60, 2.33, 12, '118048', 1),
(127, 'Terraforming Mars: Colonies', 2018, 'FryxGames', 'Jacob Fryxelius', 1, 5, 120, 120, 3.2, 12, '255681', 1),
(128, 'Terraforming Mars: Prelude', 2018, 'FryxGames', 'Jacob Fryxelius', 1, 5, 120, 120, 3.1, 12, '247030', 1),
(129, 'Ticket to Ride: Europe', 2005, 'Days of Wonder', 'Alan R. Moon', 2, 5, 30, 60, 1.92, 8, '14996', 1),
(130, 'Tiny Epic Dungeons', 2021, 'Gamelyn Games', 'Scott Almes', 1, 4, 30, 60, 2.75, 14, '331787', 1),
(131, 'Tussie Mussie', 2019, 'Button Shy', 'Elizabeth Hargrave', 2, 4, 20, 30, 1.2, 8, '257614', 1),
(132, 'UNO', 1971, 'Mattel', 'Merle Robbins', 2, 10, 30, 30, 1.11, 6, '2223', 1),
(133, 'Vantage', 2011, 'Vantage Games', 'Manny Trembley', 2, 6, 30, 45, 1.5, 8, '108234', 1),
(134, 'Village Green', 2020, 'Osprey Games', 'Peer Sylvester', 1, 5, 30, 30, 1.87, 14, '300583', 1),
(135, 'La Viña', 2019, 'Devir', 'Josep M. Allué', 2, 5, 30, 45, 1.6, 8, '239636', 1);

-- 5. Relacje Planszówka-Gatunek
INSERT INTO `planszowka_gatunek` (`id_planszowki`, `id_gatunku`) VALUES
(1, 2), (1, 4), (1, 25), (2, 1), (2, 2), (3, 1), (3, 3), (3, 7), (3, 39), (4, 2), (4, 4), (4, 28), (5, 2), (5, 8), (5, 13), (5, 32), (6, 8), (6, 35), (6, 44), (7, 2), (7, 4), (7, 8), (8, 7), (8, 13), (8, 21), (9, 1), (9, 2), (9, 7), (10, 4), (10, 8), (11, 8), (11, 13), (11, 21), (12, 2), (12, 4), (12, 21), (13, 2), (13, 26), (14, 2), (14, 11), (15, 6), (15, 39), (15, 42), (16, 2), (16, 4), (17, 5), (17, 6), (17, 28), (18, 4), (18, 44), (19, 6), (19, 7), (19, 44), (20, 2), (20, 35), (21, 26), (21, 44), (22, 7), (22, 13), (22, 21), (22, 42), (23, 7), (23, 13), (23, 47), (24, 1), (24, 6), (25, 5), (25, 30), (26, 5), (26, 28), (26, 31), (27, 16), (27, 23), (27, 37), (28, 5), (28, 6), (28, 42), (29, 5), (29, 12), (29, 31), (30, 5), (30, 31), (31, 4), (31, 5), (32, 5), (32, 30), (32, 31), (33, 5), (33, 11), (33, 39), (34, 5), (34, 6), (34, 37), (35, 1), (35, 6), (36, 12), (36, 24), (37, 16), (37, 23), (37, 37), (38, 5), (38, 6), (38, 42), (39, 3), (39, 35), (40, 5), (40, 45), (41, 5), (41, 7), (42, 16), (42, 36), (42, 37), (42, 48), (43, 1), (43, 16), (43, 23), (44, 6), (44, 43), (45, 3), (45, 35), (45, 44), (46, 1), (46, 6), (47, 4), (47, 25), (48, 2), (48, 3), (48, 7), (49, 8), (49, 9), (49, 21), (49, 48), (50, 1), (50, 3), (50, 9), (51, 2), (51, 4), (51, 20), (52, 4), (52, 30), (52, 44), (53, 4), (53, 25), (53, 46), (54, 4), (54, 22), (54, 25), (55, 4), (55, 15), (55, 44), (56, 2), (56, 15), (56, 44), (57, 2), (57, 8), (57, 44), (58, 1), (58, 9), (58, 14), (58, 21), (59, 21), (59, 22), (59, 27), (59, 32), (60, 22), (60, 27), (60, 42), (61, 8), (61, 32), (61, 47), (62, 16), (62, 32), (62, 36), (63, 2), (63, 12), (64, 2), (64, 4), (64, 43), (65, 26), (65, 44), (66, 2), (66, 44), (67, 10), (67, 11), (67, 12), (68, 5), (68, 31), (69, 5), (69, 30), (69, 32), (70, 7), (70, 22), (70, 47), (71, 5), (71, 31), (72, 4), (72, 6), (72, 39), (73, 12), (73, 39), (74, 10), (74, 12), (74, 27), (75, 8), (75, 35), (75, 39), (76, 6), (76, 30), (76, 35), (77, 4), (77, 6), (77, 8), (78, 1), (78, 37), (79, 1), (79, 3), (79, 45), (80, 2), (80, 22), (80, 30), (81, 12), (81, 22), (81, 30), (82, 2), (82, 8), (82, 13), (83, 2), (83, 13), (83, 32), (84, 1), (84, 8), (84, 36), (84, 48), (85, 2), (85, 4), (85, 30), (86, 4), (86, 44), (87, 2), (87, 4), (88, 4), (88, 11), (89, 2), (89, 44), (90, 11), (90, 44), (91, 5), (91, 7), (91, 44), (92, 5), (92, 11), (92, 30), (92, 44), (93, 6), (93, 46), (94, 5), (94, 6), (94, 32), (95, 16), (95, 36), (96, 5), (96, 16), (97, 1), (97, 37), (98, 1), (98, 6), (98, 10), (99, 5), (99, 6), (99, 45), (100, 4), (100, 5), (100, 46), (101, 2), (101, 6), (101, 13), (102, 6), (102, 10), (102, 33), (103, 5), (103, 31), (104, 6), (104, 33), (104, 45), (105, 6), (105, 22), (105, 39), (106, 16), (106, 23), (107, 6), (107, 46), (108, 6), (108, 7), (109, 6), (109, 20), (110, 26), (110, 29), (110, 43), (111, 7), (111, 42), (111, 43), (112, 6), (112, 16), (113, 4), (113, 5), (113, 32), (114, 6), (114, 7), (114, 32), (115, 2), (115, 22), (115, 49), (116, 27), (116, 37), (117, 2), (117, 4), (117, 26), (118, 6), (118, 8), (118, 39), (119, 2), (119, 26), (120, 23), (120, 30), (121, 6), (121, 36), (122, 6), (122, 42), (123, 6), (123, 42), (124, 6), (124, 10), (125, 3), (125, 7), (125, 11), (126, 2), (126, 44), (127, 4), (127, 8), (128, 4), (128, 8), (129, 5), (129, 30), (130, 1), (130, 3), (130, 7), (131, 6), (131, 42), (132, 5), (132, 6), (133, 37), (134, 6), (134, 31), (135, 6), (135, 33);

-- 6. Dodanie pluginu (zgodnie z nowym schematem - bez 'opis')
START TRANSACTION;

SET @id_user = 1;

-- 1. Brass: Birmingham
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Brass: Birmingham - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma punktów z kafelków, połączeń i pieniędzy." },
    "ui": { "title": "Brass: Birmingham", "description": "Podlicz punkty na koniec Ery Kolejowej." },
    "categories": [
        { "id": "tiles", "name": "Kafelki Przemysłu", "color": "#795548", "input_type": "number", "default": 0, "description": "Suma punktów z odwróconych kafelków." },
        { "id": "links", "name": "Połączenia (Kanały/Kolej)", "color": "#009688", "input_type": "number", "default": 0, "description": "Suma punktów za połączenia." },
        { "id": "money", "name": "Pieniądze", "color": "#FFC107", "input_type": "number", "default": 0, "description": "1 punkt za każde 17 funtów." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (1, @id_plugin, 'Standardowy');

-- 2. Pandemic Legacy
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Pandemic Legacy - Raport', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Raport z gry (nie ma standardowych punktów zwycięstwa)." },
    "ui": { "title": "Pandemic Legacy", "description": "Wpisz wynik misji." },
    "categories": [
        { "id": "result", "name": "Wynik (1=Sukces, 0=Porażka)", "color": "#4CAF50", "input_type": "number", "default": 1, "description": "Wpisz 1 jeśli wygraliście, 0 jeśli przegraliście." },
        { "id": "funding", "name": "Poziom Finansowania", "color": "#2196F3", "input_type": "number", "default": 4, "description": "Poziom finansowania na koniec gry." },
        { "id": "outbreaks", "name": "Liczba Ognisk", "color": "#F44336", "input_type": "number", "default": 0, "description": "Liczba znaczników ognisk choroby." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (2, @id_plugin, 'Raport Misji');

-- 3. Gloomhaven
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Gloomhaven - Statystyki Gracza', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Statystyki indywidualne po scenariuszu." },
    "ui": { "title": "Gloomhaven", "description": "Wpisz swoje zdobycze." },
    "categories": [
        { "id": "xp", "name": "Zdobyte XP", "color": "#3F51B5", "input_type": "number", "default": 0, "description": "Doświadczenie zdobyte w scenariuszu (bez bonusu za wygraną)." },
        { "id": "gold", "name": "Złoto", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba zebranych monet (lub ich wartość)." },
        { "id": "checks", "name": "Haczyki (Battle Goals)", "color": "#8BC34A", "input_type": "number", "default": 0, "description": "Liczba zdobytych haczyków (0-2)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (3, @id_plugin, 'Statystyki Postaci');

-- 4. Ark Nova
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Ark Nova - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Punkty Atrakcyjności minus Punkty Ochrony (przeliczone)." },
    "ui": { "title": "Ark Nova", "description": "Wpisz wartości z torów." },
    "categories": [
        { "id": "appeal", "name": "Punkty Atrakcyjności (Bilety)", "color": "#795548", "input_type": "number", "default": 0, "description": "Wartość z toru biletów." },
        { "id": "conservation", "name": "Punkty Ochrony (Tarcze)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty z zielonego toru (system sam ich nie odejmuje - wpisz wynik końcowy jeśli wolisz)." },
        { "id": "cards", "name": "Punkty z Kart Celów", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Dodatkowe punkty z kart celów końcowych." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (4, @id_plugin, 'Standardowy');

-- 5. Twilight Imperium 4
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('TI4 - Punkty Zwycięstwa', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma punktów z celów." },
    "ui": { "title": "Twilight Imperium 4", "description": "Podział punktów zwycięstwa." },
    "categories": [
        { "id": "public1", "name": "Cele Publiczne I", "color": "#90CAF9", "input_type": "number", "default": 0, "description": "Punkty z celów etapu I." },
        { "id": "public2", "name": "Cele Publiczne II", "color": "#1565C0", "input_type": "number", "default": 0, "description": "Punkty z celów etapu II." },
        { "id": "secret", "name": "Cele Tajne", "color": "#D32F2F", "input_type": "number", "default": 0, "description": "Punkty ze zrealizowanych celów tajnych." },
        { "id": "support", "name": "Wsparcie Tronów/Inne", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty z kart Wsparcia, Mecatol Rex, Agendy itp." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (5, @id_plugin, 'Standardowy');

-- 6. Dune: Imperium
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Dune: Imperium - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Punkty na koniec gry." },
    "ui": { "title": "Dune: Imperium", "description": "Podliczanie punktów." },
    "categories": [
        { "id": "track", "name": "Tor Punktów", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty widoczne na torze w trakcie gry." },
        { "id": "endcards", "name": "Karty Intrygi (Koniec Gry)", "color": "#607D8B", "input_type": "number", "default": 0, "description": "Punkty z kart intrygi rozpatrywanych na koniec." },
        { "id": "resources", "name": "Rozstrzyganie Remisów (Przyprawa/Solari)", "color": "#795548", "input_type": "number", "default": 0, "description": "Opcjonalnie: wpisz wartość zasobów jako ułamek punktu dla remisu." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (6, @id_plugin, 'Standardowy');

-- 7. Terraforming Mars
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Terraformacja Marsa', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "TR + Plansza + Karty." },
    "ui": { "title": "Terraformacja Marsa", "description": "Arkusz końcowy." },
    "categories": [
        { "id": "tr", "name": "Współczynnik Terraformacji (TR)", "color": "#F44336", "input_type": "number", "default": 20, "description": "Twój bazowy TR na koniec gry." },
        { "id": "awards", "name": "Nagrody i Tytuły", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty za ufundowane Nagrody i Tytuły." },
        { "id": "greencity", "name": "Plansza (Zieleń/Miasta)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty za obszary zieleni i miasta (oraz obszary przyległe do miast)." },
        { "id": "cards", "name": "Punkty z Kart", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Symbole Jowisza, zwierzęta, mikroby i inne VP na kartach." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (7, @id_plugin, 'Standardowy');

-- 8. War of the Ring
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Wojna o Pierścień', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Punkty zwycięstwa militarnego lub Ring Dunk." },
    "ui": { "title": "Wojna o Pierścień", "description": "Wynik rozgrywki." },
    "categories": [
        { "id": "mil_vp", "name": "Punkty Militarne", "color": "#D32F2F", "input_type": "number", "default": 0, "description": "Liczba zdobytych punktów zwycięstwa militarnego." },
        { "id": "corruption", "name": "Poziom Zepsucia / Wynik Wyprawy", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Dla Wolnych Ludów: pozycja na torze Góry Przeznaczenia. Dla Cienia: poziom zepsucia Powiernika." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (8, @id_plugin, 'Standardowy');

-- 9. Spirit Island
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Spirit Island - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Oficjalna punktacja wg instrukcji." },
    "ui": { "title": "Spirit Island", "description": "Kalkulator wyniku (opcjonalny)." },
    "categories": [
        { "id": "win", "name": "Zwycięstwo (tak=1, nie=0)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Czy gra zakończyła się wygraną?" },
        { "id": "invaders", "name": "Karty Najeźdźców w Talii", "color": "#F44336", "input_type": "number", "default": 0, "description": "Liczba kart pozostałych w talii najeźdźców (tylko przy wygranej)." },
        { "id": "dahan", "name": "Dahanie na planszy", "color": "#795548", "input_type": "number", "default": 0, "description": "Liczba ocalałych Dahan (podzielona przez liczbę graczy)." },
        { "id": "blight", "name": "Zaraza na planszy", "color": "#9E9E9E", "input_type": "number", "default": 0, "allow_negative": true, "description": "Wpisz jako liczbę ujemną (-1 za każdą zarazę)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (9, @id_plugin, 'Oficjalna Punktacja');

-- 10. Gaia Project
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Gaia Project - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma wszystkich VP." },
    "ui": { "title": "Projekt Gaja", "description": "Arkusz końcowy." },
    "categories": [
        { "id": "base", "name": "Punkty z Gry", "color": "#03A9F4", "input_type": "number", "default": 10, "description": "Punkty zdobyte w trakcie rund (z żetonów, sojuszy itp.)." },
        { "id": "research", "name": "Badania", "color": "#673AB7", "input_type": "number", "default": 0, "description": "4 punkty za każdy 3/4/5 poziom badań." },
        { "id": "objectives", "name": "Cele Końcowe", "color": "#8BC34A", "input_type": "number", "default": 0, "description": "Punkty z kafli celów końcowych (ranking)." },
        { "id": "resources", "name": "Zasoby", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty za pozostałe zasoby (QIC, Kredyty, Wiedza)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (10, @id_plugin, 'Standardowy');

SET @id_game = (SELECT id_planszowki FROM planszowka WHERE tytul_planszowki = '7 Wonders' LIMIT 1);
-- 11. 7 Wonders - Punktacja    
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES (
    '7 Wonders - Scoring', 
    '{
    "meta": {
        "version": "1.0",
        "author": "Admin",
        "date_created": "2024-06-01",
        "last_modified": "2024-06-01",
        "score_guide": "Gracz samodzielnie oblicza punkty dla każdej kategorii."
    },
    "ui": {
        "title": "7 Wonders",
        "description": "Arkusz punktacji. Wpisz obliczone wartości dla każdej kategorii."
    },
    "categories": [
        { "id": "military", "name": "Konflikty Militarne", "color": "#D32F2F", "input_type": "number", "default": 0, "allow_negative": true, "description": "Suma żetonów zwycięstwa minus żetony porażki (Czerwone karty)." },
        { "id": "treasury", "name": "Skarbiec", "color": "#FBC02D", "input_type": "number", "default": 0, "allow_negative": false, "description": "1 punkt za każde 3 monety. (Oblicz: Monety / 3)." },
        { "id": "wonder", "name": "Cud Świata", "color": "#616161", "input_type": "number", "default": 0, "allow_negative": false, "description": "Punkty za wybudowane etapy Cudu." },
        { "id": "civilian", "name": "Budowle Cywilne", "color": "#1976D2", "input_type": "number", "default": 0, "allow_negative": false, "description": "Suma punktów z Niebieskich kart." },
        { "id": "scientific", "name": "Budowle Naukowe", "color": "#388E3C", "input_type": "number", "default": 0, "allow_negative": false, "description": "Punkty za zestawy symboli z Zielonych kart (oblicz wg tabeli na planszy)." },
        { "id": "commercial", "name": "Budowle Handlowe", "color": "#F57C00", "input_type": "number", "default": 0, "allow_negative": false, "description": "Punkty z Żółtych kart." },
        { "id": "guilds", "name": "Gildie", "color": "#7B1FA2", "input_type": "number", "default": 0, "allow_negative": false, "description": "Punkty z Fioletowych kart (zależnie od warunku gildii)." }
    ]
}', 
    @id_user
);

SET @id_new_plugin = LAST_INSERT_ID();

-- 7. Powiązanie z grą (kolumny w arkusz_punktacji bez zmian)
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza)
VALUES (@id_game, @id_new_plugin, '7 Wonders - Standardowy');

-- ============================================================
-- PLUGINY DLA GIER 11-20
-- ============================================================

-- Ustawienie zmiennej ID użytkownika (Admina)
SET @id_user = 1;

-- 11. Star Wars: Rebellion
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Star Wars: Rebellion - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Gra binarna: Wygrana lub Przegrana." },
    "ui": { "title": "Star Wars: Rebellion", "description": "Wpisz 1 dla zwycięzcy." },
    "categories": [
        { "id": "win", "name": "Zwycięstwo (1=Tak, 0=Nie)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Wpisz 1 jeśli ta strona konfliktu wygrała." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (11, @id_plugin, 'Status Końcowy');

-- 12. Scythe
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Scythe - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma monet na koniec gry." },
    "ui": { "title": "Scythe", "description": "Podlicz monety z wszystkich źródeł." },
    "categories": [
        { "id": "coins_hand", "name": "Monety na ręku", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Gotówka posiadana na koniec gry." },
        { "id": "star_points", "name": "Punkty za Gwiazdy", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Liczba gwiazd x Mnożnik z toru popularności." },
        { "id": "territory_points", "name": "Punkty za Terytoria", "color": "#795548", "input_type": "number", "default": 0, "description": "Liczba pól x Mnożnik z toru popularności." },
        { "id": "resource_points", "name": "Punkty za Zasoby", "color": "#607D8B", "input_type": "number", "default": 0, "description": "Liczba par zasobów x Mnożnik z toru popularności." },
        { "id": "building_bonus", "name": "Bonus z Budynków", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty wynikające z rozmieszczenia budynków." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (12, @id_plugin, 'Standardowy');

-- 13. Great Western Trail
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Great Western Trail - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma punktów ze wszystkich źródeł." },
    "ui": { "title": "Great Western Trail", "description": "Arkusz punktacji." },
    "categories": [
        { "id": "money", "name": "Pieniądze (1 za 5$)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "1 punkt za każde 5 dolarów." },
        { "id": "buildings", "name": "Budynki", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty nadrukowane na wybudowanych budynkach." },
        { "id": "cities", "name": "Miasta (Dyski)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty z miast, do których dostarczono bydło." },
        { "id": "stations", "name": "Stacje Kolejowe", "color": "#212121", "input_type": "number", "default": 0, "description": "Punkty z odblokowanych stacji." },
        { "id": "hazards", "name": "Zagrożenia", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty za zebrane żetony zagrożeń." },
        { "id": "cards", "name": "Karty (Krowy/Cele)", "color": "#3F51B5", "input_type": "number", "default": 0, "description": "Punkty z kart krów i zrealizowanych celów." },
        { "id": "board", "name": "Plansza Gracza", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Odblokowane pola na planszy gracza." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (13, @id_plugin, 'Standardowy');

-- 14. The Castles of Burgundy
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Zamki Burgundii - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Tor punktów + bonusy końcowe." },
    "ui": { "title": "Zamki Burgundii", "description": "Podliczanie końcowe." },
    "categories": [
        { "id": "track", "name": "Punkty z Toru", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie gry (na torze)." },
        { "id": "goods", "name": "Niesprzedane Towary", "color": "#FFC107", "input_type": "number", "default": 0, "description": "1 punkt za każdy niesprzedany towar." },
        { "id": "silver", "name": "Srebrniki", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "1 punkt za każdy srebrnik." },
        { "id": "workers", "name": "Robotnicy (x2 -> 1VP)", "color": "#795548", "input_type": "number", "default": 0, "description": "1 punkt za każdych 2 robotników." },
        { "id": "yellow", "name": "Kafelki Wiedzy (Żółte)", "color": "#FFEB3B", "input_type": "number", "default": 0, "description": "Punkty z żółtych kafelków bonusowych." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (14, @id_plugin, 'Standardowy');

-- 15. 7 Wonders Duel
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('7 Wonders Duel - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Sumowanie punktów (jeśli nie było wygranej natychmiastowej)." },
    "ui": { "title": "7 Cudów Świata: Pojedynek", "description": "Wpisz punkty z kategorii." },
    "categories": [
        { "id": "blue", "name": "Karty Cywilne (Niebieskie)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Suma punktów." },
        { "id": "green", "name": "Karty Naukowe (Zielone)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Suma punktów." },
        { "id": "yellow", "name": "Karty Handlowe (Żółte)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Suma punktów." },
        { "id": "guilds", "name": "Gildie (Fioletowe)", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Suma punktów." },
        { "id": "wonders", "name": "Cuda Świata", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty z wybudowanych cudów." },
        { "id": "progress", "name": "Żetony Postępu", "color": "#8BC34A", "input_type": "number", "default": 0, "description": "Punkty z żetonów postępu." },
        { "id": "money", "name": "Skarbiec (3 monety = 1 VP)", "color": "#BDBDBD", "input_type": "number", "default": 0, "description": "Oblicz: Monety / 3." },
        { "id": "military", "name": "Przewaga Militarna", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty za pozycję piona konfliktu (dla wygrywającego)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (15, @id_plugin, 'Standardowy');

-- 16. Concordia
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Concordia - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Punkty z kart bogów." },
    "ui": { "title": "Concordia", "description": "Podlicz punkty wg bóstw." },
    "categories": [
        { "id": "vesta", "name": "Vesta (Pieniądze)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "1 pkt za każde 10 sestercji." },
        { "id": "jupiter", "name": "Jupiter (Domy)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Karty x Domy (niebędące cegłą)." },
        { "id": "saturn", "name": "Saturn (Prowincje)", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Karty x Liczba prowincji." },
        { "id": "mercury", "name": "Merkury (Rodzaje Towarów)", "color": "#607D8B", "input_type": "number", "default": 0, "description": "Karty x Liczba rodzajów produkowanych towarów." },
        { "id": "mars", "name": "Mars (Koloniści)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Karty x Liczba kolonistów na planszy." },
        { "id": "minerva", "name": "Minerwa (Specjalistyczne)", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Punkty za konkretne rodzaje miast." },
        { "id": "concordia", "name": "Karta Concordia", "color": "#009688", "input_type": "number", "default": 7, "description": "7 punktów dla posiadacza karty." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (16, @id_plugin, 'Standardowy');

-- 17. Wingspan
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Wingspan (Na Skrzydłach) - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Standardowy notes punktacji." },
    "ui": { "title": "Na Skrzydłach", "description": "Wpisz wyniki z notesu." },
    "categories": [
        { "id": "birds", "name": "Punkty z Ptaków", "color": "#795548", "input_type": "number", "default": 0, "description": "Suma punktów nadrukowanych na kartach." },
        { "id": "bonus", "name": "Karty Bonusowe", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty z celów osobistych." },
        { "id": "goals", "name": "Cele Końca Rundy", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty z planszy celów." },
        { "id": "eggs", "name": "Jaja", "color": "#F06292", "input_type": "number", "default": 0, "description": "1 punkt za każde jajo." },
        { "id": "food", "name": "Pożywienie na kartach", "color": "#8BC34A", "input_type": "number", "default": 0, "description": "1 punkt za każdy znacznik pożywienia na karcie." },
        { "id": "tucked", "name": "Karty podłożone", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "1 punkt za każdą podłożoną kartę." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (17, @id_plugin, 'Standardowy');

-- 18. Viticulture Essential Edition
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Viticulture - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Wynik z toru." },
    "ui": { "title": "Viticulture", "description": "Podlicz wynik." },
    "categories": [
        { "id": "track", "name": "Punkty Zwycięstwa", "color": "#8BC34A", "input_type": "number", "default": 0, "description": "Wynik z toru punktacji." },
        { "id": "tiebreaker", "name": "Rozstrzyganie remisów (Suma: Liry + Wino)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Opcjonalnie: wpisz sumę wartości pieniędzy i wina w piwnicy." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (18, @id_plugin, 'Standardowy');

-- 19. Everdell
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Everdell - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma punktów z kart i bonusów." },
    "ui": { "title": "Everdell", "description": "Arkusz punktacji." },
    "categories": [
        { "id": "cards_base", "name": "Wartość Kart", "color": "#795548", "input_type": "number", "default": 0, "description": "Suma punktów z zagranych kart." },
        { "id": "cards_bonus", "name": "Karty Punktujące (Fioletowe)", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Punkty z efektów kart fioletowych." },
        { "id": "journey", "name": "Wyprawa", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty za podróż (jesień)." },
        { "id": "events", "name": "Wydarzenia", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty ze zdobytych żetonów wydarzeń." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (19, @id_plugin, 'Standardowy');

-- 20. Orléans
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Orléans - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Zasoby + (Status x Rozwój)." },
    "ui": { "title": "Orléans", "description": "Oblicz wynik końcowy." },
    "categories": [
        { "id": "coins", "name": "Monety", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Suma posiadanych monet." },
        { "id": "goods", "name": "Wartość Towarów", "color": "#795548", "input_type": "number", "default": 0, "description": "Suma wartości żetonów towarów." },
        { "id": "development", "name": "Punkty Rozwoju (Gwiazdki x Obywatele)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Oblicz: (Liczba stacji handlowych + Liczba obywateli) x Poziom na torze rozwoju." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (20, @id_plugin, 'Standardowy');

-- ============================================================
-- PLUGINY DLA GIER 21-30
-- ============================================================

-- 21. A Feast for Odin (Uczta dla Odyna)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('A Feast for Odin - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma punktów dodatnich i ujemnych." },
    "ui": { "title": "Uczta dla Odyna", "description": "Arkusz punktacji." },
    "categories": [
        { "id": "board_neg", "name": "Plansza Główna (Puste Pola)", "color": "#F44336", "input_type": "number", "default": 0, "allow_negative": true, "description": "Wpisz jako liczbę ujemną (-1 za każde pole)." },
        { "id": "islands", "name": "Wyspy i Budynki", "color": "#795548", "input_type": "number", "default": 0, "description": "Suma punktów z wysp i szop (uwzględnij kary za pola jako minusy)." },
        { "id": "ships", "name": "Statki i Emigracja", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty za łodzie, statki i karty emigracji." },
        { "id": "goods", "name": "Wełna, Zioła, Pieniądze", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Suma punktów za towary i srebrniki." },
        { "id": "occupations", "name": "Karty Pomocników", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty zwycięstwa na zagranych kartach." },
        { "id": "final_thing", "name": "Kara za Thing", "color": "#9E9E9E", "input_type": "number", "default": 0, "allow_negative": true, "description": "Wpisz karę za nieodwrócone żetony Thing." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (21, @id_plugin, 'Standardowy');

-- 22. Blood Rage
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Blood Rage - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Chwała z klanu i gry." },
    "ui": { "title": "Blood Rage", "description": "Podlicz punkty Chwały." },
    "categories": [
        { "id": "track", "name": "Chwała z Toru", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie gry (bitwy, wyprawy)." },
        { "id": "stats", "name": "Statystyki Klanu", "color": "#FFC107", "input_type": "number", "default": 0, "description": "10/20 punktów za wymaksowane statystyki." },
        { "id": "quests", "name": "Wyprawy (Karty)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty za zrealizowane karty wypraw." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (22, @id_plugin, 'Standardowy');

-- 23. Root
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Root - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Wynik z toru (zazwyczaj do 30)." },
    "ui": { "title": "Root", "description": "Wpisz wynik końcowy." },
    "categories": [
        { "id": "vp", "name": "Punkty Zwycięstwa", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Ostateczny wynik z toru punktacji." },
        { "id": "domination", "name": "Dominacja (1=Tak, 0=Nie)", "color": "#000000", "input_type": "number", "default": 0, "description": "Wpisz 1 jeśli wygrałeś kartą Dominacji (ignorując punkty)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (23, @id_plugin, 'Standardowy');

-- 24. The Crew: The Quest for Planet Nine
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('The Crew - Log', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Kooperacja." },
    "ui": { "title": "The Crew", "description": "Raport z misji." },
    "categories": [
        { "id": "mission", "name": "Numer Misji", "color": "#3F51B5", "input_type": "number", "default": 1, "description": "Którą misję graliście?" },
        { "id": "attempts", "name": "Liczba Prób", "color": "#F44336", "input_type": "number", "default": 1, "description": "Ile razy podchodziliście do misji?" },
        { "id": "success", "name": "Sukces (1=Tak)", "color": "#4CAF50", "input_type": "number", "default": 1, "description": "Czy misja zakończyła się sukcesem?" }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (24, @id_plugin, 'Dziennik Pokładowy');

-- 25. Ticket to Ride (Wsiąść do Pociągu)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Ticket to Ride - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Trasy + Bilety." },
    "ui": { "title": "Wsiąść do Pociągu", "description": "Podliczanie punktów." },
    "categories": [
        { "id": "routes", "name": "Punkty za Trasy", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty zdobyte za stawianie wagoników." },
        { "id": "tickets_done", "name": "Zrealizowane Bilety", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Suma punktów z biletów na plus." },
        { "id": "tickets_fail", "name": "Niezrealizowane Bilety", "color": "#D32F2F", "input_type": "number", "default": 0, "allow_negative": true, "description": "Suma punktów z biletów na minus (wpisz jako liczbę ujemną)." },
        { "id": "bonus", "name": "Bonusy (Najdłuższa trasa/Globetrotter)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "10 lub 15 punktów za bonusy." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (25, @id_plugin, 'Standardowy');

-- 26. Cascadia
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Cascadia - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Zwierzęta + Siedliska." },
    "ui": { "title": "Kaskadia", "description": "Arkusz natury." },
    "categories": [
        { "id": "bears", "name": "Niedźwiedzie", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty za grupy niedźwiedzi." },
        { "id": "elk", "name": "Wapiti", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Punkty za linie wapiti." },
        { "id": "salmon", "name": "Łososie", "color": "#F06292", "input_type": "number", "default": 0, "description": "Punkty za ciągi łososi." },
        { "id": "hawks", "name": "Jastrzębie", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty za jastrzębie." },
        { "id": "foxes", "name": "Lisy", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty za lisy." },
        { "id": "habitats", "name": "Siedliska (Największe obszary)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty za największe obszary każdego terenu." },
        { "id": "nature", "name": "Żetony Natury", "color": "#FFC107", "input_type": "number", "default": 0, "description": "1 punkt za każdy niewykorzystany żeton." },
        { "id": "bonus", "name": "Bonusy za Przewagi", "color": "#CDDC39", "input_type": "number", "default": 0, "description": "Punkty za posiadanie największych siedlisk w grupie." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (26, @id_plugin, 'Standardowy');

-- 27. Codenames (Tajniacy)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Codenames - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Wygrana drużyny." },
    "ui": { "title": "Tajniacy", "description": "Kto wygrał?" },
    "categories": [
        { "id": "winner", "name": "Zwycięska Drużyna", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "1 = Czerwoni, 2 = Niebiescy." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (27, @id_plugin, 'Standardowy');

-- 28. 7 Wonders (Reprise - dla zachowania ciągłości ID)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('7 Wonders - Scoring (ID 28)', '{
    "meta": { "version": "1.0", "author": "Admin", "score_guide": "Suma kategorii." },
    "ui": { "title": "7 Cudów Świata", "description": "Arkusz punktacji." },
    "categories": [
        { "id": "military", "name": "Konflikty Militarne", "color": "#D32F2F", "input_type": "number", "default": 0, "allow_negative": true, "description": "Czerwone karty." },
        { "id": "treasury", "name": "Skarbiec", "color": "#FBC02D", "input_type": "number", "default": 0, "description": "Monety / 3." },
        { "id": "wonder", "name": "Cud Świata", "color": "#616161", "input_type": "number", "default": 0, "description": "Etapy cudu." },
        { "id": "civilian", "name": "Budowle Cywilne", "color": "#1976D2", "input_type": "number", "default": 0, "description": "Niebieskie karty." },
        { "id": "scientific", "name": "Budowle Naukowe", "color": "#388E3C", "input_type": "number", "default": 0, "description": "Zielone karty." },
        { "id": "commercial", "name": "Budowle Handlowe", "color": "#F57C00", "input_type": "number", "default": 0, "description": "Żółte karty." },
        { "id": "guilds", "name": "Gildie", "color": "#7B1FA2", "input_type": "number", "default": 0, "description": "Fioletowe karty." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (28, @id_plugin, 'Standardowy');

-- 29. Azul
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Azul - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Punkty z gry + Bonusy." },
    "ui": { "title": "Azul", "description": "Podliczanie końcowe." },
    "categories": [
        { "id": "ingame", "name": "Punkty z Gry", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie rund (przesuwanie znacznika)." },
        { "id": "rows", "name": "Bonus - Poziome Linie", "color": "#FFC107", "input_type": "number", "default": 0, "description": "2 punkty za każdą pełną linię poziomą." },
        { "id": "cols", "name": "Bonus - Pionowe Linie", "color": "#FF9800", "input_type": "number", "default": 0, "description": "7 punktów za każdą pełną linię pionową." },
        { "id": "colors", "name": "Bonus - Kolory", "color": "#F44336", "input_type": "number", "default": 0, "description": "10 punktów za każdy komplet 5 kafelków jednego koloru." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (29, @id_plugin, 'Standardowy');

-- 30. Patchwork
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Patchwork - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Guziki - (Puste Pola * 2)." },
    "ui": { "title": "Patchwork", "description": "Oblicz wynik." },
    "categories": [
        { "id": "buttons", "name": "Guziki", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Liczba posiadanych guzików na koniec." },
        { "id": "empty", "name": "Puste Pola (Kara)", "color": "#F44336", "input_type": "number", "default": 0, "allow_negative": true, "description": "Policz puste pola, pomnóż przez 2 i wpisz jako liczbę ujemną (np. -4)." },
        { "id": "special", "name": "Żeton 7x7", "color": "#FFC107", "input_type": "number", "default": 0, "description": "7 punktów jeśli posiadasz żeton specjalny." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (30, @id_plugin, 'Standardowy');
-- ============================================================
-- PLUGINY DLA GIER 31-40
-- ============================================================

-- Ustawienie zmiennej ID użytkownika (Admina)
SET @id_user = 1;

-- 31. Splendor
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Splendor - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Karty + Arystokraci." },
    "ui": { "title": "Splendor", "description": "Suma prestiżu." },
    "categories": [
        { "id": "cards", "name": "Punkty z Kart", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba punktów nadrukowana na kartach rozwoju." },
        { "id": "nobles", "name": "Arystokraci", "color": "#795548", "input_type": "number", "default": 0, "description": "3 punkty za każdego odwiedzonego arystokratę." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (31, @id_plugin, 'Standardowy');

-- 32. Carcassonne
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Carcassonne - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Punkty z planszy + Łąki." },
    "ui": { "title": "Carcassonne", "description": "Podliczanie końcowe." },
    "categories": [
        { "id": "track", "name": "Punkty z Toru", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie gry." },
        { "id": "farmers", "name": "Chłopi (Łąki)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "3 punkty za każde ukończone miasto na łące." },
        { "id": "incomplete", "name": "Niedokończone Obiekty", "color": "#F44336", "input_type": "number", "default": 0, "description": "Drogi (1pkt), Klasztory (1pkt/kafelek), Miasta (1pkt/kafelek)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (32, @id_plugin, 'Standardowy');

-- 33. King of Tokyo (Potwory w Tokio)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('King of Tokyo - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Gwiazdy (PZ) lub Eliminacja." },
    "ui": { "title": "Potwory w Tokio", "description": "Stan końcowy." },
    "categories": [
        { "id": "stars", "name": "Punkty Zwycięstwa (Gwiazdy)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba zdobytych gwiazd (max 20)." },
        { "id": "alive", "name": "Przetrwanie (1=Tak, 0=Nie)", "color": "#4CAF50", "input_type": "number", "default": 1, "description": "Czy Twój potwór przeżył?" }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (33, @id_plugin, 'Standardowy');

-- 34. Love Letter (List Miłosny)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Love Letter - Żetony', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Liczba wygranych rund." },
    "ui": { "title": "List Miłosny", "description": "Liczba żetonów uczucia." },
    "categories": [
        { "id": "tokens", "name": "Żetony Uczucia (Wygrane rundy)", "color": "#E91E63", "input_type": "number", "default": 0, "description": "Liczba kostek/żetonów zdobytych za wygranie rundy." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (34, @id_plugin, 'Standardowy');

-- 35. The Mind
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('The Mind - Poziom', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Kooperacja - osiągnięty poziom." },
    "ui": { "title": "The Mind", "description": "Wynik drużynowy." },
    "categories": [
        { "id": "level", "name": "Osiągnięty Poziom", "color": "#3F51B5", "input_type": "number", "default": 1, "description": "Numer ostatniego ukończonego poziomu." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (35, @id_plugin, 'Wynik Drużynowy');

-- 36. Crokinole
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Crokinole - Wynik Meczu', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Punkty meczowe." },
    "ui": { "title": "Crokinole", "description": "Wynik końcowy." },
    "categories": [
        { "id": "points", "name": "Punkty", "color": "#000000", "input_type": "number", "default": 0, "description": "Suma punktów zdobytych w meczu." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (36, @id_plugin, 'Standardowy');

-- 37. Decrypto
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Decrypto - Żetony', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Przechwycenia vs Nieporozumienia." },
    "ui": { "title": "Decrypto", "description": "Stan żetonów." },
    "categories": [
        { "id": "intercepts", "name": "Żetony Przechwycenia (Białe)", "color": "#Ffffff", "input_type": "number", "default": 0, "description": "2 żetony = Wygrana." },
        { "id": "miscom", "name": "Żetony Nieporozumienia (Czarne)", "color": "#000000", "input_type": "number", "default": 0, "description": "2 żetony = Przegrana." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (37, @id_plugin, 'Standardowy');

-- 38. Sushi Go!
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Sushi Go! - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma 3 rund + desery." },
    "ui": { "title": "Sushi Go!", "description": "Podliczanie posiłku." },
    "categories": [
        { "id": "r1", "name": "Runda 1", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Wynik z pierwszej rundy." },
        { "id": "r2", "name": "Runda 2", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Wynik z drugiej rundy." },
        { "id": "r3", "name": "Runda 3", "color": "#FF5722", "input_type": "number", "default": 0, "description": "Wynik z trzeciej rundy." },
        { "id": "pudding", "name": "Desery (Pudding)", "color": "#E91E63", "input_type": "number", "default": 0, "allow_negative": true, "description": "Punkty dodatnie lub ujemne za desery." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (38, @id_plugin, 'Standardowy');

-- 39. Clank! (Brzdęk!)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Brzdęk! - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma łupów (pod warunkiem wyjścia)." },
    "ui": { "title": "Brzdęk!", "description": "Bogactwa z podziemi." },
    "categories": [
        { "id": "artifact", "name": "Artefakt", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Wartość wyniesionego artefaktu." },
        { "id": "tokens", "name": "Żetony (Jaja, Sekrety, Małpy)", "color": "#8BC34A", "input_type": "number", "default": 0, "description": "Suma punktów na zebranych żetonach." },
        { "id": "gold", "name": "Złoto", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Suma wartości złota." },
        { "id": "cards", "name": "Karty w talii", "color": "#3F51B5", "input_type": "number", "default": 0, "description": "Zielone punkty na kartach w talii." },
        { "id": "mastery", "name": "Mistrzostwo (20)", "color": "#F44336", "input_type": "number", "default": 0, "description": "20 punktów, jeśli wróciłeś na powierzchnię." },
        { "id": "escaped", "name": "Czy przeżyłeś? (1=Tak, 0=Nie)", "color": "#000000", "input_type": "number", "default": 1, "description": "Jeśli zginąłeś w głębinach (brak artefaktu lub czarne pole), wynik to 0." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (39, @id_plugin, 'Standardowy');

-- 40. The Quacks of Quedlinburg (Szarlatani z Pasikurowic)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Szarlatani - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Tor + Rubiny + Pieniądze." },
    "ui": { "title": "Szarlatani z Pasikurowic", "description": "Warzenie mikstur zakończone." },
    "categories": [
        { "id": "vp_track", "name": "Punkty z Toru", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Główne punkty zwycięstwa." },
        { "id": "rubies", "name": "Rubiny (1 za 2)", "color": "#F44336", "input_type": "number", "default": 0, "description": "1 punkt za każde 2 rubiny." },
        { "id": "money", "name": "Pieniądze (1 za 5)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "1 punkt za każde 5 sztuk złota/punktów zakupów." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (40, @id_plugin, 'Standardowy');

-- ============================================================
-- PLUGINY DLA GIER 41-50
-- ============================================================

-- Ustawienie zmiennej ID użytkownika (Admina)
SET @id_user = 1;

-- 41. Cartographers (Kartografowie)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Kartografowie - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Sumowanie dekretów, monet i potworów." },
    "ui": { "title": "Kartografowie", "description": "Podlicz gwiazdki z czterech pór roku." },
    "categories": [
        { "id": "decrees", "name": "Punkty z Dekretów (A+B+C+D)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Suma punktów zdobytych za realizację dekretów we wszystkich porach roku." },
        { "id": "coins", "name": "Monety", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Suma gwiazdek za zebrane monety." },
        { "id": "monsters", "name": "Potwory", "color": "#F44336", "input_type": "number", "default": 0, "allow_negative": true, "description": "Punkty ujemne za nieotoczone pola potworów (wpisz jako liczbę ujemną)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (41, @id_plugin, 'Standardowy');

-- 42. The Resistance: Avalon
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Avalon - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Dobro vs Zło." },
    "ui": { "title": "The Resistance: Avalon", "description": "Wynik rozgrywki." },
    "categories": [
        { "id": "winner", "name": "Zwycięska Strona", "color": "#2196F3", "input_type": "number", "default": 0, "description": "1 = Dobro (Artur), 0 = Zło (Mordred)." },
        { "id": "assassination", "name": "Udany Zamach na Merlina?", "color": "#F44336", "input_type": "number", "default": 0, "description": "1 = Tak, 0 = Nie (tylko jeśli wygrało Dobro)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (42, @id_plugin, 'Standardowy');

-- 43. Just One
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Just One - Wynik Drużynowy', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Liczba odgadniętych haseł (0-13)." },
    "ui": { "title": "Just One", "description": "Wynik wspólny." },
    "categories": [
        { "id": "score", "name": "Liczba Sukcesów", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba kart odgadniętych poprawnie (max 13)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (43, @id_plugin, 'Standardowy');

-- 44. Heat: Pedal to the Metal
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Heat - Wynik Wyścigu', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Pozycja na mecie." },
    "ui": { "title": "Heat", "description": "Rezultat wyścigu." },
    "categories": [
        { "id": "position", "name": "Miejsce na mecie", "color": "#000000", "input_type": "number", "default": 1, "description": "Zajęta pozycja (1, 2, 3...)." },
        { "id": "champ_points", "name": "Punkty Mistrzostw", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trybie sezonu/mistrzostw." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (44, @id_plugin, 'Wyścig');

-- 45. Lost Ruins of Arnak (Zaginiona Wyspa Arnak)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Arnak - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Tor badań + karty + idole + strażnicy." },
    "ui": { "title": "Zaginiona Wyspa Arnak", "description": "Podlicz punkty." },
    "categories": [
        { "id": "research", "name": "Tor Badań (Lupa/Notatnik)", "color": "#3F51B5", "input_type": "number", "default": 0, "description": "Suma punktów za pozycję na torze badań." },
        { "id": "temple", "name": "Kafelki Świątyni", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty ze złotych kafelków świątyni." },
        { "id": "idols", "name": "Idole", "color": "#2196F3", "input_type": "number", "default": 0, "description": "3 punkty za każdego idola (plus puste sloty)." },
        { "id": "guardians", "name": "Pokonani Strażnicy", "color": "#F44336", "input_type": "number", "default": 0, "description": "5 punktów za każdego pokonanego strażnika." },
        { "id": "cards", "name": "Karty (Przedmioty/Artefakty)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty zwycięstwa na kartach w talii." },
        { "id": "fear", "name": "Karty Strachu", "color": "#9E9E9E", "input_type": "number", "default": 0, "allow_negative": true, "description": "-1 punkt za każdą kartę strachu (wpisz jako ujemne)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (45, @id_plugin, 'Standardowy');

-- 46. Marvel Champions: The Card Game
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Marvel Champions - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Kooperacja vs Złoczyńca." },
    "ui": { "title": "Marvel Champions", "description": "Raport starcia." },
    "categories": [
        { "id": "win", "name": "Pokonanie Złoczyńcy (1=Tak)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Czy udało się zredukować życie wroga do 0?" },
        { "id": "threat", "name": "Poziom Zagrożenia (końcowy)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Ile zagrożenia było na planie głównym?" },
        { "id": "hp", "name": "Pozostałe Życie Bohatera", "color": "#E91E63", "input_type": "number", "default": 10, "description": "HP twojej postaci na koniec gry." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (46, @id_plugin, 'Raport Bohatera');

-- 47. Le Havre
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Le Havre - Majątek', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma franków (gotówka + budynki)." },
    "ui": { "title": "Le Havre", "description": "Podlicz majątek." },
    "categories": [
        { "id": "cash", "name": "Gotówka (Franki)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Ilość posiadanych pieniędzy." },
        { "id": "buildings", "name": "Wartość Budynków", "color": "#795548", "input_type": "number", "default": 0, "description": "Wartość wszystkich posiadanych budynków i statków." },
        { "id": "bonus", "name": "Bonusy z Budynków", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Dodatkowe punkty z budynków specjalnych." },
        { "id": "loans", "name": "Pożyczki (Kara)", "color": "#F44336", "input_type": "number", "default": 0, "allow_negative": true, "description": "-7 franków za każdą niespłaconą pożyczkę (wpisz ujemnie)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (47, @id_plugin, 'Standardowy');

-- 48. Mage Knight Board Game
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Mage Knight - Sława', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Podliczanie sławy (Fame)." },
    "ui": { "title": "Mage Knight", "description": "Suma punktów sławy." },
    "categories": [
        { "id": "base_fame", "name": "Podstawowa Sława", "color": "#3F51B5", "input_type": "number", "default": 0, "description": "Sława zdobyta w trakcie gry (z toru)." },
        { "id": "achievements", "name": "Osiągnięcia (Miasta/Artefakty)", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty za karty (artefakty, czary, akcje) i miasta." },
        { "id": "crystals", "name": "Kryształy i Jednostki", "color": "#00BCD4", "input_type": "number", "default": 0, "description": "Połowa sławy za jednostki, 1 za kryształ." },
        { "id": "conquest", "name": "Podbój i Przygoda", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Bonusy za podbite lokacje." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (48, @id_plugin, 'Standardowy');

-- 49. Nemesis
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Nemesis - Raport', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Przetrwanie i Cel." },
    "ui": { "title": "Nemesis", "description": "Czy przeżyłeś?" },
    "categories": [
        { "id": "survival", "name": "Przetrwanie (1=Tak)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Czy postać dotarła na Ziemię/Marsa żywa (lub zahibernowana)?" },
        { "id": "objective", "name": "Cel Wykonany (1=Tak)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Czy cel osobisty został spełniony?" },
        { "id": "infection", "name": "Zakażenie (1=Tak)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Czy postać była zarażona larwą na koniec?" }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (49, @id_plugin, 'Raport Końcowy');

-- 50. Mansions of Madness: Second Edition
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Posiadłość Szaleństwa - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Kooperacja." },
    "ui": { "title": "Posiadłość Szaleństwa", "description": "Wynik scenariusza." },
    "categories": [
        { "id": "result", "name": "Zwycięstwo (1=Tak, 0=Nie)", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Czy badacze rozwiązali zagadkę i przeżyli?" },
        { "id": "sanity", "name": "Stan Poczytalności", "color": "#3F51B5", "input_type": "number", "default": 1, "description": "1 = Zdrowy, 0 = Obłąkany." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (50, @id_plugin, 'Standardowy');


-- ============================================================
-- PLUGINY DLA GIER 51-60
-- ============================================================

-- Ustawienie zmiennej ID użytkownika (Admina)
SET @id_user = 1;

-- 51. Through the Ages: A New Story of Civilization
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Through the Ages - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Kultura z toru + Wydarzenia." },
    "ui": { "title": "Cywilizacja: Poprzez Wieki", "description": "Podliczanie punktów kultury." },
    "categories": [
        { "id": "track", "name": "Kultura z Toru", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie gry." },
        { "id": "impact_tech", "name": "Wpływ: Nauka/Kultura", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty z kart wydarzeń (technologie, biblioteki)." },
        { "id": "impact_mil", "name": "Wpływ: Siła Militarna", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty za siłę militarną (wydarzenia)." },
        { "id": "impact_prod", "name": "Wpływ: Produkcja/Żywność", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty za produkcję i rolnictwo." },
        { "id": "impact_pop", "name": "Wpływ: Populacja/Zadowolenie", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty za ludzi i buźki." },
        { "id": "impact_wonder", "name": "Wpływ: Cuda", "color": "#607D8B", "input_type": "number", "default": 0, "description": "Punkty za wybudowane cuda." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (51, @id_plugin, 'Standardowy');

-- 52. Agricola
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Agricola - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Gospodarstwo." },
    "ui": { "title": "Agricola", "description": "Rozliczanie gospodarstwa." },
    "categories": [
        { "id": "fields", "name": "Zaorane Pola", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty za liczbę pól (0-4)." },
        { "id": "pastures", "name": "Pastwiska", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty za liczbę pastwisk (0-4)." },
        { "id": "crops", "name": "Zboże i Warzywa", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Suma punktów za znaczniki zboża i warzyw." },
        { "id": "animals", "name": "Zwierzęta (Owce/Dziki/Krowy)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Suma punktów za zwierzęta (pamiętaj o karze -1 za brak gatunku)." },
        { "id": "unused", "name": "Niewykorzystane Pola", "color": "#9E9E9E", "input_type": "number", "default": 0, "allow_negative": true, "description": "-1 punkt za każde puste pole planszy (wpisz ujemnie)." },
        { "id": "house", "name": "Dom i Rodzina", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Izby (zależnie od surowca) + 3 pkt za każdego członka rodziny." },
        { "id": "cards", "name": "Punkty z Kart/Usprawnień", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Punkty bonusowe z kart." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (52, @id_plugin, 'Standardowy');

-- 53. Power Grid (Wysokie Napięcie)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Wysokie Napięcie - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Zasilone miasta + Elektro." },
    "ui": { "title": "Wysokie Napięcie", "description": "Stan sieci." },
    "categories": [
        { "id": "cities", "name": "Zasilone Miasta", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Główne kryterium zwycięstwa." },
        { "id": "money", "name": "Pieniądze (Elektro)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Pozostała gotówka (rozstrzyga remisy)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (53, @id_plugin, 'Standardowy');

-- 54. Barrage
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Barrage - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Tor VP + Cele." },
    "ui": { "title": "Barrage", "description": "Podliczanie energii i celów." },
    "categories": [
        { "id": "vp_track", "name": "Punkty z Toru", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie rund." },
        { "id": "objective", "name": "Kafel Celu", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty za cel końcowy gry." },
        { "id": "resources", "name": "Zasoby/Woda", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty za pozostałe krople wody i surowce (wg tabeli)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (54, @id_plugin, 'Standardowy');

-- 55. The Gallerist
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('The Gallerist - Pieniądze', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Pieniądze = Punkty." },
    "ui": { "title": "The Gallerist", "description": "Suma majątku." },
    "categories": [
        { "id": "cash", "name": "Gotówka", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Posiadane pieniądze." },
        { "id": "art", "name": "Dzieła Sztuki", "color": "#E91E63", "input_type": "number", "default": 0, "description": "Wartość posiadanych dzieł." },
        { "id": "collections", "name": "Kolekcje i Cele", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Bonusy za zestawy dzieł i cele kustosza." },
        { "id": "influence", "name": "Wpływy/Bilety", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Przelicznik wpływów i biletów na pieniądze." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (55, @id_plugin, 'Standardowy');

-- 56. Tzolk\'in: The Mayan Calendar
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Tzolk\'in - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Punkty + Zasoby + Monumenty." },
    "ui": { "title": "Tzolk\'in", "description": "Koniec kalendarza." },
    "categories": [
        { "id": "vp_track", "name": "Punkty z Toru", "color": "#8BC34A", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie gry." },
        { "id": "monuments", "name": "Monumenty", "color": "#607D8B", "input_type": "number", "default": 0, "description": "Punkty z wybudowanych monumentów." },
        { "id": "resources", "name": "Surowce (Kukurydza)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Przelicz kukurydzę i surowce na punkty (1 kukurydza = 1/4 pkt)." },
        { "id": "skulls", "name": "Kryształowe Czaszki", "color": "#2196F3", "input_type": "number", "default": 0, "description": "3 punkty za każdą posiadaną czaszkę." },
        { "id": "temples", "name": "Świątynie", "color": "#F44336", "input_type": "number", "default": 0, "description": "Ostateczna punktacja świątyń (jeśli nie wliczona w tor)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (56, @id_plugin, 'Standardowy');

-- 57. Anachrony
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Anachrony - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Punkty + Oś Czasu." },
    "ui": { "title": "Anachrony", "description": "Przyszłość nadeszła." },
    "categories": [
        { "id": "vp_ingame", "name": "Punkty z Gry", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty z żetonów VP zdobytych w trakcie." },
        { "id": "buildings", "name": "Budynki i Superprojekty", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Punkty nadrukowane na kafelkach." },
        { "id": "timeline", "name": "Podróże w Czasie", "color": "#673AB7", "input_type": "number", "default": 0, "description": "Punkty za tor podróży w czasie." },
        { "id": "evacuation", "name": "Warunek Ewakuacji", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty za spełnienie warunku ewakuacji (jeśli nastąpiła)." },
        { "id": "morale", "name": "Morale", "color": "#FFEB3B", "input_type": "number", "default": 0, "description": "Punkty za tor morale." },
        { "id": "water", "name": "Zasoby (Woda/Inne)", "color": "#03A9F4", "input_type": "number", "default": 0, "description": "1 punkt za każdą Wodę/Zasób (zwykle)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (57, @id_plugin, 'Standardowy');

-- 58. Kingdom Death: Monster
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('KDM - Raport Starcia', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Przetrwanie." },
    "ui": { "title": "Kingdom Death: Monster", "description": "Raport z polowania." },
    "categories": [
        { "id": "monster_lvl", "name": "Poziom Potwora", "color": "#000000", "input_type": "number", "default": 1, "description": "Poziom bestii (1, 2, 3)." },
        { "id": "victory", "name": "Zwycięstwo (1=Tak)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Czy potwór został pokonany?" },
        { "id": "deaths", "name": "Śmierci Ocalałych", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Ilu ocalałych zginęło w trakcie starcia?" },
        { "id": "resources", "name": "Zasoby Zdobyte", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba zdobytych kart zasobów." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (58, @id_plugin, 'Raport Starcia');

-- 59. Rising Sun
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Rising Sun - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Zima." },
    "ui": { "title": "Rising Sun", "description": "Punktacja zimowa." },
    "categories": [
        { "id": "vp_track", "name": "Punkty z Toru", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty zdobyte podczas pór roku." },
        { "id": "provinces", "name": "Żetony Prowincji", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty za liczbę unikalnych prowincji wojennych (10/20/30...)." },
        { "id": "winter_cards", "name": "Ulepszenia Zimowe", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty z kart zimowych." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (59, @id_plugin, 'Standardowy');

-- 60. Inis
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Inis - Warunki Zwycięstwa', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Spełnione warunki." },
    "ui": { "title": "Inis", "description": "Sprawdź warunki zwycięstwa." },
    "categories": [
        { "id": "conditions", "name": "Spełnione Warunki", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba spełnionych warunków (Klany/Terytoria/Sanktuaria)." },
        { "id": "deeds", "name": "Żetonyczynów (Deeds)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Liczba posiadanych żetonów (rozstrzyga remisy)." },
        { "id": "brenn", "name": "Brenn (1=Tak)", "color": "#795548", "input_type": "number", "default": 0, "description": "Czy jesteś Brennem? (Ważne przy ostatecznym remisie)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (60, @id_plugin, 'Standardowy');

-- ============================================================
-- PLUGINY DLA GIER 61-70
-- ============================================================

-- Ustawienie zmiennej ID użytkownika (Admina)
SET @id_user = 1;

-- 61. Cosmic Encounter
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Cosmic Encounter - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Liczba kolonii." },
    "ui": { "title": "Cosmic Encounter", "description": "Stan kolonizacji." },
    "categories": [
        { "id": "colonies", "name": "Obce Kolonie", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba kolonii na planetach innych graczy (5 = Wygrana)." },
        { "id": "win", "name": "Zwycięstwo (1=Tak)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Czy wygrałeś (samodzielnie lub wspólnie)?" }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (61, @id_plugin, 'Standardowy');

-- 62. Sheriff of Nottingham (Szeryf z Nottingham)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Szeryf z Nottingham - Majątek', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma złota i wartości towarów." },
    "ui": { "title": "Szeryf z Nottingham", "description": "Podliczanie majątku." },
    "categories": [
        { "id": "coins", "name": "Monety", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Wartość posiadanych monet." },
        { "id": "legal", "name": "Legalne Towary", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Wartość (oraz bonusy Króla/Królowej) za Jabłka, Ser, Chleb, Kurczaki." },
        { "id": "contraband", "name": "Kontrabanda", "color": "#F44336", "input_type": "number", "default": 0, "description": "Wartość towarów z czerwonym tłem." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (62, @id_plugin, 'Standardowy');

-- 63. Five Tribes (Pięć Klanów)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Five Tribes - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma punktów." },
    "ui": { "title": "Pięć Klanów", "description": "Arkusz sułtana." },
    "categories": [
        { "id": "coins", "name": "Złote Monety", "color": "#FFC107", "input_type": "number", "default": 0, "description": "1 punkt za każdą monetę." },
        { "id": "viziers", "name": "Wezyrowie (Żółci) + Przewaga", "color": "#FFEB3B", "input_type": "number", "default": 0, "description": "1 pkt za każdego + 10 pkt za przewagę." },
        { "id": "elders", "name": "Starszyzna (Biali)", "color": "#EEEEEE", "input_type": "number", "default": 0, "description": "2 punkty za każdego." },
        { "id": "djinn", "name": "Dżiny", "color": "#673AB7", "input_type": "number", "default": 0, "description": "Punkty nadrukowane na kartach Dżinów." },
        { "id": "camels", "name": "Wielbłądy (Kontrola)", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty za kontrolowane kafelki." },
        { "id": "merch", "name": "Towary", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty za zestawy towarów." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (63, @id_plugin, 'Standardowy');

-- 64. Istanbul
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Istanbul - Rubiny', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Liczba rubinów (cel: 5 lub 6)." },
    "ui": { "title": "Istanbul", "description": "Wyścig po rubiny." },
    "categories": [
        { "id": "rubies", "name": "Rubiny", "color": "#F44336", "input_type": "number", "default": 0, "description": "Liczba zebranych rubinów." },
        { "id": "tiebreaker", "name": "Remisy (Pieniądze/Towary)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Opcjonalnie: wpisz posiadaną gotówkę dla rozstrzygnięcia remisu." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (64, @id_plugin, 'Standardowy');

-- 65. Raiders of the North Sea (Najeźdźcy z Północy)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Najeźdźcy z Północy - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Tor + Walkirie + Dary." },
    "ui": { "title": "Najeźdźcy z Północy", "description": "Chwała Wikinga." },
    "categories": [
        { "id": "track", "name": "Punkty z Toru", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie gry." },
        { "id": "valkyrie", "name": "Tor Walkirii", "color": "#000000", "input_type": "number", "default": 0, "description": "Punkty za śmierć załogi (tor czarny)." },
        { "id": "armor", "name": "Tor Pancerza", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Punkty za siłę pancerza." },
        { "id": "offerings", "name": "Dary dla Wodza", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty za zrealizowane kafelki darów." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (65, @id_plugin, 'Standardowy');

-- 66. Architects of the West Kingdom (Architekci Zachodniego Królestwa)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Architekci - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Budynki + Katedra + Cnota." },
    "ui": { "title": "Architekci Zachodniego Królestwa", "description": "Podliczanie budowy." },
    "categories": [
        { "id": "buildings", "name": "Wzniesione Budynki", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty nadrukowane na kartach budynków." },
        { "id": "cathedral", "name": "Katedra", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty za poziom budowy katedry." },
        { "id": "virtue", "name": "Tor Cnoty", "color": "#E91E63", "input_type": "number", "default": 0, "description": "Punkty (dodatnie lub ujemne) z toru cnoty." },
        { "id": "resources", "name": "Złoto/Marmur (1 pkt)", "color": "#607D8B", "input_type": "number", "default": 0, "description": "1 punkt za każde złoto lub marmur." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (66, @id_plugin, 'Standardowy');

-- 67. Sagrada
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Sagrada - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Cele + Kostki." },
    "ui": { "title": "Sagrada", "description": "Ocena witraża." },
    "categories": [
        { "id": "public", "name": "Cele Publiczne", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Suma punktów z trzech kart wspólnych." },
        { "id": "private", "name": "Cel Prywatny", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Suma oczek na kościach w twoim kolorze." },
        { "id": "favor", "name": "Znaczniki Uznania", "color": "#FFC107", "input_type": "number", "default": 0, "description": "1 punkt za każdy niewykorzystany znacznik." },
        { "id": "empty", "name": "Puste Pola", "color": "#000000", "input_type": "number", "default": 0, "allow_negative": true, "description": "-1 punkt za każde puste pole w witrażu (wpisz ujemnie)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (67, @id_plugin, 'Standardowy');

-- 68. Kingdomino
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Kingdomino - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Pola x Korony + Bonusy." },
    "ui": { "title": "Kingdomino", "description": "Podlicz królestwo." },
    "categories": [
        { "id": "points", "name": "Punkty z Terytoriów", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Suma iloczynów (Liczba Pól x Liczba Koron) dla każdego obszaru." },
        { "id": "bonus", "name": "Bonusy (Zamek/Harmonia)", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty za zamek na środku lub pełny kwadrat (jeśli gracie z wariantami)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (68, @id_plugin, 'Standardowy');

-- 69. Catan (Osadnicy z Catanu)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Catan - Punkty Zwycięstwa', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Zazwyczaj do 10 punktów." },
    "ui": { "title": "Catan", "description": "Wynik końcowy." },
    "categories": [
        { "id": "settlements", "name": "Osady (1 pkt)", "color": "#8BC34A", "input_type": "number", "default": 2, "description": "Liczba osad na planszy." },
        { "id": "cities", "name": "Miasta (2 pkt)", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Liczba miast na planszy x 2." },
        { "id": "cards", "name": "Karty Rozwoju (VP)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba punktów z kart rozwoju." },
        { "id": "longest_road", "name": "Najdłuższa Droga", "color": "#795548", "input_type": "number", "default": 0, "description": "2 punkty jeśli posiadasz kartę." },
        { "id": "largest_army", "name": "Największa Armia", "color": "#F44336", "input_type": "number", "default": 0, "description": "2 punkty jeśli posiadasz kartę." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (69, @id_plugin, 'Standardowy');

-- 70. Small World
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Small World - Monety', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma monet zwycięstwa." },
    "ui": { "title": "Small World", "description": "Ile złota zebrałeś?" },
    "categories": [
        { "id": "coins", "name": "Monety Zwycięstwa", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Całkowita wartość monet na koniec gry." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (70, @id_plugin, 'Standardowy');

-- ============================================================
-- PLUGINY DLA GIER 71-80
-- ============================================================

-- Ustawienie zmiennej ID użytkownika (Admina)
SET @id_user = 1;

-- 71. Takenoko
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Takenoko - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma celów." },
    "ui": { "title": "Takenoko", "description": "Podlicz punkty z kart celów." },
    "categories": [
        { "id": "plots", "name": "Cele: Działki", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Suma punktów z kart układu działek." },
        { "id": "gardener", "name": "Cele: Ogrodnik", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Suma punktów z kart zadań ogrodnika (bambusy)." },
        { "id": "panda", "name": "Cele: Panda", "color": "#E91E63", "input_type": "number", "default": 0, "description": "Suma punktów z kart zadań pandy (zjedzone bambusy)." },
        { "id": "emperor", "name": "Karta Cesarza", "color": "#2196F3", "input_type": "number", "default": 0, "description": "2 punkty za kartę Cesarza (dla gracza, który skończył grę)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (71, @id_plugin, 'Standardowy');

-- 72. Jaipur
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Jaipur - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma żetonów." },
    "ui": { "title": "Jaipur", "description": "Podlicz bogactwo." },
    "categories": [
        { "id": "goods", "name": "Żetony Towarów", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Suma wartości zebranych żetonów towarów." },
        { "id": "bonus", "name": "Bonusy (3/4/5 kart)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Suma punktów z zakrytych żetonów bonusowych." },
        { "id": "camels", "name": "Wielbłądy", "color": "#795548", "input_type": "number", "default": 0, "description": "5 punktów za posiadanie stada wielbłądów." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (72, @id_plugin, 'Standardowy');

-- 73. Hive (Rój)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Rój - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Otoczenie Królowej." },
    "ui": { "title": "Rój", "description": "Czyja Królowa została otoczona?" },
    "categories": [
        { "id": "win", "name": "Zwycięstwo (1=Tak)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Wpisz 1, jeśli udało Ci się otoczyć Królową przeciwnika." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (73, @id_plugin, 'Standardowy');

-- 74. Santorini
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Santorini - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Wejście na 3. poziom." },
    "ui": { "title": "Santorini", "description": "Kto zdobył szczyt?" },
    "categories": [
        { "id": "win", "name": "Zwycięstwo (1=Tak)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Wpisz 1, jeśli Twój budowniczy stanął na 3. poziomie." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (74, @id_plugin, 'Standardowy');

-- 75. Star Realms
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Star Realms - Autorytet', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Pozostałe punkty życia (Autorytet)." },
    "ui": { "title": "Star Realms", "description": "Stan Autorytetu." },
    "categories": [
        { "id": "authority", "name": "Autorytet (Życie)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Ile punktów życia Ci zostało (0 = Przegrana)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (75, @id_plugin, 'Standardowy');

-- 76. Dominion
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Dominion - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma VP w talii." },
    "ui": { "title": "Dominion", "description": "Podlicz punkty w talii." },
    "categories": [
        { "id": "estates", "name": "Posiadłości (1)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Suma punktów z kart Posiadłość (Estate)." },
        { "id": "duchies", "name": "Powiaty (3)", "color": "#8BC34A", "input_type": "number", "default": 0, "description": "Suma punktów z kart Powiat (Duchy)." },
        { "id": "provinces", "name": "Prowincje (6)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Suma punktów z kart Prowincja (Province)." },
        { "id": "gardens", "name": "Ogrody / Inne", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty z Ogrodów, Klątw (-1) i innych kart królestwa." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (76, @id_plugin, 'Standardowy');

-- 77. Race for the Galaxy
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Race for the Galaxy - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "VP żetony + Karty." },
    "ui": { "title": "Race for the Galaxy", "description": "Podbój galaktyki." },
    "categories": [
        { "id": "chips", "name": "Żetony PZ", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Liczba punktów w żetonach." },
        { "id": "table", "name": "Karty na stole", "color": "#3F51B5", "input_type": "number", "default": 0, "description": "Suma wartości (sześciokątów) wyłożonych kart." },
        { "id": "dev6", "name": "Bonusy (Karty 6-kosztowe)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty zmienne z drogich dewelopmentów (? w sześciokącie)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (77, @id_plugin, 'Standardowy');

-- 78. Sherlock Holmes Consulting Detective
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Sherlock Holmes - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Odpowiedzi minus Tropy." },
    "ui": { "title": "Sherlock Holmes CD", "description": "Porównaj się z mistrzem." },
    "categories": [
        { "id": "answers", "name": "Punkty za Odpowiedzi", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty za poprawne odpowiedzi na pytania główne i dodatkowe." },
        { "id": "leads", "name": "Liczba Tropów (Kara)", "color": "#F44336", "input_type": "number", "default": 0, "allow_negative": true, "description": "Odejmij 5 punktów za każdy trop odwiedzony ponad liczbę tropów Sherlocka." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (78, @id_plugin, 'Standardowy');

-- 79. Robinson Crusoe
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Robinson Crusoe - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Kooperacja - Przetrwanie." },
    "ui": { "title": "Robinson Crusoe", "description": "Czy przetrwaliście?" },
    "categories": [
        { "id": "win", "name": "Zwycięstwo (1=Tak)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Czy scenariusz został ukończony?" },
        { "id": "round", "name": "Runda Końcowa", "color": "#FF9800", "input_type": "number", "default": 1, "description": "W której rundzie gra się zakończyła?" },
        { "id": "hp", "name": "Pozostałe Zdrowie", "color": "#F44336", "input_type": "number", "default": 0, "description": "Stan zdrowia postaci na koniec." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (79, @id_plugin, 'Raport Rozbitka');

-- 80. El Grande
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('El Grande - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Tor punktacji." },
    "ui": { "title": "El Grande", "description": "Podlicz wpływy." },
    "categories": [
        { "id": "score", "name": "Punkty z Toru", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Ostateczny wynik na torze punktacji." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (80, @id_plugin, 'Standardowy');


-- ============================================================
-- PLUGINY DLA GIER 81-90
-- ============================================================

-- Ustawienie zmiennej ID użytkownika (Admina)
SET @id_user = 1;

-- 81. Tigris & Euphrates (Eufrat i Tygrys)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Eufrat i Tygrys - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Najsłabszy kolor." },
    "ui": { "title": "Eufrat i Tygrys", "description": "Podlicz kostki." },
    "categories": [
        { "id": "red", "name": "Czerwone (Świątynie)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Liczba kostek czerwonych." },
        { "id": "green", "name": "Zielone (Rynki)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Liczba kostek zielonych." },
        { "id": "black", "name": "Czarne (Królestwa)", "color": "#000000", "input_type": "number", "default": 0, "description": "Liczba kostek czarnych." },
        { "id": "blue", "name": "Niebieskie (Farmy)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Liczba kostek niebieskich." },
        { "id": "gold", "name": "Skarby (Jokery)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba skarbów (zastępują dowolny kolor)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (81, @id_plugin, 'Standardowy');

-- 82. Eclipse: Second Dawn for the Galaxy
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Eclipse - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Reputacja + Sektory + Tech." },
    "ui": { "title": "Eclipse", "description": "Suma punktów." },
    "categories": [
        { "id": "reputation", "name": "Żetony Reputacji (Walka)", "color": "#E91E63", "input_type": "number", "default": 0, "description": "Suma punktów z żetonów reputacji na planszy gracza." },
        { "id": "ambassador", "name": "Żetony Ambasadorów", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Punkty z sojuszy (maks. 3)." },
        { "id": "sectors", "name": "Kontrolowane Sektory", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty za sektory (1-4 za każdy)." },
        { "id": "monoliths", "name": "Monolity", "color": "#000000", "input_type": "number", "default": 0, "description": "3 punkty za każdy kontrolowany monolit." },
        { "id": "discovery", "name": "Żetony Odkryć", "color": "#FF9800", "input_type": "number", "default": 0, "description": "2 punkty za każdy zachowany żeton odkrycia." },
        { "id": "tech", "name": "Drzewo Technologii", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty za liczbę opracowanych technologii." },
        { "id": "species", "name": "Bonus Gatunkowy", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Specjalne punkty dla rasy (np. Magellan)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (82, @id_plugin, 'Standardowy');

-- 83. A Game of Thrones: The Board Game (Gra o Tron)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Gra o Tron - Zamki', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Liczba zamków/twierdzy." },
    "ui": { "title": "Gra o Tron", "description": "Stan panowania." },
    "categories": [
        { "id": "castles", "name": "Zamki i Twierdze", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba kontrolowanych obszarów z zamkiem lub twierdzą (7 = Wygrana)." },
        { "id": "supply", "name": "Zaopatrzenie (Remis)", "color": "#795548", "input_type": "number", "default": 0, "description": "Poziom na torze zaopatrzenia (dla remisów)." },
        { "id": "iron_throne", "name": "Żelazny Tron (Remis)", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Pozycja na torze Żelaznego Tronu (im niższa tym lepiej, wpisz odwrotność lub zignoruj)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (83, @id_plugin, 'Standardowy');

-- 84. Battlestar Galactica
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('BSG - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Ludzie vs Cyloni." },
    "ui": { "title": "Battlestar Galactica", "description": "Kto przetrwał?" },
    "categories": [
        { "id": "humans_win", "name": "Wygrana Ludzi (1=Tak)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Czy skok nr 8 wykonany i zasoby > 0?" },
        { "id": "cylons_win", "name": "Wygrana Cylonów (1=Tak)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Czy Galactica została zniszczona lub zaatakowana?" },
        { "id": "resources", "name": "Najniższy Zasób", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Stan najniższego zasobu na koniec gry." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (84, @id_plugin, 'Raport');

-- 85. Puerto Rico
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Puerto Rico - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "VP Żetony + Budynki." },
    "ui": { "title": "Puerto Rico", "description": "Podliczanie." },
    "categories": [
        { "id": "vp_chips", "name": "Żetony Punktów", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty zdobyte za wysyłkę towarów." },
        { "id": "buildings", "name": "Wartość Budynków", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty nadrukowane na budynkach." },
        { "id": "bonus", "name": "Duże Budynki (Bonus)", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Dodatkowe punkty za spełnienie warunków dużych budynków." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (85, @id_plugin, 'Standardowy');

-- 86. Caverna: The Cave Farmers
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Caverna - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Zwierzęta + Zboże + Budynki." },
    "ui": { "title": "Kawerna", "description": "Bogactwo jaskini." },
    "categories": [
        { "id": "gold", "name": "Złoto", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Suma złota." },
        { "id": "animals", "name": "Zwierzęta (Psy/Owce/Osły/Dziki/Krowy)", "color": "#795548", "input_type": "number", "default": 0, "description": "Suma punktów za zwierzęta." },
        { "id": "goods", "name": "Zboże i Warzywa", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty za zapasy żywności." },
        { "id": "ruby", "name": "Rubiny", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty za rubiny." },
        { "id": "dwarfs", "name": "Krasnoludy", "color": "#2196F3", "input_type": "number", "default": 0, "description": "1 punkt za każdego krasnoluda." },
        { "id": "unused", "name": "Puste Pola", "color": "#9E9E9E", "input_type": "number", "default": 0, "allow_negative": true, "description": "-1 punkt za każde puste pole (wpisz ujemnie)." },
        { "id": "furnishing", "name": "Umeblowanie i Pastwiska", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty z kafelków umeblowania i pastwisk." },
        { "id": "bonus", "name": "Bonusy z Żółtych Kafelków", "color": "#FFEB3B", "input_type": "number", "default": 0, "description": "Dodatkowe punkty z izb bonusowych." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (86, @id_plugin, 'Standardowy');

-- 87. Food Chain Magnate
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Food Chain Magnate - Gotówka', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Tylko gotówka się liczy." },
    "ui": { "title": "Food Chain Magnate", "description": "Stan konta." },
    "categories": [
        { "id": "cash", "name": "Gotówka", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Suma zarobionych pieniędzy." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (87, @id_plugin, 'Standardowy');

-- 88. Grand Austria Hotel
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Grand Austria Hotel - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Tor + Pokoje + Cele." },
    "ui": { "title": "Grand Austria Hotel", "description": "Podlicz prestiż." },
    "categories": [
        { "id": "vp_track", "name": "Punkty z Toru", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie gry." },
        { "id": "staff", "name": "Karty Personelu", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Punkty końcowe z kart personelu." },
        { "id": "politics", "name": "Karty Polityki", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty za zrealizowane cele." },
        { "id": "rooms", "name": "Zajęte Pokoje", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty za zajęte pokoje na poszczególnych piętrach." },
        { "id": "resources", "name": "Zasoby i Pieniądze", "color": "#795548", "input_type": "number", "default": 0, "description": "1 punkt za każdy zasób/koronę." },
        { "id": "emperor", "name": "Tor Cesarza", "color": "#FFEB3B", "input_type": "number", "default": 0, "description": "Bonusy lub kary z toru cesarza." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (88, @id_plugin, 'Standardowy');

-- 89. Yokohama
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Yokohama - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma wszystkiego." },
    "ui": { "title": "Yokohama", "description": "Podliczanie punktów." },
    "categories": [
        { "id": "vp_track", "name": "Punkty z Toru", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie gry." },
        { "id": "church", "name": "Tor Kościoła", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Punkty za wiarę." },
        { "id": "customs", "name": "Tor Celny", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty za cło." },
        { "id": "tech", "name": "Technologie", "color": "#607D8B", "input_type": "number", "default": 0, "description": "Punkty z kart technologii (krajowe i przemysłowe)." },
        { "id": "orders", "name": "Zrealizowane Zamówienia", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Bonus za zestawy flag z zamówień." },
        { "id": "resources", "name": "Zasoby i Pieniądze", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty za pozostałe dobra." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (89, @id_plugin, 'Standardowy');

-- 90. Champions of Midgard
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Champions of Midgard - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Chwała + Potwory." },
    "ui": { "title": "Champions of Midgard", "description": "Chwała Wikinga." },
    "categories": [
        { "id": "glory", "name": "Chwała z Toru", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie gry." },
        { "id": "monsters", "name": "Zestawy Potworów", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty za zestawy 3 kolorów (Troll, Draugr, Potwór)." },
        { "id": "journey", "name": "Karty Podróży (Runy)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Punkty z kart losu." },
        { "id": "ship", "name": "Prywatny Statek", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty za posiadanie własnego statku." },
        { "id": "resources", "name": "Złoto/Pochylnie (1 za 3)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "1 punkt za każde 3 sztuki złota." },
        { "id": "blame", "name": "Żetony Hańby", "color": "#000000", "input_type": "number", "default": 0, "allow_negative": true, "description": "Punkty ujemne za hańbę (wpisz ujemnie)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (90, @id_plugin, 'Standardowy');

-- ============================================================
-- PLUGINY DLA GIER 91-100
-- ============================================================

-- Ustawienie zmiennej ID użytkownika (Admina)
SET @id_user = 1;

-- 91. Lords of Waterdeep
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Lords of Waterdeep - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Tor + Bonusy Lorda." },
    "ui": { "title": "Lords of Waterdeep", "description": "Podliczanie wpływów." },
    "categories": [
        { "id": "vp_track", "name": "Punkty z Toru", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie gry (za questy)." },
        { "id": "lord_bonus", "name": "Bonus Lorda", "color": "#673AB7", "input_type": "number", "default": 0, "description": "Punkty za spełnienie warunków karty Lorda." },
        { "id": "resources", "name": "Zasoby i Złoto", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "1 punkt za każdy awanturnika i każde 2 sztuki złota." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (91, @id_plugin, 'Standardowy');

-- 92. Stone Age (Epoka Kamienia)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Epoka Kamienia - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Wioska + Karty Cywilizacji." },
    "ui": { "title": "Epoka Kamienia", "description": "Koniec epoki." },
    "categories": [
        { "id": "track", "name": "Punkty z Toru (Budynki)", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty za wybudowane chaty." },
        { "id": "civ_farmers", "name": "Rolnicy (Mnożnik Żywności)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba rolników na kartach x Poziom rolnictwa." },
        { "id": "civ_tools", "name": "Twórcy (Mnożnik Narzędzi)", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Liczba twórców na kartach x Liczba narzędzi." },
        { "id": "civ_builders", "name": "Budowniczowie (Mnożnik Budynków)", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Liczba budowniczych na kartach x Liczba budynków." },
        { "id": "civ_shamans", "name": "Szamani (Mnożnik Ludzi)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Liczba szamanów na kartach x Liczba ludzi." },
        { "id": "civ_green", "name": "Karty Kultury (Zestawy)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty za zestawy zielonych kart (symboli)." },
        { "id": "resources", "name": "Pozostałe Zasoby", "color": "#607D8B", "input_type": "number", "default": 0, "description": "1 punkt za każdy pozostały surowiec." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (92, @id_plugin, 'Standardowy');

-- 93. Biblios
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Biblios - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Punkty z wygranych kości." },
    "ui": { "title": "Biblios", "description": "Podlicz skryptorium." },
    "categories": [
        { "id": "dice", "name": "Punkty Zwycięstwa", "color": "#3F51B5", "input_type": "number", "default": 0, "description": "Suma oczek na zdobytych kościach kategorii." },
        { "id": "gold", "name": "Złoto (Remis)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Posiadane złoto (rozstrzyga remisy)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (93, @id_plugin, 'Standardowy');

-- 94. Bohnanza (Fasolki)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Fasolki - Złoto', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Liczba monet." },
    "ui": { "title": "Fasolki", "description": "Ile zarobiłeś na fasolach?" },
    "categories": [
        { "id": "coins", "name": "Złote Monety", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba monet (rewersy kart)." },
        { "id": "cards_hand", "name": "Karty na ręku (Remis)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Liczba kart na ręku (rozstrzyga remisy)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (94, @id_plugin, 'Standardowy');

-- 95. Skull
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Skull - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Liczba wygranych licytacji." },
    "ui": { "title": "Skull", "description": "Stan gry." },
    "categories": [
        { "id": "wins", "name": "Punkty (Wygrane rundy)", "color": "#E91E63", "input_type": "number", "default": 0, "description": "Liczba zdobytych żetonów (2 = Wygrana)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (95, @id_plugin, 'Standardowy');

-- 96. Dixit
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Dixit - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Tor punktacji." },
    "ui": { "title": "Dixit", "description": "Wynik z toru." },
    "categories": [
        { "id": "score", "name": "Punkty", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Ostateczna pozycja króliczka na torze." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (96, @id_plugin, 'Standardowy');

-- 97. Mysterium
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Mysterium - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Kooperacja." },
    "ui": { "title": "Mysterium", "description": "Czy duch zaznał spokoju?" },
    "categories": [
        { "id": "win", "name": "Zwycięstwo (1=Tak)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Czy poprawnie wskazano sprawcę?" },
        { "id": "rounds", "name": "Pozostałe Godziny", "color": "#607D8B", "input_type": "number", "default": 0, "description": "Ile godzin (rund) zostało do końca gry." },
        { "id": "insight", "name": "Poziom Jasnowidzenia (Osobisty)", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Indywidualny wynik na torze jasnowidzenia." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (97, @id_plugin, 'Standardowy');

-- 98. Hanabi
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Hanabi - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma gwiazdek 0-25." },
    "ui": { "title": "Hanabi", "description": "Pokaz fajerwerków." },
    "categories": [
        { "id": "score", "name": "Wynik Końcowy", "color": "#F44336", "input_type": "number", "default": 0, "description": "Suma wartości na stosach (max 25)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (98, @id_plugin, 'Standardowy');

-- 99. No Thanks! (Prezencik)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('No Thanks! - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Im mniej tym lepiej." },
    "ui": { "title": "Prezencik", "description": "Podlicz punkty karne." },
    "categories": [
        { "id": "cards", "name": "Wartość Kart", "color": "#F44336", "input_type": "number", "default": 0, "description": "Suma wartości zebranych kart (tylko najniższe w ciągu)." },
        { "id": "chips", "name": "Żetony (Odejmij)", "color": "#4CAF50", "input_type": "number", "default": 0, "allow_negative": true, "description": "Wpisz liczbę żetonów jako wartość ujemną (np. -5)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (99, @id_plugin, 'Standardowy');

-- 100. For Sale (Na Sprzedaż)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Na Sprzedaż - Majątek', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Czeki + Gotówka." },
    "ui": { "title": "Na Sprzedaż", "description": "Podlicz zarobek." },
    "categories": [
        { "id": "cheques", "name": "Czeki", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Suma wartości zdobytych czeków." },
        { "id": "coins", "name": "Pozostała Gotówka", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Niewydane monety (1000$ = 1 pkt? Wpisz pełną kwotę w tysiącach)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (100, @id_plugin, 'Standardowy');

-- ============================================================
-- PLUGINY DLA GIER 101-110
-- ============================================================

-- Ustawienie zmiennej ID użytkownika (Admina)
SET @id_user = 1;

-- 101. Air, Land, & Sea (Powietrze, Ląd i Morze)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Air, Land, & Sea - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma punktów z bitew." },
    "ui": { "title": "Powietrze, Ląd i Morze", "description": "Wynik wojny." },
    "categories": [
        { "id": "score", "name": "Punkty Zwycięstwa", "color": "#F44336", "input_type": "number", "default": 0, "description": "Łączna liczba punktów zdobyta we wszystkich bitwach (zazwyczaj do 12)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (101, @id_plugin, 'Standardowy');

-- 102. Arboretum
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Arboretum - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Ścieżki drzew." },
    "ui": { "title": "Arboretum", "description": "Podlicz alejki." },
    "categories": [
        { "id": "paths", "name": "Punkty za Ścieżki", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Suma punktów za wszystkie punktowane ścieżki (pamiętaj o prawie do punktowania)." },
        { "id": "bonuses", "name": "Bonusy (1 i 8)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Dodatkowe punkty za początek z 1 lub koniec z 8." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (102, @id_plugin, 'Standardowy');

-- 103. Carcassonne: Inns & Cathedrals (Karczmy i Katedry)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Carcassonne I&C - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Tor + Łąki + Bonusy." },
    "ui": { "title": "Carcassonne: KiK", "description": "Podliczanie z dodatkiem." },
    "categories": [
        { "id": "track", "name": "Punkty z Toru", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie gry." },
        { "id": "farmers", "name": "Łąki (Chłopi)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty za miasta na łąkach." },
        { "id": "cathedrals", "name": "Katedry (Bonus)", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Extra punkty za ukończone miasta z katedrą (3pkt/kafel)." },
        { "id": "inns", "name": "Karczmy (Bonus)", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Extra punkty za ukończone drogi z karczmą (2pkt/kafel)." },
        { "id": "incomplete", "name": "Niedokończone (0 za Katedry/Karczmy!)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty za pozostałe obiekty." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (103, @id_plugin, 'Rozszerzony');

-- 104. Coloretto
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Coloretto - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "3 Kolory na plus, reszta na minus." },
    "ui": { "title": "Coloretto", "description": "Liczba kameleonów." },
    "categories": [
        { "id": "positive", "name": "Punkty Dodatnie (3 zestawy)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Suma punktów z 3 największych zestawów kolorów." },
        { "id": "negative", "name": "Punkty Ujemne (Pozostałe)", "color": "#F44336", "input_type": "number", "default": 0, "allow_negative": true, "description": "Suma punktów z pozostałych kolorów (wpisz jako liczbę ujemną)." },
        { "id": "jokers", "name": "Bonusy (+2)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty z kart +2." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (104, @id_plugin, 'Standardowy');

-- 105. Hanamikoji
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Hanamikoji - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Gejsze lub Urok." },
    "ui": { "title": "Hanamikoji", "description": "Przychylność Gejsz." },
    "categories": [
        { "id": "geishas", "name": "Liczba Gejsz", "color": "#E91E63", "input_type": "number", "default": 0, "description": "Liczba pozyskanych Gejsz (4 = Wygrana)." },
        { "id": "charm", "name": "Suma Uroku", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Suma punktów uroku na pozyskanych Gejszach (11 = Wygrana)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (105, @id_plugin, 'Standardowy');

-- 106. Herd Mentality
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Herd Mentality - Krowy', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Liczba krów." },
    "ui": { "title": "Herd Mentality", "description": "Stan stada." },
    "categories": [
        { "id": "cows", "name": "Liczba Krów", "color": "#E91E63", "input_type": "number", "default": 0, "description": "Liczba zdobytych żetonów krów (8 = Wygrana)." },
        { "id": "gold_cow", "name": "Złota Krowa (1=Tak)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Jeśli masz Złotą Krowę, nie możesz wygrać (wpisz 1)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (106, @id_plugin, 'Standardowy');

-- 107. High Society
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('High Society - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Status (o ile nie jesteś najbiedniejszy)." },
    "ui": { "title": "High Society", "description": "Luksus i bankructwo." },
    "categories": [
        { "id": "status", "name": "Punkty Statusu", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Suma punktów z kart luksusu (pomniejszona o karty hańby)." },
        { "id": "money", "name": "Pozostała Gotówka", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Gracz z najmniejszą ilością gotówki odpada (wpisz 0 pkt statusu)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (107, @id_plugin, 'Standardowy');

-- 108. The Hobbit Card Game
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Hobbit Gra Karciana - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Dobra vs Zło." },
    "ui": { "title": "Hobbit Karcianka", "description": "Podział łupów i ran." },
    "categories": [
        { "id": "wins", "name": "Wygrane Lewy", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Liczba wziętych lew (jeśli punktowane)." },
        { "id": "damage", "name": "Obrażenia/Złe Karty", "color": "#F44336", "input_type": "number", "default": 0, "allow_negative": true, "description": "Punkty ujemne za hełmy orków / Smauga (dla Dobra)." },
        { "id": "points", "name": "Punkty (Gwiazdki)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty dodatnie za białe gwiazdki." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (108, @id_plugin, 'Standardowy');

-- 109. Innovation (Innowacje)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Innowacje - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Dominacje." },
    "ui": { "title": "Innowacje", "description": "Rozwój cywilizacji." },
    "categories": [
        { "id": "dominations", "name": "Dominacje", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Liczba zdobytych kart dominacji (główny cel)." },
        { "id": "influence", "name": "Wpływy (Remis)", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Punkty wpływów (rozstrzyga remisy)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (109, @id_plugin, 'Standardowy');

-- 110. Lewis & Clark
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Lewis & Clark - Wyścig', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Wyścig do Fort Clatsop." },
    "ui": { "title": "Lewis & Clark", "description": "Ekspedycja." },
    "categories": [
        { "id": "finished", "name": "Ukończono (1=Tak)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Czy dotarłeś do Fort Clatsop?" },
        { "id": "camp", "name": "Pozostały Dystans", "color": "#795548", "input_type": "number", "default": 0, "allow_negative": true, "description": "Ile pól brakuje do mety (im mniej tym lepiej, dla przegranych)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (110, @id_plugin, 'Wyścig');

-- ============================================================
-- PLUGINY DLA GIER 111-120
-- ============================================================

-- Ustawienie zmiennej ID użytkownika (Admina)
SET @id_user = 1;

-- 111. Magical Athlete
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Magical Athlete - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma punktów z wyścigów." },
    "ui": { "title": "Magical Athlete", "description": "Podlicz punkty drużyny." },
    "categories": [
        { "id": "race_points", "name": "Punkty z Wyścigów", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Suma punktów zdobytych przez wszystkich zawodników gracza." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (111, @id_plugin, 'Standardowy');

-- 112. Mal Trago
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Mal Trago - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Ostatni żywy goblin." },
    "ui": { "title": "Mal Trago", "description": "Kto przetrwał?" },
    "categories": [
        { "id": "alive", "name": "Przetrwanie (1=Tak)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Czy Twój goblin przeżył?" },
        { "id": "potions", "name": "Wypite Mikstury", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Liczba wypitych mikstur (dla statystyki)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (112, @id_plugin, 'Standardowy');

-- 113. Monopoly: European Edition
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Monopoly - Majątek', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Gotówka + Nieruchomości." },
    "ui": { "title": "Monopoly", "description": "Podlicz majątek." },
    "categories": [
        { "id": "cash", "name": "Gotówka", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Posiadane pieniądze." },
        { "id": "properties", "name": "Wartość Nieruchomości", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Wartość działek, domów i hoteli (zazwyczaj tylko gotówka się liczy, chyba że gra na czas)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (113, @id_plugin, 'Majątek');

-- 114. Munchkin
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Munchkin - Poziom', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Poziom postaci." },
    "ui": { "title": "Munchkin", "description": "Kto wbił 10 poziom?" },
    "categories": [
        { "id": "level", "name": "Poziom Postaci", "color": "#FF9800", "input_type": "number", "default": 1, "description": "Twój ostateczny poziom (10 = Wygrana)." },
        { "id": "gear", "name": "Siła Ekwipunku", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Siła bojowa z przedmiotów (dla remisu/statystyki)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (114, @id_plugin, 'Standardowy');

-- 115. Oath: Chronicles of Empire and Exile
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Oath - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Spełnienie Warunku Zwycięstwa." },
    "ui": { "title": "Oath", "description": "Historia Imperium." },
    "categories": [
        { "id": "win", "name": "Zwycięstwo (1=Tak)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Czy wygrałeś (Kanclerz/Uzurpator/Wizjoner)?" },
        { "id": "role", "name": "Rola (1=Kanclerz, 2=Obywatel, 3=Wygnaniec)", "color": "#2196F3", "input_type": "number", "default": 3, "description": "Twoja rola na koniec gry." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (115, @id_plugin, 'Standardowy');

-- 116. Oh My Gods!
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Oh My Gods! - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Pierwszy z 3 punktami." },
    "ui": { "title": "Oh My Gods!", "description": "Podlicz punkty." },
    "categories": [
        { "id": "score", "name": "Punkty", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Liczba punktów (zazwyczaj gra do 3)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (116, @id_plugin, 'Standardowy');

-- 117. Pax Renaissance
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Pax Renaissance - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Zwycięstwo przez patronat." },
    "ui": { "title": "Pax Renaissance", "description": "Zwycięstwo." },
    "categories": [
        { "id": "win", "name": "Wygrana (1=Tak)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Czy ogłosiłeś zwycięstwo?" },
        { "id": "type", "name": "Typ Zwycięstwa (1=Imp, 2=Glob, 3=Rep, 4=Św)", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Rodzaj zwycięstwa: 1=Imperialne, 2=Globalizacja, 3=Republikańskie, 4=Święte." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (117, @id_plugin, 'Standardowy');

-- 118. Radlands
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Radlands - Obozy', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Zniszczenie obozów wroga." },
    "ui": { "title": "Radlands", "description": "Stan obozów." },
    "categories": [
        { "id": "camps_left", "name": "Twoje Obozy", "color": "#4CAF50", "input_type": "number", "default": 3, "description": "Liczba Twoich niezniszczonych obozów (0 = Przegrana)." },
        { "id": "enemy_destroyed", "name": "Zniszczone Obozy Wroga", "color": "#F44336", "input_type": "number", "default": 0, "description": "Ile obozów przeciwnika zniszczyłeś (3 = Wygrana)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (118, @id_plugin, 'Standardowy');

-- 119. The Red Cathedral (Czerwona Katedra)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Czerwona Katedra - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Prestiż (PZ)." },
    "ui": { "title": "Czerwona Katedra", "description": "Podliczanie prestiżu." },
    "categories": [
        { "id": "prestige", "name": "Punkty Prestiżu (Tor)", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty zdobyte w trakcie gry." },
        { "id": "towers", "name": "Ukończone Sekcje", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty za wkład w budowę katedry (większości)." },
        { "id": "resources", "name": "Zasoby (1 za 5)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "1 punkt za każde 5 surowców/rubli." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (119, @id_plugin, 'Standardowy');

-- 120. Scrabble
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Scrabble - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Suma punktów." },
    "ui": { "title": "Scrabble", "description": "Wynik końcowy." },
    "categories": [
        { "id": "score", "name": "Punkty", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Suma punktów ze wszystkich rund (po odjęciu kar za litery)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (120, @id_plugin, 'Standardowy');

-- ============================================================
-- PLUGINY DLA GIER 121-135 (KONIEC LISTY)
-- ============================================================

-- Ustawienie zmiennej ID użytkownika (Admina)
SET @id_user = 1;

-- 121. Spicy
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Spicy - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Karty + Trofea." },
    "ui": { "title": "Spicy", "description": "Kocice i przyprawy." },
    "categories": [
        { "id": "cards", "name": "Wygrane Karty", "color": "#F44336", "input_type": "number", "default": 0, "description": "1 punkt za każdą wygraną kartę." },
        { "id": "trophies", "name": "Trofea", "color": "#FFC107", "input_type": "number", "default": 0, "description": "10 punktów za każde zdobyte trofeum." },
        { "id": "bonus", "name": "Bonus za Wygraną", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Dodatkowe punkty za pozbycie się kart." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (121, @id_plugin, 'Standardowy');

-- 122. Splito
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Splito - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Mnożenie wartości przez cele." },
    "ui": { "title": "Splito", "description": "Wynik indywidualny." },
    "categories": [
        { "id": "score", "name": "Punkty Zwycięstwa", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Obliczony wynik końcowy (wspólne strefy)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (122, @id_plugin, 'Standardowy');

-- 123. Sushi Go! 10th Anniversary
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Sushi Go 10th - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "3 rundy + desery." },
    "ui": { "title": "Sushi Go! 10th", "description": "Uczta sushi." },
    "categories": [
        { "id": "r1", "name": "Runda 1", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Wynik z pierwszej rundy." },
        { "id": "r2", "name": "Runda 2", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Wynik z drugiej rundy." },
        { "id": "r3", "name": "Runda 3", "color": "#FF5722", "input_type": "number", "default": 0, "description": "Wynik z trzeciej rundy." },
        { "id": "dessert", "name": "Desery", "color": "#E91E63", "input_type": "number", "default": 0, "allow_negative": true, "description": "Punkty z deserów (również ujemne)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (123, @id_plugin, 'Standardowy');

-- 124. Take 5 (6. nimmt!)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('6. bierze - Punkty Karne', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Liczba byczych głów (ujemne)." },
    "ui": { "title": "6. bierze!", "description": "Wpisz punkty karne." },
    "categories": [
        { "id": "bullheads", "name": "Bycze Głowy (Punkty Karne)", "color": "#F44336", "input_type": "number", "default": 0, "allow_negative": true, "description": "Wpisz sumę byczych głów jako liczbę ujemną (np. -15)." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (124, @id_plugin, 'Standardowy');

-- 125. Talisman: Revised 4th Edition
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Talisman - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Korona Władzy." },
    "ui": { "title": "Magia i Miecz", "description": "Kto zdobył Koronę?" },
    "categories": [
        { "id": "win", "name": "Zwycięstwo (1=Tak)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Czy dotarłeś do Korony Władzy i pokonałeś rywali?" }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (125, @id_plugin, 'Standardowy');

-- 126. Targi
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Targi - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Karty Plemienia + Towary." },
    "ui": { "title": "Targi", "description": "Podliczanie punktów." },
    "categories": [
        { "id": "cards", "name": "Karty Plemienia", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty nadrukowane na kartach." },
        { "id": "rows", "name": "Bonusy za Rzędy", "color": "#FFC107", "input_type": "number", "default": 0, "description": "4 punkty za każdy rząd tych samych symboli, 2 za różne." },
        { "id": "goods", "name": "Znaczniki Zwycięstwa", "color": "#9E9E9E", "input_type": "number", "default": 0, "description": "Srebrne krzyżyki zdobyte w trakcie gry." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (126, @id_plugin, 'Standardowy');

-- 127. Terraforming Mars: Colonies
-- (Jako dodatek, użyjemy standardowego arkusza Terraformacji Marsa)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Terraformacja Marsa: Kolonie', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "TR + Plansza + Karty." },
    "ui": { "title": "TM: Kolonie", "description": "Arkusz końcowy." },
    "categories": [
        { "id": "tr", "name": "Współczynnik Terraformacji (TR)", "color": "#F44336", "input_type": "number", "default": 20, "description": "Twój bazowy TR na koniec gry." },
        { "id": "awards", "name": "Nagrody i Tytuły", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty za ufundowane Nagrody i Tytuły." },
        { "id": "greencity", "name": "Plansza (Zieleń/Miasta)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty za obszary zieleni i miasta." },
        { "id": "cards", "name": "Punkty z Kart", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Symbole Jowisza, zwierzęta, mikroby i inne VP na kartach." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (127, @id_plugin, 'Standardowy');

-- 128. Terraforming Mars: Prelude
-- (Jako dodatek, użyjemy standardowego arkusza Terraformacji Marsa)
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Terraformacja Marsa: Preludium', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "TR + Plansza + Karty." },
    "ui": { "title": "TM: Preludium", "description": "Arkusz końcowy." },
    "categories": [
        { "id": "tr", "name": "Współczynnik Terraformacji (TR)", "color": "#F44336", "input_type": "number", "default": 20, "description": "Twój bazowy TR na koniec gry." },
        { "id": "awards", "name": "Nagrody i Tytuły", "color": "#FF9800", "input_type": "number", "default": 0, "description": "Punkty za ufundowane Nagrody i Tytuły." },
        { "id": "greencity", "name": "Plansza (Zieleń/Miasta)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Punkty za obszary zieleni i miasta." },
        { "id": "cards", "name": "Punkty z Kart", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Symbole Jowisza, zwierzęta, mikroby i inne VP na kartach." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (128, @id_plugin, 'Standardowy');

-- 129. Ticket to Ride: Europe
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Wsiąść do Pociągu: Europa', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Trasy + Bilety + Dworce." },
    "ui": { "title": "TTR: Europa", "description": "Podliczanie punktów." },
    "categories": [
        { "id": "routes", "name": "Punkty za Trasy", "color": "#F44336", "input_type": "number", "default": 0, "description": "Punkty zdobyte za stawianie wagoników." },
        { "id": "tickets_done", "name": "Zrealizowane Bilety", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "Suma punktów z biletów na plus." },
        { "id": "tickets_fail", "name": "Niezrealizowane Bilety", "color": "#D32F2F", "input_type": "number", "default": 0, "allow_negative": true, "description": "Suma punktów z biletów na minus." },
        { "id": "stations", "name": "Niewykorzystane Dworce", "color": "#2196F3", "input_type": "number", "default": 0, "description": "4 punkty za każdy zachowany dworzec." },
        { "id": "bonus", "name": "Najdłuższa Trasa (Europe Express)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "10 punktów za bonus." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (129, @id_plugin, 'Standardowy');

-- 130. Tiny Epic Dungeons
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Tiny Epic Dungeons - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Pokonanie Bossa." },
    "ui": { "title": "Tiny Epic Dungeons", "description": "Wynik wyprawy." },
    "categories": [
        { "id": "win", "name": "Zwycięstwo (1=Tak)", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Czy Boss został pokonany przed wyczerpaniem czasu?" }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (130, @id_plugin, 'Standardowy');

-- 131. Tussie Mussie
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Tussie Mussie - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Serca + Zestawy." },
    "ui": { "title": "Tussie Mussie", "description": "Podliczanie bukietu." },
    "categories": [
        { "id": "hearts", "name": "Serca na Kartach", "color": "#E91E63", "input_type": "number", "default": 0, "description": "Liczba serc na kartach w Twoim układzie." },
        { "id": "bonus", "name": "Punkty Bonusowe", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty z efektów kart i zestawów kolorów." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (131, @id_plugin, 'Standardowy');

-- 132. UNO
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('UNO - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Karty przeciwników." },
    "ui": { "title": "UNO", "description": "Wynik rundy." },
    "categories": [
        { "id": "score", "name": "Punkty", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Suma wartości kart, które zostały przeciwnikom na ręce." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (132, @id_plugin, 'Standardowy');

-- 133. Vantage
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Vantage - Wynik', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Dedykacja." },
    "ui": { "title": "Vantage", "description": "Wynik." },
    "categories": [
        { "id": "score", "name": "Punkty", "color": "#2196F3", "input_type": "number", "default": 0, "description": "Ostateczny wynik punktowy." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (133, @id_plugin, 'Standardowy');

-- 134. Village Green
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('Village Green - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Zieleń + Nagrody." },
    "ui": { "title": "Village Green", "description": "Najpiękniejsza wioska." },
    "categories": [
        { "id": "awards", "name": "Karty Nagród", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty z kart nagród (zewnętrznych)." },
        { "id": "ponds", "name": "Stawy", "color": "#2196F3", "input_type": "number", "default": 0, "description": "2 punkty za każdy staw." },
        { "id": "lawns", "name": "Trawniki (Puste)", "color": "#4CAF50", "input_type": "number", "default": 0, "description": "1 punkt za każdą widoczną kartę trawnika." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (134, @id_plugin, 'Standardowy');

-- 135. La Viña
INSERT INTO plugin (nazwa_pluginu, struktura_json, stworzone_przez_id_uzytkownika)
VALUES ('La Viña - Punktacja', '{
    "meta": { "version": "1.0", "author": "System", "score_guide": "Winiarnie + Prestiż." },
    "ui": { "title": "La Viña", "description": "Jakość wina." },
    "categories": [
        { "id": "deliveries", "name": "Dostawy do Winiarni", "color": "#9C27B0", "input_type": "number", "default": 0, "description": "Suma punktów za zrealizowane dostawy." },
        { "id": "prestige", "name": "Prestiż", "color": "#FFC107", "input_type": "number", "default": 0, "description": "Punkty za żetony prestiżu." },
        { "id": "tools", "name": "Narzędzia", "color": "#795548", "input_type": "number", "default": 0, "description": "Punkty za zestawy narzędzi." }
    ]
}', @id_user);
SET @id_plugin = LAST_INSERT_ID();
INSERT INTO arkusz_punktacji (id_planszowki, id_pluginu, nazwa_arkusza) VALUES (135, @id_plugin, 'Standardowy');


COMMIT;

SET FOREIGN_KEY_CHECKS=1;