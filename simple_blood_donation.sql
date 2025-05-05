CREATE DATABASE IF NOT EXISTS simple_blood_donation;
use simple_blood_donation;
-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 04 mai 2025 à 16:26
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `simple_blood_donation`
--

-- --------------------------------------------------------

--
-- Structure de la table `blood_inventory`
--

DROP TABLE IF EXISTS `blood_inventory`;
CREATE TABLE IF NOT EXISTS `blood_inventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `blood_type` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  `units_added` int DEFAULT '0',
  `units_used` int DEFAULT '0',
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`inventory_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `blood_inventory`
--

INSERT INTO `blood_inventory` (`inventory_id`, `blood_type`, `units_added`, `units_used`, `last_updated`) VALUES
(1, 'A+', 5, 0, '2025-05-03 23:32:03'),
(2, 'A-', 2, 0, '2025-05-04 15:59:38'),
(3, 'B+', 2, 0, '2025-05-03 23:33:07'),
(4, 'B-', 2, 0, '2025-05-04 15:58:38'),
(5, 'AB+', 1, 0, '2025-05-04 16:02:13'),
(6, 'AB-', 4, 0, '2025-05-04 16:01:34'),
(7, 'O+', 0, 0, '2025-05-03 19:13:50'),
(8, 'O-', 2, 0, '2025-05-04 14:21:19');

-- --------------------------------------------------------

--
-- Structure de la table `donors`
--

DROP TABLE IF EXISTS `donors`;
CREATE TABLE IF NOT EXISTS `donors` (
  `donor_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `blood_type` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  `donation_type` enum('Blood','Platelets') NOT NULL,
  `district` varchar(50) NOT NULL,
  `commune` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`donor_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `donors`
--

INSERT INTO `donors` (`donor_id`, `username`, `phone`, `email`, `password`, `blood_type`, `donation_type`, `district`, `commune`, `created_at`) VALUES
(1, 'yasser', '4524245', 'egeg', 'fgfgf', '', '', 'fhfhf', 'eefef', '2025-05-03 17:32:01'),
(2, 'drbalyasser@gmail.com', '0656227589', 'drbalyasser@gmail.com', 'yasser', 'A+', 'Blood', 'Sidi Okba', 'بابا حسن', '2025-05-03 18:29:43'),
(3, 'testuser', '123456789', 'test@example.com', '123456', 'A+', 'Blood', 'Biskra', 'TestCommune', '2025-05-03 19:06:12'),
(4, 'drbalyasser@gmail.com', '0656227589', 'slimane@gmail.com', 'ssss', 'A+', 'Blood', 'Sidi Okba', 'بابا حسن', '2025-05-03 19:15:36'),
(5, 'solaymane@gmail.com', '235235235235', 'solaymane@gmail.com', 'derbal', 'A+', 'Platelets', 'Sidi Okba', 'slimane', '2025-05-03 19:16:43'),
(6, 'eedede@gmail.com', '343434', 'drbalyaefefefsser@gmail.com', '1', 'A+', 'Blood', 'Sidi Okba', 'بابا حسن', '2025-05-03 19:19:00'),
(7, 'eeded', '343434', 'drbalyaeefefsser@gmail.com', '12', 'B+', 'Blood', 'Mechouneche', 'بابا حسن', '2025-05-03 19:19:38'),
(8, 'salime', 'Mohamed', 'salim@gmail.com', '123', 'A+', 'Blood', 'Ourlal', 'Bab oude', '2025-05-03 23:17:53'),
(9, 'drbalyasser@gmail.com', '34242342\"\'', 'eafaefa@yahoo.com', '12345', 'B-', 'Blood', 'Biskra', 'zdzd', '2025-05-03 23:23:36'),
(10, 'Mohamed', '435345345345', 'Ahmed@gmail.com', '1234', 'A+', 'Blood', 'Sidi Okba', 'Draria', '2025-05-03 23:32:03'),
(11, 'Samiram', '4545454', 'samira@gmail.com', '1234', 'B+', 'Blood', 'Biskra', 'deded', '2025-05-03 23:33:07'),
(12, 'drbalyasser@gmail.com', '453453', 'drbalsalime@gmail.com', '1234', 'O-', 'Blood', 'Biskra', 'بابا حسن', '2025-05-03 23:37:16'),
(13, 'salime', '2342342', 'salim@yahoo.com', '1234', 'AB-', 'Blood', 'Biskra', 'BABA HASSEN', '2025-05-04 14:18:22'),
(14, 'mohamed', '234234', 'Mohamedelamrai.dev@gmail.com', '12', 'O-', 'Platelets', 'Biskra', 'baba oude', '2025-05-04 14:21:19'),
(15, 'slimane', '1232323', 'slimane@yahoo', 'slimane', 'AB-', 'Blood', 'Biskra', 'souala', '2025-05-04 15:51:36'),
(16, 'kamilya', '01124134310341', 'kamil@gmail.com', 'kamilya', 'AB-', 'Platelets', 'Biskra', 'بابا حسن', '2025-05-04 15:53:02'),
(17, 'sidehmed', '134141241', 'sidou@yahoo.com', 'AZER', 'A-', 'Blood', 'Biskra', 'Draria', '2025-05-04 15:56:14'),
(18, 'sami', '134141', 'sami@gmail.com', 'sami', 'B-', 'Blood', 'Biskra', 'chlef', '2025-05-04 15:58:38'),
(19, 'moha', 'moha', 'rReceptionniste@gmaile.com', 'rr', 'A-', 'Blood', 'Sidi Okba', 'Bab oude', '2025-05-04 15:59:38'),
(20, 'aefaef', '32525', 'Receptionniste@gmailee.com', '1', 'AB-', 'Blood', 'Biskra', 'zdzd', '2025-05-04 16:01:34'),
(21, 'drbalyasser@gmail.com', '0656227589', 'AAdmimne@gmaile.com', '123', 'AB+', 'Blood', 'Biskra', 'بابا حسن', '2025-05-04 16:02:13');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
