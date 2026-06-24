-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: hastanesistemi
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `Admin_ID` int NOT NULL,
  `Kullanici_ID` int NOT NULL,
  PRIMARY KEY (`Admin_ID`),
  KEY `Kullanici_ID` (`Kullanici_ID`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`Kullanici_ID`) REFERENCES `kullanici` (`Kullanici_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (999,4);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doktor`
--

DROP TABLE IF EXISTS `doktor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doktor` (
  `Doktor_ID` int NOT NULL,
  `Uzmanlik` varchar(100) NOT NULL,
  `Kullanici_ID` int NOT NULL,
  PRIMARY KEY (`Doktor_ID`),
  KEY `Kullanici_ID` (`Kullanici_ID`),
  CONSTRAINT `doktor_ibfk_1` FOREIGN KEY (`Kullanici_ID`) REFERENCES `kullanici` (`Kullanici_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doktor`
--

LOCK TABLES `doktor` WRITE;
/*!40000 ALTER TABLE `doktor` DISABLE KEYS */;
INSERT INTO `doktor` VALUES (101,'Psikiyatri',3),(102,'Dahiliye',13),(103,'Kardiyoloji',14),(104,'Göz Hastalıkları',15);
/*!40000 ALTER TABLE `doktor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hasta`
--

DROP TABLE IF EXISTS `hasta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hasta` (
  `TC_Kimlik` varchar(11) NOT NULL,
  `Ad_Soyad` varchar(100) NOT NULL,
  `Dogum_Tarihi` date DEFAULT NULL,
  `Sehir` varchar(50) DEFAULT NULL,
  `Ilce` varchar(50) DEFAULT NULL,
  `Mahalle` varchar(50) DEFAULT NULL,
  `Kullanici_ID` int NOT NULL,
  `Kan_Grubu` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`TC_Kimlik`),
  KEY `Kullanici_ID` (`Kullanici_ID`),
  KEY `idx_hasta_ad_btree` (`Ad_Soyad`) USING BTREE,
  KEY `idx_hasta_tc_hash` (`TC_Kimlik`),
  CONSTRAINT `hasta_ibfk_1` FOREIGN KEY (`Kullanici_ID`) REFERENCES `kullanici` (`Kullanici_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hasta`
--

LOCK TABLES `hasta` WRITE;
/*!40000 ALTER TABLE `hasta` DISABLE KEYS */;
INSERT INTO `hasta` VALUES ('10101010101','Öykü Koç','1995-04-23','İstanbul','Şişli','Mecidiyeköy',12,NULL),('11111111111','Tolgacan Serbes','2000-03-24','İstanbul','Eyüp','Alibeyköy',1,NULL),('22222222222','Güneş Taşkıran','1999-12-01','Ankara','Çankaya','Kızılay',2,NULL),('33333333333','Çağrı Sinci','1988-12-13','İzmir','Bornova','Evka 3',5,NULL),('44444444444','Zeynep Tanyıldız','1994-07-28','İzmir','Konak','Gürçeşme',6,NULL),('55555555555','Alperen Şengün','2002-07-25','Giresun','Keşap','Gülburnu',7,NULL),('66666666666','Wade Baldwin','1996-03-29','New Jersey','Belle Mead','Chelsea',8,NULL),('77777777777','Can Bozok','1988-05-19','Denizli','Beylerbeyi','Saltak',9,NULL),('88888888888','Elif Şahin','1990-12-12','Bursa','Nilüfer','Özlüce',10,NULL),('99999999999','Fatih Terim','1953-09-04','Adana','Seyhan','Ziyapaşa',11,NULL);
/*!40000 ALTER TABLE `hasta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hasta_telefon`
--

DROP TABLE IF EXISTS `hasta_telefon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hasta_telefon` (
  `Telefon_No` varchar(15) NOT NULL,
  `Hasta_TC_Kimlik` varchar(11) NOT NULL,
  PRIMARY KEY (`Telefon_No`,`Hasta_TC_Kimlik`),
  KEY `Hasta_TC_Kimlik` (`Hasta_TC_Kimlik`),
  CONSTRAINT `hasta_telefon_ibfk_1` FOREIGN KEY (`Hasta_TC_Kimlik`) REFERENCES `hasta` (`TC_Kimlik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hasta_telefon`
--

LOCK TABLES `hasta_telefon` WRITE;
/*!40000 ALTER TABLE `hasta_telefon` DISABLE KEYS */;
INSERT INTO `hasta_telefon` VALUES ('05321112233','11111111111'),('05554445566','22222222222');
/*!40000 ALTER TABLE `hasta_telefon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kullanici`
--

DROP TABLE IF EXISTS `kullanici`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kullanici` (
  `Kullanici_ID` int NOT NULL,
  `E_Posta` varchar(100) NOT NULL,
  `Sifre` varchar(50) NOT NULL,
  PRIMARY KEY (`Kullanici_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kullanici`
--

LOCK TABLES `kullanici` WRITE;
/*!40000 ALTER TABLE `kullanici` DISABLE KEYS */;
INSERT INTO `kullanici` VALUES (1,'tolgacan.serbes@mail.com','sifre123'),(2,'gunes.taskiran@mail.com','gunes456'),(3,'volkan.ayvazoglu@mail.com','volkan789'),(4,'admin@hastane.com','adminpass'),(5,'cagri.sinci@mail.com','pass1'),(6,'zeynep.tanyildiz@mail.com','pass2'),(7,'alperen.sungun@mail.com','pass3'),(8,'wade.baldwin@mail.com','pass4'),(9,'can.bozok@mail.com','pass5'),(10,'elif.sahin@mail.com','pass6'),(11,'fatih.terim@mail.com','pass7'),(12,'oyku.koc@mail.com','pass8'),(13,'hakan.calhanoglu@mail.com','pass9'),(14,'travis.scott@mail.com','pass10'),(15,'leyla.mecnun@mail.com','pass11');
/*!40000 ALTER TABLE `kullanici` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `muayene`
--

DROP TABLE IF EXISTS `muayene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muayene` (
  `Hasta_TC_Kimlik` varchar(11) NOT NULL,
  `Doktor_ID` int NOT NULL,
  PRIMARY KEY (`Hasta_TC_Kimlik`,`Doktor_ID`),
  KEY `Doktor_ID` (`Doktor_ID`),
  CONSTRAINT `muayene_ibfk_1` FOREIGN KEY (`Hasta_TC_Kimlik`) REFERENCES `hasta` (`TC_Kimlik`),
  CONSTRAINT `muayene_ibfk_2` FOREIGN KEY (`Doktor_ID`) REFERENCES `doktor` (`Doktor_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `muayene`
--

LOCK TABLES `muayene` WRITE;
/*!40000 ALTER TABLE `muayene` DISABLE KEYS */;
INSERT INTO `muayene` VALUES ('11111111111',101),('22222222222',101),('33333333333',102),('66666666666',102),('44444444444',103),('55555555555',104);
/*!40000 ALTER TABLE `muayene` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recete`
--

DROP TABLE IF EXISTS `recete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recete` (
  `Recete_No` int NOT NULL,
  `Hasta_TC_Kimlik` varchar(11) NOT NULL,
  `Tarih` date DEFAULT NULL,
  `Dozaj` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Recete_No`,`Hasta_TC_Kimlik`),
  KEY `Hasta_TC_Kimlik` (`Hasta_TC_Kimlik`),
  CONSTRAINT `recete_ibfk_1` FOREIGN KEY (`Hasta_TC_Kimlik`) REFERENCES `hasta` (`TC_Kimlik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recete`
--

LOCK TABLES `recete` WRITE;
/*!40000 ALTER TABLE `recete` DISABLE KEYS */;
INSERT INTO `recete` VALUES (1001,'11111111111','2026-05-25','Günde 1 tok karnına'),(1002,'22222222222','2026-05-26','Sabah akşam 1 adet'),(1003,'33333333333','2026-05-20','Günde 2 tok'),(1004,'44444444444','2026-05-21','Sabah 1 aç'),(1005,'55555555555','2026-05-22','Günde 1 damla');
/*!40000 ALTER TABLE `recete` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-25 23:37:50
