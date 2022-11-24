
--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `creationtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `docname` varchar(256) NOT NULL DEFAULT '',
  `classcode` varchar(256) NOT NULL DEFAULT '',
  `confcode` varchar(256) NOT NULL DEFAULT '',
  `formatcode` varchar(256) NOT NULL DEFAULT '',
  `facilitycode` varchar(256) NOT NULL DEFAULT '',
  `practicecode` varchar(256) NOT NULL DEFAULT '',
  `speciality` varchar(256) NOT NULL DEFAULT '',
  `expression` varchar(256) NOT NULL DEFAULT '',
  `authors` varchar(256) NOT NULL DEFAULT '',
  `xdspid` varchar(256) NOT NULL DEFAULT '',
  `xdsdocentryuId` varchar(256) NOT NULL DEFAULT '',
  `repositoryuniqueid` varchar(256) NOT NULL DEFAULT '',
  `nhsid` varchar(256) NOT NULL DEFAULT '',
  `user` varchar(256) NOT NULL DEFAULT '',
  `org` varchar(256) NOT NULL DEFAULT '',
  `role` varchar(256) NOT NULL DEFAULT '',
  `topic` varchar(256) NOT NULL DEFAULT '',
  `pathway` varchar(256) NOT NULL DEFAULT '',
  `comments` varchar(1024) NOT NULL DEFAULT '',
  `version` int NOT NULL DEFAULT '0',
  `taskid` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `nhsid` (`nhsid`),
  KEY `user` (`user`),
  KEY `org` (`org`),
  KEY `pathway` (`pathway`),
  KEY `expression` (`expression`),
  KEY `xdsdocentryuId` (`xdsdocentryuId`)
) ENGINE=InnoDB AUTO_INCREMENT=536 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Table structure for table `idmaps`
--

DROP TABLE IF EXISTS `idmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idmaps` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `lid` varchar(256) DEFAULT NULL,
  `mid` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servicestates`
--

DROP TABLE IF EXISTS `servicestates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicestates` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `service` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb3 COMMENT='newTable';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `brokerref` varchar(256) DEFAULT NULL,
  `pathway` varchar(256) DEFAULT NULL,
  `topic` varchar(256) DEFAULT NULL,
  `expression` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `brokerref` (`brokerref`),
  KEY `pathway` (`pathway`),
  KEY `topic` (`topic`),
  KEY `expression` (`expression`)
) ENGINE=InnoDB AUTO_INCREMENT=1170 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templates`
--

DROP TABLE IF EXISTS `templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `isxml` tinyint(1) NOT NULL DEFAULT '0',
  `template` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6302 DEFAULT CHARSET=utf8mb3 COMMENT='newTable';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workflows`
--

DROP TABLE IF EXISTS `workflows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workflows` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `pathway` varchar(128) NOT NULL DEFAULT '',
  `nhsid` varchar(10) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `xdw_key` varchar(256) NOT NULL DEFAULT '',
  `xdw_uid` varchar(255) NOT NULL DEFAULT '',
  `xdw_doc` longtext NOT NULL,
  `xdw_def` longtext NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `status` varchar(64) NOT NULL DEFAULT 'OPEN',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2788 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `xdws`
--

DROP TABLE IF EXISTS `xdws`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xdws` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `isxdsmeta` tinyint(1) NOT NULL DEFAULT '0',
  `xdw` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb3 COMMENT='newTable';
/*!40101 SET character_set_client = @saved_cs_client */;
