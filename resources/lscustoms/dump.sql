CREATE DATABASE  IF NOT EXISTS `gfav_n3m` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `gfav_n3m`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 151.236.37.159    Database: gfav_n3m
-- ------------------------------------------------------
-- Server version	5.7.18-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user_vehmods`
--

DROP TABLE IF EXISTS `user_vehmods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_vehmods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `mod24` varchar(45) DEFAULT '-1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate_UNIQUE` (`plate`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-28 16:21:45
