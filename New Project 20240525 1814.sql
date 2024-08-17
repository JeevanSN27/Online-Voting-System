-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.22-community-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema qrvoting
--

CREATE DATABASE IF NOT EXISTS qrvoting;
USE qrvoting;

--
-- Definition of table `add_candidate`
--

DROP TABLE IF EXISTS `add_candidate`;
CREATE TABLE `add_candidate` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `election_name` varchar(145) NOT NULL,
  `candidate_name` varchar(45) NOT NULL,
  `address` varchar(445) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `photo` longblob NOT NULL,
  `party_name` varchar(145) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `add_candidate`
--

/*!40000 ALTER TABLE `add_candidate` DISABLE KEYS */;
/*!40000 ALTER TABLE `add_candidate` ENABLE KEYS */;


--
-- Definition of table `add_election`
--

DROP TABLE IF EXISTS `add_election`;
CREATE TABLE `add_election` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `election_name` varchar(145) NOT NULL,
  `end_date` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `add_election`
--

/*!40000 ALTER TABLE `add_election` DISABLE KEYS */;
/*!40000 ALTER TABLE `add_election` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `gender` varchar(10) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(255) NOT NULL,
  `aadhaar` varchar(20) NOT NULL,
  `voterid` longblob NOT NULL,
  `password` varchar(255) NOT NULL,
  `rtime` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `ustatus` varchar(45) default 'No',
  `image_data` longblob,
  `unique_id` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `vote`
--

DROP TABLE IF EXISTS `vote`;
CREATE TABLE `vote` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `election_name` varchar(145) NOT NULL,
  `cid` varchar(45) NOT NULL,
  `candidate_name` varchar(145) NOT NULL,
  `uname` varchar(145) NOT NULL,
  `uid` varchar(45) NOT NULL,
  `time` varchar(45) NOT NULL,
  `ustatus` varchar(45) NOT NULL,
  `imageData` longblob NOT NULL,
  `eid` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vote`
--

/*!40000 ALTER TABLE `vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `vote` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
