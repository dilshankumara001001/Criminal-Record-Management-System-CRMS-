-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 04, 2026 at 10:52 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `crms_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_trail`
--

CREATE TABLE `audit_trail` (
  `audit_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cases`
--

CREATE TABLE `cases` (
  `case_id` int(11) NOT NULL,
  `case_code` varchar(20) NOT NULL,
  `case_title` varchar(200) NOT NULL,
  `case_description` text DEFAULT NULL,
  `case_type` varchar(50) DEFAULT NULL,
  `crime_category_id` int(11) DEFAULT NULL,
  `status` enum('open','ongoing','court','closed') DEFAULT 'open',
  `priority` enum('low','medium','high','urgent') DEFAULT 'medium',
  `assigned_officer_id` int(11) DEFAULT NULL,
  `investigating_officer_id` int(11) DEFAULT NULL,
  `police_station_id` int(11) DEFAULT NULL,
  `court_name` varchar(100) DEFAULT NULL,
  `next_hearing_date` date DEFAULT NULL,
  `judge_name` varchar(100) DEFAULT NULL,
  `verdict` text DEFAULT NULL,
  `closed_date` date DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cases`
--

INSERT INTO `cases` (`case_id`, `case_code`, `case_title`, `case_description`, `case_type`, `crime_category_id`, `status`, `priority`, `assigned_officer_id`, `investigating_officer_id`, `police_station_id`, `court_name`, `next_hearing_date`, `judge_name`, `verdict`, `closed_date`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'C-2024-089', 'Homicide - Galle Road', 'Investigation into the murder of a 35-year-old man on Galle Road', 'Criminal', 1, 'closed', 'high', NULL, NULL, 1, 'Colombo High Court', '2026-10-15', NULL, NULL, NULL, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(2, 'C-2024-102', 'Drug Trafficking - Maradana', 'Large-scale drug operation busted in Maradana', 'Narcotics', 2, 'court', 'urgent', NULL, NULL, 1, 'Colombo Magistrate Court', '2026-10-22', NULL, NULL, NULL, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(3, 'C-2024-115', 'Cyber Crime - Banking Fraud', 'International cybercrime ring targeting Sri Lankan banks', 'Cyber', 4, 'ongoing', 'high', NULL, NULL, 5, 'Negombo Court', '2026-11-05', NULL, NULL, NULL, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(4, 'C-2024-128', 'Burglary - Nugegoda', 'Multiple burglaries reported in Nugegoda area', 'Property', 3, 'open', 'medium', NULL, NULL, 4, 'Nugegoda Court', '2026-09-28', NULL, NULL, NULL, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24');

-- --------------------------------------------------------

--
-- Table structure for table `case_criminals`
--

CREATE TABLE `case_criminals` (
  `id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `criminal_id` int(11) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  `arrest_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `case_criminals`
--

INSERT INTO `case_criminals` (`id`, `case_id`, `criminal_id`, `role`, `arrest_date`, `status`) VALUES
(1, 1, 1, 'Primary Suspect', '2026-08-15', 'Arrested'),
(2, 2, 2, 'Primary Suspect', '2026-07-20', 'Remanded'),
(3, 4, 3, 'Primary Suspect', '2026-05-10', 'Bailed'),
(4, 3, 4, 'Primary Suspect', NULL, 'Wanted');

-- --------------------------------------------------------

--
-- Table structure for table `clearance_certificates`
--

CREATE TABLE `clearance_certificates` (
  `certificate_id` int(11) NOT NULL,
  `certificate_code` varchar(20) NOT NULL,
  `applicant_name` varchar(100) NOT NULL,
  `applicant_nic` varchar(15) NOT NULL,
  `applicant_address` text DEFAULT NULL,
  `applicant_phone` varchar(15) DEFAULT NULL,
  `purpose` varchar(100) DEFAULT NULL,
  `has_criminal_record` tinyint(1) DEFAULT 0,
  `status` enum('pending','approved','rejected','adverse') DEFAULT 'pending',
  `verified_by` int(11) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `complaint_id` int(11) NOT NULL,
  `complaint_code` varchar(20) NOT NULL,
  `complainant_name` varchar(100) NOT NULL,
  `complainant_nic` varchar(15) DEFAULT NULL,
  `complainant_address` text DEFAULT NULL,
  `complainant_phone` varchar(15) DEFAULT NULL,
  `complainant_email` varchar(100) DEFAULT NULL,
  `complaint_type` varchar(50) DEFAULT NULL,
  `description` text NOT NULL,
  `incident_date` date DEFAULT NULL,
  `incident_location` text DEFAULT NULL,
  `severity` enum('low','medium','high','critical') DEFAULT 'medium',
  `status` enum('pending','investigating','resolved','rejected') DEFAULT 'pending',
  `assigned_officer_id` int(11) DEFAULT NULL,
  `police_station_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `resolution_notes` text DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`complaint_id`, `complaint_code`, `complainant_name`, `complainant_nic`, `complainant_address`, `complainant_phone`, `complainant_email`, `complaint_type`, `description`, `incident_date`, `incident_location`, `severity`, `status`, `assigned_officer_id`, `police_station_id`, `created_by`, `resolution_notes`, `resolved_at`, `created_at`, `updated_at`) VALUES
(1, 'CMP-001', 'Mala Fernando', '1985123456V', NULL, NULL, NULL, 'Harassment', 'Neighbor has been harassing me and my family for weeks', '2026-09-02', 'Colombo 05', 'high', 'investigating', NULL, 1, 4, NULL, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(2, 'CMP-002', 'Ravi Perera', '1990123456V', NULL, NULL, NULL, 'Theft', 'My wallet and phone were stolen from my car', '2026-09-03', 'Negombo Beach', 'medium', 'pending', NULL, 5, 4, NULL, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(3, 'CMP-003', 'Saman Kumara', '1989234567V', NULL, NULL, NULL, 'Assault', 'Was physically assaulted by a group of men', '2026-09-01', 'Kandy City Center', 'critical', 'resolved', NULL, 2, 4, NULL, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(4, 'CMP-004', 'Nimal Rathnayake', '1987654321V', NULL, NULL, NULL, 'Fraud', 'A fake company scammed me out of Rs. 500,000', '2026-08-30', 'Online', 'high', 'rejected', NULL, 1, 4, NULL, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(5, 'CMP-005', 'Priyani Wickramasinghe', '1995345678V', NULL, NULL, NULL, 'Domestic Violence', 'Husband physically abused me', '2026-09-04', 'Kurunegala', 'critical', 'investigating', NULL, 3, 4, NULL, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24');

-- --------------------------------------------------------

--
-- Table structure for table `court_hearings`
--

CREATE TABLE `court_hearings` (
  `hearing_id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `hearing_date` date NOT NULL,
  `hearing_time` time DEFAULT NULL,
  `court_name` varchar(100) DEFAULT NULL,
  `judge_name` varchar(100) DEFAULT NULL,
  `hearing_type` varchar(50) DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `next_hearing_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `court_hearings`
--

INSERT INTO `court_hearings` (`hearing_id`, `case_id`, `hearing_date`, `hearing_time`, `court_name`, `judge_name`, `hearing_type`, `summary`, `next_hearing_date`, `status`, `created_at`) VALUES
(1, 1, '2026-10-15', '10:00:00', 'Colombo High Court', 'Judge M.H. Amarasiri', 'Trial', NULL, NULL, 'Scheduled', '2026-09-04 19:37:24'),
(2, 2, '2026-10-22', '14:30:00', 'Colombo Magistrate Court', 'Judge S.K. Bandara', 'Preliminary', NULL, NULL, 'Scheduled', '2026-09-04 19:37:24'),
(3, 4, '2026-09-28', '09:30:00', 'Nugegoda Court', 'Judge P.S. Gunawardena', 'Hearing', NULL, NULL, 'Scheduled', '2026-09-04 19:37:24');

-- --------------------------------------------------------

--
-- Table structure for table `crime_categories`
--

CREATE TABLE `crime_categories` (
  `category_id` int(11) NOT NULL,
  `category_code` varchar(20) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_grave` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `crime_categories`
--

INSERT INTO `crime_categories` (`category_id`, `category_code`, `category_name`, `description`, `is_grave`, `created_at`) VALUES
(1, 'HOM-01', 'Homicide', 'Wilful killing of one person by another', 1, '2026-09-04 19:37:24'),
(2, 'DRG-02', 'Drug Trafficking', 'Illegal trade of narcotic substances', 1, '2026-09-04 19:37:24'),
(3, 'BRG-03', 'Burglary', 'Breaking and entering with intent to commit a crime', 1, '2026-09-04 19:37:24'),
(4, 'CYB-04', 'Cyber Crime', 'Online fraud, hacking, identity theft', 1, '2026-09-04 19:37:24'),
(5, 'TRF-05', 'Traffic Offense', 'Serious traffic violations', 1, '2026-09-04 19:37:24'),
(6, 'FRA-06', 'Fraud', 'Deception for financial gain', 1, '2026-09-04 19:37:24'),
(7, 'KID-07', 'Kidnapping', 'Unlawful taking away of a person', 1, '2026-09-04 19:37:24'),
(8, 'ROB-08', 'Robbery', 'Taking property by force or threat', 1, '2026-09-04 19:37:24'),
(9, 'ARS-09', 'Arson', 'Wilful burning of property', 1, '2026-09-04 19:37:24'),
(10, 'ASL-10', 'Assault', 'Physical attack on another person', 1, '2026-09-04 19:37:24'),
(11, 'HRM-11', 'Harassment', 'Unwanted behaviour causing distress', 1, '2026-09-04 19:37:24'),
(12, 'THF-12', 'Theft', 'Stealing of property', 1, '2026-09-04 19:37:24'),
(13, 'CRP-13', 'Corruption', 'Abuse of power for personal gain', 1, '2026-09-04 19:37:24'),
(14, 'MTR-14', 'Human Trafficking', 'Trade of humans for exploitation', 1, '2026-09-04 19:37:24'),
(15, 'TER-15', 'Terrorism', 'Acts of violence for political aims', 1, '2026-09-04 19:37:24'),
(16, 'ENV-16', 'Environmental Crime', 'Pollution, illegal dumping, deforestation', 1, '2026-09-04 19:37:24'),
(17, 'GUN-17', 'Illegal Firearms', 'Unlawful possession of weapons', 1, '2026-09-04 19:37:24'),
(18, 'MNY-18', 'Money Laundering', 'Concealing origins of illegally obtained money', 1, '2026-09-04 19:37:24'),
(19, 'PRS-19', 'Prison Escape', 'Escape from lawful custody', 1, '2026-09-04 19:37:24'),
(20, 'RPE-20', 'Rape', 'Non-consensual sexual intercourse', 1, '2026-09-04 19:37:24'),
(21, 'DOM-21', 'Domestic Violence', 'Abuse within family or household', 1, '2026-09-04 19:37:24'),
(22, 'CHD-22', 'Child Abuse', 'Physical, sexual, or emotional abuse of a child', 1, '2026-09-04 19:37:24'),
(23, 'ELD-23', 'Elder Abuse', 'Abuse of elderly persons', 1, '2026-09-04 19:37:24'),
(24, 'DIS-24', 'Disorderly Conduct', 'Disturbing public peace and order', 1, '2026-09-04 19:37:24'),
(25, 'VAN-25', 'Vandalism', 'Wilful destruction of property', 1, '2026-09-04 19:37:24'),
(26, 'OTH-26', 'Other Grave Crime', 'Other serious offenses', 1, '2026-09-04 19:37:24');

-- --------------------------------------------------------

--
-- Table structure for table `criminals`
--

CREATE TABLE `criminals` (
  `criminal_id` int(11) NOT NULL,
  `criminal_code` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `nic` varchar(15) DEFAULT NULL,
  `passport_no` varchar(20) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `address` text DEFAULT NULL,
  `contact_no` varchar(15) DEFAULT NULL,
  `occupation` varchar(50) DEFAULT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `fingerprint_hash` varchar(255) DEFAULT NULL,
  `height_cm` decimal(5,2) DEFAULT NULL,
  `eye_color` varchar(20) DEFAULT NULL,
  `distinguishing_marks` text DEFAULT NULL,
  `status` enum('arrested','investigation','released','wanted','court') DEFAULT 'investigation',
  `arrest_date` date DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `bail_amount` decimal(12,2) DEFAULT NULL,
  `police_station_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `criminals`
--

INSERT INTO `criminals` (`criminal_id`, `criminal_code`, `full_name`, `nic`, `passport_no`, `date_of_birth`, `gender`, `address`, `contact_no`, `occupation`, `photo_url`, `fingerprint_hash`, `height_cm`, `eye_color`, `distinguishing_marks`, `status`, `arrest_date`, `release_date`, `bail_amount`, `police_station_id`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'CRM-001', 'Kumara Silva', '1987654321V', NULL, '1985-03-15', 'Male', 'No. 45, Galle Road, Colombo 03', '+94771234567', 'Unemployed', NULL, NULL, NULL, NULL, NULL, 'arrested', '2026-08-15', NULL, NULL, 1, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(2, 'CRM-002', 'Nishan Perera', '1990123456V', NULL, '1990-06-22', 'Male', 'No. 12, Dalada Vidiya, Kandy', '+94772345678', 'Businessman', NULL, NULL, NULL, NULL, NULL, 'investigation', '2026-07-20', NULL, NULL, 2, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(3, 'CRM-003', 'Sunil Jayawardena', '1985123456V', NULL, '1985-11-10', 'Male', 'No. 78, High Level Road, Nugegoda', '+94773456789', 'Driver', NULL, NULL, NULL, NULL, NULL, 'released', '2026-05-10', NULL, NULL, 4, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(4, 'CRM-004', 'Mohamed Rizvi', '1989234567V', NULL, '1989-08-05', 'Male', 'No. 34, Main Street, Negombo', '+94774567890', 'IT Professional', NULL, NULL, NULL, NULL, NULL, 'wanted', NULL, NULL, NULL, 5, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(5, 'CRM-005', 'Chaminda Bandara', '1995345678V', NULL, '1995-12-01', 'Male', 'No. 56, Kandy Road, Kurunegala', '+94775678901', 'Farmer', NULL, NULL, NULL, NULL, NULL, 'arrested', '2026-09-01', NULL, NULL, 3, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24');

-- --------------------------------------------------------

--
-- Table structure for table `criminal_crimes`
--

CREATE TABLE `criminal_crimes` (
  `id` int(11) NOT NULL,
  `criminal_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `crime_date` date DEFAULT NULL,
  `crime_location` text DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `criminal_crimes`
--

INSERT INTO `criminal_crimes` (`id`, `criminal_id`, `category_id`, `crime_date`, `crime_location`, `description`) VALUES
(1, 1, 1, '2026-08-14', 'Galle Road, Colombo 03', 'Stabbed victim during a heated argument'),
(2, 1, 8, '2026-07-10', 'Bambalapitiya', 'Robbed a jewelry store with accomplices'),
(3, 2, 2, '2026-07-19', 'Maradana, Colombo', 'Found in possession of 5kg of heroin'),
(4, 3, 3, '2026-05-09', 'Nugegoda', 'Broke into a house and stole valuables'),
(5, 4, 4, '2026-08-01', 'Online', 'Hacked 100+ bank accounts and stole funds'),
(6, 5, 7, '2026-08-30', 'Kurunegala', 'Kidnapped a 10-year-old child for ransom');

-- --------------------------------------------------------

--
-- Table structure for table `evidence`
--

CREATE TABLE `evidence` (
  `evidence_id` int(11) NOT NULL,
  `evidence_code` varchar(20) NOT NULL,
  `case_id` int(11) NOT NULL,
  `evidence_type` varchar(50) DEFAULT NULL,
  `description` text NOT NULL,
  `storage_location` varchar(100) DEFAULT NULL,
  `collected_date` date DEFAULT NULL,
  `collected_by` int(11) DEFAULT NULL,
  `chain_of_custody` text DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fines`
--

CREATE TABLE `fines` (
  `fine_id` int(11) NOT NULL,
  `fine_code` varchar(20) NOT NULL,
  `criminal_id` int(11) DEFAULT NULL,
  `case_id` int(11) DEFAULT NULL,
  `fine_amount` decimal(12,2) NOT NULL,
  `fine_type` varchar(50) DEFAULT NULL,
  `issued_date` date NOT NULL,
  `due_date` date DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `status` enum('pending','paid','overdue','waived') DEFAULT 'pending',
  `issued_by` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fines`
--

INSERT INTO `fines` (`fine_id`, `fine_code`, `criminal_id`, `case_id`, `fine_amount`, `fine_type`, `issued_date`, `due_date`, `payment_date`, `payment_method`, `status`, `issued_by`, `notes`, `created_at`) VALUES
(1, 'FIN-001', 1, 1, 500000.00, 'Court Fine', '2026-08-20', '2026-11-20', NULL, NULL, 'pending', 2, NULL, '2026-09-04 19:37:24'),
(2, 'FIN-002', 3, 4, 25000.00, 'Traffic Fine', '2026-05-11', '2026-06-11', NULL, NULL, 'paid', 3, NULL, '2026-09-04 19:37:24');

-- --------------------------------------------------------

--
-- Table structure for table `investigations`
--

CREATE TABLE `investigations` (
  `investigation_id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `investigating_officer_id` int(11) DEFAULT NULL,
  `start_date` date NOT NULL,
  `expected_end_date` date DEFAULT NULL,
  `status` enum('ongoing','suspended','completed','transferred') DEFAULT 'ongoing',
  `progress_percentage` int(11) DEFAULT 0,
  `summary` text DEFAULT NULL,
  `findings` text DEFAULT NULL,
  `evidence_notes` text DEFAULT NULL,
  `completed_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `link` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `police_stations`
--

CREATE TABLE `police_stations` (
  `station_id` int(11) NOT NULL,
  `station_name` varchar(100) NOT NULL,
  `station_code` varchar(10) NOT NULL,
  `division` varchar(50) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `oic_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `police_stations`
--

INSERT INTO `police_stations` (`station_id`, `station_name`, `station_code`, `division`, `district`, `province`, `address`, `phone`, `email`, `oic_name`, `created_at`) VALUES
(1, 'Colombo Fort Police Station', 'CFS', 'Colombo', 'Colombo', 'Western', 'No. 1, Galle Road, Colombo 01', '+94112432121', NULL, 'SSP K.P. Siripala', '2026-09-04 19:37:24'),
(2, 'Kandy Police Station', 'KPS', 'Kandy', 'Kandy', 'Central', 'No. 45, Dalada Vidiya, Kandy', '+94812234567', NULL, 'SSP M.A.P. Perera', '2026-09-04 19:37:24'),
(3, 'Galle Police Station', 'GPS', 'Galle', 'Galle', 'Southern', 'No. 12, Church Street, Galle', '+94912223456', NULL, 'SP R.M.S. Jayasuriya', '2026-09-04 19:37:24'),
(4, 'Nugegoda Police Station', 'NPS', 'Colombo', 'Colombo', 'Western', 'No. 78, High Level Road, Nugegoda', '+94112876543', NULL, 'CI H.P. Weerasinghe', '2026-09-04 19:37:24'),
(5, 'Negombo Police Station', 'NES', 'Gampaha', 'Gampaha', 'Western', 'No. 34, Main Street, Negombo', '+94312234567', NULL, 'SP S.P. Fernando', '2026-09-04 19:37:24');

-- --------------------------------------------------------

--
-- Table structure for table `system_logs`
--

CREATE TABLE `system_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action_type` varchar(50) DEFAULT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `old_data` text DEFAULT NULL,
  `new_data` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `role` enum('admin','oic','investigator','officer','public') DEFAULT 'officer',
  `police_station_id` int(11) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password_hash`, `full_name`, `email`, `phone`, `role`, `police_station_id`, `profile_image`, `is_active`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'password', 'System Administrator', 'admin@police.lk', '+94112223344', 'admin', 1, NULL, 1, '2026-09-05 02:04:03', '2026-09-04 19:37:24', '2026-09-04 20:34:03'),
(2, 'oic_colombo', 'colombo123', 'SSP K.P. Siripala', 'kpsiripala@police.lk', '+94112432121', 'oic', 1, NULL, 1, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(3, 'investigator1', 'invest123', 'Inspector N.M. Perera', 'nmperera@police.lk', '+94112432122', 'investigator', 1, NULL, 1, NULL, '2026-09-04 19:37:24', '2026-09-04 19:37:24'),
(4, 'officer1', 'password123', 'SI S.G. Jayasinghe', 'sgjayasinghe@police.lk', '+94112432123', 'officer', 1, NULL, 1, NULL, '2026-09-04 19:37:24', '2026-09-04 20:21:09');

-- --------------------------------------------------------

--
-- Table structure for table `warrants`
--

CREATE TABLE `warrants` (
  `warrant_id` int(11) NOT NULL,
  `warrant_code` varchar(20) NOT NULL,
  `case_id` int(11) DEFAULT NULL,
  `criminal_id` int(11) NOT NULL,
  `warrant_type` enum('arrest','search','bail','summons') DEFAULT 'arrest',
  `issued_date` date NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `issued_by` varchar(100) DEFAULT NULL,
  `court_name` varchar(100) DEFAULT NULL,
  `status` enum('active','executed','expired','cancelled') DEFAULT 'active',
  `execution_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `warrants`
--

INSERT INTO `warrants` (`warrant_id`, `warrant_code`, `case_id`, `criminal_id`, `warrant_type`, `issued_date`, `expiry_date`, `issued_by`, `court_name`, `status`, `execution_date`, `notes`, `created_at`) VALUES
(1, 'WAR-001', 3, 4, 'arrest', '2026-08-20', '2026-11-20', 'SP R.M.S. Jayasuriya', 'Negombo Court', 'active', NULL, NULL, '2026-09-04 19:37:24'),
(2, 'WAR-002', 2, 2, 'search', '2026-07-21', '2026-10-21', 'SSP K.P. Siripala', 'Colombo Magistrate Court', 'executed', NULL, NULL, '2026-09-04 19:37:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_trail`
--
ALTER TABLE `audit_trail`
  ADD PRIMARY KEY (`audit_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cases`
--
ALTER TABLE `cases`
  ADD PRIMARY KEY (`case_id`),
  ADD UNIQUE KEY `case_code` (`case_code`),
  ADD KEY `crime_category_id` (`crime_category_id`),
  ADD KEY `assigned_officer_id` (`assigned_officer_id`),
  ADD KEY `investigating_officer_id` (`investigating_officer_id`),
  ADD KEY `police_station_id` (`police_station_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `case_criminals`
--
ALTER TABLE `case_criminals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `criminal_id` (`criminal_id`);

--
-- Indexes for table `clearance_certificates`
--
ALTER TABLE `clearance_certificates`
  ADD PRIMARY KEY (`certificate_id`),
  ADD UNIQUE KEY `certificate_code` (`certificate_code`),
  ADD KEY `verified_by` (`verified_by`);

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`complaint_id`),
  ADD UNIQUE KEY `complaint_code` (`complaint_code`),
  ADD KEY `assigned_officer_id` (`assigned_officer_id`),
  ADD KEY `police_station_id` (`police_station_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `court_hearings`
--
ALTER TABLE `court_hearings`
  ADD PRIMARY KEY (`hearing_id`),
  ADD KEY `case_id` (`case_id`);

--
-- Indexes for table `crime_categories`
--
ALTER TABLE `crime_categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_code` (`category_code`);

--
-- Indexes for table `criminals`
--
ALTER TABLE `criminals`
  ADD PRIMARY KEY (`criminal_id`),
  ADD UNIQUE KEY `criminal_code` (`criminal_code`),
  ADD UNIQUE KEY `nic` (`nic`),
  ADD KEY `police_station_id` (`police_station_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `criminal_crimes`
--
ALTER TABLE `criminal_crimes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `criminal_id` (`criminal_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `evidence`
--
ALTER TABLE `evidence`
  ADD PRIMARY KEY (`evidence_id`),
  ADD UNIQUE KEY `evidence_code` (`evidence_code`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `collected_by` (`collected_by`);

--
-- Indexes for table `fines`
--
ALTER TABLE `fines`
  ADD PRIMARY KEY (`fine_id`),
  ADD UNIQUE KEY `fine_code` (`fine_code`),
  ADD KEY `criminal_id` (`criminal_id`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `issued_by` (`issued_by`);

--
-- Indexes for table `investigations`
--
ALTER TABLE `investigations`
  ADD PRIMARY KEY (`investigation_id`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `investigating_officer_id` (`investigating_officer_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `police_stations`
--
ALTER TABLE `police_stations`
  ADD PRIMARY KEY (`station_id`),
  ADD UNIQUE KEY `station_code` (`station_code`);

--
-- Indexes for table `system_logs`
--
ALTER TABLE `system_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `warrants`
--
ALTER TABLE `warrants`
  ADD PRIMARY KEY (`warrant_id`),
  ADD UNIQUE KEY `warrant_code` (`warrant_code`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `criminal_id` (`criminal_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_trail`
--
ALTER TABLE `audit_trail`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cases`
--
ALTER TABLE `cases`
  MODIFY `case_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `case_criminals`
--
ALTER TABLE `case_criminals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `clearance_certificates`
--
ALTER TABLE `clearance_certificates`
  MODIFY `certificate_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `complaint_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `court_hearings`
--
ALTER TABLE `court_hearings`
  MODIFY `hearing_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `crime_categories`
--
ALTER TABLE `crime_categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `criminals`
--
ALTER TABLE `criminals`
  MODIFY `criminal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `criminal_crimes`
--
ALTER TABLE `criminal_crimes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `evidence`
--
ALTER TABLE `evidence`
  MODIFY `evidence_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fines`
--
ALTER TABLE `fines`
  MODIFY `fine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `investigations`
--
ALTER TABLE `investigations`
  MODIFY `investigation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `police_stations`
--
ALTER TABLE `police_stations`
  MODIFY `station_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `system_logs`
--
ALTER TABLE `system_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `warrants`
--
ALTER TABLE `warrants`
  MODIFY `warrant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_trail`
--
ALTER TABLE `audit_trail`
  ADD CONSTRAINT `audit_fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `cases`
--
ALTER TABLE `cases`
  ADD CONSTRAINT `cases_fk_assigned` FOREIGN KEY (`assigned_officer_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `cases_fk_category` FOREIGN KEY (`crime_category_id`) REFERENCES `crime_categories` (`category_id`),
  ADD CONSTRAINT `cases_fk_investigator` FOREIGN KEY (`investigating_officer_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `cases_fk_station` FOREIGN KEY (`police_station_id`) REFERENCES `police_stations` (`station_id`),
  ADD CONSTRAINT `cases_fk_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `case_criminals`
--
ALTER TABLE `case_criminals`
  ADD CONSTRAINT `case_criminals_fk_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `case_criminals_fk_criminal` FOREIGN KEY (`criminal_id`) REFERENCES `criminals` (`criminal_id`) ON DELETE CASCADE;

--
-- Constraints for table `clearance_certificates`
--
ALTER TABLE `clearance_certificates`
  ADD CONSTRAINT `clearance_fk_user` FOREIGN KEY (`verified_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_fk_officer` FOREIGN KEY (`assigned_officer_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `complaints_fk_station` FOREIGN KEY (`police_station_id`) REFERENCES `police_stations` (`station_id`),
  ADD CONSTRAINT `complaints_fk_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `court_hearings`
--
ALTER TABLE `court_hearings`
  ADD CONSTRAINT `court_hearings_fk_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`) ON DELETE CASCADE;

--
-- Constraints for table `criminals`
--
ALTER TABLE `criminals`
  ADD CONSTRAINT `criminals_fk_station` FOREIGN KEY (`police_station_id`) REFERENCES `police_stations` (`station_id`),
  ADD CONSTRAINT `criminals_fk_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `criminal_crimes`
--
ALTER TABLE `criminal_crimes`
  ADD CONSTRAINT `criminal_crimes_fk_category` FOREIGN KEY (`category_id`) REFERENCES `crime_categories` (`category_id`),
  ADD CONSTRAINT `criminal_crimes_fk_criminal` FOREIGN KEY (`criminal_id`) REFERENCES `criminals` (`criminal_id`) ON DELETE CASCADE;

--
-- Constraints for table `evidence`
--
ALTER TABLE `evidence`
  ADD CONSTRAINT `evidence_fk_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`),
  ADD CONSTRAINT `evidence_fk_user` FOREIGN KEY (`collected_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `fines`
--
ALTER TABLE `fines`
  ADD CONSTRAINT `fines_fk_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`),
  ADD CONSTRAINT `fines_fk_criminal` FOREIGN KEY (`criminal_id`) REFERENCES `criminals` (`criminal_id`),
  ADD CONSTRAINT `fines_fk_user` FOREIGN KEY (`issued_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `investigations`
--
ALTER TABLE `investigations`
  ADD CONSTRAINT `investigations_fk_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`),
  ADD CONSTRAINT `investigations_fk_user` FOREIGN KEY (`investigating_officer_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `system_logs`
--
ALTER TABLE `system_logs`
  ADD CONSTRAINT `logs_fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `warrants`
--
ALTER TABLE `warrants`
  ADD CONSTRAINT `warrants_fk_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`),
  ADD CONSTRAINT `warrants_fk_criminal` FOREIGN KEY (`criminal_id`) REFERENCES `criminals` (`criminal_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
