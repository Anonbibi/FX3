-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Mar 01 Août 2017 à 20:08
-- Version du serveur :  5.7.14
-- Version de PHP :  5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `fx_gfav_n3m`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL,
  `command` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `autoecole_vehicle`
--

CREATE TABLE `autoecole_vehicle` (
  `ID` int(10) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `vehicle_name` varchar(60) DEFAULT NULL,
  `vehicle_model` varchar(60) DEFAULT NULL,
  `vehicle_price` int(60) DEFAULT NULL,
  `vehicle_plate` varchar(60) DEFAULT NULL,
  `vehicle_state` varchar(60) DEFAULT NULL,
  `vehicle_colorprimary` varchar(60) DEFAULT NULL,
  `vehicle_colorsecondary` varchar(60) DEFAULT NULL,
  `vehicle_pearlescentcolor` varchar(60) NOT NULL,
  `vehicle_wheelcolor` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `autoecole_vehicle`
--

INSERT INTO `autoecole_vehicle` (`ID`, `identifier`, `vehicle_name`, `vehicle_model`, `vehicle_price`, `vehicle_plate`, `vehicle_state`, `vehicle_colorprimary`, `vehicle_colorsecondary`, `vehicle_pearlescentcolor`, `vehicle_wheelcolor`) VALUES
(1, 'ip:80.236.125.167	', 'Autoecole', 'rhapsody', 0, 'AUTOECO1', 'Rentré', '1', '1', '0', '156'),
(2, 'ip:80.236.125.167', 'Autoecole', 'rhapsody', 0, 'AUTOECO1', 'Rentré', '1', '1', '0', '156');

-- --------------------------------------------------------

--
-- Structure de la table `bans`
--

CREATE TABLE `bans` (
  `id` int(10) UNSIGNED NOT NULL,
  `banned` varchar(50) NOT NULL DEFAULT '0',
  `banner` varchar(50) NOT NULL,
  `reason` varchar(150) NOT NULL DEFAULT '0',
  `expires` datetime NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `cascade_vehicle`
--

CREATE TABLE `cascade_vehicle` (
  `ID` int(10) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `vehicle_name` varchar(60) DEFAULT NULL,
  `vehicle_model` varchar(60) DEFAULT NULL,
  `vehicle_price` int(60) DEFAULT NULL,
  `vehicle_plate` varchar(60) DEFAULT NULL,
  `vehicle_state` varchar(60) DEFAULT NULL,
  `vehicle_colorprimary` varchar(60) DEFAULT NULL,
  `vehicle_colorsecondary` varchar(60) DEFAULT NULL,
  `vehicle_pearlescentcolor` varchar(60) NOT NULL,
  `vehicle_wheelcolor` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `cascade_vehicle`
--

INSERT INTO `cascade_vehicle` (`ID`, `identifier`, `vehicle_name`, `vehicle_model`, `vehicle_price`, `vehicle_plate`, `vehicle_state`, `vehicle_colorprimary`, `vehicle_colorsecondary`, `vehicle_pearlescentcolor`, `vehicle_wheelcolor`) VALUES
(1, 'ip:83.157.88.182', 'Liberator', 'monster', 0, 'CASCAD01', 'Rentré', '111', '111', '111', '156'),
(2, 'ip:83.157.88.182', 'Marshall', 'marshall', 0, 'CASCAD02', 'Rentré', '1', '1', '0', '156'),
(3, 'ip:83.157.88.182', 'Stalion', 'stalion2', 0, 'CASCAD03', 'Rentré', '1', '1', '0', '156');

-- --------------------------------------------------------

--
-- Structure de la table `chat`
--

CREATE TABLE `chat` (
  `id` int(11) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `clothes_outfits`
--

CREATE TABLE `clothes_outfits` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `category` varchar(50) NOT NULL DEFAULT '0',
  `skin_model` varchar(50) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `arm` int(11) NOT NULL DEFAULT '0',
  `arm_txt` int(11) NOT NULL DEFAULT '0',
  `tshirt` int(11) NOT NULL DEFAULT '0',
  `tshirt_txt` int(11) NOT NULL DEFAULT '0',
  `jacket` int(11) NOT NULL DEFAULT '0',
  `jacket_txt` int(11) NOT NULL DEFAULT '0',
  `pant` int(11) NOT NULL DEFAULT '0',
  `pant_txt` int(11) NOT NULL DEFAULT '0',
  `shoe` int(11) NOT NULL DEFAULT '0',
  `shoe_txt` int(11) NOT NULL DEFAULT '0',
  `glasses` int(11) NOT NULL DEFAULT '0',
  `glasses_txt` int(11) NOT NULL DEFAULT '0',
  `hat` int(11) NOT NULL DEFAULT '0',
  `hat_txt` int(11) NOT NULL DEFAULT '0',
  `mask` int(11) NOT NULL DEFAULT '0',
  `mask_txt` int(11) NOT NULL DEFAULT '0',
  `shield` int(11) NOT NULL DEFAULT '0',
  `shield_txt` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `clothes_outfits`
--

INSERT INTO `clothes_outfits` (`id`, `name`, `category`, `skin_model`, `price`, `arm`, `arm_txt`, `tshirt`, `tshirt_txt`, `jacket`, `jacket_txt`, `pant`, `pant_txt`, `shoe`, `shoe_txt`, `glasses`, `glasses_txt`, `hat`, `hat_txt`, `mask`, `mask_txt`, `shield`, `shield_txt`) VALUES
(3, 'Négligé', 'skincreator', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 22, 1, 5, 0, 12, 6, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Mauvais Goût', 'skincreator', 'mp_m_freemode_01', 1500, 5, 0, 15, 0, 5, 0, 12, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 'Bronzage', 'skincreator', 'mp_m_freemode_01', 1500, 5, 0, 15, 0, 5, 7, 16, 11, 16, 9, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 'Ordinaire', 'skincreator', 'mp_m_freemode_01', 1500, 6, 0, 5, 0, 3, 0, 2, 11, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 'Le Quartier', 'skincreator', 'mp_m_freemode_01', 1500, 6, 0, 5, 2, 7, 0, 7, 12, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 'Sportif', 'skincreator', 'mp_m_freemode_01', 1500, 6, 0, 0, 3, 3, 15, 3, 15, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0),
(21, 'Gangsta', 'skincreator', 'mp_f_freemode_01', 1500, 4, 0, 15, 0, 5, 0, 3, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0),
(22, 'Garçon manqué', 'skincreator', 'mp_f_freemode_01', 1500, 3, 0, 14, 0, 3, 1, 1, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(23, 'Normale', 'skincreator', 'mp_f_freemode_01', 1500, 4, 0, 14, 0, 0, 11, 1, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(24, 'Jeune', 'skincreator', 'mp_f_freemode_01', 1500, 1, 0, 0, 9, 1, 11, 8, 7, 3, 5, 0, 0, 0, 0, 0, 0, 0, 0),
(25, 'Sportive', 'skincreator', 'mp_f_freemode_01', 1500, 1, 0, 22, 2, 10, 0, 14, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(26, 'Diablesse', 'skincreator', 'mp_f_freemode_01', 1500, 15, 0, 15, 0, 4, 13, 2, 2, 11, 3, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 'Street', 'skincreator', 'mp_m_freemode_01', 1500, 4, 0, 15, 0, 14, 13, 9, 7, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 'Loveur', 'skincreator', 'mp_m_freemode_01', 2000, 4, 0, 21, 1, 4, 2, 20, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(9, 'Plage', 'skincreator', 'mp_m_freemode_01', 750, 5, 0, 15, 1, 17, 2, 14, 12, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 'Motard', 'skincreator', 'mp_m_freemode_01', 1500, 4, 0, 27, 2, 37, 1, 24, 6, 26, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(11, 'Barman', 'skincreator', 'mp_m_freemode_01', 2000, 11, 0, 7, 0, 40, 1, 20, 0, 15, 2, 0, 0, 0, 0, 0, 0, 0, 0),
(37, 'Short - Tshirt', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 131, 0, 6, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(13, 'Casual Chic', 'skincreator', 'mp_m_freemode_01', 2000, 4, 0, 11, 2, 142, 0, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(14, 'Casual Liberty', 'skincreator', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 131, 0, 48, 1, 40, 3, 0, 0, 0, 0, 0, 0, 0, 0),
(15, 'BaBaCool', 'skincreator', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 121, 3, 62, 1, 3, 15, 0, 0, 0, 0, 0, 0, 0, 0),
(16, 'BlingBling', 'skincreator', 'mp_m_freemode_01', 2500, 14, 0, 15, 0, 70, 7, 20, 2, 28, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(17, 'Sous vetement', 'skincreator', 'mp_m_freemode_01', 500, 15, 0, 15, 0, 15, 7, 21, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0, 0),
(27, 'Jean\'s', 'skincreator', 'mp_f_freemode_01', 1500, 0, 0, 0, 0, 9, 2, 8, 2, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0),
(28, 'Fatal', 'skincreator', 'mp_f_freemode_01', 1500, 15, 0, 2, 0, 26, 2, 27, 4, 14, 15, 0, 0, 0, 0, 0, 0, 0, 0),
(29, 'Plage', 'skincreator', 'mp_f_freemode_01', 750, 15, 0, 2, 0, 15, 10, 10, 2, 5, 13, 0, 0, 0, 0, 0, 0, 0, 0),
(33, 'Working Girl', 'skincreator', 'mp_f_freemode_01', 2000, 5, 0, 64, 0, 93, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(30, 'Motard', 'skincreator', 'mp_f_freemode_01', 1500, 6, 0, 15, 0, 110, 7, 54, 2, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(31, 'BarMaid', 'skincreator', 'mp_f_freemode_01', 2000, 0, 0, 24, 4, 28, 9, 23, 7, 19, 3, 0, 0, 0, 0, 0, 0, 0, 0),
(38, 'Short - Pull noir', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 134, 0, 6, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(34, 'Casual', 'skincreator', 'mp_f_freemode_01', 1500, 14, 0, 15, 0, 14, 10, 0, 1, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0),
(35, 'BaBaCool', 'skincreator', 'mp_f_freemode_01', 1500, 0, 0, 15, 0, 123, 3, 66, 2, 1, 14, 0, 0, 0, 0, 0, 0, 0, 0),
(36, 'BlingBling', 'skincreator', 'mp_f_freemode_01', 2500, 6, 0, 1, 0, 65, 8, 26, 0, 8, 7, 0, 0, 0, 0, 0, 0, 0, 0),
(39, 'Short - Pull rouge', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 134, 1, 6, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40, 'Short - Pull blanc', '0', 'mp_m_freemode_01', 1500, 0, 0, 15, 0, 134, 2, 6, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41, 'Veste en cuir - Jean', '0', 'mp_m_freemode_01', 2000, 1, 0, 1, 4, 122, 8, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 'Pull à capuche', '0', 'mp_m_freemode_01', 1500, 4, 0, 15, 0, 96, 0, 43, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(43, 'Chic noir', '0', 'mp_m_freemode_01', 1500, 11, 0, 7, 0, 11, 0, 25, 0, 12, 6, 0, 0, 0, 0, 0, 0, 0, 0),
(44, 'Détente au soleil', '0', 'mp_m_freemode_01', 1000, 15, 0, 15, 0, 15, 0, 54, 1, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45, 'Test Lylo', 'skincreator', 'mp_f_freemode_01', 2500, 15, 0, 15, 0, 13, 8, 36, 0, 14, 3, 0, 0, 0, 0, 0, 0, 0, 0),
(46, 'Test Lylo 2', 'skincreator', 'mp_f_freemode_01', 2500, 15, 0, 2, 0, 15, 0, 15, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `clothes_props`
--

CREATE TABLE `clothes_props` (
  `id` int(11) NOT NULL,
  `model` varchar(50) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '500',
  `category` varchar(50) DEFAULT '0',
  `item_id` int(11) DEFAULT '0',
  `item_txt_allowed` varchar(255) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `clothes_props`
--

INSERT INTO `clothes_props` (`id`, `model`, `price`, `category`, `item_id`, `item_txt_allowed`) VALUES
(1, 'mp_m_freemode_01', 500, 'hat', 2, '0'),
(2, 'mp_m_freemode_01', 500, 'hat', 4, '0'),
(3, 'mp_m_freemode_01', 500, 'hat', 5, '0'),
(4, 'mp_m_freemode_01', 500, 'hat', 6, '0'),
(5, 'mp_m_freemode_01', 500, 'hat', 7, '0'),
(6, 'mp_m_freemode_01', 500, 'hat', 12, '0'),
(7, 'mp_m_freemode_01', 500, 'hat', 13, '0'),
(8, 'mp_m_freemode_01', 500, 'hat', 14, '0'),
(9, 'mp_m_freemode_01', 500, 'hat', 15, '0'),
(10, 'mp_m_freemode_01', 500, 'hat', 16, '0'),
(11, 'mp_m_freemode_01', 500, 'hat', 17, '0'),
(12, 'mp_m_freemode_01', 500, 'hat', 18, '0'),
(13, 'mp_m_freemode_01', 500, 'hat', 19, '0'),
(14, 'mp_m_freemode_01', 500, 'hat', 20, '0'),
(15, 'mp_m_freemode_01', 500, 'hat', 21, '0'),
(16, 'mp_m_freemode_01', 500, 'hat', 25, '0'),
(17, 'mp_m_freemode_01', 500, 'hat', 26, '0'),
(18, 'mp_m_freemode_01', 500, 'hat', 27, '0'),
(19, 'mp_m_freemode_01', 500, 'hat', 28, '0'),
(20, 'mp_m_freemode_01', 500, 'hat', 29, '0'),
(21, 'mp_m_freemode_01', 500, 'hat', 30, '0'),
(22, 'mp_m_freemode_01', 500, 'hat', 31, '0'),
(23, 'mp_m_freemode_01', 500, 'hat', 44, '0'),
(24, 'mp_m_freemode_01', 500, 'hat', 45, '0'),
(25, 'mp_m_freemode_01', 500, 'hat', 48, '0'),
(26, 'mp_m_freemode_01', 500, 'hat', 49, '0'),
(27, 'mp_m_freemode_01', 500, 'hat', 50, '0'),
(28, 'mp_m_freemode_01', 500, 'hat', 51, '0'),
(29, 'mp_m_freemode_01', 500, 'hat', 52, '0'),
(30, 'mp_m_freemode_01', 500, 'hat', 53, '0'),
(31, 'mp_m_freemode_01', 500, 'hat', 54, '0'),
(32, 'mp_m_freemode_01', 500, 'hat', 55, '0'),
(33, 'mp_m_freemode_01', 500, 'hat', 56, '0'),
(34, 'mp_m_freemode_01', 500, 'hat', 58, '0'),
(35, 'mp_m_freemode_01', 500, 'hat', 60, '0'),
(36, 'mp_m_freemode_01', 500, 'hat', 61, '0'),
(37, 'mp_m_freemode_01', 500, 'hat', 62, '0'),
(38, 'mp_m_freemode_01', 500, 'hat', 63, '0'),
(39, 'mp_m_freemode_01', 500, 'hat', 64, '0'),
(40, 'mp_m_freemode_01', 500, 'hat', 65, '0'),
(41, 'mp_m_freemode_01', 500, 'hat', 66, '0'),
(42, 'mp_m_freemode_01', 500, 'hat', 67, '0'),
(43, 'mp_m_freemode_01', 500, 'hat', 68, '0'),
(44, 'mp_m_freemode_01', 500, 'hat', 69, '0'),
(45, 'mp_m_freemode_01', 500, 'hat', 70, '0'),
(46, 'mp_m_freemode_01', 500, 'hat', 71, '0'),
(47, 'mp_m_freemode_01', 500, 'hat', 72, '0'),
(48, 'mp_m_freemode_01', 500, 'hat', 73, '0'),
(49, 'mp_m_freemode_01', 500, 'hat', 74, '0'),
(50, 'mp_m_freemode_01', 500, 'hat', 75, '0'),
(51, 'mp_m_freemode_01', 500, 'hat', 76, '0'),
(52, 'mp_m_freemode_01', 500, 'hat', 77, '0'),
(53, 'mp_m_freemode_01', 500, 'hat', 78, '0'),
(54, 'mp_m_freemode_01', 500, 'hat', 79, '0'),
(55, 'mp_m_freemode_01', 500, 'hat', 80, '0'),
(56, 'mp_m_freemode_01', 500, 'hat', 81, '0'),
(57, 'mp_m_freemode_01', 500, 'hat', 82, '0'),
(58, 'mp_f_freemode_01', 500, 'hat', 4, '0'),
(59, 'mp_f_freemode_01', 500, 'hat', 5, '0'),
(60, 'mp_f_freemode_01', 500, 'hat', 6, '0'),
(61, 'mp_f_freemode_01', 500, 'hat', 7, '0'),
(62, 'mp_f_freemode_01', 500, 'hat', 9, '0'),
(63, 'mp_f_freemode_01', 500, 'hat', 12, '0'),
(64, 'mp_f_freemode_01', 500, 'hat', 13, '0'),
(65, 'mp_f_freemode_01', 500, 'hat', 14, '0'),
(66, 'mp_f_freemode_01', 500, 'hat', 15, '0'),
(67, 'mp_f_freemode_01', 500, 'hat', 16, '0'),
(68, 'mp_f_freemode_01', 500, 'hat', 17, '0'),
(69, 'mp_f_freemode_01', 500, 'hat', 18, '0'),
(70, 'mp_f_freemode_01', 500, 'hat', 19, '0'),
(71, 'mp_f_freemode_01', 500, 'hat', 20, '0'),
(72, 'mp_f_freemode_01', 500, 'hat', 21, '0'),
(73, 'mp_f_freemode_01', 500, 'hat', 22, '0'),
(74, 'mp_f_freemode_01', 500, 'hat', 26, '0'),
(75, 'mp_f_freemode_01', 500, 'hat', 27, '0'),
(76, 'mp_f_freemode_01', 500, 'hat', 28, '0'),
(77, 'mp_f_freemode_01', 500, 'hat', 29, '0'),
(78, 'mp_f_freemode_01', 500, 'hat', 43, '0'),
(79, 'mp_f_freemode_01', 500, 'hat', 44, '0'),
(80, 'mp_f_freemode_01', 500, 'hat', 47, '0'),
(81, 'mp_f_freemode_01', 500, 'hat', 48, '0'),
(82, 'mp_f_freemode_01', 500, 'hat', 49, '0'),
(83, 'mp_f_freemode_01', 500, 'hat', 50, '0'),
(84, 'mp_f_freemode_01', 500, 'hat', 51, '0'),
(85, 'mp_f_freemode_01', 500, 'hat', 52, '0'),
(86, 'mp_f_freemode_01', 500, 'hat', 53, '0'),
(87, 'mp_f_freemode_01', 500, 'hat', 54, '0'),
(88, 'mp_f_freemode_01', 500, 'hat', 55, '0'),
(89, 'mp_f_freemode_01', 500, 'hat', 56, '0'),
(90, 'mp_f_freemode_01', 500, 'hat', 57, '0'),
(91, 'mp_f_freemode_01', 500, 'hat', 58, '0'),
(92, 'mp_f_freemode_01', 500, 'hat', 81, '0'),
(93, 'mp_f_freemode_01', 500, 'glasses', 1, '0'),
(94, 'mp_f_freemode_01', 500, 'glasses', 2, '0'),
(95, 'mp_f_freemode_01', 500, 'glasses', 3, '0'),
(96, 'mp_f_freemode_01', 500, 'glasses', 4, '0'),
(97, 'mp_f_freemode_01', 500, 'glasses', 6, '0'),
(98, 'mp_f_freemode_01', 500, 'glasses', 7, '0'),
(99, 'mp_f_freemode_01', 500, 'glasses', 8, '0'),
(100, 'mp_f_freemode_01', 500, 'glasses', 9, '0'),
(101, 'mp_f_freemode_01', 500, 'glasses', 10, '0'),
(102, 'mp_f_freemode_01', 500, 'glasses', 11, '0'),
(103, 'mp_f_freemode_01', 500, 'glasses', 14, '0'),
(104, 'mp_f_freemode_01', 500, 'glasses', 16, '0'),
(105, 'mp_f_freemode_01', 500, 'glasses', 17, '0'),
(106, 'mp_f_freemode_01', 500, 'glasses', 18, '0'),
(107, 'mp_f_freemode_01', 500, 'glasses', 19, '0'),
(108, 'mp_f_freemode_01', 500, 'glasses', 20, '0'),
(109, 'mp_f_freemode_01', 500, 'glasses', 21, '0'),
(110, 'mp_m_freemode_01', 500, 'glasses', 3, '0'),
(111, 'mp_m_freemode_01', 500, 'glasses', 4, '0'),
(112, 'mp_m_freemode_01', 500, 'glasses', 5, '0'),
(113, 'mp_m_freemode_01', 500, 'glasses', 7, '0'),
(114, 'mp_m_freemode_01', 500, 'glasses', 8, '0'),
(115, 'mp_m_freemode_01', 500, 'glasses', 9, '0'),
(116, 'mp_m_freemode_01', 500, 'glasses', 10, '0'),
(117, 'mp_m_freemode_01', 500, 'glasses', 12, '0'),
(118, 'mp_m_freemode_01', 500, 'glasses', 13, '0'),
(119, 'mp_m_freemode_01', 500, 'glasses', 15, '0'),
(120, 'mp_m_freemode_01', 500, 'glasses', 16, '0'),
(121, 'mp_m_freemode_01', 500, 'glasses', 17, '0'),
(122, 'mp_m_freemode_01', 500, 'glasses', 18, '0'),
(123, 'mp_m_freemode_01', 500, 'glasses', 19, '0'),
(124, 'mp_m_freemode_01', 500, 'glasses', 20, '0');

-- --------------------------------------------------------

--
-- Structure de la table `clothes_users_outfits`
--

CREATE TABLE `clothes_users_outfits` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL DEFAULT '0',
  `current` int(11) NOT NULL DEFAULT '0',
  `outfit_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `clothes_users_props`
--

CREATE TABLE `clothes_users_props` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT '0',
  `category` varchar(50) DEFAULT NULL,
  `current` int(11) DEFAULT '0',
  `prop_id` int(11) DEFAULT '0',
  `prop_txt` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `clothes_users_props`
--

INSERT INTO `clothes_users_props` (`id`, `identifier`, `category`, `current`, `prop_id`, `prop_txt`) VALUES
(1, 'steam:11000010e40098f', 'glasses', 1, 115, 0),
(2, 'steam:11000010e40098f', 'hat', 1, 3, 0),
(3, 'steam:11000010578ba32', 'hat', 0, 4, 0),
(4, 'steam:11000010578ba32', 'glasses', 0, 111, 0),
(5, 'steam:11000010578ba32', 'glasses', 1, 113, 0),
(6, 'steam:11000010e40098f', 'hat', 0, 30, 0),
(7, 'steam:1100001070489ef', 'hat', 0, 3, 0),
(8, 'steam:1100001070489ef', 'hat', 1, 30, 0),
(9, 'steam:110000104bc9698', 'hat', 1, 4, 0),
(10, 'steam:110000104bc9698', 'glasses', 1, 113, 0),
(11, 'steam:1100001050cd15d', 'hat', 1, 30, 0),
(12, 'steam:1100001050cd15d', 'hat', 0, 18, 0),
(13, 'steam:1100001050cd15d', 'hat', 0, 39, 0),
(14, 'steam:1100001050cd15d', 'hat', 0, 2, 0),
(15, 'steam:11000010df208ea', 'hat', 1, 30, 0),
(16, 'steam:11000010df208ea', 'glasses', 1, 113, 0),
(17, 'steam:11000010df208ea', 'hat', 0, 6, 0),
(18, 'steam:11000010a7d411e', 'hat', 0, 46, 0),
(19, 'steam:11000010a7d411e', 'hat', 0, 28, 0),
(20, 'steam:110000108765f50', 'hat', 0, 1, 0),
(21, 'steam:110000108765f50', 'glasses', 0, 113, 0),
(22, 'steam:110000109ec04e5', 'glasses', 1, 112, 0),
(23, 'steam:110000109ec04e5', 'hat', 1, 2, 0),
(24, 'steam:11000010c7ed271', 'hat', 1, 29, 0),
(25, 'steam:11000010c7ed271', 'glasses', 1, 114, 0),
(26, 'steam:1100001019c2160', 'hat', 1, 29, 0),
(27, 'steam:110000108765f50', 'hat', 0, 2, 0),
(28, 'steam:11000010269b6a2', 'hat', 0, 6, 0),
(29, 'steam:1100001027d0279', 'glasses', 0, 122, 0),
(30, 'steam:1100001027d0279', 'hat', 1, 30, 0),
(31, 'steam:11000010a7d411e', 'hat', 0, 40, 0),
(32, 'steam:1100001145464ea', 'hat', 0, 28, 0),
(33, 'steam:110000100b36f21', 'hat', 1, 28, 0),
(34, 'steam:110000100b36f21', 'glasses', 1, 116, 0),
(35, 'steam:1100001050cd15d', 'glasses', 1, 113, 0),
(36, 'steam:11000010c8c8341', 'hat', 1, 28, 0),
(37, 'steam:11000010e40098f', 'hat', 0, 39, 0),
(38, 'steam:1100001027d0279', 'hat', 0, 34, 0),
(39, 'steam:1100001027d0279', 'hat', 0, 40, 0),
(40, 'steam:11000010e40098f', 'hat', 0, 5, 0),
(41, 'steam:110000108765f50', 'glasses', 1, 115, 0),
(42, 'steam:1100001145464ea', 'glasses', 1, 122, 0),
(43, 'steam:11000010f529659', 'hat', 1, 33, 0),
(44, 'steam:11000010f529659', 'glasses', 1, 112, 0),
(45, 'steam:1100001196ec9d0', 'glasses', 1, 119, 0),
(46, 'steam:1100001196ec9d0', 'hat', 0, 40, 0),
(47, 'steam:1100001069170dd', 'hat', 0, 6, 0),
(48, 'steam:11000010a6a92b0', 'glasses', 1, 116, 0),
(49, 'steam:11000010269b6a2', 'hat', 0, 21, 0),
(50, 'steam:1100001064a7a93', 'hat', 1, 30, 0),
(51, 'steam:110000104ab323b', 'hat', 1, 41, 0),
(52, 'steam:110000104ab323b', 'glasses', 0, 119, 0),
(53, 'steam:11000010c8c8341', 'hat', 0, 6, 0),
(54, 'steam:11000010578ba32', 'hat', 1, 27, 0),
(55, 'steam:11000010578ba32', 'hat', 0, 6, 0),
(56, 'steam:11000010270be8a', 'glasses', 1, 121, 0),
(57, 'steam:11000010b5324f5', 'glasses', 0, 123, 0),
(58, 'steam:110000106d5ed07', 'hat', 1, 28, 0),
(59, 'steam:110000108ae7fff', 'glasses', 1, 107, 0),
(60, 'steam:11000010e40098f', 'glasses', 0, 122, 0),
(61, 'steam:11000010e40098f', 'glasses', 0, 117, 0),
(62, 'steam:11000010a7d411e', 'hat', 0, 2, 0),
(63, 'steam:11000010a7d411e', 'hat', 0, 4, 0),
(64, 'steam:110000104ab323b', 'hat', 0, 2, 0),
(65, 'steam:11000010b5324f5', 'hat', 0, 3, 0),
(66, 'steam:110000105b6d7cd', 'glasses', 1, 121, 0),
(67, 'steam:110000105b6d7cd', 'hat', 1, 20, 0),
(68, 'steam:11000010a7d411e', 'hat', 1, 22, 0),
(69, 'steam:11000010adf29c5', 'hat', 1, 30, 0),
(70, 'steam:11000010e40098f', 'hat', 0, 9, 0),
(71, 'steam:110000104ab323b', 'hat', 0, 27, 0),
(72, 'steam:11000010c8c8341', 'glasses', 0, 115, 0),
(73, 'steam:110000111b5b1eb', 'hat', 1, 29, 0),
(74, 'steam:11000010889376d', 'glasses', 1, 112, 0),
(75, 'steam:110000106888e01', 'glasses', 1, 122, 0),
(76, 'steam:11000010a6a92b0', 'hat', 1, 29, 0),
(77, 'steam:11000010a6a92b0', 'hat', 0, 5, 0),
(78, 'steam:11000010b5324f5', 'hat', 1, 27, 0),
(79, 'steam:110000117cb4376', 'hat', 1, 28, 0),
(80, 'steam:11000010270be8a', 'hat', 0, 12, 0),
(81, 'steam:11000010270be8a', 'hat', 1, 30, 0),
(82, 'steam:110000117cb4376', 'hat', 0, 3, 0),
(83, 'steam:11000010adf29c5', 'hat', 0, 7, 0),
(84, 'steam:11000010adf29c5', 'glasses', 1, 116, 0),
(85, 'steam:110000117cb4376', 'glasses', 0, 114, 0),
(86, 'steam:110000117cb4376', 'hat', 0, 19, 0),
(87, 'steam:110000117cb4376', 'hat', 0, 33, 0),
(88, 'steam:110000117cb4376', 'glasses', 1, 121, 0),
(89, 'steam:110000117cb4376', 'hat', 0, 6, 0),
(90, 'steam:110000117cb4376', 'glasses', 0, 112, 0),
(91, 'steam:11000010adf29c5', 'hat', 0, 5, 0),
(92, 'steam:1100001145464ea', 'hat', 0, 5, 0),
(93, 'steam:1100001145464ea', 'hat', 0, 24, 0),
(94, 'steam:1100001145464ea', 'hat', 0, 33, 0),
(95, 'steam:110000104ab323b', 'hat', 0, 39, 0),
(96, 'steam:110000104ab323b', 'glasses', 0, 120, 0),
(97, 'steam:1100001027d0279', 'glasses', 0, 112, 0),
(98, 'steam:1100001027d0279', 'hat', 0, 6, 0),
(99, 'steam:1100001027d0279', 'hat', 0, 21, 0),
(100, 'steam:11000010b5324f5', 'glasses', 0, 117, 0),
(101, 'steam:110000108765f50', 'hat', 1, 27, 0),
(102, 'steam:1100001069170dd', 'hat', 1, 29, 0),
(103, 'steam:11000010269b6a2', 'hat', 1, 30, 0),
(104, 'steam:110000104ab323b', 'glasses', 1, 112, 0),
(105, 'steam:1100001027d0279', 'glasses', 1, 115, 0),
(106, 'steam:1100001196ec9d0', 'hat', 1, 27, 0),
(107, 'steam:11000010f17ada9', 'glasses', 1, 123, 0),
(108, 'steam:11000010f17ada9', 'hat', 1, 29, 0),
(109, 'steam:1100001069f1e65', 'hat', 1, 27, 0),
(110, 'steam:11000010c8c8341', 'glasses', 1, 114, 0),
(111, 'steam:11000010c8c8341', 'hat', 0, 2, 0),
(112, 'steam:11000011262d25d', 'hat', 0, 3, 0),
(113, 'steam:11000011262d25d', 'hat', 0, 1, 0),
(114, 'steam:1100001044d80e2', 'hat', 1, 28, 0),
(115, 'steam:1100001044d80e2', 'glasses', 1, 112, 0),
(116, 'steam:11000010b5324f5', 'glasses', 1, 124, 0),
(117, 'steam:1100001060b800f', 'hat', 0, 9, 0),
(118, 'steam:1100001060b800f', 'hat', 1, 29, 0),
(119, 'steam:1100001060b800f', 'hat', 0, 6, 0),
(120, 'steam:1100001027d0279', 'hat', 0, 42, 0),
(121, 'steam:11000011262d25d', 'hat', 1, 27, 0),
(122, 'steam:1100001060b800f', 'glasses', 1, 122, 0),
(123, 'steam:11000011abb0d0b', 'hat', 0, 21, 0),
(124, 'steam:11000011abb0d0b', 'hat', 0, 6, 0),
(125, 'steam:11000011abb0d0b', 'hat', 0, 27, 0),
(126, 'steam:11000011abb0d0b', 'hat', 1, 30, 0),
(127, 'steam:11000011abb0d0b', 'glasses', 0, 112, 0),
(128, 'steam:11000011abb0d0b', 'glasses', 1, 115, 0),
(129, 'steam:11000011abb0d0b', 'hat', 0, 2, 0),
(130, 'steam:1100001145464ea', 'hat', 1, 30, 0);

-- --------------------------------------------------------

--
-- Structure de la table `coffrelspd`
--

CREATE TABLE `coffrelspd` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `solde` varchar(10) NOT NULL,
  `lasttransfert` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `coffrelspd`
--

INSERT INTO `coffrelspd` (`id`, `identifier`, `solde`, `lasttransfert`) VALUES
(1, 'steam:1100001070489ef', '3628648', '13000');

-- --------------------------------------------------------

--
-- Structure de la table `coffremine`
--

CREATE TABLE `coffremine` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `ca` varchar(10) NOT NULL,
  `solde` varchar(10) NOT NULL,
  `sale` varchar(10) NOT NULL,
  `lasttransfert` varchar(10) NOT NULL,
  `entreprise` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `coffremine`
--

INSERT INTO `coffremine` (`id`, `identifier`, `ca`, `solde`, `sale`, `lasttransfert`, `entreprise`) VALUES
(1, 'steam:11000011abb0d0b', '8997022', '551241', '6420368', '66000', 'Metal Co'),
(2, 'steam:11000010e40098f', '5000000', '4700001', '0', '300000', 'Gouvernement'),
(3, 'steam:110000105b6d7cd', '1058991', '940906', '734321', '100000', 'Bucheron'),
(4, '', '1000', '1000', '1000', '0', 'TequiLaLa'),
(5, 'steam:11000010c8c8341', '4000', '5510', '1490', '1000', 'Garrage Carreno'),
(6, '', '1000', '1000', '1000', '0', 'Eco Taxi');

-- --------------------------------------------------------

--
-- Structure de la table `commands`
--

CREATE TABLE `commands` (
  `id` int(11) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL,
  `command` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `coordinates`
--

CREATE TABLE `coordinates` (
  `id` int(11) UNSIGNED NOT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `coordinates`
--

INSERT INTO `coordinates` (`id`, `x`, `y`, `z`) VALUES
(4, 2477.70239257813, -401.587371826172, 94.8190231323242),
(5, 154.047317504883, -746.245727539063, 242.151977539063),
(6, 1417.51257324219, 6339.32373046875, 24.3983821868896),
(7, 2328.89526367188, 2571.3037109375, 46.6769371032715),
(8, -2253.71069335938, 233.639923095703, 174.606887817383),
(9, -1149.40832519531, 4940.5615234375, 222.26872253418),
(13, 288.269836425781, -1775.34997558594, 28.4219989776611),
(14, 141.223419189453, -3110.16064453125, 5.89630699157715),
(15, -1381.94372558594, -614.571105957031, 31.4979038238525),
(16, 2156.95629882813, 3385.71533203125, 45.6220855712891),
(17, 1119.68017578125, -2015.09460449219, 35.6227264404297),
(18, 1273.87280273438, -1708.31628417969, 54.7714385986328),
(19, -1763.41442871094, -262.681091308594, 48.2089042663574),
(20, 250.657516479492, -1349.09777832031, 24.5378131866455),
(21, 2441.33422851563, 4976.5771484375, 46.8105545043945),
(22, 328.586059570313, 6473.61962890625, 29.8534069061279),
(23, 1062.802734375, -2407.45703125, 29.9821376800537),
(24, -372.136413574219, 194.208862304688, 84.0617980957031),
(25, 67.5528, 3695.29, 39.255),
(26, 1057.56, -3200.79, -39.9001),
(27, -110.851, -10.5289, 70.5196),
(28, -424.174, 2064.56, 119.671),
(29, 3534.36, 3660.11, 28.1219),
(30, 244.552, 368.221, 105.738),
(31, 1906.7, 4837.09, 45.76),
(32, -2167.52, 5197.33, 16.38),
(33, 1415.18, 1161.44, 114.174),
(34, 148.665, -739.001, 258.152),
(35, 2330.08, 2569.09, 46.67),
(36, 1160.81, -3195.81, -39.008),
(37, 1093.39, -3196.47, -38.99),
(38, 1129.18, -3194.24, -40.39),
(39, -2152.45, 234.919, 184.602),
(40, 3563.23, 3673.45, 27.7219),
(41, 1007.63, -3197.73, -38.39),
(42, -1407.72, -617.348, 39.6094);

-- --------------------------------------------------------

--
-- Structure de la table `garages`
--

CREATE TABLE `garages` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `x` decimal(10,2) NOT NULL,
  `y` decimal(10,2) NOT NULL,
  `z` decimal(10,2) NOT NULL,
  `price` int(11) NOT NULL,
  `blip_colour` int(255) NOT NULL,
  `blip_id` int(255) NOT NULL,
  `slot` int(255) NOT NULL,
  `available` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `gouv`
--

CREATE TABLE `gouv` (
  `identifier` varchar(255) NOT NULL,
  `rank` varchar(255) NOT NULL DEFAULT 'Recrue'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `gouv`
--

INSERT INTO `gouv` (`identifier`, `rank`) VALUES
('steam:1100001050cd15d', 'Agent'),
('steam:11000010c7ed271', 'Agent'),
('steam:11000010e40098f', 'Agent');

-- --------------------------------------------------------

--
-- Structure de la table `gouve_vehicle`
--

CREATE TABLE `gouve_vehicle` (
  `ID` int(10) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `vehicle_name` varchar(60) DEFAULT NULL,
  `vehicle_model` varchar(60) DEFAULT NULL,
  `vehicle_price` int(60) DEFAULT NULL,
  `vehicle_plate` varchar(60) DEFAULT NULL,
  `vehicle_state` varchar(60) DEFAULT NULL,
  `vehicle_colorprimary` varchar(60) DEFAULT NULL,
  `vehicle_colorsecondary` varchar(60) DEFAULT NULL,
  `vehicle_pearlescentcolor` varchar(60) NOT NULL,
  `vehicle_wheelcolor` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `gouve_vehicle`
--

INSERT INTO `gouve_vehicle` (`ID`, `identifier`, `vehicle_name`, `vehicle_model`, `vehicle_price`, `vehicle_plate`, `vehicle_state`, `vehicle_colorprimary`, `vehicle_colorsecondary`, `vehicle_pearlescentcolor`, `vehicle_wheelcolor`) VALUES
(1, 'ip:82.236.178.158', 'Kuruma', 'kuruma2', 0, 'GOUV0001', 'Rentré', '1', '1', '1', '156'),
(2, 'ip:82.243.98.90', 'Kuruma', 'kuruma2', 0, 'GOUV0002', 'Rentré', '1', '1', '1', '156'),
(3, 'ip:176.150.86.154', 'Kuruma', 'kuruma2', 0, 'GOUV0003', 'Rentré', '1', '1', '1', '156'),
(4, 'ip:82.243.98.90', 'Schafter V12 B', 'schafter5', 0, 'GOUV0004', 'Rentré', '1', '1', '1', '156'),
(5, 'ip:82.243.98.90', 'XLS B', 'xls2', 0, 'GOUV0005', 'Rentré', '1', '1', '1', '156'),
(6, 'ip:82.243.98.90', 'Baller Lw8 B', 'baller6', 0, 'GOUV0006', 'Rentré', '1', '1', '1', '156'),
(8, 'ip:82.243.98.90', 'Volatus', 'volatus', 0, 'GOUV0007', 'Rentré', '1', '1', '1', '156'),
(9, 'ip:82.236.178.158', 'Kuruma2', 'kuruma', 0, 'GOUV0009', 'Rentré', '1', '1', '1', '156');

-- --------------------------------------------------------

--
-- Structure de la table `hcdh`
--

CREATE TABLE `hcdh` (
  `identifier` varchar(255) NOT NULL,
  `rank` varchar(255) NOT NULL DEFAULT 'Recrue'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `hcdh`
--

INSERT INTO `hcdh` (`identifier`, `rank`) VALUES
('steam:110000108ae7fff', 'Membre');

-- --------------------------------------------------------

--
-- Structure de la table `interiors`
--

CREATE TABLE `interiors` (
  `id` int(11) NOT NULL COMMENT 'key id',
  `enter` text NOT NULL COMMENT 'enter coords',
  `exit` text NOT NULL COMMENT 'destination coords',
  `iname` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `interiors`
--

INSERT INTO `interiors` (`id`, `enter`, `exit`, `iname`) VALUES
(1, '{-1388.24,-586.854,30.2176,90}', '{-1387.61,-588.068,30.3195,90}', 'mamas'),
(2, '{1151.8,-1529.4,35.1842,321.7075}', '{275.169,-1360.71,24.5378,321.7075}', 'Urgences GFAV'),
(4, '{-596.538,2090.51,131.413,0.0}', '{-595.353,2086.71,131.381,0.0}', 'Mine Abandonnee'),
(5, '{437.27,-978.2,30.6896,0.0}', '{418.104,-1003.35,-99.0044,0.0}', 'Salle d interogatoire'),
(6, '{-85.611,835.005,235.52,0.0}', '{1398.04,1141.78,114.394,0.0}', 'Maison Du Président De GFAV'),
(7, '{1223.58,-481.998,66.3967,0.0}', '{1066.38,-3183.27,-39.164,0.0}', 'Smoke Weed Every Day'),
(8, '{84.1342,191.221,105.257,0.0}', '{1173.68,-3196.7,-39.008,0.0}', '???????????????????'),
(9, '{1304.22,314.158,82.001,0.0}', '{1088.75,-3190.17,-38.9935,0.0}', 'De quoi tuer un cheval'),
(10, '{258.777,-1357.02,30.15,0.0}', '{1118.75,-3193.37,-40.39,0.0}', 'De quoi bien dormir'),
(11, '{-77.512,-822.449,243.386,0.0}', '{-66.8711,-822.103,321.287,0.0}', 'Heli perso'),
(12, '{139.253,-613.53,44.8187,0.0}', '{112.974,-638.77,206.047,0.0}', 'IAA'),
(13, '{136.325,-761.283,242.152,0.0}', '{136.212,-761.383,45.752,0.0}', 'FBI Ascenseur 1'),
(14, '{136.257,-762.112,234.152,0.0}', '{139.383,-762.227,45.7521,0.0}', 'FBI Ascenseur 2'),
(15, '{485.779,-1529.79,28.88,0.0}', '{997.627,-3200.62,-36.3937,0.0}', 'Suivez le lapin blanc'),
(16, '{-13.7757,6480.69,31.1242,0.0}', '{998.408,-3157.92,-38.9071,0.0}', 'Hels Angel'),
(17, '{3540.73,3676.02,20.9918,0.0}', '{3540.74,3676.16,28.1211,0.0}', 'Labo Acsenceur');

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `id` int(11) UNSIGNED NOT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `isIllegal` tinyint(1) NOT NULL DEFAULT '0',
  `canUse` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `items`
--

INSERT INTO `items` (`id`, `libelle`, `isIllegal`, `canUse`) VALUES
(1, 'Minerai', 0, 0),
(2, 'Metal', 0, 0),
(3, 'Or', 0, 0),
(4, 'Cannabis', 1, 0),
(5, 'Farine', 0, 0),
(6, 'Eau', 0, 1),
(7, 'Feuille de Coca', 1, 0),
(8, 'Joint', 1, 3),
(9, 'Lingot', 0, 0),
(10, 'Blé', 0, 0),
(11, 'Meth', 1, 3),
(12, 'Meth Transformée', 1, 3),
(13, 'Feuille de sassafras', 1, 0),
(14, 'Ecstasy', 1, 3),
(15, 'Pierre précieuse', 1, 0),
(16, 'Bijoux', 1, 0),
(17, 'Organe Sale', 1, 0),
(18, 'Organe Stérilisé', 1, 0),
(19, 'Bois Brut', 0, 0),
(20, 'Planche', 0, 0),
(21, 'poisson', 0, 0),
(22, 'Filet de Poisson', 0, 2),
(23, 'Viande fraiche', 0, 2),
(24, 'Orge', 0, 0),
(25, 'Bière', 0, 3),
(26, 'Raisin', 0, 2),
(27, 'Bouteille de vin', 0, 3),
(28, 'Cocaine', 1, 3),
(29, 'Documents secrets', 1, 0),
(30, 'Jambon Beurre', 0, 2),
(31, 'faux papiers', 1, 0),
(32, 'Opium', 1, 0),
(33, 'Heroine', 1, 0),
(34, 'Kebab', 0, 2),
(35, 'Cola', 0, 1),
(36, 'Limonade', 0, 1),
(37, 'Pomme', 0, 2),
(38, 'Café', 0, 1),
(39, 'Orange', 0, 2),
(40, 'Banane', 0, 2),
(42, 'Barre Choco', 0, 2),
(43, 'Diamant brut', 1, 0),
(44, 'Diamant', 1, 0),
(45, 'Ergot de seigle', 1, 0),
(46, 'LSD 25', 1, 5),
(47, 'DD Crypté', 1, 0),
(48, 'DD Décrypté', 1, 0),
(49, 'Kétamine Cheval', 1, 5),
(50, 'Kétamine diluée ', 1, 3),
(51, 'GABA', 1, 3),
(52, 'GHB', 1, 5),
(53, 'amphétamine brute', 1, 5),
(54, 'amphétamine basé', 1, 5),
(99, 'GPS', 0, 0),
(100, 'Champagne', 0, 3),
(101, 'Vodka', 0, 0),
(102, 'Whisky\r\n', 0, 0),
(103, 'Rhum', 0, 0),
(104, 'Tequi-La-La', 0, 0),
(105, 'Vodka-Bull', 0, 0),
(106, 'Whisky-Cola', 0, 0),
(107, 'Rhum-Cola', 0, 0),
(108, 'Tequi-Cola', 0, 0),
(109, 'Tequi-Juice', 0, 0),
(110, 'Tequi-Coffee', 0, 0),
(111, 'Tequi-Tea', 0, 0),
(112, 'Tequi-Limo', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `job_id` int(11) NOT NULL,
  `job_name` varchar(40) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT '500'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `jobs`
--

INSERT INTO `jobs` (`job_id`, `job_name`, `salary`) VALUES
(1, 'Chomeur', 500),
(2, '[LSPD] Recrue', 1200),
(3, 'futurservice', 1500),
(4, 'futurjob2', 500),
(5, 'futurjob', 500),
(6, 'Fermier', 1000),
(7, 'Bucheron', 1000),
(8, 'Gang', 1),
(9, 'Mineur', 1000),
(10, 'Pecheur', 1000),
(11, 'Docker', 500),
(12, 'Brasseur', 1000),
(13, 'Vigneron', 1000),
(14, 'Livreur', 500),
(15, 'Ambulancier', 2500),
(16, 'Mecano', 2000),
(17, 'Taxi', 2000),
(20, '[LSPD] Brigadier', 1500),
(21, '[LSPD] Sergent', 2000),
(22, '[LSPD] Lieutenant', 2500),
(23, '[LSPD] Capitaine', 3500),
(24, '[GOUV] Agent', 5000),
(25, '[GOUV] President', 10000),
(26, '[HCDH] Representent', 5500),
(27, '[BOSS] Metal co', 0),
(28, '[$] Grand Bandit', 0),
(29, '[LSPD] Brigadier-Chef', 1750),
(30, '[LSPD] Sergent-Chef', 2250),
(31, '[LSPD] Lieutenant-Chef', 3000),
(32, '[LSPD] Commandant', 4250),
(33, '[BOSS] LBDL', 0),
(34, '[BOSS] TequiLaLa', 0),
(35, '[BOSS] Garage Carreno', 0),
(36, '[BOSS] Eco Taxi', 0),
(37, '[ASSO] Evenews', 4000);

-- --------------------------------------------------------

--
-- Structure de la table `licences`
--

CREATE TABLE `licences` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `licences`
--

INSERT INTO `licences` (`id`, `name`, `price`) VALUES
(1, 'De conduire', 1000),
(2, 'De port d\'arme', 5000);

-- --------------------------------------------------------

--
-- Structure de la table `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isRead` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `phone_users_contacts`
--

CREATE TABLE `phone_users_contacts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `number` varchar(10) NOT NULL,
  `display` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `police`
--

CREATE TABLE `police` (
  `identifier` varchar(255) NOT NULL,
  `rank` varchar(255) NOT NULL DEFAULT 'Recrue'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `police`
--

INSERT INTO `police` (`identifier`, `rank`) VALUES
('steam:110000100B36F21', 'Sergent'),
('steam:11000010270be8a', 'AgentGouv'),
('steam:1100001044D80E2', 'Sergent'),
('steam:110000104ab323b', 'Brigadier'),
('steam:1100001054070BD', 'BrigadierChef'),
('steam:11000010578ba32', 'AgentGouv'),
('steam:1100001064A7A93', 'Lieutenant'),
('steam:110000106D5ED07', 'Sergent'),
('steam:1100001070489ef', 'Commandant'),
('steam:11000010a7d411e', 'BrigadierChef');

-- --------------------------------------------------------

--
-- Structure de la table `police_vehicle`
--

CREATE TABLE `police_vehicle` (
  `ID` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `vehicle_name` varchar(60) DEFAULT NULL,
  `vehicle_model` varchar(60) DEFAULT NULL,
  `vehicle_price` int(11) DEFAULT NULL,
  `vehicle_plate` varchar(60) DEFAULT NULL,
  `vehicle_state` varchar(60) DEFAULT NULL,
  `vehicle_colorprimary` varchar(60) DEFAULT '112',
  `vehicle_colorsecondary` varchar(60) DEFAULT '141',
  `vehicle_pearlescentcolor` varchar(60) NOT NULL,
  `vehicle_wheelcolor` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `police_vehicle`
--

INSERT INTO `police_vehicle` (`ID`, `identifier`, `vehicle_name`, `vehicle_model`, `vehicle_price`, `vehicle_plate`, `vehicle_state`, `vehicle_colorprimary`, `vehicle_colorsecondary`, `vehicle_pearlescentcolor`, `vehicle_wheelcolor`) VALUES
(1, 'steam:1100001070489ef', 'Porche', 'pol718', 0, 'POLICE01', 'Rentré', '1', '1', '0', '156'),
(6, 'steam:1100001070489ef', 'BAC', 'fbi', 0, 'POLICE02', 'Rentré', '1', '1', '0', '156'),
(7, 'réserve2', 'POLICE3', 'police', 0, 'POLICE03', 'Rentré', '112', '141', '0', '156'),
(8, 'ip:80.236.125.167', 'POLICE4', 'Police3', 0, 'POLICE04', 'Rentré', '112', '141', '0', '156'),
(9, 'steam:1100001070489ef', 'Moto', 'policeb', 0, 'POLICE06', 'Rentré', '112', '141', '0', '156'),
(10, 'steam:1100001070489ef', 'Van', 'policet', 0, 'POLICE07', 'Rentré', '112', '141', '0', '156'),
(11, 'steam:1100001070489ef', 'Riot', 'riot', 0, 'POLICE08', 'Rentré', '112', '141', '0', '156'),
(12, 'steam:1100001070489ef', 'Sheriff 1', 'sheriff', 0, 'POLICE09', 'Rentré', '112', '141', '0', '156'),
(13, 'ip:90.113.12.69', 'FORD', 'police7', 0, 'POLICE10', 'Rentré', '112', '141', '0', '156'),
(14, 'ip:90.113.12.69', 'CHEVROLET', 'police8', 0, 'POLICE11', 'Rentré', '112', '141', '0', '156'),
(15, 'ip:109.19.128.86', 'Moto', 'policeb', 0, 'POLICE12', 'Rentré', '112', '141', '0', '156'),
(16, 'ip:109.19.128.86', 'Buffalo', 'police2', 0, 'POLICE13', 'Rentré', '112', '141', '0', '156'),
(17, 'ip:109.19.128.86', 'Interceptor', 'police3', 0, 'POLICE14', 'Rentré', '112', '141', '0', '156'),
(18, 'ip:109.19.128.86', '4x4 Chevrolet', 'police6', 0, 'POLICE15', 'Rentré', '112', '141', '0', '156'),
(19, 'steam:1100001054070bd 	', 'Interceptor', 'police3', 0, 'POLICE16', 'Rentré', '112', '141', '0', '156'),
(20, 'steam:1100001054070bd', 'Rancher', 'police4', 0, 'POLICE17', 'Rentré', '112', '141', '0', '156'),
(21, 'steam:1100001054070bd', 'Back', 'fbi2', 0, 'POLICE18', 'Rentré', '112', '141', '0', '156'),
(22, 'steam:1100001054070bd', 'Moto', 'policeb', 0, 'POLICE19', 'Rentré', '112', '141', '0', '156'),
(23, 'steam:1100001019c2160', 'FORD', 'police', 0, 'POLICE20', 'Rentré', '112', '141', '0', '156'),
(24, 'steam:1100001019c2160', 'CHEVROLET', 'police8', 0, 'POLICE21', 'Rentré', '112', '141', '0', '156'),
(25, 'ip:109.19.128.86', 'FBI', 'fbi1', 0, 'POLICE22', 'Rentré', '1', '1', '0', '156'),
(26, 'steam:1100001070489ef', 'BAC2', 'fbi', 0, 'POLICE02', 'Rentré', '25', '25', '0', '156'),
(27, 'steam:1100001070489ef', 'BAC3', 'fbi', 0, 'POLICE04', 'Rentré', '65', '65', '0', '156'),
(28, 'steam:1100001019c2160', 'FORD', 'police7', 0, 'POLICE30', 'Rentré', '112', '141', '0', '156'),
(29, 'steam:1100001019c2160', 'CHEVROLET', 'police8', 0, 'POLICE31', 'Rentré', '112', '141', '0', '156');

-- --------------------------------------------------------

--
-- Structure de la table `recolt`
--

CREATE TABLE `recolt` (
  `ID` int(11) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL,
  `raw_id` int(11) UNSIGNED DEFAULT NULL,
  `treated_id` int(11) UNSIGNED DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `field_id` int(10) UNSIGNED DEFAULT NULL,
  `treatment_id` int(10) UNSIGNED DEFAULT NULL,
  `seller_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `recolt`
--

INSERT INTO `recolt` (`ID`, `name`, `raw_id`, `treated_id`, `job_id`, `price`, `field_id`, `treatment_id`, `seller_id`) VALUES
(1, 'Cocaine', 7, 28, 8, 320, 22, 23, 24),
(2, 'Document secret', 29, 31, 8, 360, 4, 5, 6),
(3, 'Ecsta', 13, 14, 8, 380, 13, 14, 15),
(4, 'Bijous', 15, 16, 8, 400, 16, 17, 18),
(5, 'Organnes', 17, 18, 8, 500, 19, 20, 21),
(6, 'Hero', 32, 33, 8, 540, 7, 8, 9),
(7, 'GHB', 51, 52, 8, 800, 25, 26, 27),
(8, 'Diamands', 43, 44, 8, 850, 28, 29, 30),
(9, 'Amphéte', 53, 54, 8, 1000, 31, 32, 33),
(10, 'DD Crypté', 47, 48, 8, 1150, 34, 35, 36),
(11, 'Kéta', 49, 50, 8, 925, 37, 38, 39),
(12, 'LSD', 45, 46, 8, 900, 40, 41, 42);

-- --------------------------------------------------------

--
-- Structure de la table `skin`
--

CREATE TABLE `skin` (
  `id` int(11) NOT NULL,
  `identifier` varchar(120) DEFAULT NULL,
  `model` varchar(50) NOT NULL DEFAULT '0',
  `head` int(11) NOT NULL DEFAULT '0',
  `body_color` int(11) NOT NULL DEFAULT '0',
  `hair` int(11) NOT NULL DEFAULT '0',
  `hair_color` int(11) NOT NULL DEFAULT '0',
  `beard` int(11) NOT NULL DEFAULT '0',
  `beard_color` int(11) NOT NULL DEFAULT '0',
  `eyebrows` int(11) NOT NULL DEFAULT '0',
  `eyebrows_color` int(11) NOT NULL DEFAULT '0',
  `percing` int(11) DEFAULT '0',
  `percing_txt` int(11) DEFAULT '0',
  `makeup` int(11) DEFAULT '0',
  `makeup_opacity` int(11) DEFAULT '0',
  `lipstick` int(11) DEFAULT '0',
  `lipstick_color` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `stationaryradar`
--

CREATE TABLE `stationaryradar` (
  `id` int(11) NOT NULL,
  `x` double(8,2) NOT NULL,
  `y` double(8,2) NOT NULL,
  `z` double(8,2) NOT NULL,
  `maxspeed` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `stationaryradar_permissions`
--

CREATE TABLE `stationaryradar_permissions` (
  `steamid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `permission_level` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `stationaryradar_permissions`
--

INSERT INTO `stationaryradar_permissions` (`steamid`, `name`, `permission_level`) VALUES
('steam:1100001070489ef', '?ICHT$$CH?ÂRT?', 1),
('steam:1100001050cd15d', '[FR] Anonbibi', 0);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `identifier` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `player_state` int(255) NOT NULL DEFAULT '0',
  `group` varchar(50) NOT NULL DEFAULT '0',
  `permission_level` int(11) NOT NULL DEFAULT '0',
  `money` double NOT NULL DEFAULT '0',
  `bankbalance` int(32) DEFAULT '0',
  `job` int(11) DEFAULT '1',
  `lastpos` varchar(255) DEFAULT '{-1044.99914550781,-2749.8173828125,21.3634204864502}',
  `personalvehicle` varchar(60) DEFAULT NULL,
  `isFirstConnection` int(11) DEFAULT '1',
  `nom` varchar(128) NOT NULL DEFAULT '',
  `prenom` varchar(128) NOT NULL DEFAULT '',
  `dateNaissance` date DEFAULT '1980-01-01',
  `sexe` varchar(1) NOT NULL DEFAULT 'f',
  `taille` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `food` double NOT NULL DEFAULT '100',
  `water` double NOT NULL DEFAULT '100',
  `needs` double NOT NULL DEFAULT '0',
  `dirty_money` double NOT NULL DEFAULT '0',
  `phone_number` varchar(50) DEFAULT '0',
  `permisvoiture` varchar(255) NOT NULL DEFAULT 'Non Acquis',
  `permisbateaux` varchar(255) NOT NULL DEFAULT 'Non Acquis',
  `permishelico` varchar(255) NOT NULL DEFAULT 'Non Acquis',
  `permisavion` varchar(255) NOT NULL DEFAULT 'Non Acquis',
  `portarmeleg` varchar(255) NOT NULL DEFAULT 'Non Acquis',
  `portarmelourd` varchar(255) NOT NULL DEFAULT 'Non Acquis',
  `licencegrandbandi` varchar(255) NOT NULL DEFAULT 'Non Acquis',
  `playtime` int(11) NOT NULL DEFAULT '0',
  `shotsfired` int(11) NOT NULL DEFAULT '0',
  `kmdriven` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`identifier`, `player_state`, `group`, `permission_level`, `money`, `bankbalance`, `job`, `lastpos`, `personalvehicle`, `isFirstConnection`, `nom`, `prenom`, `dateNaissance`, `sexe`, `taille`, `food`, `water`, `needs`, `dirty_money`, `phone_number`, `permisvoiture`, `permisbateaux`, `permishelico`, `permisavion`, `portarmeleg`, `portarmelourd`, `licencegrandbandi`, `playtime`, `shotsfired`, `kmdriven`) VALUES
('steam:1100001044d80e2', 0, '0', 0, 992840000, 998000001, 1, '{-1044.99914550781,-2749.8173828125,21.3634204864502}', NULL, 1, '', '', '1980-01-01', 'f', 0, 100, 100, 0, 0, '0', 'Non Acquis', 'Non Acquis', 'Non Acquis', 'Non Acquis', 'Non Acquis', 'Non Acquis', 'Non Acquis', 0, 0, 0),
('steam:1100001050cd15d', 0, '0', 0, 10000000, 100000000, 1, '{-1044.99914550781,-2749.8173828125,21.3634204864502}', NULL, 1, '', '', '1980-01-01', 'f', 0, 100, 100, 0, 0, '0', 'Non Acquis', 'Non Acquis', 'Non Acquis', 'Non Acquis', 'Non Acquis', 'Non Acquis', 'Non Acquis', 0, 0, 0),
('steam:110000108f465a3', 0, '0', 0, 125100, 1880899, 1, '{-1044.99914550781,-2749.8173828125,21.3634204864502}', NULL, 1, '', '', '1980-01-01', 'f', 0, 100, 100, 0, 0, '0', 'Non Acquis', 'Non Acquis', 'Non Acquis', 'Non Acquis', 'Non Acquis', 'Non Acquis', 'Non Acquis', 0, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `user_appartement`
--

CREATE TABLE `user_appartement` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `money` int(11) NOT NULL DEFAULT '0',
  `dirtymoney` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `user_boat`
--

CREATE TABLE `user_boat` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `boat_name` varchar(255) DEFAULT NULL,
  `boat_model` varchar(255) DEFAULT NULL,
  `boat_price` int(60) DEFAULT NULL,
  `boat_plate` varchar(255) DEFAULT NULL,
  `boat_state` varchar(255) DEFAULT NULL,
  `boat_colorprimary` varchar(255) DEFAULT NULL,
  `boat_colorsecondary` varchar(255) DEFAULT NULL,
  `boat_pearlescentcolor` varchar(255) DEFAULT NULL,
  `boat_wheelcolor` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_garage`
--

CREATE TABLE `user_garage` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `garage_id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_heli`
--

CREATE TABLE `user_heli` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `heli_name` varchar(255) DEFAULT NULL,
  `heli_model` varchar(255) DEFAULT NULL,
  `heli_price` int(60) DEFAULT NULL,
  `heli_plate` varchar(255) DEFAULT NULL,
  `heli_state` varchar(255) DEFAULT NULL,
  `heli_colorprimary` varchar(255) DEFAULT NULL,
  `heli_colorsecondary` varchar(255) DEFAULT NULL,
  `heli_pearlescentcolor` varchar(255) DEFAULT NULL,
  `heli_wheelcolor` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_inventory`
--

CREATE TABLE `user_inventory` (
  `user_id` varchar(255) NOT NULL DEFAULT '',
  `item_id` int(11) UNSIGNED NOT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_licence`
--

CREATE TABLE `user_licence` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `licence_id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_message`
--

CREATE TABLE `user_message` (
  `id` int(11) NOT NULL,
  `owner_id` varchar(50) NOT NULL,
  `receiver_id` varchar(50) NOT NULL,
  `msg` varchar(200) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `has_read` int(11) NOT NULL DEFAULT '0',
  `receiver_deleted` int(11) DEFAULT '0',
  `phone_number` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_phonelist`
--

CREATE TABLE `user_phonelist` (
  `id` int(11) NOT NULL,
  `owner_id` varchar(50) NOT NULL,
  `contact_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_plane`
--

CREATE TABLE `user_plane` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `plane_name` varchar(255) DEFAULT NULL,
  `plane_model` varchar(255) DEFAULT NULL,
  `plane_price` int(60) DEFAULT NULL,
  `plane_plate` varchar(255) DEFAULT NULL,
  `plane_state` varchar(255) DEFAULT NULL,
  `plane_colorprimary` varchar(255) DEFAULT NULL,
  `plane_colorsecondary` varchar(255) DEFAULT NULL,
  `plane_pearlescentcolor` varchar(255) DEFAULT NULL,
  `plane_wheelcolor` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_vehicle`
--

CREATE TABLE `user_vehicle` (
  `ID` int(10) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `vehicle_name` varchar(60) DEFAULT NULL,
  `vehicle_model` varchar(60) DEFAULT NULL,
  `vehicle_price` int(70) NOT NULL DEFAULT '0',
  `vehicle_plate` varchar(60) DEFAULT NULL,
  `vehicle_state` varchar(60) DEFAULT NULL,
  `vehicle_colorsecondary` varchar(60) DEFAULT NULL,
  `vehicle_colorprimary` varchar(60) DEFAULT NULL,
  `vehicle_pearlescentcolor` varchar(60) NOT NULL,
  `vehicle_wheelcolor` varchar(60) NOT NULL,
  `garage_id` varchar(255) DEFAULT '22',
  `insurance` varchar(255) NOT NULL DEFAULT 'off',
  `instance` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `user_vehicle`
--

INSERT INTO `user_vehicle` (`ID`, `identifier`, `vehicle_name`, `vehicle_model`, `vehicle_price`, `vehicle_plate`, `vehicle_state`, `vehicle_colorsecondary`, `vehicle_colorprimary`, `vehicle_pearlescentcolor`, `vehicle_wheelcolor`, `garage_id`, `insurance`, `instance`) VALUES
(534, '@username', '@name', '@vehicle', 0, '@plate', '@state', '@secondarycolor', '@primarycolor', '@pearlescentcolor', '@wheelcolor', '22', 'off', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `user_vehmods`
--

CREATE TABLE `user_vehmods` (
  `id` int(11) NOT NULL,
  `plate` varchar(45) NOT NULL,
  `tyresmoke` varchar(45) DEFAULT '255,255,255',
  `mod0` varchar(45) DEFAULT '-1',
  `mod1` varchar(45) DEFAULT '-1',
  `mod2` varchar(45) DEFAULT '-1',
  `mod3` varchar(45) DEFAULT '-1',
  `mod4` varchar(45) DEFAULT '-1',
  `mod5` varchar(45) DEFAULT '-1',
  `mod6` varchar(45) DEFAULT '-1',
  `mod7` varchar(45) DEFAULT '-1',
  `mod8` varchar(45) DEFAULT '-1',
  `mod9` varchar(45) DEFAULT '-1',
  `mod10` varchar(45) DEFAULT '-1',
  `mod11` varchar(45) DEFAULT '-1',
  `mod12` varchar(45) DEFAULT '-1',
  `mod13` varchar(45) DEFAULT '-1',
  `mod14` varchar(45) DEFAULT '-1',
  `mod15` varchar(45) DEFAULT '-1',
  `mod16` varchar(45) DEFAULT '-1',
  `mod17` varchar(45) DEFAULT '-1',
  `mod18` varchar(45) DEFAULT '-1',
  `mod19` varchar(45) DEFAULT '-1',
  `mod20` varchar(45) DEFAULT '-1',
  `mod21` varchar(45) DEFAULT '-1',
  `mod22` varchar(45) DEFAULT '-1',
  `mod23` varchar(45) DEFAULT '-1',
  `mod24` varchar(45) DEFAULT '-1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `user_vehmods`
--

INSERT INTO `user_vehmods` (`id`, `plate`, `tyresmoke`, `mod0`, `mod1`, `mod2`, `mod3`, `mod4`, `mod5`, `mod6`, `mod7`, `mod8`, `mod9`, `mod10`, `mod11`, `mod12`, `mod13`, `mod14`, `mod15`, `mod16`, `mod17`, `mod18`, `mod19`, `mod20`, `mod21`, `mod22`, `mod23`, `mod24`) VALUES
(179, '06OFE391', '255,255,255', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1'),
(180, '43NYL343', '255,255,255', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1'),
(181, '69GNP269', '255,255,255', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1'),
(182, '64BDL132', '255,255,255', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1'),
(183, '65RWU790', '255,255,255', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1'),
(184, '21VRB560', '255,255,255', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1');

-- --------------------------------------------------------

--
-- Structure de la table `user_weapons`
--

CREATE TABLE `user_weapons` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `weapon_model` varchar(255) NOT NULL,
  `withdraw_cost` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int(255) NOT NULL,
  `model` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `vehicles`
--

INSERT INTO `vehicles` (`id`, `name`, `price`, `model`) VALUES
(1, 'Blista', 15000, 'blista'),
(2, 'Brioso R/A', 155000, 'brioso'),
(3, 'Dilettante', 25000, 'Dilettante'),
(4, 'Issi', 18000, 'issi2'),
(5, 'Panto', 85000, 'panto'),
(6, 'Prairie', 30000, 'prairie'),
(7, 'Rhapsody', 120000, 'rhapsody'),
(8, 'Cognoscenti Cabrio', 180000, 'cogcabrio'),
(9, 'Exemplar', 200000, 'exemplar'),
(10, 'F620', 80000, 'f620'),
(11, 'Felon', 90000, 'felon'),
(12, 'Felon GT', 95000, 'felon2'),
(13, 'Jackal', 60000, 'jackal'),
(14, 'Oracle', 80000, 'oracle'),
(15, 'Oracle XS', 82000, 'oracle2'),
(16, 'Sentinel', 90000, 'sentinel'),
(17, 'Sentinel XS', 60000, 'sentinel2'),
(18, 'Windsor', 800000, 'windsor'),
(19, 'Windsor Drop', 850000, 'windsor2'),
(20, 'Zion', 60000, 'zion'),
(21, 'Zion Cabrio', 65000, 'zion2'),
(22, '9F', 120000, 'ninef'),
(23, '9F Cabrio', 130000, 'ninef2'),
(24, 'Alpha', 150000, 'alpha'),
(25, 'Banshee', 105000, 'banshee'),
(26, 'Bestia GTS', 610000, 'bestiagts'),
(27, 'Blista Compact', 42000, 'blista'),
(28, 'Buffalo', 35000, 'buffalo'),
(29, 'Buffalo S', 96000, 'buffalo2'),
(30, 'Carbonizzare', 195000, 'carbonizzare'),
(31, 'Comet', 100000, 'comet2'),
(32, 'Coquette', 138000, 'coquette'),
(33, 'Drift Tampa', 995000, 'tampa2'),
(34, 'Feltzer', 130000, 'feltzer2'),
(35, 'Furore GT', 448000, 'furoregt'),
(36, 'Fusilade', 36000, 'fusilade'),
(37, 'Jester', 240000, 'jester'),
(38, 'Jester(Racecar)', 350000, 'jester2'),
(39, 'Kuruma', 95000, 'kuruma'),
(40, 'Lynx', 1735000, 'lynx'),
(41, 'Massacro', 275000, 'massacro'),
(42, 'Massacro(Racecar)', 385000, 'massacro2'),
(43, 'Omnis', 701000, 'omnis'),
(44, 'Penumbra', 24000, 'penumbra'),
(45, 'Rapid GT', 140000, 'rapidgt'),
(46, 'Rapid GT Convertible', 150000, 'rapidgt2'),
(47, 'Schafter V12', 140000, 'schafter3'),
(48, 'Sultan', 12000, 'sultan'),
(49, 'Surano', 110000, 'surano'),
(50, 'Tropos', 816000, 'tropos'),
(51, 'Verkierer', 695000, 'verlierer2'),
(52, 'Casco', 680000, 'casco'),
(53, 'Coquette Classic', 665000, 'coquette2'),
(54, 'JB 700', 350000, 'jb700'),
(55, 'Pigalle', 400000, 'pigalle'),
(56, 'Stinger', 850000, 'stinger'),
(57, 'Stinger GT', 875000, 'stingergt'),
(58, 'Stirling GT', 975000, 'feltzer3'),
(59, 'Z-Type', 950000, 'ztype'),
(60, 'Adder', 1000000, 'adder'),
(61, 'Banshee 900R', 565000, 'banshee2'),
(62, 'Bullet', 155000, 'bullet'),
(63, 'Cheetah', 650000, 'cheetah'),
(64, 'Entity XF', 795000, 'entityxf'),
(65, 'ETR1', 199500, 'sheava'),
(66, 'FMJ', 1750000, 'fmj'),
(67, 'Infernus', 440000, 'infernus'),
(68, 'Osiris', 1950000, 'osiris'),
(69, 'RE-7B', 2475000, 'le7b'),
(70, 'Reaper', 1595000, 'reaper'),
(71, 'Sultan RS', 795000, 'sultanrs'),
(72, 'T20', 2200000, 't20'),
(73, 'Turismo R', 500000, 'turismor'),
(74, 'Tyrus', 2550000, 'tyrus'),
(75, 'Vacca', 240000, 'vacca'),
(76, 'Voltic', 150000, 'voltic'),
(77, 'X80 Proto', 2700000, 'prototipo'),
(78, 'Zentorno', 725000, 'zentorno'),
(79, 'Blade', 160000, 'blade'),
(80, 'Buccaneer', 29000, 'buccaneer'),
(81, 'Chino', 225000, 'chino'),
(82, 'Coquette BlackFin', 695000, 'coquette3'),
(83, 'Dominator', 35000, 'dominator'),
(84, 'Dukes', 62000, 'dukes'),
(85, 'Gauntlet', 32000, 'gauntlet'),
(86, 'Hotknife', 90000, 'hotknife'),
(87, 'Faction', 36000, 'faction'),
(88, 'Nightshade', 585000, 'nightshade'),
(89, 'Picador', 9000, 'picador'),
(90, 'Sabre Turbo', 15000, 'sabregt'),
(91, 'Tampa', 375000, 'tampa'),
(92, 'Virgo', 195000, 'virgo'),
(93, 'Vigero', 21000, 'vigero'),
(94, 'Bifta', 75000, 'bifta'),
(95, 'Blazer', 8000, 'blazer'),
(96, 'Brawler', 715000, 'brawler'),
(97, 'Bubsta 6x6', 249000, 'dubsta3'),
(98, 'Dune Buggy', 20000, 'dune'),
(99, 'Rebel', 22000, 'rebel2'),
(100, 'Sandking', 38000, 'sandking'),
(101, 'The Liberator', 550000, 'monster'),
(102, 'Trophy Truck', 550000, 'trophytruck'),
(103, 'Baller', 90000, 'baller'),
(104, 'Cavalcade', 60000, 'cavalcade'),
(105, 'Grabger', 35000, 'granger'),
(106, 'Huntley S', 195000, 'huntley'),
(107, 'Landstalker', 58000, 'landstalker'),
(108, 'Radius', 32000, 'radi'),
(109, 'Rocoto', 85000, 'rocoto'),
(110, 'Seminole', 30000, 'seminole'),
(111, 'XLS', 253000, 'xls'),
(112, 'Bison', 30000, 'bison'),
(113, 'Bobcat XL', 23000, 'bobcatxl'),
(114, 'Gang Burrito', 65000, 'gburrito'),
(115, 'Journey', 15000, 'journey'),
(116, 'Minivan', 30000, 'minivan'),
(117, 'Paradise', 25000, 'paradise'),
(118, 'Rumpo', 13000, 'rumpo'),
(119, 'Surfer', 11000, 'surfer'),
(120, 'Youga', 16000, 'youga'),
(121, 'Asea', 1000000, 'asea'),
(122, 'Asterope', 1000000, 'asterope'),
(123, 'Fugitive', 24000, 'fugitive'),
(124, 'Glendale', 200000, 'glendale'),
(125, 'Ingot', 9000, 'ingot'),
(126, 'Intruder', 16000, 'intruder'),
(127, 'Premier', 10000, 'premier'),
(128, 'Primo', 9000, 'primo'),
(129, 'Primo Custom', 9500, 'primo2'),
(130, 'Regina', 8000, 'regina'),
(131, 'Schafter', 65000, 'schafter2'),
(132, 'Stanier', 10000, 'stanier'),
(133, 'Stratum', 10000, 'stratum'),
(134, 'Stretch', 30000, 'stretch'),
(135, 'Super Diamond', 250000, 'superd'),
(136, 'Surge', 38000, 'surge'),
(137, 'Tailgater', 55000, 'tailgater'),
(138, 'Warrener', 120000, 'warrener'),
(139, 'Washington', 15000, 'washington'),
(140, 'Akuma', 9000, 'AKUMA'),
(141, 'Bagger', 5000, 'bagger'),
(142, 'Bati 801', 15000, 'bati'),
(143, 'Bati 801RR', 15000, 'bati2'),
(144, 'BF400', 95000, 'bf400'),
(145, 'Carbon RS', 40000, 'carbonrs'),
(146, 'Cliffhanger', 225000, 'cliffhanger'),
(147, 'Daemon', 5000, 'daemon'),
(148, 'Double T', 12000, 'double'),
(149, 'Enduro', 48000, 'enduro'),
(150, 'Faggio', 4000, 'faggio2'),
(151, 'Gargoyle', 120000, 'gargoyle'),
(152, 'Hakuchou', 82000, 'hakuchou'),
(153, 'Hexer', 15000, 'hexer'),
(154, 'Innovation', 90000, 'innovation'),
(155, 'Lectro', 700000, 'lectro'),
(156, 'Nemesis', 12000, 'nemesis'),
(157, 'PCJ-600', 9000, 'pcj'),
(158, 'Ruffian', 9000, 'ruffian'),
(159, 'Sanchez', 7000, 'sanchez'),
(160, 'Sovereign', 90000, 'sovereign'),
(161, 'Thrust', 75000, 'thrust'),
(162, 'Vader', 9000, 'vader'),
(163, 'Vindicator', 600000, 'vindicator');

-- --------------------------------------------------------

--
-- Structure de la table `whitelist`
--

CREATE TABLE `whitelist` (
  `identifier` varchar(255) NOT NULL,
  `listed` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `whitelist`
--

INSERT INTO `whitelist` (`identifier`, `listed`) VALUES
('steam:1100001050cd15d', 1),
('steam:1100001070489ef', 1),
('steam:11000010578ba32', 1),
('steam:1100001054070bd', 1),
('steam:110000108ae7fff', 1),
('steam:110000105d8bfd5', 1),
('steam:110000104bc9698', 1),
('steam:110000105b6d7cd', 1),
('steam:1100001019c2160', 1),
('steam:11000011262d25d', 1),
('steam:11000010ca6deef', 1),
('steam:11000010b117d12', 1),
('steam:110000102FFD1AA', 1),
('steam:11000010834E8DB', 1),
('steam:11000010DF208EA', 1),
('steam:1100001064A7A93', 1),
('steam:110000108F465A3', 1),
('steam:11000010E40098F', 1),
('steam:110000106D5ED07', 1),
('steam:110000101DA8C40', 1),
('steam:11000010483B3ED', 1),
('steam:11000010C7ED271', 1),
('steam:110000104AB323B', 1),
('steam:110000105CDE112', 1),
('steam:1100001034F8462', 1),
('steam:11000010A7D411E', 1),
('steam:11000010C8C8341', 1),
('steam:1100001044D80E2', 1),
('steam:1100001145464EA', 1),
('steam:1100001069170DD', 1),
('steam:11000010394A38F', 1),
('steam:11000010C7EA946', 1),
('steam:1100001069F1E65', 1),
('steam:11000010F529659', 1),
('steam:1100001196EC9D0', 1),
('steam:110000108765F50', 1),
('steam:11000010269B6A2', 1),
('steam:110000109EC04E5', 1),
('steam:11000010A6A92B0', 1),
('steam:1B33334D0C803F', 1),
('steam:11000010699A3DD', 1),
('steam:110000100B36F21', 1),
('steam:110000111B5B1EB', 1),
('steam:11000010F17ADA9', 1),
('steam:11000010B5324F5', 1),
('steam:11000010ADF29C5', 1),
('steam:1100001108A43A0', 1),
('steam:1100001094D1405', 1),
('steam:110000109902210', 1),
('steam:1100001120A20CF', 1),
('steam:110000102727677', 1),
('steam:11000010270BE8A', 1),
('steam:1100001023AEEED', 1),
('steam:11000010889376D', 1),
('steam:110000106888E01', 1),
('steam:1100001033343AB', 1),
('steam:110000100A5C9EA', 1),
('steam:1100001156F5CE3', 1),
('steam:110000111BF2B7F', 1),
('steam:110000117CB4376', 1),
('steam:1100001099D8D9D', 1),
('steam:110000106D35A6A', 1),
('steam:1100001136629EA', 1),
('steam:110000109AB5A92', 1),
('steam:1100001098B0B2F', 1),
('steam:11000011087734a', 1),
('steam:11000010187bd4b', 1),
('steam:11000011A2C2609', 1),
('steam:110000104F09C54', 1),
('steam:11000010626DD06', 1),
('steam:1100001035BED9D', 1),
('steam:11000010C68C509', 1),
('steam:1100001061405AA', 1),
('steam:1100001022b6054', 1),
('steam:11000011A5D0ED3', 1),
('steam:1100001064F7A0A', 1),
('steam:1100001060B800F', 1),
('steam:110000107597E57', 1),
('steam:11000010BE1DD0F', 1),
('steam:11000011ABB0D0B', 1),
('steam:1100001027D0279', 1);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `clothes_outfits`
--
ALTER TABLE `clothes_outfits`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `clothes_props`
--
ALTER TABLE `clothes_props`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `clothes_users_outfits`
--
ALTER TABLE `clothes_users_outfits`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `clothes_users_props`
--
ALTER TABLE `clothes_users_props`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `coffrelspd`
--
ALTER TABLE `coffrelspd`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `coffremine`
--
ALTER TABLE `coffremine`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `commands`
--
ALTER TABLE `commands`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `coordinates`
--
ALTER TABLE `coordinates`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `garages`
--
ALTER TABLE `garages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `gouv`
--
ALTER TABLE `gouv`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `hcdh`
--
ALTER TABLE `hcdh`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `interiors`
--
ALTER TABLE `interiors`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`job_id`);

--
-- Index pour la table `licences`
--
ALTER TABLE `licences`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `police`
--
ALTER TABLE `police`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `police_vehicle`
--
ALTER TABLE `police_vehicle`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `recolt`
--
ALTER TABLE `recolt`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `raw_id` (`raw_id`),
  ADD KEY `treated_id` (`treated_id`),
  ADD KEY `job_id` (`job_id`),
  ADD KEY `field_id` (`field_id`),
  ADD KEY `treatment_id` (`treatment_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Index pour la table `skin`
--
ALTER TABLE `skin`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `stationaryradar`
--
ALTER TABLE `stationaryradar`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `stationaryradar_permissions`
--
ALTER TABLE `stationaryradar_permissions`
  ADD PRIMARY KEY (`steamid`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `user_appartement`
--
ALTER TABLE `user_appartement`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_boat`
--
ALTER TABLE `user_boat`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `boat_plate` (`boat_plate`);

--
-- Index pour la table `user_garage`
--
ALTER TABLE `user_garage`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_heli`
--
ALTER TABLE `user_heli`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `heli_plate` (`heli_plate`);

--
-- Index pour la table `user_inventory`
--
ALTER TABLE `user_inventory`
  ADD PRIMARY KEY (`user_id`,`item_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Index pour la table `user_licence`
--
ALTER TABLE `user_licence`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_message`
--
ALTER TABLE `user_message`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_phonelist`
--
ALTER TABLE `user_phonelist`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_plane`
--
ALTER TABLE `user_plane`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plane_plate` (`plane_plate`);

--
-- Index pour la table `user_vehicle`
--
ALTER TABLE `user_vehicle`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `user_vehmods`
--
ALTER TABLE `user_vehmods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plate_UNIQUE` (`plate`);

--
-- Index pour la table `user_weapons`
--
ALTER TABLE `user_weapons`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `whitelist`
--
ALTER TABLE `whitelist`
  ADD PRIMARY KEY (`identifier`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `chat`
--
ALTER TABLE `chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `clothes_outfits`
--
ALTER TABLE `clothes_outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
--
-- AUTO_INCREMENT pour la table `clothes_props`
--
ALTER TABLE `clothes_props`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;
--
-- AUTO_INCREMENT pour la table `clothes_users_outfits`
--
ALTER TABLE `clothes_users_outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=207;
--
-- AUTO_INCREMENT pour la table `clothes_users_props`
--
ALTER TABLE `clothes_users_props`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;
--
-- AUTO_INCREMENT pour la table `commands`
--
ALTER TABLE `commands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `coordinates`
--
ALTER TABLE `coordinates`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT pour la table `garages`
--
ALTER TABLE `garages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT pour la table `interiors`
--
ALTER TABLE `interiors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'key id', AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT pour la table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;
--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT pour la table `licences`
--
ALTER TABLE `licences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `recolt`
--
ALTER TABLE `recolt`
  MODIFY `ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT pour la table `skin`
--
ALTER TABLE `skin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;
--
-- AUTO_INCREMENT pour la table `stationaryradar`
--
ALTER TABLE `stationaryradar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `user_appartement`
--
ALTER TABLE `user_appartement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT pour la table `user_boat`
--
ALTER TABLE `user_boat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `user_garage`
--
ALTER TABLE `user_garage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `user_heli`
--
ALTER TABLE `user_heli`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `user_licence`
--
ALTER TABLE `user_licence`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `user_message`
--
ALTER TABLE `user_message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3584;
--
-- AUTO_INCREMENT pour la table `user_phonelist`
--
ALTER TABLE `user_phonelist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=304;
--
-- AUTO_INCREMENT pour la table `user_plane`
--
ALTER TABLE `user_plane`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `user_vehicle`
--
ALTER TABLE `user_vehicle`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=535;
--
-- AUTO_INCREMENT pour la table `user_vehmods`
--
ALTER TABLE `user_vehmods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=185;
--
-- AUTO_INCREMENT pour la table `user_weapons`
--
ALTER TABLE `user_weapons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;
--
-- AUTO_INCREMENT pour la table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=164;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `recolt`
--
ALTER TABLE `recolt`
  ADD CONSTRAINT `recolt_ibfk_1` FOREIGN KEY (`raw_id`) REFERENCES `items` (`id`),
  ADD CONSTRAINT `recolt_ibfk_2` FOREIGN KEY (`treated_id`) REFERENCES `items` (`id`),
  ADD CONSTRAINT `recolt_ibfk_3` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`),
  ADD CONSTRAINT `recolt_ibfk_4` FOREIGN KEY (`field_id`) REFERENCES `coordinates` (`id`),
  ADD CONSTRAINT `recolt_ibfk_5` FOREIGN KEY (`treatment_id`) REFERENCES `coordinates` (`id`),
  ADD CONSTRAINT `recolt_ibfk_6` FOREIGN KEY (`seller_id`) REFERENCES `coordinates` (`id`);

--
-- Contraintes pour la table `user_inventory`
--
ALTER TABLE `user_inventory`
  ADD CONSTRAINT `user_inventory_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
