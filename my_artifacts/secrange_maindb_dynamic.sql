-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 07, 2018 at 03:31 PM
-- Server version: 5.7.23-0ubuntu0.18.04.1
-- PHP Version: 7.2.7-0ubuntu0.18.04.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `secrange_maindb`
--

-- --------------------------------------------------------

--
-- Table structure for table `alembic_version`
--

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('d7bfc69b0142');

-- --------------------------------------------------------

--
-- Table structure for table `sec_category`
--

CREATE TABLE `sec_category` (
  `id` int(11) NOT NULL,
  `cat_name` varchar(60) DEFAULT NULL,
  `cat_publish` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_category`
--

INSERT INTO `sec_category` (`id`, `cat_name`, `cat_publish`) VALUES
(1, 'Developer Tasks', 1),
(2, 'Secretarial Tasks', 1),
(3, 'General Usage', 1),
(4, 'Database Tasks', 1),
(5, 'Malicious user', 0);

-- --------------------------------------------------------

--
-- Table structure for table `sec_industry`
--

CREATE TABLE `sec_industry` (
  `id` int(11) NOT NULL,
  `industry_name` varchar(60) DEFAULT NULL,
  `industry_core` int(11) DEFAULT NULL,
  `industry_serverip` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_industry`
--

INSERT INTO `sec_industry` (`id`, `industry_name`, `industry_core`, `industry_serverip`) VALUES
(1, 'Software Development', 1, 'devserver'),
(2, 'Surgery (Health)', 4, 'bankserver'),
(3, 'Law Firm', 2, 'ftpserve');

-- --------------------------------------------------------

--
-- Table structure for table `sec_instances`
--

CREATE TABLE `sec_instances` (
  `instance_id` int(11) NOT NULL,
  `instance_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `instance_end` timestamp NULL DEFAULT NULL,
  `instance_projectid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_instances`
--

INSERT INTO `sec_instances` (`instance_id`, `instance_start`, `instance_end`, `instance_projectid`) VALUES
(1, '2018-07-09 11:23:00', NULL, 3),
(2, '2018-07-09 11:23:45', NULL, 3),
(3, '2018-07-09 11:24:30', NULL, 3),
(4, '2018-07-09 11:25:36', NULL, 3),
(5, '2018-07-09 11:26:17', NULL, 3),
(6, '2018-07-09 11:47:29', NULL, 2),
(7, '2018-07-09 11:51:08', NULL, 1),
(8, '2018-07-09 12:16:23', NULL, 2),
(9, '2018-07-09 12:23:28', NULL, 6),
(10, '2018-07-09 12:24:09', NULL, 4),
(11, '2018-07-09 12:35:11', NULL, 4),
(12, '2018-07-09 12:35:24', NULL, 1),
(13, '2018-07-09 13:36:54', '2018-07-09 13:36:55', 1),
(14, '2018-07-09 13:41:00', NULL, 2),
(15, '2018-07-09 13:42:53', '2018-07-09 13:42:53', 1),
(16, '2018-07-11 16:20:56', '2018-07-11 16:20:56', 7),
(17, '2018-07-11 16:21:10', '2018-07-11 16:21:11', 7),
(18, '2018-07-11 16:32:10', NULL, 7),
(19, '2018-07-20 13:22:08', '2018-07-20 13:22:09', 8),
(20, '2018-07-20 13:33:32', NULL, 8),
(21, '2018-07-22 19:50:00', NULL, 1),
(22, '2018-07-22 20:11:06', NULL, 1),
(23, '2018-07-22 20:11:12', NULL, 1),
(24, '2018-07-22 20:12:26', NULL, 2),
(25, '2018-07-22 20:25:13', NULL, 1),
(26, '2018-07-22 20:28:15', NULL, 4),
(27, '2018-07-22 20:29:07', NULL, 6),
(28, '2018-07-22 20:46:38', NULL, 2),
(29, '2018-07-22 22:08:06', NULL, 4),
(30, '2018-07-22 22:08:49', NULL, 4),
(31, '2018-07-23 08:14:50', '2018-07-23 08:14:50', 1),
(32, '2018-07-23 08:16:20', '2018-07-23 08:16:21', 2),
(33, '2018-07-23 10:31:30', NULL, 9),
(34, '2018-07-23 11:45:52', NULL, 9),
(35, '2018-07-24 13:26:40', NULL, 2),
(36, '2018-07-24 13:32:41', NULL, 4),
(37, '2018-07-24 13:33:28', NULL, 2),
(38, '2018-07-24 13:53:10', NULL, 6),
(39, '2018-07-24 13:55:56', NULL, 2),
(40, '2018-07-24 14:37:36', NULL, 1),
(41, '2018-07-24 14:38:54', NULL, 1),
(42, '2018-07-24 14:38:56', NULL, 1),
(43, '2018-07-24 14:39:32', NULL, 2),
(44, '2018-07-24 14:40:54', NULL, 2),
(45, '2018-07-24 14:43:03', NULL, 1),
(46, '2018-07-24 14:44:49', NULL, 1),
(47, '2018-07-24 14:49:19', NULL, 2),
(48, '2018-07-24 14:49:51', NULL, 1),
(49, '2018-07-24 14:51:49', NULL, 1),
(50, '2018-07-24 14:52:48', NULL, 1),
(51, '2018-07-24 14:52:55', NULL, 1),
(52, '2018-07-24 14:53:44', NULL, 4),
(53, '2018-07-24 14:54:26', NULL, 2),
(54, '2018-07-24 14:56:19', NULL, 1),
(55, '2018-07-24 14:56:31', NULL, 1),
(56, '2018-07-24 14:57:25', NULL, 1),
(57, '2018-07-24 15:00:18', NULL, 4),
(58, '2018-07-24 15:02:51', NULL, 2),
(59, '2018-07-24 15:03:10', NULL, 1),
(60, '2018-07-24 15:03:23', NULL, 1),
(61, '2018-07-24 15:05:27', NULL, 1),
(62, '2018-07-24 15:07:00', NULL, 2),
(63, '2018-07-24 15:10:31', NULL, 2),
(64, '2018-07-24 15:52:45', NULL, 2),
(65, '2018-07-24 15:53:50', NULL, 2),
(66, '2018-07-24 15:54:10', NULL, 2),
(67, '2018-07-24 15:55:36', NULL, 1),
(68, '2018-07-24 15:57:44', NULL, 1),
(69, '2018-07-24 15:59:28', NULL, 1),
(70, '2018-07-24 16:00:06', NULL, 1),
(71, '2018-07-24 16:03:55', NULL, 1),
(72, '2018-07-24 16:24:44', NULL, 2),
(73, '2018-07-24 16:24:45', NULL, 2),
(74, '2018-07-25 15:58:10', NULL, 2),
(75, '2018-07-25 15:58:10', NULL, 2),
(76, '2018-07-25 15:58:11', NULL, 2),
(77, '2018-08-08 16:21:23', NULL, 10),
(78, '2018-08-08 16:21:50', NULL, 10),
(79, '2018-08-12 06:50:06', NULL, 12),
(80, '2018-08-12 06:50:07', NULL, 12),
(81, '2018-08-12 06:50:07', NULL, 12),
(82, '2018-08-12 06:50:07', NULL, 12),
(83, '2018-08-12 06:55:03', NULL, 12),
(84, '2018-08-12 06:55:49', NULL, 12),
(85, '2018-08-12 07:02:26', NULL, 12),
(86, '2018-08-12 07:03:59', NULL, 12),
(87, '2018-08-12 07:10:06', NULL, 12),
(88, '2018-08-12 07:12:09', NULL, 12),
(89, '2018-08-12 07:12:31', NULL, 12),
(90, '2018-08-12 07:58:41', NULL, 12),
(91, '2018-08-12 08:09:46', NULL, 12),
(92, '2018-08-12 08:15:59', NULL, 12),
(93, '2018-08-12 08:20:18', NULL, 12),
(94, '2018-08-12 08:24:07', NULL, 12),
(95, '2018-08-12 09:05:53', '2018-08-12 09:05:53', 12),
(96, '2018-08-31 21:38:39', NULL, 17),
(97, '2018-08-31 21:51:26', NULL, 17),
(98, '2018-09-01 00:14:23', NULL, 17),
(99, '2018-09-01 00:23:39', NULL, 17),
(100, '2018-09-01 00:24:15', NULL, 17),
(101, '2018-09-01 00:29:24', NULL, 17),
(102, '2018-09-01 00:30:41', NULL, 17),
(103, '2018-09-01 00:30:57', NULL, 17),
(104, '2018-09-01 00:35:23', '2018-09-01 00:35:23', 17),
(105, '2018-09-02 00:21:32', NULL, 17),
(106, '2018-09-02 00:33:00', NULL, 17),
(107, '2018-09-02 00:44:10', NULL, 17),
(108, '2018-09-02 00:59:35', NULL, 17),
(109, '2018-09-02 01:13:47', NULL, 17),
(110, '2018-09-07 13:27:02', NULL, 17),
(111, '2018-09-07 13:43:52', '2018-09-07 13:43:52', 17),
(112, '2018-09-07 13:54:55', NULL, 17),
(113, '2018-09-07 14:30:57', '2018-09-07 14:30:57', 17);

-- --------------------------------------------------------

--
-- Table structure for table `sec_organisation`
--

CREATE TABLE `sec_organisation` (
  `id` int(11) NOT NULL,
  `org_email` varchar(60) DEFAULT NULL,
  `org_phone` varchar(60) DEFAULT NULL,
  `org_name` varchar(60) DEFAULT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  `org_sizeid` int(11) DEFAULT NULL,
  `org_industryid` int(11) DEFAULT NULL,
  `org_status` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_organisation`
--

INSERT INTO `sec_organisation` (`id`, `org_email`, `org_phone`, `org_name`, `password_hash`, `org_sizeid`, `org_industryid`, `org_status`) VALUES
(1, 'mos@yahoo.com', '08045674555', 'Mosaic Corporations', 'pbkdf2:sha256:50000$XDXQOSh8$ec309e2ee8417e90a8fac8db319587abe1ea5d7d28db7f962276dee7e2f999cc', NULL, 1, 1),
(2, 'upper@yahoo.com', '1234567', 'Upperlink Limited', 'pbkdf2:sha256:50000$avsZfyyz$1ec2a642e3aa446a58aca698dfa669947bcfdaf18f83df19a8e2755edc5421f3', NULL, 1, 1),
(3, 'ad@yahoo.com', '0803456788', 'Adversary Incorporated', 'pbkdf2:sha256:50000$P0bDQamZ$91e276d7c1dddbc24599e71231becce6750e853006aded67c73abb97d4033daf', NULL, 2, 1),
(4, 'cardiff@y.com', '08045246677', 'Cardiff University', 'pbkdf2:sha256:50000$nYubAhGt$dbb05a745ad1320418d8da4ba5d78c75267adf7d5f918fde34a1991f7c484399', NULL, 1, 1),
(5, 'fraser@yahoo.com', '08802323567', 'House of Fraser', 'pbkdf2:sha256:50000$VR1MvD77$79eedd850691cbe1e780e8ca54138d7fc68d67ce0befa8c589ae424cfb8d751e', NULL, 2, 1),
(6, 'co@y.com', '0984567899', 'Cofense Security Inc.', 'pbkdf2:sha256:50000$AHtIvzJ6$634987f37059615877024d3391376ce8fc6651385c0bfef2548db061677623ea', NULL, 1, 1),
(7, 'mod@yahoo.com', '+44708299098', 'Mod Insurance', 'pbkdf2:sha256:50000$qeK1gibv$ce439de2b6bf07a4a031f6d3e30cdb3f26ad6ca6bb2f7df9a67b565d604a7f86', NULL, 2, 1),
(8, 'james@stanley.com', '+44708299098', 'Stanley James Limited', 'pbkdf2:sha256:50000$Ka6ecDB2$39e53b9789eb8654375d2e355e531d9fb2ba1515615525cd8bdbe8915ae308fc', NULL, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `sec_project`
--

CREATE TABLE `sec_project` (
  `id` int(11) NOT NULL,
  `project_name` varchar(100) DEFAULT NULL,
  `project_details` varchar(128) DEFAULT NULL,
  `project_industryid` int(11) DEFAULT NULL,
  `project_datesetup` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `project_status` varchar(128) DEFAULT NULL,
  `project_orgid` int(11) DEFAULT NULL,
  `project_ip` varchar(50) DEFAULT NULL,
  `project_netip` varchar(50) DEFAULT NULL,
  `project_netos` varchar(50) DEFAULT NULL,
  `project_bandwidth_delay` int(11) DEFAULT NULL,
  `project_totalnodes` int(11) DEFAULT NULL,
  `project_corenodes` int(11) DEFAULT NULL,
  `project_coreos` varchar(50) DEFAULT NULL,
  `project_generalnodes` int(11) DEFAULT NULL,
  `project_generalos` varchar(50) DEFAULT NULL,
  `project_extratraffic` int(11) DEFAULT NULL,
  `collection_pointip` varchar(100) DEFAULT NULL,
  `insider_threat` int(11) DEFAULT NULL,
  `outsider_threat` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_project`
--

INSERT INTO `sec_project` (`id`, `project_name`, `project_details`, `project_industryid`, `project_datesetup`, `project_status`, `project_orgid`, `project_ip`, `project_netip`, `project_netos`, `project_bandwidth_delay`, `project_totalnodes`, `project_corenodes`, `project_coreos`, `project_generalnodes`, `project_generalos`, `project_extratraffic`, `collection_pointip`, `insider_threat`, `outsider_threat`) VALUES
(1, 'Checking Openflow on low bandwidth', 'My first experiment on SMEin a BOX', 1, '2018-07-08 05:55:10', 'active', 1, NULL, NULL, 'Linux', 100, 25, 20, 'Windows', 5, 'Linux', 1, NULL, NULL, NULL),
(2, 'Assessing The Effectiveness of Symantec Norton Antivirus', 'template for research', 3, '2018-07-08 07:56:16', 'active', 1, NULL, NULL, 'Linux', 200, 100, 90, 'Linux', 10, 'Windows', 1, NULL, NULL, NULL),
(3, 'Identifying Attacker Behaviour', 'A mini research for mr Sola', 1, '2018-07-08 08:57:27', 'active', 2, NULL, NULL, 'Linux', 1000, 15, 8, 'Linux', 7, 'Windows', 1, NULL, NULL, NULL),
(4, 'Examining Packet Loss in Remote Locations', 'A simple experiment', 2, '2018-07-08 20:28:55', 'active', 1, NULL, NULL, 'Windows', 1000, 10, 6, 'Windows', 4, 'Windows', 1, NULL, NULL, NULL),
(5, 'Halting Social Engineering', 'experiment for our client', 1, '2018-07-08 21:13:44', 'active', 3, NULL, NULL, 'Windows', 10, 23, 12, 'Linux', 11, 'Linux', 1, NULL, NULL, NULL),
(6, 'Testing Effectiveness of Norton Antivirus Attachements', 'My sample test', 2, '2018-07-09 12:23:14', 'active', 1, NULL, NULL, 'Windows', 100, 12, 6, 'Windows', 6, 'Linux', 1, NULL, NULL, NULL),
(7, 'Testing Norton', '', 1, '2018-07-11 15:58:19', 'active', 1, NULL, NULL, 'Windows', 100, 25, 15, 'Windows', 10, 'Windows', 1, NULL, NULL, NULL),
(8, 'GDPR Test', 'sample exp', 3, '2018-07-20 13:21:52', 'active', 1, NULL, NULL, 'Windows', 100, 16, 6, 'Windows', 10, 'Linux', 1, NULL, NULL, NULL),
(9, 'Experimentation On Openstack', 'test description', 1, '2018-07-23 11:43:48', 'active', 4, NULL, NULL, 'Windows', 1000, 4, 3, 'Linux', 1, 'Windows', 1, NULL, NULL, NULL),
(10, 'Examining the Effect of GDPR', 'Project Supervised by Prof', 1, '2018-08-08 15:05:26', 'active', 6, NULL, NULL, 'Linux', 100, NULL, 12, 'Windows', 6, 'Windows', 1, NULL, 1, 1),
(11, 'Open Data', 'HSE EDUCATION', 3, '2018-08-08 19:12:18', 'active', 6, NULL, NULL, 'Windows', 1000, NULL, 1, 'Windows', 2, 'Linux', 1, NULL, 1, 1),
(12, 'Cardiff Uni', 'Test', 1, '2018-08-12 09:06:35', 'active', 6, NULL, NULL, 'Windows', 0, NULL, 1, 'Windows', 1, 'Linux', 1, NULL, 1, 1),
(13, 'Random EXperiment', 'random thoughts', 1, '2018-08-21 04:31:08', 'active', 1, NULL, NULL, '0', 100, NULL, 1, 'Linux', 1, 'Linux', 1, NULL, 1, 1),
(14, 'bebbe', 'test', 1, '2018-08-21 06:46:40', 'active', 1, NULL, NULL, '0', 100, NULL, 1, 'Windows', 1, 'Windows', 0, NULL, 0, 0),
(15, 'Tuuu', 'uuu', 1, '2018-08-21 07:06:16', 'active', 1, NULL, NULL, '0', 100, NULL, 1, 'Windows', 1, 'Linux', 1, NULL, 0, 0),
(16, 'symnatec IDS', 'hhh', 1, '2018-08-24 15:34:19', 'active', 1, NULL, NULL, '0', 100, NULL, 1, 'Windows', 1, 'Linux', 1, NULL, 1, 1),
(17, 'Evaluating Mcafe Gateway Suite', 'Q4 Evaluation', 2, '2018-09-07 13:30:39', 'active', 8, NULL, NULL, 'Linux', 100, NULL, 1, 'Linux', 2, 'Linux', 0, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sec_size`
--

CREATE TABLE `sec_size` (
  `id` int(11) NOT NULL,
  `size_desc` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_size`
--

INSERT INTO `sec_size` (`id`, `size_desc`) VALUES
(1, 'Less than 10'),
(2, '10 - 25'),
(3, '25 - 50'),
(4, '50 - 100'),
(5, 'More than 100');

-- --------------------------------------------------------

--
-- Table structure for table `sec_task`
--

CREATE TABLE `sec_task` (
  `id` int(11) NOT NULL,
  `task_shortname` varchar(60) DEFAULT NULL,
  `task_purpose` varchar(128) DEFAULT NULL,
  `task_catid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_task`
--

INSERT INTO `sec_task` (`id`, `task_shortname`, `task_purpose`, `task_catid`) VALUES
(1, 'Launch Mozilla Firefox Browser', 'User Browsing the Internet', 3),
(2, 'DNS Querying', 'To get information about the DNS', 5),
(3, 'Livehost Scanning', 'To scan LIVE Hosts', 5),
(4, 'Port Scanning', 'Scans ports of hosts in a specified IP address range', 5),
(5, 'Merge PDF Files into 1', 'PDF Files within a directory are all merged into one file', 3),
(6, 'Update columns in a csv file', 'Change the product sales value in a csv file', 3),
(7, 'Launch Word Processing Application', 'Open a document, update and save in a folder', 3),
(8, 'Upload File to FTP server', 'User in a Data organisation keeping their files in a remote FTP server', 2),
(9, 'Access the organisation Internal App', 'carry out day to day function', 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alembic_version`
--
ALTER TABLE `alembic_version`
  ADD PRIMARY KEY (`version_num`);

--
-- Indexes for table `sec_category`
--
ALTER TABLE `sec_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cat_name` (`cat_name`);

--
-- Indexes for table `sec_industry`
--
ALTER TABLE `sec_industry`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `industry_name` (`industry_name`),
  ADD KEY `industry_core` (`industry_core`);

--
-- Indexes for table `sec_instances`
--
ALTER TABLE `sec_instances`
  ADD PRIMARY KEY (`instance_id`),
  ADD KEY `instance_projectid` (`instance_projectid`);

--
-- Indexes for table `sec_organisation`
--
ALTER TABLE `sec_organisation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_sec_organisation_org_email` (`org_email`),
  ADD KEY `org_industryid` (`org_industryid`),
  ADD KEY `org_sizeid` (`org_sizeid`),
  ADD KEY `ix_sec_organisation_org_name` (`org_name`),
  ADD KEY `ix_sec_organisation_org_phone` (`org_phone`);

--
-- Indexes for table `sec_project`
--
ALTER TABLE `sec_project`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_industryid` (`project_industryid`),
  ADD KEY `project_orgid` (`project_orgid`),
  ADD KEY `ix_sec_project_project_name` (`project_name`);

--
-- Indexes for table `sec_size`
--
ALTER TABLE `sec_size`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sec_task`
--
ALTER TABLE `sec_task`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_sec_task_task_shortname` (`task_shortname`),
  ADD KEY `task_catid` (`task_catid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sec_category`
--
ALTER TABLE `sec_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `sec_industry`
--
ALTER TABLE `sec_industry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `sec_instances`
--
ALTER TABLE `sec_instances`
  MODIFY `instance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;
--
-- AUTO_INCREMENT for table `sec_organisation`
--
ALTER TABLE `sec_organisation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `sec_project`
--
ALTER TABLE `sec_project`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `sec_size`
--
ALTER TABLE `sec_size`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `sec_task`
--
ALTER TABLE `sec_task`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `sec_industry`
--
ALTER TABLE `sec_industry`
  ADD CONSTRAINT `sec_industry_ibfk_1` FOREIGN KEY (`industry_core`) REFERENCES `sec_category` (`id`);

--
-- Constraints for table `sec_instances`
--
ALTER TABLE `sec_instances`
  ADD CONSTRAINT `sec_instances_ibfk_1` FOREIGN KEY (`instance_projectid`) REFERENCES `sec_project` (`id`);

--
-- Constraints for table `sec_organisation`
--
ALTER TABLE `sec_organisation`
  ADD CONSTRAINT `sec_organisation_ibfk_1` FOREIGN KEY (`org_industryid`) REFERENCES `sec_industry` (`id`),
  ADD CONSTRAINT `sec_organisation_ibfk_2` FOREIGN KEY (`org_sizeid`) REFERENCES `sec_size` (`id`);

--
-- Constraints for table `sec_project`
--
ALTER TABLE `sec_project`
  ADD CONSTRAINT `sec_project_ibfk_1` FOREIGN KEY (`project_industryid`) REFERENCES `sec_industry` (`id`),
  ADD CONSTRAINT `sec_project_ibfk_2` FOREIGN KEY (`project_orgid`) REFERENCES `sec_organisation` (`id`);

--
-- Constraints for table `sec_task`
--
ALTER TABLE `sec_task`
  ADD CONSTRAINT `sec_task_ibfk_1` FOREIGN KEY (`task_catid`) REFERENCES `sec_category` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
