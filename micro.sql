T1NKER0
t1nker0
Online

T1NKER0 — 05/05/2024 4:56 PM
Attachment file type: document
CPEN410_PROJECT2_REPORT.docx
20.43 KB
Manny — 05/05/2024 5:30 PM
Attachment file type: document
AR-natomy-EngiDayPoster.pptx
3.74 MB
Attachment file type: document
CPEN410_PROJECT2_REPORT.docx
20.31 KB
T1NKER0 — 05/05/2024 5:43 PM
Attachment file type: archive
Project2_Rodriguez_Manuel_Santana_Marcos.zip
60.30 KB
T1NKER0 — 05/05/2024 6:13 PM
Attachment file type: document
AR-natomy-EngiDayPoster.pptx
3.74 MB
Manny — 05/06/2024 9:22 AM
Attachment file type: archive
pulse-monitor.zip
48.04 KB
Manny — 05/06/2024 9:34 AM
Attachment file type: document
VITALS_AND_TEMPERATURE_MONITORING_SYSTEM_UPDATE1.docx
1.31 MB
Manny — 05/06/2024 9:41 AM
Attachment file type: archive
pulse_sensor_code.zip
1.33 KB
Manny — 05/06/2024 10:08 AM
CREATE DATABASE  IF NOT EXISTS `micro` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `micro`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: micro
-- ------------------------------------------------------
Expand
message.txt
5 KB
Manny — 05/06/2024 10:21 AM
https://1drv.ms/w/s!Ao2xlhHy9FIMugX72tM96IGBrflQ?e=Ipi0Hn
Micro Project.docx
Im going to give you some codes for a micro project I worked on. The project was a very simple vital monitoring system using a very basic pulse sensor and a temperature sensor (ds18b20). The project is structured like so:
Use an arduino uno to handle the pulse and temperature reading
Use an esp32 to connect it to the arduino and form an UART to send the readings to a server
Database to store the readings
Server to send the readings in the database to a very basic webpage.

How the server is handled and codes from the arduino and esp32 will be seen in codes that Ill give you so you can understand the project and then we can build some sort of report and presentation. 
T1NKER0 — 05/06/2024 11:00 AM
Voy a comer un momento
Manny — 05/06/2024 2:14 PM
Image
T1NKER0 — 05/06/2024 4:03 PM
Attachment file type: document
VITALS_MONITORING_SYSTEM_ELEN442.docx
1.29 MB
Manny — 05/06/2024 4:33 PM
#include <HTTPClient.h>
#include <ArduinoJson.h>
#include <WiFi.h>

int averageBPM;
float temperature;
Expand
message.txt
3 KB
T1NKER0 — 05/06/2024 4:51 PM
Image
Manny — 05/06/2024 5:54 PM
Image
Image
Image
Image
Manny — 05/06/2024 6:04 PM
Image
Image
https://1drv.ms/w/s!Ao2xlhHy9FIMuglXbyYzFtLWez4z?e=dxS1xr
VITALS_MONITORING_SYSTEM_ELEN442.docx
Manny — 05/06/2024 6:38 PM
https://1drv.ms/p/s!Ao2xlhHy9FIMugr443Np3XMavHRA?e=hYQp4t
MicroProjectPresentation.pptx
Manny — 05/06/2024 7:17 PM
Image
Image
Image
Manny — 05/06/2024 7:55 PM
Image
Image
Image
Manny — 05/06/2024 8:10 PM
Image
Image
Image
Image
Manny — 05/06/2024 8:26 PM
Image
T1NKER0 — 05/06/2024 8:33 PM
Image
Manny — 05/06/2024 8:34 PM
Image
Image
Manny — 05/07/2024 2:52 PM
preparate
que idalides nos va a citar
para la defensa
T1NKER0 — 05/07/2024 3:00 PM
Como lo sabes
Ay CABROOON
HOY HABIA MOBILE
T1NKER0 — 05/07/2024 4:00 PM
Attachment file type: document
CPEN444_HW4.docx
18.37 KB
T1NKER0 — 05/07/2024 4:31 PM
Attachment file type: document
CPEN444_HW5.docx
20.21 KB
T1NKER0 — 05/07/2024 6:30 PM
Attachment file type: document
CPEN444_HW6.docx
16.83 KB
T1NKER0 — 05/07/2024 8:16 PM
Attachment file type: document
CPEN444_HW6.docx
18.64 KB
Attachment file type: document
CPEN444_MICROPROCESSOR_REPORT.docx
43.29 KB
T1NKER0 — 05/08/2024 10:33 PM
%CATALINA%\lib\java-json.jar
T1NKER0 — Today at 3:44 PM
https://github.com/T1NKER0/VITALS_MONITORING_SYSTEM/blob/main/README.md
GitHub
VITALS_MONITORING_SYSTEM/README.md at main · T1NKER0/VITALS_MONITOR...
Microprocessors I ELEN 442 / 447 Final Project. Contribute to T1NKER0/VITALS_MONITORING_SYSTEM development by creating an account on GitHub.
VITALS_MONITORING_SYSTEM/README.md at main · T1NKER0/VITALS_MONITOR...
ya esta el README
voy a subir los files de vscode y el databse script
Manny — Today at 3:49 PM
duro
﻿
Manny
mannychuela
CREATE DATABASE  IF NOT EXISTS `micro` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `micro`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: micro
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device` (
  `device_id` int unsigned NOT NULL AUTO_INCREMENT,
  `device_name` varchar(255) NOT NULL,
  `user_id` int unsigned NOT NULL,
  PRIMARY KEY (`device_id`),
  KEY `fk_device_user_idx` (`user_id`),
  CONSTRAINT `fk_device_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` VALUES (1,'device_01',0);
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitor`
--

DROP TABLE IF EXISTS `monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monitor` (
  `monitor_id` int unsigned NOT NULL AUTO_INCREMENT,
  `avg_temp` bigint NOT NULL,
  `avg_pulse` bigint NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pulse_alert` enum('yes','no') NOT NULL DEFAULT 'no',
  `temp_alert` enum('yes','no') NOT NULL DEFAULT 'no',
  `device_id` int unsigned NOT NULL,
  PRIMARY KEY (`monitor_id`),
  KEY `fk_monitor_device1_idx` (`device_id`),
  CONSTRAINT `fk_monitor_device1` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitor`
--

LOCK TABLES `monitor` WRITE;
/*!40000 ALTER TABLE `monitor` DISABLE KEYS */;
INSERT INTO `monitor` VALUES (1,36,78,'2024-04-20 14:49:17','no','no',1),(2,3,78,'2024-04-20 14:55:59','no','no',1),(3,3,105,'2024-04-20 14:56:20','yes','no',1),(4,38,105,'2024-04-20 14:56:34','yes','yes',1),(5,38,105,'2024-04-20 15:26:27','yes','yes',1),(6,38,105,'2024-04-20 15:26:31','yes','yes',1),(7,40,137,'2024-04-20 15:29:25','yes','yes',1),(8,45,98,'2024-04-20 15:32:27','no','yes',1),(9,35,98,'2024-04-20 15:32:59','no','no',1),(10,35,101,'2024-04-20 15:33:18','yes','no',1),(11,37,101,'2024-04-20 15:35:49','yes','no',1),(12,38,101,'2024-04-20 15:39:44','yes','yes',1),(13,35,101,'2024-04-20 15:40:07','yes','no',1),(14,35,98,'2024-04-20 15:40:14','no','no',1);
/*!40000 ALTER TABLE `monitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `hash` mediumtext NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'USER','USER','HASH');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-20 11:42:15
