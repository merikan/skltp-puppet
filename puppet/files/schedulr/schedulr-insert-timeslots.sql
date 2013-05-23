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
-- Dumping data for table `timeslot`
--

INSERT INTO `timeslot` (`id`, `version`, `cancel_booking_allowed`, `caretype`, `end_time_exclusive`, `healthcare_facility_id`, `is_invitation`, `performer_id`, `purpose`, `reason`, `rebooking_allowed`, `resource_id`, `resource_name`, `start_time_inclusive`, `subject_of_care_id`, `timetype`) VALUES
(1, 0, b'0', 'REHAB', '2013-05-22 12:50:00', 1, b'0', 1, '', '', b'0', NULL, NULL, '2013-05-22 11:50:00', 1, '1'),
(2, 0, b'0', 'SAMPLING', '2013-06-22 12:59:00', 1, b'0', 3, '', '', b'0', NULL, NULL, '2013-06-22 11:59:00', 1, NULL),
(3, 1, b'0', 'UPVISIT', '2013-07-22 13:04:00', 3, b'0', 5, '', '', b'0', NULL, NULL, '2013-07-22 12:04:00', 1, NULL);


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
