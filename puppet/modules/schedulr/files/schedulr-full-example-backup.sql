-- phpMyAdmin SQL Dump
-- version 3.5.8.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 22, 2013 at 02:43 PM
-- Server version: 5.1.69
-- PHP Version: 5.3.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `schedulr`
--

-- --------------------------------------------------------

--
-- Table structure for table `healthcare_facility`
--

CREATE TABLE IF NOT EXISTS `healthcare_facility` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `healthcare_facility` varchar(255) NOT NULL,
  `healthcare_facility_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `healthcare_facility`
--

INSERT INTO `healthcare_facility` (`id`, `version`, `healthcare_facility`, `healthcare_facility_name`) VALUES
(1, 0, 'HSA-VKK123', 'Vårdcentralen kusten, Kärna'),
(2, 0, 'HSA-VKM345', 'Vårdcentralen kusten, Marstrand'),
(3, 0, 'HSA-VKY567', 'Vårdcentralen kusten, Ytterby');

-- --------------------------------------------------------

--
-- Table structure for table `performer`
--

CREATE TABLE IF NOT EXISTS `performer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `performer_id` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `performer_id` (`performer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `performer`
--

INSERT INTO `performer` (`id`, `version`, `first_name`, `last_name`, `performer_id`, `title`) VALUES
(1, 0, 'Stina', 'Karlsson', 'HSA-12345', 'Läkare'),
(2, 0, 'Lotta', 'Olsson', 'HSA-54321', 'Läkare'),
(3, 0, 'Oskar', 'Nilsson', 'HSA-34567', 'Läkare'),
(4, 0, 'Peter', 'Andersson', 'HSA-87654', 'Sjuksköterska'),
(5, 0, 'Lars', 'Fredriksson', 'HSA-35674', 'Sjuksköterska');

-- --------------------------------------------------------

--
-- Table structure for table `subject_of_care`
--

CREATE TABLE IF NOT EXISTS `subject_of_care` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `co_address` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `home_address` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `subject_of_care_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject_of_care_id` (`subject_of_care_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `subject_of_care`
--

INSERT INTO `subject_of_care` (`id`, `version`, `co_address`, `email`, `first_name`, `home_address`, `last_name`, `middle_name`, `phone`, `subject_of_care_id`) VALUES
(1, 0, NULL, 'agda.andersson@fejkepost.something', 'Agda', 'Tungegatan 32, 44254, Ytterby', 'Andersson', NULL, '0451-3553531', '188803099368'),
(2, 0, NULL, 'per.persson@fejkepost.something', 'Per', 'Bygatan 145, 44254, Kärna', 'Persson', NULL, '021-6213418', '197510266849'),
(3, 0, NULL, 'peter.petersson@fejkepost.something', 'Peter', 'Sparråsvägen 21, 44254, Ytterby', 'Petersson', NULL, '040-3191163', '197012177650'),
(4, 0, NULL, 'olle.granberg@dodgit.com', 'Olle', 'Holmtebo ekbacken, 91290, Marstrand', 'Granberg', NULL, '0940-4230632', '197004064155');

-- --------------------------------------------------------

--
-- Table structure for table `timeslot`
--

CREATE TABLE IF NOT EXISTS `timeslot` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cancel_booking_allowed` bit(1) NOT NULL,
  `caretype` varchar(255) DEFAULT NULL,
  `end_time_exclusive` datetime NOT NULL,
  `healthcare_facility_id` bigint(20) NOT NULL,
  `is_invitation` bit(1) NOT NULL,
  `performer_id` bigint(20) DEFAULT NULL,
  `purpose` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `rebooking_allowed` bit(1) NOT NULL,
  `resource_id` varchar(255) DEFAULT NULL,
  `resource_name` varchar(255) DEFAULT NULL,
  `start_time_inclusive` datetime NOT NULL,
  `subject_of_care_id` bigint(20) NOT NULL,
  `timetype` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK843C0E4B102BCF32` (`performer_id`),
  KEY `FK843C0E4BA2DF9A5D` (`healthcare_facility_id`),
  KEY `FK843C0E4B997931A0` (`subject_of_care_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `timeslot`
--

INSERT INTO `timeslot` (`id`, `version`, `cancel_booking_allowed`, `caretype`, `end_time_exclusive`, `healthcare_facility_id`, `is_invitation`, `performer_id`, `purpose`, `reason`, `rebooking_allowed`, `resource_id`, `resource_name`, `start_time_inclusive`, `subject_of_care_id`, `timetype`) VALUES
(1, 0, b'0', 'REHAB', '2013-05-22 12:50:00', 1, b'0', 1, '', '', b'0', NULL, NULL, '2013-05-22 11:50:00', 1, '1'),
(2, 0, b'0', 'SAMPLING', '2013-06-22 12:59:00', 1, b'0', 3, '', '', b'0', NULL, NULL, '2013-06-22 11:59:00', 1, NULL),
(3, 1, b'0', 'UPVISIT', '2013-07-22 13:04:00', 3, b'0', 5, '', '', b'0', NULL, NULL, '2013-07-22 12:04:00', 1, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `timeslot`
--
ALTER TABLE `timeslot`
  ADD CONSTRAINT `FK843C0E4B997931A0` FOREIGN KEY (`subject_of_care_id`) REFERENCES `subject_of_care` (`id`),
  ADD CONSTRAINT `FK843C0E4B102BCF32` FOREIGN KEY (`performer_id`) REFERENCES `performer` (`id`),
  ADD CONSTRAINT `FK843C0E4BA2DF9A5D` FOREIGN KEY (`healthcare_facility_id`) REFERENCES `healthcare_facility` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
