--
-- Table structure for table `trail`
--

DROP TABLE IF EXISTS `trail`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trail`
(
    `uid`       int         NOT NULL,
    `area`      varchar(10) NOT NULL,
    `scan_time` datetime    NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trail`
--

LOCK TABLES `trail` WRITE;
/*!40000 ALTER TABLE `trail`
    DISABLE KEYS */;
INSERT INTO `trail` (`uid`, `area`, `scan_time`)
VALUES (1, 'A001', '2022-05-01 09:00:00'),
       (1, 'A001', '2022-05-01 10:00:00'),
       (1, 'A001', '2022-05-01 11:00:00'),
       (1, 'A002', '2022-05-01 11:05:00'),
       (1, 'A002', '2022-05-01 13:00:00'),
       (1, 'A001', '2022-05-01 13:15:00'),
       (1, 'A001', '2022-05-01 14:00:00'),
       (2, 'A001', '2022-05-01 10:30:00'),
       (2, 'A001', '2022-05-01 12:00:00'),
       (3, 'A001', '2022-05-01 11:00:00'),
       (3, 'A001', '2022-05-01 12:00:00');
/*!40000 ALTER TABLE `trail`
    ENABLE KEYS */;
UNLOCK TABLES;

-- Dump completed on 2022-05-29 22:53:35
