-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 02 mai 2025 à 13:39
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
-- Base de données : `lama_location`
--

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `vehicule` varchar(255) NOT NULL,
  `quantite` int NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `chauffeur` varchar(10) NOT NULL,
  `montant_total` int NOT NULL,
  `date_reservation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
CREATE TABLE IF NOT EXISTS `reservations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `vehicule_id` int NOT NULL,
  `quantite` int NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `chauffeur` enum('avec','sans') NOT NULL,
  `montant_total` int NOT NULL,
  `date_reservation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `vehicule_id` (`vehicule_id`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `date_inscription` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `email`, `password`, `date_inscription`) VALUES
(1, 'awab', 'boye4885@gmail.com', '$2y$10$bz9obenO6EO41dI5duHx2O1c4iVgWOYa.7hfaYJ5KturmSzda.Kle', '2025-04-30 13:29:57'),
(2, 'gzendo', 'gwendolinedia8@gmail.com', '$2y$10$d/bZpj50Bsj1UZPtX6t6gOHjPO1gFzIEJRaOGIJ5ii3toR/8/M78m', '2025-05-01 12:23:05'),
(3, 'thérèse cisse', 'cissetherese67@gmail.com', '$2y$10$X7X7I/F2cHQSXn1j/y8juOslytNxitDFkwu9nm3ylmM5BRJdSxROW', '2025-05-02 11:38:06'),
(4, 'Ousmane Ndome', 'uthmandevsec@gmail.com', '$2y$10$bwDUnT0vgEFTPZ07GbriOeWQx3Qh.HE5zoPIZHhcnru0tz/AYQAfS', '2025-05-02 12:50:59'),
(5, 'assy', 'assietoudjitte@gmail.com', '$2y$10$FcXLM.6b9EpdXj94/.LiWOsTJ3uDH0SsxfKV1SVIFsAbB6yYSBxlq', '2025-05-02 13:10:52');

-- --------------------------------------------------------

--
-- Structure de la table `vehicules`
--

DROP TABLE IF EXISTS `vehicules`;
CREATE TABLE IF NOT EXISTS `vehicules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marque` varchar(50) NOT NULL,
  `modele` varchar(100) NOT NULL,
  `annee` int NOT NULL,
  `prix_jour` int NOT NULL,
  `boite` varchar(50) NOT NULL,
  `carburant` varchar(50) NOT NULL,
  `clim` varchar(5) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `vehicules`
--

INSERT INTO `vehicules` (`id`, `marque`, `modele`, `annee`, `prix_jour`, `boite`, `carburant`, `clim`, `image`) VALUES
(1, 'Hyundai', 'Santa Fe', 2017, 20000, 'Automatique', 'Diesel', 'Oui', 'images/hyundai.jpg'),
(2, 'Peugeot', '2008', 2017, 25000, 'Manuelle', 'Essence', 'Oui', 'images/peugeot.jpg'),
(3, 'Renault', 'Master', 2016, 50000, 'Manuelle', 'Diesel', 'Oui', 'images/renault_master.jpg'),
(4, 'Citroën', 'Jumper Bus', 2020, 60000, 'Manuelle', 'Diesel', 'Oui', 'images/jumper.jpg'),
(5, 'Ford', 'Escape', 2017, 40000, 'Automatique', 'Essence', 'Oui', 'images/ford_escape.jpg'),
(6, 'Kia', 'Sorento', 2016, 40000, 'Automatique', 'Essence', 'Oui', 'images/kia.jpg'),
(7, 'BMW', 'X1', 2017, 50000, 'Automatique', 'Essence', 'Oui', 'images/bmw.jpg'),
(8, 'Land Rover', 'Discovery Sport', 2019, 60000, 'Automatique', 'Diesel', 'Oui', 'images/discovery.jpg'),
(9, 'Nissan', 'Rogue', 2017, 30000, 'Automatique', 'Essence', 'Oui', 'images/nissan.jpg');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
