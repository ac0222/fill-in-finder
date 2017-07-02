-- MySQL dump 10.13  Distrib 5.7.18, for macos10.12 (x86_64)
--
-- Host: localhost    Database: rfl
-- ------------------------------------------------------
-- Server version	5.7.18

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
-- Table structure for table `FillInRequest`
--

DROP TABLE IF EXISTS `FillInRequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FillInRequest` (
  `RID` int(11) NOT NULL AUTO_INCREMENT,
  `RequesterID` int(11) NOT NULL,
  `FillInID` int(11) DEFAULT NULL,
  `Active` tinyint(1) NOT NULL,
  PRIMARY KEY (`RID`),
  KEY `RequesterID` (`RequesterID`),
  KEY `FillInID` (`FillInID`),
  CONSTRAINT `fillinrequest_ibfk_1` FOREIGN KEY (`RequesterID`) REFERENCES `Player` (`PlayerID`),
  CONSTRAINT `fillinrequest_ibfk_2` FOREIGN KEY (`FillInID`) REFERENCES `Player` (`PlayerID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FillInRequest`
--

LOCK TABLES `FillInRequest` WRITE;
/*!40000 ALTER TABLE `FillInRequest` DISABLE KEYS */;
INSERT INTO `FillInRequest` VALUES (1,100,NULL,1),(2,99,NULL,0);
/*!40000 ALTER TABLE `FillInRequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Player`
--

DROP TABLE IF EXISTS `Player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Player` (
  `PlayerID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `PhoneNumber` varchar(16) NOT NULL,
  `Grade` enum('platinum','gold','silver','bronze','copper') NOT NULL,
  PRIMARY KEY (`PlayerID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Player`
--

LOCK TABLES `Player` WRITE;
/*!40000 ALTER TABLE `Player` DISABLE KEYS */;
INSERT INTO `Player` VALUES (1,'Alfreda','Arnold','(04) 0656 9541','gold'),(2,'Nadine','Schmidt','(06) 0028 8266','copper'),(3,'Katell','Morales','(07) 2591 4667','silver'),(4,'Gregory','Skinner','(01) 5175 9400','bronze'),(5,'Mechelle','Knight','(05) 5027 8021','platinum'),(6,'Aileen','Carver','(04) 7858 0717','platinum'),(7,'Macy','Manning','(06) 7542 4999','copper'),(8,'Rae','Sutton','(05) 8261 6072','gold'),(9,'Barry','Ashley','(02) 9520 6118','silver'),(10,'Althea','Oneil','(01) 7901 4441','platinum'),(11,'Anika','Merritt','(01) 9574 6605','platinum'),(12,'Yoshi','Chen','(06) 6474 1847','silver'),(13,'Carly','Curtis','(08) 5113 9385','platinum'),(14,'Risa','Juarez','(08) 7525 9322','silver'),(15,'Aspen','Aguirre','(07) 5067 7738','silver'),(16,'Nicole','Sweeney','(08) 6216 1256','platinum'),(17,'Derek','Mcintyre','(09) 6013 3587','copper'),(18,'Kareem','Suarez','(08) 2200 0253','copper'),(19,'Quyn','Palmer','(06) 6131 3919','gold'),(20,'Regan','Blackburn','(06) 1448 4850','bronze'),(21,'Maisie','Whitehead','(04) 6495 5652','platinum'),(22,'Gray','Jacobs','(09) 1721 8774','copper'),(23,'Macy','Barr','(02) 3791 3056','copper'),(24,'Joelle','Mills','(09) 6555 8902','gold'),(25,'Amaya','Frost','(09) 5127 7431','platinum'),(26,'Eleanor','Haynes','(06) 0177 5559','silver'),(27,'Zorita','Cruz','(07) 3155 5827','platinum'),(28,'Alyssa','Salinas','(09) 2474 8613','copper'),(29,'Ralph','Winters','(05) 4998 1588','copper'),(30,'Alma','Deleon','(05) 9934 6852','bronze'),(31,'Dennis','Gay','(01) 8964 7954','gold'),(32,'Breanna','Adams','(03) 7317 3701','silver'),(33,'Graiden','Byers','(07) 7579 4401','gold'),(34,'Carla','Tyler','(01) 8155 8120','bronze'),(35,'Mufutau','Fuentes','(09) 3186 2533','bronze'),(36,'Erin','Hicks','(08) 1232 6482','platinum'),(37,'David','Monroe','(09) 9879 7929','copper'),(38,'Gil','Roberts','(09) 9808 8761','gold'),(39,'Linus','Cash','(03) 3285 7064','platinum'),(40,'Hedley','Lawson','(03) 0022 7965','copper'),(41,'Lane','Randall','(05) 3208 8208','copper'),(42,'Rinah','Winters','(08) 5253 3172','silver'),(43,'Herrod','Boyer','(01) 7767 2596','gold'),(44,'Jack','Hansen','(04) 2129 0228','copper'),(45,'Leilani','Carson','(09) 3399 0945','platinum'),(46,'Rafael','Pratt','(04) 9642 4954','copper'),(47,'Myles','Noel','(07) 5532 9770','bronze'),(48,'Casey','Lynn','(05) 2885 4966','platinum'),(49,'Oren','Forbes','(08) 2977 9009','gold'),(50,'Sheila','Mann','(07) 5120 2706','bronze'),(51,'Hammett','Dickson','(05) 6796 8853','platinum'),(52,'Leandra','Head','(08) 1218 5560','silver'),(53,'Yetta','Taylor','(02) 4826 4034','bronze'),(54,'Raven','Carrillo','(02) 4583 3669','silver'),(55,'Kai','Lott','(07) 5456 3872','copper'),(56,'Karen','Barber','(01) 5375 2917','gold'),(57,'Denise','Joyner','(05) 4360 6316','silver'),(58,'Sean','Schultz','(04) 1650 9732','copper'),(59,'Kathleen','Wooten','(09) 0696 6966','platinum'),(60,'Kimberly','Burke','(02) 4320 8296','platinum'),(61,'Logan','Cabrera','(07) 3526 3497','bronze'),(62,'Baxter','Shannon','(09) 1447 8996','gold'),(63,'Zahir','Oneill','(04) 7358 6887','silver'),(64,'Buffy','Cherry','(07) 9985 6191','silver'),(65,'Alan','Hebert','(09) 4554 2030','bronze'),(66,'Erasmus','Lowery','(06) 1569 8544','copper'),(67,'Tanek','Estrada','(08) 5953 1527','copper'),(68,'Roary','Johnston','(09) 9267 8123','gold'),(69,'Maya','Doyle','(06) 5198 5055','copper'),(70,'Cain','Boyd','(09) 7085 7046','platinum'),(71,'Indigo','Fox','(08) 3266 8278','gold'),(72,'Kennan','Randolph','(08) 0723 7557','silver'),(73,'Rachel','Mckee','(06) 9350 3084','silver'),(74,'Larissa','Boyer','(07) 6565 1465','copper'),(75,'Erasmus','Mccall','(05) 5290 9766','bronze'),(76,'Tana','Miranda','(05) 5535 4019','silver'),(77,'Jeanette','Phillips','(04) 7037 7996','silver'),(78,'Linda','Hickman','(01) 9338 7971','bronze'),(79,'Dexter','Faulkner','(01) 7241 8231','copper'),(80,'Yolanda','Mercado','(07) 9276 9547','copper'),(81,'Cassady','Hopper','(06) 7976 0727','bronze'),(82,'Veronica','Graham','(06) 0340 7540','gold'),(83,'Cyrus','Steele','(08) 6981 6355','bronze'),(84,'Duncan','Cameron','(07) 7411 4925','copper'),(85,'Gwendolyn','Wiley','(07) 0342 1289','platinum'),(86,'Imelda','Dorsey','(01) 0149 0093','platinum'),(87,'Hoyt','Daugherty','(01) 2261 6237','copper'),(88,'Bradley','Merritt','(06) 8816 0229','platinum'),(89,'Aidan','Duran','(04) 2194 4529','copper'),(90,'Giselle','Ballard','(09) 1649 7990','gold'),(91,'Marshall','Stafford','(05) 3780 5354','platinum'),(92,'Heather','Cohen','(07) 4108 0146','copper'),(93,'Maite','Whitley','(01) 8042 1533','silver'),(94,'Hillary','Wise','(01) 3581 8282','silver'),(95,'Rana','Hester','(09) 0310 0900','bronze'),(96,'Ivor','Hickman','(02) 8675 3465','bronze'),(97,'Quon','Bridges','(01) 8403 3658','gold'),(98,'Harding','Mooney','(06) 2653 3654','copper'),(99,'Beverly','Grant','(01) 3309 8415','bronze'),(100,'Britanney','Sears','(05) 1541 2133','platinum');
/*!40000 ALTER TABLE `Player` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-02 11:16:49
