CREATE DATABASE  IF NOT EXISTS `shared_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shared_db`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: shared_db
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `AM_API`
--

DROP TABLE IF EXISTS `AM_API`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_API` (
  `API_ID` int NOT NULL AUTO_INCREMENT,
  `API_UUID` varchar(256) DEFAULT NULL,
  `API_PROVIDER` varchar(255) DEFAULT NULL,
  `API_NAME` varchar(255) DEFAULT NULL,
  `API_VERSION` varchar(30) DEFAULT NULL,
  `CONTEXT` varchar(256) DEFAULT NULL,
  `CONTEXT_TEMPLATE` varchar(256) DEFAULT NULL,
  `API_TIER` varchar(256) DEFAULT NULL,
  `API_TYPE` varchar(10) DEFAULT NULL,
  `ORGANIZATION` varchar(100) DEFAULT NULL,
  `GATEWAY_VENDOR` varchar(100) DEFAULT 'wso2',
  PRIMARY KEY (`API_ID`),
  UNIQUE KEY `API_PROVIDER` (`API_PROVIDER`,`API_NAME`,`API_VERSION`,`ORGANIZATION`),
  UNIQUE KEY `API_UUID` (`API_UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_API_CATEGORIES`
--

DROP TABLE IF EXISTS `AM_API_CATEGORIES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_API_CATEGORIES` (
  `UUID` varchar(50) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(1024) DEFAULT NULL,
  `TENANT_ID` int NOT NULL,
  PRIMARY KEY (`UUID`),
  UNIQUE KEY `NAME` (`NAME`,`TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_API_COMMENTS`
--

DROP TABLE IF EXISTS `AM_API_COMMENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_API_COMMENTS` (
  `COMMENT_ID` varchar(255) NOT NULL,
  `COMMENT_TEXT` varchar(512) DEFAULT NULL,
  `COMMENTED_USER` varchar(255) DEFAULT NULL,
  `DATE_COMMENTED` timestamp NOT NULL,
  `API_ID` int NOT NULL,
  `ORGANIZATION` varchar(100) NOT NULL DEFAULT 'carbon.super',
  `PARENT_COMMENT_ID` varchar(255) DEFAULT NULL,
  `ENTRY_POINT` varchar(20) DEFAULT NULL,
  `CATEGORY` varchar(20) DEFAULT 'GENERAL',
  PRIMARY KEY (`COMMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_API_RATINGS`
--

DROP TABLE IF EXISTS `AM_API_RATINGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_API_RATINGS` (
  `RATING_ID` varchar(255) NOT NULL,
  `API_ID` int NOT NULL,
  `RATING` int NOT NULL,
  `SUBSCRIBER_ID` int NOT NULL,
  `ORGANIZATION` varchar(100) NOT NULL DEFAULT 'carbon.super',
  PRIMARY KEY (`RATING_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_API_SCOPES`
--

DROP TABLE IF EXISTS `AM_API_SCOPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_API_SCOPES` (
  `API_ID` int NOT NULL,
  `SCOPE_ID` int NOT NULL,
  PRIMARY KEY (`API_ID`,`SCOPE_ID`),
  KEY `SCOPE_ID` (`SCOPE_ID`),
  CONSTRAINT `am_api_scopes_ibfk_1` FOREIGN KEY (`API_ID`) REFERENCES `AM_API` (`API_ID`) ON DELETE CASCADE,
  CONSTRAINT `am_api_scopes_ibfk_2` FOREIGN KEY (`SCOPE_ID`) REFERENCES `AM_SCOPE` (`SCOPE_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_API_THROTTLE_POLICY`
--

DROP TABLE IF EXISTS `AM_API_THROTTLE_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_API_THROTTLE_POLICY` (
  `POLICY_ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL,
  `DISPLAY_NAME` varchar(512) DEFAULT NULL,
  `TENANT_ID` int NOT NULL,
  `DESCRIPTION` varchar(1024) DEFAULT NULL,
  `DEFAULT_QUOTA_TYPE` varchar(25) NOT NULL,
  `DEFAULT_QUOTA` int NOT NULL,
  `DEFAULT_QUOTA_UNIT` varchar(10) DEFAULT NULL,
  `DEFAULT_UNIT_TIME` int NOT NULL,
  `DEFAULT_TIME_UNIT` varchar(25) NOT NULL,
  `APPLICABLE_LEVEL` varchar(25) NOT NULL,
  `IS_DEPLOYED` tinyint(1) NOT NULL DEFAULT '0',
  `UUID` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`POLICY_ID`),
  UNIQUE KEY `API_NAME_TENANT` (`NAME`,`TENANT_ID`),
  UNIQUE KEY `UUID` (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_API_URL_MAPPING`
--

DROP TABLE IF EXISTS `AM_API_URL_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_API_URL_MAPPING` (
  `URL_MAPPING_ID` int NOT NULL AUTO_INCREMENT,
  `API_ID` int NOT NULL,
  `HTTP_METHOD` varchar(20) NOT NULL,
  `AUTH_TYPE` varchar(50) NOT NULL,
  `URL_PATTERN` varchar(512) NOT NULL,
  `THROTTLING_TIER` varchar(512) DEFAULT NULL,
  `MEDIATION_SCRIPT_ID` varchar(255) DEFAULT NULL,
  `REVISION_UUID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`URL_MAPPING_ID`),
  KEY `API_ID` (`API_ID`),
  CONSTRAINT `am_api_url_mapping_ibfk_1` FOREIGN KEY (`API_ID`) REFERENCES `AM_API` (`API_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_APPLICATION`
--

DROP TABLE IF EXISTS `AM_APPLICATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_APPLICATION` (
  `APPLICATION_ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) DEFAULT NULL,
  `SUBSCRIBER_ID` int DEFAULT NULL,
  `APPLICATION_TIER` varchar(512) DEFAULT 'Unlimited',
  `CALLBACK_URL` varchar(512) DEFAULT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `APPLICATION_STATUS` varchar(50) DEFAULT 'APPROVED',
  `GROUP_ID` varchar(512) DEFAULT NULL,
  `CREATED_BY` varchar(100) DEFAULT NULL,
  `CREATED_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(100) DEFAULT NULL,
  `UPDATED_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UUID` varchar(256) DEFAULT NULL,
  `TOKEN_TYPE` varchar(10) DEFAULT NULL,
  `ORGANIZATION` varchar(100) DEFAULT NULL,
  `SHARED_ORGANIZATION` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`APPLICATION_ID`),
  UNIQUE KEY `NAME` (`NAME`,`SUBSCRIBER_ID`,`ORGANIZATION`),
  UNIQUE KEY `UUID` (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_APPLICATION_ATTRIBUTES`
--

DROP TABLE IF EXISTS `AM_APPLICATION_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_APPLICATION_ATTRIBUTES` (
  `APPLICATION_ID` int NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(1024) NOT NULL,
  `TENANT_ID` int NOT NULL,
  PRIMARY KEY (`APPLICATION_ID`,`NAME`),
  CONSTRAINT `am_application_attributes_ibfk_1` FOREIGN KEY (`APPLICATION_ID`) REFERENCES `AM_APPLICATION` (`APPLICATION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_APPLICATION_GROUP_MAPPING`
--

DROP TABLE IF EXISTS `AM_APPLICATION_GROUP_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_APPLICATION_GROUP_MAPPING` (
  `APPLICATION_ID` int NOT NULL,
  `GROUP_ID` varchar(512) NOT NULL,
  `TENANT_ID` int NOT NULL,
  PRIMARY KEY (`APPLICATION_ID`,`GROUP_ID`),
  CONSTRAINT `am_application_group_mapping_ibfk_1` FOREIGN KEY (`APPLICATION_ID`) REFERENCES `AM_APPLICATION` (`APPLICATION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_APPLICATION_KEY_MAPPING`
--

DROP TABLE IF EXISTS `AM_APPLICATION_KEY_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_APPLICATION_KEY_MAPPING` (
  `APPLICATION_ID` int NOT NULL,
  `CONSUMER_KEY` varchar(255) DEFAULT NULL,
  `KEY_TYPE` varchar(512) NOT NULL,
  `STATE` varchar(30) NOT NULL,
  `CREATE_MODE` varchar(30) DEFAULT 'CREATED',
  `APP_INFO` blob,
  PRIMARY KEY (`APPLICATION_ID`,`KEY_TYPE`),
  CONSTRAINT `am_application_key_mapping_ibfk_1` FOREIGN KEY (`APPLICATION_ID`) REFERENCES `AM_APPLICATION` (`APPLICATION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_COMMON_OPERATION_POLICY`
--

DROP TABLE IF EXISTS `AM_COMMON_OPERATION_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_COMMON_OPERATION_POLICY` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `SPEC_ID` int DEFAULT NULL,
  `POLICY_NAME` varchar(255) DEFAULT NULL,
  `POLICY_VERSION` varchar(10) DEFAULT NULL,
  `POLICY_UUID` char(36) NOT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `POLICY_DESCRIPTION` text,
  `POLICY_PARAMETERS` text,
  `POLICY_CATEGORY` varchar(100) DEFAULT NULL,
  `APPLICABLE_FLOWS` varchar(100) DEFAULT NULL,
  `GATEWAY_TYPES` varchar(255) DEFAULT NULL,
  `API_TYPES` varchar(255) DEFAULT NULL,
  `POLICY_MD5` varchar(32) DEFAULT NULL,
  `ORGANIZATION` varchar(100) DEFAULT NULL,
  `IS_FULL_POLICY_ATTACHED` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `POLICY_UUID` (`POLICY_UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_CONDITION`
--

DROP TABLE IF EXISTS `AM_CONDITION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_CONDITION` (
  `CONDITION_ID` int NOT NULL AUTO_INCREMENT,
  `CONDITION_TYPE` varchar(255) NOT NULL,
  `IS_INVERTED` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`CONDITION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_CORRELATION_CONFIG`
--

DROP TABLE IF EXISTS `AM_CORRELATION_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_CORRELATION_CONFIG` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL,
  `ENABLED` varchar(50) NOT NULL,
  `ORGANIZATION` varchar(100) NOT NULL DEFAULT 'carbon.super',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME` (`NAME`,`ORGANIZATION`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_CORRELATION_CONFIGS`
--

DROP TABLE IF EXISTS `AM_CORRELATION_CONFIGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_CORRELATION_CONFIGS` (
  `COMPONENT_NAME` varchar(255) NOT NULL,
  `NAME` varchar(255) NOT NULL DEFAULT 'default',
  `ENABLED` varchar(50) NOT NULL DEFAULT 'false',
  `ORGANIZATION` varchar(100) NOT NULL DEFAULT 'carbon.super',
  PRIMARY KEY (`COMPONENT_NAME`,`NAME`,`ORGANIZATION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_CORRELATION_PROPERTIES`
--

DROP TABLE IF EXISTS `AM_CORRELATION_PROPERTIES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_CORRELATION_PROPERTIES` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `CONFIG_ID` int DEFAULT NULL,
  `PROPERTY_NAME` varchar(255) DEFAULT NULL,
  `PROPERTY_VALUE` varchar(255) DEFAULT NULL,
  `COMPONENT_NAME` varchar(255) DEFAULT NULL,
  `ORGANIZATION` varchar(100) DEFAULT 'carbon.super',
  PRIMARY KEY (`ID`),
  KEY `CONFIG_ID` (`CONFIG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_DEPLOYMENT_REVISIONS`
--

DROP TABLE IF EXISTS `AM_DEPLOYMENT_REVISIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_DEPLOYMENT_REVISIONS` (
  `NAME` varchar(255) NOT NULL,
  `VHOST` varchar(255) NOT NULL,
  `REVISION_UUID` varchar(255) NOT NULL,
  `DEPLOYED_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`NAME`,`VHOST`,`REVISION_UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_GATEWAY_ENVIRONMENT`
--

DROP TABLE IF EXISTS `AM_GATEWAY_ENVIRONMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_GATEWAY_ENVIRONMENT` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(1024) DEFAULT NULL,
  `TENANT_ID` int NOT NULL,
  `UUID` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME` (`NAME`,`TENANT_ID`),
  UNIQUE KEY `UUID` (`UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_GW_API_ARTIFACTS`
--

DROP TABLE IF EXISTS `AM_GW_API_ARTIFACTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_GW_API_ARTIFACTS` (
  `API_ID` varchar(255) NOT NULL,
  `ARTIFACT` longblob,
  `GATEWAY_INSTRUCTION` varchar(20) DEFAULT NULL,
  `GATEWAY_LABEL` varchar(255) NOT NULL,
  `GATEWAY_INSTRUCTION_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`GATEWAY_INSTRUCTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_GW_PUBLISHED_API_DETAILS`
--

DROP TABLE IF EXISTS `AM_GW_PUBLISHED_API_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_GW_PUBLISHED_API_DETAILS` (
  `API_ID` varchar(255) NOT NULL,
  `TENANT_DOMAIN` varchar(255) DEFAULT NULL,
  `API_MAPPING_ID` varchar(255) DEFAULT NULL,
  `GW_GROUP_NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`API_ID`,`GW_GROUP_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_HEADER_FIELD_CONDITION`
--

DROP TABLE IF EXISTS `AM_HEADER_FIELD_CONDITION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_HEADER_FIELD_CONDITION` (
  `HEADER_FIELD_ID` int NOT NULL AUTO_INCREMENT,
  `CONDITION_ID` int NOT NULL,
  `HEADER_FIELD_NAME` varchar(255) NOT NULL,
  `HEADER_FIELD_VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`HEADER_FIELD_ID`),
  KEY `CONDITION_ID` (`CONDITION_ID`),
  CONSTRAINT `am_header_field_condition_ibfk_1` FOREIGN KEY (`CONDITION_ID`) REFERENCES `AM_CONDITION` (`CONDITION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_IP_CONDITION`
--

DROP TABLE IF EXISTS `AM_IP_CONDITION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_IP_CONDITION` (
  `AM_IP_CONDITION_ID` int NOT NULL AUTO_INCREMENT,
  `CONDITION_ID` int NOT NULL,
  `STARTING_IP` varchar(45) NOT NULL,
  `ENDING_IP` varchar(45) NOT NULL,
  `SPECIFIC_IP` varchar(45) NOT NULL,
  `IP_TYPE` varchar(20) NOT NULL,
  PRIMARY KEY (`AM_IP_CONDITION_ID`),
  KEY `CONDITION_ID` (`CONDITION_ID`),
  CONSTRAINT `am_ip_condition_ibfk_1` FOREIGN KEY (`CONDITION_ID`) REFERENCES `AM_CONDITION` (`CONDITION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_JWT_CLAIM_CONDITION`
--

DROP TABLE IF EXISTS `AM_JWT_CLAIM_CONDITION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_JWT_CLAIM_CONDITION` (
  `JWT_CLAIM_ID` int NOT NULL AUTO_INCREMENT,
  `CONDITION_ID` int NOT NULL,
  `CLAIM_URI` varchar(512) NOT NULL,
  `CLAIM_ATTRIB` varchar(512) NOT NULL,
  PRIMARY KEY (`JWT_CLAIM_ID`),
  KEY `CONDITION_ID` (`CONDITION_ID`),
  CONSTRAINT `am_jwt_claim_condition_ibfk_1` FOREIGN KEY (`CONDITION_ID`) REFERENCES `AM_CONDITION` (`CONDITION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_KEY_MANAGER`
--

DROP TABLE IF EXISTS `AM_KEY_MANAGER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_KEY_MANAGER` (
  `UUID` varchar(50) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `DISPLAY_NAME` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `TYPE` varchar(45) NOT NULL,
  `CONFIGURATION` blob,
  `ORGANISATION` varchar(100) NOT NULL,
  PRIMARY KEY (`UUID`),
  UNIQUE KEY `NAME` (`NAME`,`ORGANISATION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_OPERATION_POLICY`
--

DROP TABLE IF EXISTS `AM_OPERATION_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_OPERATION_POLICY` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `SPEC_ID` int DEFAULT NULL,
  `POLICY_NAME` varchar(255) DEFAULT NULL,
  `POLICY_VERSION` varchar(10) DEFAULT NULL,
  `POLICY_UUID` char(36) NOT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `POLICY_DESCRIPTION` text,
  `POLICY_PARAMETERS` text,
  `POLICY_CATEGORY` varchar(100) DEFAULT NULL,
  `APPLICABLE_FLOWS` varchar(100) DEFAULT NULL,
  `GATEWAY_TYPES` varchar(255) DEFAULT NULL,
  `API_TYPES` varchar(255) DEFAULT NULL,
  `POLICY_MD5` varchar(32) DEFAULT NULL,
  `ORGANIZATION` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `POLICY_UUID` (`POLICY_UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_OPERATION_POLICY_DEFINITION`
--

DROP TABLE IF EXISTS `AM_OPERATION_POLICY_DEFINITION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_OPERATION_POLICY_DEFINITION` (
  `DEFINITION_ID` int NOT NULL AUTO_INCREMENT,
  `POLICY_UUID` char(36) NOT NULL,
  `POLICY_NAME` varchar(255) DEFAULT NULL,
  `POLICY_VERSION` varchar(10) DEFAULT NULL,
  `POLICY_DEFINITION` longblob,
  `GATEWAY_TYPE` varchar(255) DEFAULT NULL,
  `DEFINITION_MD5` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`DEFINITION_ID`),
  KEY `INDEX_POLICY_UUID` (`POLICY_UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_POLICY_APPLICATION`
--

DROP TABLE IF EXISTS `AM_POLICY_APPLICATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_POLICY_APPLICATION` (
  `POLICY_ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(512) NOT NULL,
  `DISPLAY_NAME` varchar(512) DEFAULT NULL,
  `TENANT_ID` int NOT NULL,
  `DESCRIPTION` varchar(1024) DEFAULT NULL,
  `QUOTA_TYPE` varchar(25) NOT NULL,
  `QUOTA` int NOT NULL,
  `QUOTA_UNIT` varchar(10) DEFAULT NULL,
  `UNIT_TIME` int NOT NULL,
  `TIME_UNIT` varchar(25) NOT NULL,
  `RATE_LIMIT_COUNT` int DEFAULT NULL,
  `RATE_LIMIT_TIME_UNIT` varchar(25) DEFAULT NULL,
  `IS_DEPLOYED` tinyint(1) NOT NULL DEFAULT '0',
  `CUSTOM_ATTRIBUTES` blob,
  `UUID` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`POLICY_ID`),
  UNIQUE KEY `NAME` (`NAME`,`TENANT_ID`),
  UNIQUE KEY `UUID` (`UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_POLICY_GLOBAL`
--

DROP TABLE IF EXISTS `AM_POLICY_GLOBAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_POLICY_GLOBAL` (
  `POLICY_ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(512) NOT NULL,
  `KEY_TEMPLATE` varchar(512) NOT NULL,
  `DESCRIPTION` text,
  `TENANT_ID` int NOT NULL DEFAULT '-1234',
  `UUID` varchar(256) DEFAULT NULL,
  `IS_DEPLOYED` tinyint(1) NOT NULL DEFAULT '0',
  `ORGANIZATION` varchar(100) NOT NULL DEFAULT 'carbon.super',
  PRIMARY KEY (`POLICY_ID`),
  UNIQUE KEY `NAME` (`NAME`,`ORGANIZATION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_POLICY_SPECIFICATION`
--

DROP TABLE IF EXISTS `AM_POLICY_SPECIFICATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_POLICY_SPECIFICATION` (
  `POLICY_ID` int NOT NULL AUTO_INCREMENT,
  `POLICY_NAME` varchar(255) DEFAULT NULL,
  `POLICY_VERSION` varchar(10) DEFAULT NULL,
  `POLICY_TYPE` varchar(20) DEFAULT NULL,
  `POLICY_UUID` char(36) NOT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(1024) DEFAULT NULL,
  `IS_FULL_POLICY_ATTACHED` tinyint(1) DEFAULT '0',
  `APPLICABLE_FLOWS` varchar(100) DEFAULT NULL,
  `GATEWAY_TYPES` varchar(255) DEFAULT NULL,
  `ORGANIZATION` varchar(100) DEFAULT NULL,
  `MD5` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`POLICY_ID`),
  UNIQUE KEY `POLICY_UUID` (`POLICY_UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_POLICY_SUBSCRIPTION`
--

DROP TABLE IF EXISTS `AM_POLICY_SUBSCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_POLICY_SUBSCRIPTION` (
  `POLICY_ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(512) NOT NULL,
  `DISPLAY_NAME` varchar(512) DEFAULT NULL,
  `TENANT_ID` int NOT NULL,
  `DESCRIPTION` varchar(1024) DEFAULT NULL,
  `QUOTA_TYPE` varchar(25) NOT NULL,
  `QUOTA` int NOT NULL,
  `QUOTA_UNIT` varchar(10) DEFAULT NULL,
  `UNIT_TIME` int NOT NULL,
  `TIME_UNIT` varchar(25) NOT NULL,
  `RATE_LIMIT_COUNT` int DEFAULT NULL,
  `RATE_LIMIT_TIME_UNIT` varchar(25) DEFAULT NULL,
  `IS_DEPLOYED` tinyint(1) NOT NULL DEFAULT '0',
  `CUSTOM_ATTRIBUTES` blob,
  `STOP_ON_QUOTA_REACH` tinyint(1) NOT NULL DEFAULT '0',
  `BILLING_PLAN` varchar(20) NOT NULL,
  `UUID` varchar(256) DEFAULT NULL,
  `MAX_DEPTH` int DEFAULT NULL,
  `MAX_COMPLEXITY` int DEFAULT NULL,
  `MONETIZATION_PLAN` varchar(512) DEFAULT NULL,
  `FIXED_RATE` int DEFAULT NULL,
  `BILLING_CYCLE` varchar(255) DEFAULT NULL,
  `PRICE_PER_REQUEST` varchar(255) DEFAULT NULL,
  `CURRENCY` varchar(255) DEFAULT NULL,
  `CONNECTIONS_COUNT` int DEFAULT NULL,
  PRIMARY KEY (`POLICY_ID`),
  UNIQUE KEY `NAME` (`NAME`,`TENANT_ID`),
  UNIQUE KEY `UUID` (`UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_QUERY_PARAMETER_CONDITION`
--

DROP TABLE IF EXISTS `AM_QUERY_PARAMETER_CONDITION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_QUERY_PARAMETER_CONDITION` (
  `QUERY_PARAM_ID` int NOT NULL AUTO_INCREMENT,
  `CONDITION_ID` int NOT NULL,
  `PARAMETER_NAME` varchar(255) NOT NULL,
  `PARAMETER_VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`QUERY_PARAM_ID`),
  KEY `CONDITION_ID` (`CONDITION_ID`),
  CONSTRAINT `am_query_parameter_condition_ibfk_1` FOREIGN KEY (`CONDITION_ID`) REFERENCES `AM_CONDITION` (`CONDITION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_REVISIONS`
--

DROP TABLE IF EXISTS `AM_REVISIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_REVISIONS` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `API_UUID` varchar(256) NOT NULL,
  `REVISION_NUMBER` int NOT NULL,
  `DESCRIPTION` varchar(1024) DEFAULT NULL,
  `CREATED_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `API_UUID` (`API_UUID`,`REVISION_NUMBER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_SCOPE`
--

DROP TABLE IF EXISTS `AM_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_SCOPE` (
  `SCOPE_ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL,
  `DISPLAY_NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `TENANT_ID` int NOT NULL DEFAULT '-1',
  `SCOPE_TYPE` varchar(255) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`),
  UNIQUE KEY `NAME` (`NAME`,`TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_SUBSCRIPTION`
--

DROP TABLE IF EXISTS `AM_SUBSCRIPTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_SUBSCRIPTION` (
  `SUBSCRIPTION_ID` int NOT NULL AUTO_INCREMENT,
  `TIER_ID` varchar(512) DEFAULT NULL,
  `API_ID` int DEFAULT NULL,
  `APPLICATION_ID` int DEFAULT NULL,
  `SUB_STATUS` varchar(50) DEFAULT NULL,
  `SUBS_CREATE_STATE` varchar(50) DEFAULT 'SUBSCRIBE',
  `CREATED_BY` varchar(100) DEFAULT NULL,
  `CREATED_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(100) DEFAULT NULL,
  `UPDATED_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UUID` varchar(256) DEFAULT NULL,
  `TIER_ID_PENDING` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`SUBSCRIPTION_ID`),
  UNIQUE KEY `API_ID` (`API_ID`,`APPLICATION_ID`),
  UNIQUE KEY `UUID` (`UUID`),
  KEY `APPLICATION_ID` (`APPLICATION_ID`),
  CONSTRAINT `am_subscription_ibfk_1` FOREIGN KEY (`API_ID`) REFERENCES `AM_API` (`API_ID`) ON DELETE CASCADE,
  CONSTRAINT `am_subscription_ibfk_2` FOREIGN KEY (`APPLICATION_ID`) REFERENCES `AM_APPLICATION` (`APPLICATION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_SYSTEM_CONFIGS`
--

DROP TABLE IF EXISTS `AM_SYSTEM_CONFIGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_SYSTEM_CONFIGS` (
  `ORGANIZATION` varchar(100) NOT NULL,
  `CONFIG_TYPE` varchar(100) NOT NULL,
  `CONFIGURATION` blob NOT NULL,
  PRIMARY KEY (`ORGANIZATION`,`CONFIG_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_TENANT_CONF`
--

DROP TABLE IF EXISTS `AM_TENANT_CONF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_TENANT_CONF` (
  `TENANT_ID` int NOT NULL,
  `CONFIG_AS_JSON` blob NOT NULL,
  PRIMARY KEY (`TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_THROTTLE_TIER_PERMISSION`
--

DROP TABLE IF EXISTS `AM_THROTTLE_TIER_PERMISSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_THROTTLE_TIER_PERMISSION` (
  `THROTTLE_TIER_PERM_ID` int NOT NULL AUTO_INCREMENT,
  `TIER_NAME` varchar(512) NOT NULL,
  `PERM_TYPE` varchar(50) NOT NULL,
  `ROLES` varchar(512) NOT NULL,
  `TENANT_ID` int NOT NULL DEFAULT '-1234',
  `ORGANIZATION` varchar(100) NOT NULL,
  PRIMARY KEY (`THROTTLE_TIER_PERM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AM_WORKFLOWS`
--

DROP TABLE IF EXISTS `AM_WORKFLOWS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AM_WORKFLOWS` (
  `WF_ID` int NOT NULL AUTO_INCREMENT,
  `WF_REFERENCE` varchar(255) NOT NULL,
  `WF_TYPE` varchar(255) NOT NULL,
  `WF_STATUS` varchar(255) NOT NULL,
  `WF_CREATED_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `WF_UPDATED_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `WF_STATUS_DESC` text,
  `TENANT_ID` int NOT NULL DEFAULT '-1234',
  `WF_EXTERNAL_REFERENCE` varchar(255) NOT NULL,
  `WF_ATTRIBUTES` text,
  `ORGANIZATION` varchar(100) NOT NULL DEFAULT 'carbon.super',
  PRIMARY KEY (`WF_ID`),
  UNIQUE KEY `WF_EXTERNAL_REFERENCE` (`WF_EXTERNAL_REFERENCE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CM_PURPOSE`
--

DROP TABLE IF EXISTS `CM_PURPOSE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CM_PURPOSE` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(1023) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CM_PURPOSE_CATEGORY`
--

DROP TABLE IF EXISTS `CM_PURPOSE_CATEGORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CM_PURPOSE_CATEGORY` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(1023) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CM_RECEIPT`
--

DROP TABLE IF EXISTS `CM_RECEIPT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CM_RECEIPT` (
  `ID` varchar(255) NOT NULL,
  `VERSION` varchar(255) NOT NULL,
  `JURISDICTION` varchar(255) NOT NULL,
  `TERMINATION` varchar(255) NOT NULL,
  `POLICY_URL` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_AUTH_SESSION_APP_INFO`
--

DROP TABLE IF EXISTS `IDN_AUTH_SESSION_APP_INFO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_AUTH_SESSION_APP_INFO` (
  `SESSION_ID` varchar(100) NOT NULL,
  `SUBJECT` varchar(255) NOT NULL,
  `APP_ID` int NOT NULL,
  `INBOUND_AUTH_TYPE` varchar(255) NOT NULL,
  PRIMARY KEY (`SESSION_ID`,`SUBJECT`,`APP_ID`,`INBOUND_AUTH_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_AUTH_SESSION_META_DATA`
--

DROP TABLE IF EXISTS `IDN_AUTH_SESSION_META_DATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_AUTH_SESSION_META_DATA` (
  `SESSION_ID` varchar(100) NOT NULL,
  `SESSION_TYPE` varchar(100) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  `PROPERTY` varchar(255) NOT NULL,
  PRIMARY KEY (`SESSION_ID`,`SESSION_TYPE`,`PROPERTY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_AUTH_SESSION_STORE`
--

DROP TABLE IF EXISTS `IDN_AUTH_SESSION_STORE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_AUTH_SESSION_STORE` (
  `SESSION_ID` varchar(100) NOT NULL,
  `SESSION_TYPE` varchar(100) NOT NULL,
  `OPERATION` varchar(10) NOT NULL,
  `SESSION_OBJECT` blob,
  `TIME_CREATED` bigint DEFAULT NULL,
  `TENANT_ID` int NOT NULL DEFAULT '-1234',
  `EXPIRY_TIME` bigint DEFAULT NULL,
  PRIMARY KEY (`SESSION_ID`,`SESSION_TYPE`,`OPERATION`,`TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_CLAIM`
--

DROP TABLE IF EXISTS `IDN_CLAIM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_CLAIM` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `DIALECT_ID` int NOT NULL,
  `CLAIM_URI` varchar(255) NOT NULL,
  `TENANT_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CLAIM_INDEX_CONSTRAINT` (`DIALECT_ID`,`CLAIM_URI`,`TENANT_ID`),
  CONSTRAINT `idn_claim_ibfk_1` FOREIGN KEY (`DIALECT_ID`) REFERENCES `IDN_CLAIM_DIALECT` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_CLAIM_DIALECT`
--

DROP TABLE IF EXISTS `IDN_CLAIM_DIALECT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_CLAIM_DIALECT` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `DIALECT_URI` varchar(255) NOT NULL,
  `TENANT_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `DIALECT_INDEX_CONSTRAINT` (`DIALECT_URI`,`TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_CLAIM_MAPPED_ATTRIBUTE`
--

DROP TABLE IF EXISTS `IDN_CLAIM_MAPPED_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_CLAIM_MAPPED_ATTRIBUTE` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `LOCAL_CLAIM_ID` int NOT NULL,
  `USER_STORE_DOMAIN_NAME` varchar(255) NOT NULL,
  `ATTRIBUTE_NAME` varchar(255) NOT NULL,
  `TENANT_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `MAP_ATT_INDEX_CONSTRAINT` (`LOCAL_CLAIM_ID`,`USER_STORE_DOMAIN_NAME`,`TENANT_ID`),
  CONSTRAINT `idn_claim_mapped_attribute_ibfk_1` FOREIGN KEY (`LOCAL_CLAIM_ID`) REFERENCES `IDN_CLAIM` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_CLAIM_MAPPING`
--

DROP TABLE IF EXISTS `IDN_CLAIM_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_CLAIM_MAPPING` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `EXT_CLAIM_ID` int NOT NULL,
  `MAPPED_LOCAL_CLAIM_ID` int NOT NULL,
  `TENANT_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CLAIM_MAPPING_CONSTRAINT` (`EXT_CLAIM_ID`,`MAPPED_LOCAL_CLAIM_ID`,`TENANT_ID`),
  KEY `MAPPED_LOCAL_CLAIM_ID` (`MAPPED_LOCAL_CLAIM_ID`),
  CONSTRAINT `idn_claim_mapping_ibfk_1` FOREIGN KEY (`EXT_CLAIM_ID`) REFERENCES `IDN_CLAIM` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `idn_claim_mapping_ibfk_2` FOREIGN KEY (`MAPPED_LOCAL_CLAIM_ID`) REFERENCES `IDN_CLAIM` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_CLAIM_PROPERTY`
--

DROP TABLE IF EXISTS `IDN_CLAIM_PROPERTY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_CLAIM_PROPERTY` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `LOCAL_CLAIM_ID` int NOT NULL,
  `PROPERTY_NAME` varchar(255) NOT NULL,
  `PROPERTY_VALUE` varchar(255) NOT NULL,
  `TENANT_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PROPERTY_INDEX_CONSTRAINT` (`LOCAL_CLAIM_ID`,`PROPERTY_NAME`,`TENANT_ID`),
  CONSTRAINT `idn_claim_property_ibfk_1` FOREIGN KEY (`LOCAL_CLAIM_ID`) REFERENCES `IDN_CLAIM` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1432 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_IDENTITY_META_DATA`
--

DROP TABLE IF EXISTS `IDN_IDENTITY_META_DATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_IDENTITY_META_DATA` (
  `USER_NAME` varchar(255) NOT NULL,
  `TENANT_ID` int NOT NULL DEFAULT '-1234',
  `METADATA_TYPE` varchar(255) NOT NULL,
  `METADATA_VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`TENANT_ID`,`USER_NAME`,`METADATA_TYPE`,`METADATA_VALUE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_IDENTITY_USER_DATA`
--

DROP TABLE IF EXISTS `IDN_IDENTITY_USER_DATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_IDENTITY_USER_DATA` (
  `TENANT_ID` int NOT NULL DEFAULT '-1234',
  `USER_NAME` varchar(255) NOT NULL,
  `USER_DOMAIN` varchar(127) NOT NULL,
  `DATA_KEY` varchar(255) NOT NULL,
  `DATA_VALUE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TENANT_ID`,`USER_NAME`,`USER_DOMAIN`,`DATA_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_OAUTH2_ACCESS_TOKEN`
--

DROP TABLE IF EXISTS `IDN_OAUTH2_ACCESS_TOKEN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_OAUTH2_ACCESS_TOKEN` (
  `TOKEN_ID` varchar(255) NOT NULL,
  `ACCESS_TOKEN` varchar(2048) NOT NULL,
  `REFRESH_TOKEN` varchar(2048) DEFAULT NULL,
  `CONSUMER_KEY_ID` int DEFAULT NULL,
  `AUTHZ_USER` varchar(100) DEFAULT NULL,
  `TENANT_ID` int DEFAULT NULL,
  `USER_DOMAIN` varchar(50) DEFAULT NULL,
  `USER_TYPE` varchar(25) DEFAULT NULL,
  `GRANT_TYPE` varchar(50) DEFAULT NULL,
  `TIME_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `REFRESH_TOKEN_TIME_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `VALIDITY_PERIOD` bigint DEFAULT NULL,
  `REFRESH_TOKEN_VALIDITY_PERIOD` bigint DEFAULT NULL,
  `TOKEN_SCOPE_HASH` varchar(32) DEFAULT NULL,
  `TOKEN_STATE` varchar(25) DEFAULT 'ACTIVE',
  `TOKEN_STATE_ID` varchar(128) DEFAULT 'NONE',
  `SUBJECT_IDENTIFIER` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TOKEN_ID`),
  KEY `CONSUMER_KEY_ID` (`CONSUMER_KEY_ID`),
  CONSTRAINT `idn_oauth2_access_token_ibfk_1` FOREIGN KEY (`CONSUMER_KEY_ID`) REFERENCES `IDN_OAUTH_CONSUMER_APPS` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_OAUTH2_RESOURCE_SCOPE`
--

DROP TABLE IF EXISTS `IDN_OAUTH2_RESOURCE_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_OAUTH2_RESOURCE_SCOPE` (
  `RESOURCE_PATH` varchar(255) NOT NULL,
  `SCOPE_ID` int NOT NULL,
  `TENANT_ID` int NOT NULL DEFAULT '-1234',
  PRIMARY KEY (`RESOURCE_PATH`,`TENANT_ID`),
  KEY `SCOPE_ID` (`SCOPE_ID`),
  CONSTRAINT `idn_oauth2_resource_scope_ibfk_1` FOREIGN KEY (`SCOPE_ID`) REFERENCES `IDN_OAUTH2_SCOPE` (`SCOPE_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_OAUTH2_SCOPE`
--

DROP TABLE IF EXISTS `IDN_OAUTH2_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_OAUTH2_SCOPE` (
  `SCOPE_ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL,
  `DISPLAY_NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `TENANT_ID` int NOT NULL DEFAULT '-1',
  `SCOPE_TYPE` varchar(255) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`),
  UNIQUE KEY `NAME` (`NAME`,`TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_OAUTH2_SCOPE_BINDING`
--

DROP TABLE IF EXISTS `IDN_OAUTH2_SCOPE_BINDING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_OAUTH2_SCOPE_BINDING` (
  `SCOPE_ID` int NOT NULL,
  `SCOPE_BINDING` varchar(255) NOT NULL,
  `BINDING_TYPE` varchar(255) NOT NULL,
  `TENANT_ID` int NOT NULL DEFAULT '-1234',
  PRIMARY KEY (`SCOPE_ID`,`SCOPE_BINDING`,`BINDING_TYPE`,`TENANT_ID`),
  CONSTRAINT `idn_oauth2_scope_binding_ibfk_1` FOREIGN KEY (`SCOPE_ID`) REFERENCES `IDN_OAUTH2_SCOPE` (`SCOPE_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_OAUTH_CONSUMER_APPS`
--

DROP TABLE IF EXISTS `IDN_OAUTH_CONSUMER_APPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_OAUTH_CONSUMER_APPS` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `CONSUMER_KEY` varchar(255) DEFAULT NULL,
  `CONSUMER_SECRET` varchar(2048) DEFAULT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `TENANT_ID` int DEFAULT '0',
  `USER_DOMAIN` varchar(50) DEFAULT NULL,
  `APP_NAME` varchar(255) DEFAULT NULL,
  `OAUTH_VERSION` varchar(128) DEFAULT NULL,
  `CALLBACK_URL` varchar(2048) DEFAULT NULL,
  `GRANT_TYPES` varchar(1024) DEFAULT NULL,
  `PKCE_MANDATORY` char(1) DEFAULT '0',
  `PKCE_SUPPORT_PLAIN` char(1) DEFAULT '0',
  `APP_STATE` varchar(25) DEFAULT 'ACTIVE',
  `USER_ACCESS_TOKEN_EXPIRE_TIME` bigint DEFAULT '3600',
  `APP_ACCESS_TOKEN_EXPIRE_TIME` bigint DEFAULT '3600',
  `REFRESH_TOKEN_EXPIRE_TIME` bigint DEFAULT '84600',
  `ID_TOKEN_EXPIRE_TIME` bigint DEFAULT '3600',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CONSUMER_KEY_CONSTRAINT` (`CONSUMER_KEY`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_OIDC_SCOPE`
--

DROP TABLE IF EXISTS `IDN_OIDC_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_OIDC_SCOPE` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL,
  `TENANT_ID` int DEFAULT '-1234',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME` (`NAME`,`TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_OIDC_SCOPE_CLAIM_MAPPING`
--

DROP TABLE IF EXISTS `IDN_OIDC_SCOPE_CLAIM_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_OIDC_SCOPE_CLAIM_MAPPING` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `SCOPE_ID` int NOT NULL,
  `EXTERNAL_CLAIM_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `SCOPE_ID` (`SCOPE_ID`),
  CONSTRAINT `idn_oidc_scope_claim_mapping_ibfk_1` FOREIGN KEY (`SCOPE_ID`) REFERENCES `IDN_OIDC_SCOPE` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_RECOVERY_DATA`
--

DROP TABLE IF EXISTS `IDN_RECOVERY_DATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_RECOVERY_DATA` (
  `USER_NAME` varchar(255) NOT NULL,
  `USER_DOMAIN` varchar(127) NOT NULL,
  `TENANT_ID` int DEFAULT '-1234',
  `CODE` varchar(255) NOT NULL,
  `SCENARIO` varchar(255) NOT NULL,
  `STEP` varchar(255) NOT NULL,
  `TIME_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `REMAINING_SETS` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDN_USER_METADATA`
--

DROP TABLE IF EXISTS `IDN_USER_METADATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDN_USER_METADATA` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `USER_NAME` varchar(255) NOT NULL,
  `USER_DOMAIN` varchar(127) NOT NULL,
  `TENANT_ID` int DEFAULT '-1234',
  `METADATA_TYPE` varchar(255) NOT NULL,
  `METADATA_VALUE` varchar(255) NOT NULL,
  `VALUE_TYPE` varchar(255) NOT NULL,
  `TIME_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDP`
--

DROP TABLE IF EXISTS `IDP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TENANT_ID` int NOT NULL,
  `NAME` varchar(254) NOT NULL,
  `IS_PRIMARY` char(1) NOT NULL DEFAULT '0',
  `HOME_REALM_ID` varchar(254) DEFAULT NULL,
  `IMAGE` mediumblob,
  `CERTIFICATE` blob,
  `ALIAS` varchar(254) DEFAULT NULL,
  `INBOUND_PROV_ENABLED` char(1) NOT NULL DEFAULT '0',
  `INBOUND_PROV_USER_STORE_ID` varchar(254) DEFAULT NULL,
  `USER_CLAIM_URI` varchar(254) DEFAULT NULL,
  `ROLE_CLAIM_URI` varchar(254) DEFAULT NULL,
  `DESCRIPTION` varchar(1024) DEFAULT NULL,
  `DEFAULT_AUTHENTICATOR_NAME` varchar(254) DEFAULT NULL,
  `DEFAULT_PRO_CONNECTOR_NAME` varchar(254) DEFAULT NULL,
  `PROVISIONING_ROLE` varchar(254) DEFAULT NULL,
  `IS_FEDERATION_HUB` char(1) NOT NULL DEFAULT '0',
  `IS_LOCAL_CLAIM_DIALECT` char(1) NOT NULL DEFAULT '0',
  `DISPLAY_NAME` varchar(254) DEFAULT NULL,
  `IDP_ENTITY_ID` varchar(254) DEFAULT NULL,
  `IS_ENABLED` char(1) NOT NULL DEFAULT '1',
  `IMAGE_URL` varchar(1024) DEFAULT NULL,
  `UUID` char(36) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `TENANT_ID` (`TENANT_ID`,`NAME`),
  UNIQUE KEY `UUID` (`UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDP_AUTHENT_PROPERTY`
--

DROP TABLE IF EXISTS `IDP_AUTHENT_PROPERTY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_AUTHENT_PROPERTY` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `AUTHENTICATOR_ID` int NOT NULL,
  `PROPERTY_KEY` varchar(255) NOT NULL,
  `PROPERTY_VALUE` varchar(2047) DEFAULT NULL,
  `IS_SECRET` char(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `AUTHENTICATOR_ID` (`AUTHENTICATOR_ID`,`PROPERTY_KEY`),
  CONSTRAINT `idp_authent_property_ibfk_1` FOREIGN KEY (`AUTHENTICATOR_ID`) REFERENCES `IDP_AUTHENTICATOR` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDP_AUTHENTICATOR`
--

DROP TABLE IF EXISTS `IDP_AUTHENTICATOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_AUTHENTICATOR` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TENANT_ID` int NOT NULL,
  `IDP_ID` int NOT NULL,
  `NAME` varchar(254) NOT NULL,
  `IS_ENABLED` char(1) NOT NULL DEFAULT '1',
  `DISPLAY_NAME` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `TENANT_ID` (`TENANT_ID`,`IDP_ID`,`NAME`),
  KEY `IDP_ID` (`IDP_ID`),
  CONSTRAINT `idp_authenticator_ibfk_1` FOREIGN KEY (`IDP_ID`) REFERENCES `IDP` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDP_AUTHENTICATOR_PROPERTY`
--

DROP TABLE IF EXISTS `IDP_AUTHENTICATOR_PROPERTY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_AUTHENTICATOR_PROPERTY` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TENANT_ID` int NOT NULL,
  `AUTHENTICATOR_ID` int NOT NULL,
  `PROPERTY_KEY` varchar(255) NOT NULL,
  `PROPERTY_VALUE` varchar(2047) DEFAULT NULL,
  `IS_SECRET` char(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `TENANT_ID` (`TENANT_ID`,`AUTHENTICATOR_ID`,`PROPERTY_KEY`),
  KEY `AUTHENTICATOR_ID` (`AUTHENTICATOR_ID`),
  CONSTRAINT `idp_authenticator_property_ibfk_1` FOREIGN KEY (`AUTHENTICATOR_ID`) REFERENCES `IDP_AUTHENTICATOR` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDP_CLAIM`
--

DROP TABLE IF EXISTS `IDP_CLAIM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_CLAIM` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IDP_ID` int NOT NULL,
  `CLAIM` varchar(254) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IDP_ID` (`IDP_ID`,`CLAIM`),
  CONSTRAINT `idp_claim_ibfk_1` FOREIGN KEY (`IDP_ID`) REFERENCES `IDP` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDP_CLAIM_MAPPING`
--

DROP TABLE IF EXISTS `IDP_CLAIM_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_CLAIM_MAPPING` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IDP_CLAIM_ID` int NOT NULL,
  `TENANT_ID` int NOT NULL,
  `LOCAL_CLAIM` varchar(254) NOT NULL,
  `DEFAULT_VALUE` varchar(254) DEFAULT NULL,
  `IS_REQUESTED` varchar(128) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IDP_CLAIM_ID` (`IDP_CLAIM_ID`,`TENANT_ID`,`LOCAL_CLAIM`),
  CONSTRAINT `idp_claim_mapping_ibfk_1` FOREIGN KEY (`IDP_CLAIM_ID`) REFERENCES `IDP_CLAIM` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDP_METADATA`
--

DROP TABLE IF EXISTS `IDP_METADATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_METADATA` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IDP_ID` int NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `TENANT_ID` int DEFAULT '-1234',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IDP_METADATA_CONSTRAINT` (`IDP_ID`,`NAME`),
  CONSTRAINT `idp_metadata_ibfk_1` FOREIGN KEY (`IDP_ID`) REFERENCES `IDP` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDP_PROV_CONFIG_PROPERTY`
--

DROP TABLE IF EXISTS `IDP_PROV_CONFIG_PROPERTY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_PROV_CONFIG_PROPERTY` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TENANT_ID` int NOT NULL,
  `PROVISIONING_CONFIG_ID` int NOT NULL,
  `PROPERTY_KEY` varchar(255) NOT NULL,
  `PROPERTY_VALUE` varchar(2047) DEFAULT NULL,
  `PROPERTY_BLOB_VALUE` blob,
  `IS_SECRET` char(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `TENANT_ID` (`TENANT_ID`,`PROVISIONING_CONFIG_ID`,`PROPERTY_KEY`),
  KEY `PROVISIONING_CONFIG_ID` (`PROVISIONING_CONFIG_ID`),
  CONSTRAINT `idp_prov_config_property_ibfk_1` FOREIGN KEY (`PROVISIONING_CONFIG_ID`) REFERENCES `IDP_PROVISIONING_CONFIG` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDP_PROVISIONING_CONFIG`
--

DROP TABLE IF EXISTS `IDP_PROVISIONING_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_PROVISIONING_CONFIG` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TENANT_ID` int NOT NULL,
  `IDP_ID` int NOT NULL,
  `PROVISIONING_CONNECTOR_TYPE` varchar(254) NOT NULL,
  `IS_ENABLED` char(1) NOT NULL DEFAULT '0',
  `IS_DEFAULT` char(1) NOT NULL DEFAULT '0',
  `IS_BLOCKING` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `TENANT_ID` (`TENANT_ID`,`IDP_ID`,`PROVISIONING_CONNECTOR_TYPE`),
  KEY `IDP_ID` (`IDP_ID`),
  CONSTRAINT `idp_provisioning_config_ibfk_1` FOREIGN KEY (`IDP_ID`) REFERENCES `IDP` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDP_PROVISIONING_ENTITY`
--

DROP TABLE IF EXISTS `IDP_PROVISIONING_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_PROVISIONING_ENTITY` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PROVISIONING_CONFIG_ID` int NOT NULL,
  `ENTITY_TYPE` varchar(255) NOT NULL,
  `ENTITY_LOCAL_ID` varchar(255) NOT NULL,
  `ENTITY_EXTERNAL_ID` varchar(255) NOT NULL,
  `ENTITY_MODIFY_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TENANT_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PROVISIONING_CONFIG_ID` (`PROVISIONING_CONFIG_ID`,`ENTITY_TYPE`,`ENTITY_LOCAL_ID`),
  UNIQUE KEY `PROVISIONING_CONFIG_ID_2` (`PROVISIONING_CONFIG_ID`,`ENTITY_TYPE`,`ENTITY_EXTERNAL_ID`),
  CONSTRAINT `idp_provisioning_entity_ibfk_1` FOREIGN KEY (`PROVISIONING_CONFIG_ID`) REFERENCES `IDP_PROVISIONING_CONFIG` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDP_ROLE`
--

DROP TABLE IF EXISTS `IDP_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_ROLE` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IDP_ID` int NOT NULL,
  `ROLE` varchar(254) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IDP_ID` (`IDP_ID`,`ROLE`),
  CONSTRAINT `idp_role_ibfk_1` FOREIGN KEY (`IDP_ID`) REFERENCES `IDP` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IDP_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `IDP_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_ROLE_MAPPING` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IDP_ROLE_ID` int NOT NULL,
  `TENANT_ID` int NOT NULL,
  `USER_STORE_ID` varchar(255) NOT NULL,
  `LOCAL_ROLE` varchar(254) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IDP_ROLE_ID` (`IDP_ROLE_ID`,`TENANT_ID`,`USER_STORE_ID`,`LOCAL_ROLE`),
  CONSTRAINT `idp_role_mapping_ibfk_1` FOREIGN KEY (`IDP_ROLE_ID`) REFERENCES `IDP_ROLE` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_ASSOCIATION`
--

DROP TABLE IF EXISTS `REG_ASSOCIATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_ASSOCIATION` (
  `REG_ASSOCIATION_ID` int NOT NULL AUTO_INCREMENT,
  `REG_SOURCEPATH` varchar(750) NOT NULL,
  `REG_TARGETPATH` varchar(750) NOT NULL,
  `REG_ASSOCIATION_TYPE` varchar(200) NOT NULL,
  `REG_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`REG_ASSOCIATION_ID`,`REG_TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_CLUSTER_LOCK`
--

DROP TABLE IF EXISTS `REG_CLUSTER_LOCK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_CLUSTER_LOCK` (
  `REG_LOCK_ID` int NOT NULL AUTO_INCREMENT,
  `REG_LOCK_NAME` varchar(20) DEFAULT NULL,
  `REG_LOCK_VALUE` varchar(20) DEFAULT 'ALLOWED',
  `REG_RECORDED_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`REG_LOCK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_COMMENT`
--

DROP TABLE IF EXISTS `REG_COMMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_COMMENT` (
  `REG_ID` int NOT NULL AUTO_INCREMENT,
  `REG_COMMENT_TEXT` varchar(500) NOT NULL,
  `REG_USER_ID` varchar(31) NOT NULL,
  `REG_COMMENTED_TIME` timestamp NOT NULL,
  `REG_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`REG_ID`,`REG_TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_CONTENT`
--

DROP TABLE IF EXISTS `REG_CONTENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_CONTENT` (
  `REG_CONTENT_ID` int NOT NULL AUTO_INCREMENT,
  `REG_CONTENT_DATA` longblob,
  `REG_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`REG_CONTENT_ID`,`REG_TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=868 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_CONTENT_HISTORY`
--

DROP TABLE IF EXISTS `REG_CONTENT_HISTORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_CONTENT_HISTORY` (
  `REG_CONTENT_ID` int NOT NULL,
  `REG_CONTENT_DATA` longblob,
  `REG_DELETED` smallint DEFAULT NULL,
  `REG_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`REG_CONTENT_ID`,`REG_TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_LOG`
--

DROP TABLE IF EXISTS `REG_LOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_LOG` (
  `REG_LOG_ID` int NOT NULL AUTO_INCREMENT,
  `REG_PATH` varchar(750) DEFAULT NULL,
  `REG_USER_ID` varchar(31) NOT NULL,
  `REG_LOGGED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `REG_ACTION` int NOT NULL,
  `REG_ACTION_DATA` varchar(500) DEFAULT NULL,
  `REG_TENANT_ID` int DEFAULT '0',
  PRIMARY KEY (`REG_LOG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1909 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_PATH`
--

DROP TABLE IF EXISTS `REG_PATH`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_PATH` (
  `REG_PATH_ID` int NOT NULL AUTO_INCREMENT,
  `REG_PATH_VALUE` varchar(750) NOT NULL,
  `REG_PATH_PARENT_ID` int DEFAULT NULL,
  `REG_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`REG_PATH_ID`,`REG_TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=394 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_PROPERTY`
--

DROP TABLE IF EXISTS `REG_PROPERTY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_PROPERTY` (
  `REG_ID` int NOT NULL AUTO_INCREMENT,
  `REG_NAME` varchar(100) NOT NULL,
  `REG_VALUE` varchar(2500) DEFAULT NULL,
  `REG_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`REG_ID`,`REG_TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2224 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_RESOURCE`
--

DROP TABLE IF EXISTS `REG_RESOURCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_RESOURCE` (
  `REG_PATH_ID` int NOT NULL,
  `REG_NAME` varchar(256) DEFAULT NULL,
  `REG_VERSION` int NOT NULL AUTO_INCREMENT,
  `REG_MEDIA_TYPE` varchar(252) DEFAULT NULL,
  `REG_CREATOR` varchar(31) NOT NULL,
  `REG_CREATED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `REG_LAST_UPDATOR` varchar(31) DEFAULT NULL,
  `REG_LAST_UPDATED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `REG_DESCRIPTION` varchar(1000) DEFAULT NULL,
  `REG_CONTENT_ID` int DEFAULT NULL,
  `REG_TENANT_ID` int NOT NULL DEFAULT '0',
  `REG_UUID` varchar(100) NOT NULL,
  PRIMARY KEY (`REG_VERSION`,`REG_TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1678 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_RESOURCE_COMMENT`
--

DROP TABLE IF EXISTS `REG_RESOURCE_COMMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_RESOURCE_COMMENT` (
  `REG_COMMENT_ID` int NOT NULL,
  `REG_VERSION` int DEFAULT NULL,
  `REG_PATH_ID` int DEFAULT NULL,
  `REG_RESOURCE_NAME` varchar(256) DEFAULT NULL,
  `REG_TENANT_ID` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_RESOURCE_HISTORY`
--

DROP TABLE IF EXISTS `REG_RESOURCE_HISTORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_RESOURCE_HISTORY` (
  `REG_PATH_ID` int NOT NULL,
  `REG_NAME` varchar(256) DEFAULT NULL,
  `REG_VERSION` int NOT NULL,
  `REG_MEDIA_TYPE` varchar(500) DEFAULT NULL,
  `REG_CREATOR` varchar(255) NOT NULL,
  `REG_CREATED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `REG_LAST_UPDATOR` varchar(255) DEFAULT NULL,
  `REG_LAST_UPDATED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `REG_DESCRIPTION` varchar(1000) DEFAULT NULL,
  `REG_CONTENT_ID` int DEFAULT NULL,
  `REG_DELETED` smallint DEFAULT NULL,
  `REG_TENANT_ID` int NOT NULL DEFAULT '0',
  `REG_UUID` varchar(100) NOT NULL,
  PRIMARY KEY (`REG_VERSION`,`REG_TENANT_ID`),
  KEY `REG_RESOURCE_HIST_FK_BY_PATHID` (`REG_PATH_ID`,`REG_TENANT_ID`),
  KEY `REG_RESOURCE_HIST_FK_BY_CONTENT_ID` (`REG_CONTENT_ID`,`REG_TENANT_ID`),
  KEY `REG_RESOURCE_HISTORY_IND_BY_NAME` (`REG_NAME`,`REG_TENANT_ID`),
  CONSTRAINT `REG_RESOURCE_HIST_FK_BY_CONTENT_ID` FOREIGN KEY (`REG_CONTENT_ID`, `REG_TENANT_ID`) REFERENCES `REG_CONTENT_HISTORY` (`REG_CONTENT_ID`, `REG_TENANT_ID`),
  CONSTRAINT `REG_RESOURCE_HIST_FK_BY_PATHID` FOREIGN KEY (`REG_PATH_ID`, `REG_TENANT_ID`) REFERENCES `REG_PATH` (`REG_PATH_ID`, `REG_TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_RESOURCE_PROPERTY`
--

DROP TABLE IF EXISTS `REG_RESOURCE_PROPERTY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_RESOURCE_PROPERTY` (
  `REG_PROPERTY_ID` int NOT NULL,
  `REG_VERSION` int DEFAULT NULL,
  `REG_PATH_ID` int DEFAULT NULL,
  `REG_RESOURCE_NAME` varchar(256) DEFAULT NULL,
  `REG_TENANT_ID` int DEFAULT '0',
  KEY `REG_RESOURCE_PROPERTY_FK_BY_PATH_ID` (`REG_PATH_ID`,`REG_TENANT_ID`),
  KEY `REG_RESOURCE_PROPERTY_FK_BY_PROP_ID` (`REG_PROPERTY_ID`,`REG_TENANT_ID`),
  CONSTRAINT `REG_RESOURCE_PROPERTY_FK_BY_PATH_ID` FOREIGN KEY (`REG_PATH_ID`, `REG_TENANT_ID`) REFERENCES `REG_PATH` (`REG_PATH_ID`, `REG_TENANT_ID`),
  CONSTRAINT `REG_RESOURCE_PROPERTY_FK_BY_PROP_ID` FOREIGN KEY (`REG_PROPERTY_ID`, `REG_TENANT_ID`) REFERENCES `REG_PROPERTY` (`REG_ID`, `REG_TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_RESOURCE_TAG`
--

DROP TABLE IF EXISTS `REG_RESOURCE_TAG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_RESOURCE_TAG` (
  `REG_TAG_ID` int NOT NULL,
  `REG_VERSION` int DEFAULT NULL,
  `REG_PATH_ID` int DEFAULT NULL,
  `REG_RESOURCE_NAME` varchar(256) DEFAULT NULL,
  `REG_TENANT_ID` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REG_TAG`
--

DROP TABLE IF EXISTS `REG_TAG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REG_TAG` (
  `REG_ID` int NOT NULL AUTO_INCREMENT,
  `REG_TAG_NAME` varchar(500) NOT NULL,
  `REG_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`REG_ID`,`REG_TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SP_APP`
--

DROP TABLE IF EXISTS `SP_APP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SP_APP` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TENANT_ID` int NOT NULL,
  `APP_NAME` varchar(255) NOT NULL,
  `USER_STORE` varchar(255) NOT NULL,
  `UUID` char(36) NOT NULL,
  `DESCRIPTION` varchar(1024) DEFAULT NULL,
  `AUTH_TYPE` varchar(255) NOT NULL,
  `IS_SaaS_APP` char(1) DEFAULT '0',
  `IS_DISCOVERABLE` char(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `APPLICATION_NAME_CONSTRAINT` (`APP_NAME`,`TENANT_ID`),
  UNIQUE KEY `APPLICATION_UUID_CONSTRAINT` (`UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_ACCOUNT_MAPPING`
--

DROP TABLE IF EXISTS `UM_ACCOUNT_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_ACCOUNT_MAPPING` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_USER_NAME` varchar(255) NOT NULL,
  `UM_TENANT_ID` int NOT NULL,
  `UM_USER_STORE_DOMAIN` varchar(100) DEFAULT NULL,
  `UM_ACC_LINK_ID` int NOT NULL,
  PRIMARY KEY (`UM_ID`),
  UNIQUE KEY `UM_USER_NAME` (`UM_USER_NAME`,`UM_TENANT_ID`,`UM_USER_STORE_DOMAIN`,`UM_ACC_LINK_ID`),
  KEY `UM_TENANT_ID` (`UM_TENANT_ID`),
  CONSTRAINT `um_account_mapping_ibfk_1` FOREIGN KEY (`UM_TENANT_ID`) REFERENCES `UM_TENANT` (`UM_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_CLAIM`
--

DROP TABLE IF EXISTS `UM_CLAIM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_CLAIM` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_DIALECT_ID` int NOT NULL,
  `UM_CLAIM_URI` varchar(255) NOT NULL,
  `UM_DISPLAY_TAG` varchar(255) DEFAULT NULL,
  `UM_DESCRIPTION` varchar(255) DEFAULT NULL,
  `UM_MAPPED_ATTRIBUTE_DOMAIN` varchar(255) DEFAULT NULL,
  `UM_MAPPED_ATTRIBUTE` varchar(255) DEFAULT NULL,
  `UM_REG_EX` varchar(255) DEFAULT NULL,
  `UM_SUPPORTED` smallint DEFAULT NULL,
  `UM_REQUIRED` smallint DEFAULT NULL,
  `UM_DISPLAY_ORDER` int DEFAULT NULL,
  `UM_CHECKED_ATTRIBUTE` smallint DEFAULT NULL,
  `UM_READ_ONLY` smallint DEFAULT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  UNIQUE KEY `UM_DIALECT_ID` (`UM_DIALECT_ID`,`UM_CLAIM_URI`,`UM_TENANT_ID`,`UM_MAPPED_ATTRIBUTE_DOMAIN`),
  KEY `UM_DIALECT_ID_2` (`UM_DIALECT_ID`,`UM_TENANT_ID`),
  CONSTRAINT `um_claim_ibfk_1` FOREIGN KEY (`UM_DIALECT_ID`, `UM_TENANT_ID`) REFERENCES `UM_DIALECT` (`UM_ID`, `UM_TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_CLAIM_BEHAVIOR`
--

DROP TABLE IF EXISTS `UM_CLAIM_BEHAVIOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_CLAIM_BEHAVIOR` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_PROFILE_ID` int DEFAULT NULL,
  `UM_CLAIM_ID` int DEFAULT NULL,
  `UM_BEHAVIOUR` smallint DEFAULT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  KEY `UM_PROFILE_ID` (`UM_PROFILE_ID`,`UM_TENANT_ID`),
  KEY `UM_CLAIM_ID` (`UM_CLAIM_ID`,`UM_TENANT_ID`),
  CONSTRAINT `um_claim_behavior_ibfk_1` FOREIGN KEY (`UM_PROFILE_ID`, `UM_TENANT_ID`) REFERENCES `UM_PROFILE_CONFIG` (`UM_ID`, `UM_TENANT_ID`),
  CONSTRAINT `um_claim_behavior_ibfk_2` FOREIGN KEY (`UM_CLAIM_ID`, `UM_TENANT_ID`) REFERENCES `UM_CLAIM` (`UM_ID`, `UM_TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_DIALECT`
--

DROP TABLE IF EXISTS `UM_DIALECT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_DIALECT` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_DIALECT_URI` varchar(255) NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  UNIQUE KEY `UM_DIALECT_URI` (`UM_DIALECT_URI`,`UM_TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_DOMAIN`
--

DROP TABLE IF EXISTS `UM_DOMAIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_DOMAIN` (
  `UM_DOMAIN_ID` int NOT NULL AUTO_INCREMENT,
  `UM_DOMAIN_NAME` varchar(255) NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_DOMAIN_ID`,`UM_TENANT_ID`),
  UNIQUE KEY `UM_DOMAIN_NAME` (`UM_DOMAIN_NAME`,`UM_TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_GROUP_UUID_DOMAIN_MAPPER`
--

DROP TABLE IF EXISTS `UM_GROUP_UUID_DOMAIN_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_GROUP_UUID_DOMAIN_MAPPER` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_GROUP_ID` varchar(255) NOT NULL,
  `UM_DOMAIN_ID` int NOT NULL,
  `UM_TENANT_ID` int DEFAULT '0',
  PRIMARY KEY (`UM_ID`),
  UNIQUE KEY `UM_GROUP_ID` (`UM_GROUP_ID`),
  KEY `UM_DOMAIN_ID` (`UM_DOMAIN_ID`,`UM_TENANT_ID`),
  KEY `GRP_UUID_DM_GRP_ID_TID` (`UM_GROUP_ID`,`UM_TENANT_ID`),
  CONSTRAINT `um_group_uuid_domain_mapper_ibfk_1` FOREIGN KEY (`UM_DOMAIN_ID`, `UM_TENANT_ID`) REFERENCES `UM_DOMAIN` (`UM_DOMAIN_ID`, `UM_TENANT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_HYBRID_GROUP_ROLE`
--

DROP TABLE IF EXISTS `UM_HYBRID_GROUP_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_HYBRID_GROUP_ROLE` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_GROUP_NAME` varchar(255) DEFAULT NULL,
  `UM_ROLE_ID` int NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  `UM_DOMAIN_ID` int DEFAULT NULL,
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  UNIQUE KEY `UM_GROUP_NAME` (`UM_GROUP_NAME`,`UM_ROLE_ID`,`UM_TENANT_ID`,`UM_DOMAIN_ID`),
  KEY `UM_ROLE_ID` (`UM_ROLE_ID`,`UM_TENANT_ID`),
  KEY `UM_DOMAIN_ID` (`UM_DOMAIN_ID`,`UM_TENANT_ID`),
  CONSTRAINT `um_hybrid_group_role_ibfk_1` FOREIGN KEY (`UM_ROLE_ID`, `UM_TENANT_ID`) REFERENCES `UM_HYBRID_ROLE` (`UM_ID`, `UM_TENANT_ID`) ON DELETE CASCADE,
  CONSTRAINT `um_hybrid_group_role_ibfk_2` FOREIGN KEY (`UM_DOMAIN_ID`, `UM_TENANT_ID`) REFERENCES `UM_DOMAIN` (`UM_DOMAIN_ID`, `UM_TENANT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_HYBRID_ROLE`
--

DROP TABLE IF EXISTS `UM_HYBRID_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_HYBRID_ROLE` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_ROLE_NAME` varchar(255) NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  UNIQUE KEY `UM_ROLE_NAME` (`UM_ROLE_NAME`,`UM_TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_HYBRID_USER_ROLE`
--

DROP TABLE IF EXISTS `UM_HYBRID_USER_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_HYBRID_USER_ROLE` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_USER_NAME` varchar(255) DEFAULT NULL,
  `UM_ROLE_ID` int NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  `UM_DOMAIN_ID` int DEFAULT NULL,
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  KEY `UM_ROLE_ID` (`UM_ROLE_ID`,`UM_TENANT_ID`),
  KEY `UM_DOMAIN_ID` (`UM_DOMAIN_ID`,`UM_TENANT_ID`),
  CONSTRAINT `um_hybrid_user_role_ibfk_1` FOREIGN KEY (`UM_ROLE_ID`, `UM_TENANT_ID`) REFERENCES `UM_HYBRID_ROLE` (`UM_ID`, `UM_TENANT_ID`) ON DELETE CASCADE,
  CONSTRAINT `um_hybrid_user_role_ibfk_2` FOREIGN KEY (`UM_DOMAIN_ID`, `UM_TENANT_ID`) REFERENCES `UM_DOMAIN` (`UM_DOMAIN_ID`, `UM_TENANT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_MODULE`
--

DROP TABLE IF EXISTS `UM_MODULE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_MODULE` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_MODULE_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`UM_ID`),
  UNIQUE KEY `UM_MODULE_NAME` (`UM_MODULE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_MODULE_ACTIONS`
--

DROP TABLE IF EXISTS `UM_MODULE_ACTIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_MODULE_ACTIONS` (
  `UM_ACTION` varchar(255) NOT NULL,
  `UM_MODULE_ID` int NOT NULL,
  PRIMARY KEY (`UM_ACTION`,`UM_MODULE_ID`),
  KEY `UM_MODULE_ID` (`UM_MODULE_ID`),
  CONSTRAINT `um_module_actions_ibfk_1` FOREIGN KEY (`UM_MODULE_ID`) REFERENCES `UM_MODULE` (`UM_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_ORG`
--

DROP TABLE IF EXISTS `UM_ORG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_ORG` (
  `UM_ID` varchar(36) NOT NULL,
  `UM_ORG_NAME` varchar(255) NOT NULL,
  `UM_ORG_DESCRIPTION` varchar(1024) DEFAULT NULL,
  `UM_CREATED_TIME` timestamp NOT NULL,
  `UM_LAST_MODIFIED` timestamp NOT NULL,
  `UM_STATUS` varchar(255) NOT NULL DEFAULT 'ACTIVE',
  `UM_PARENT_ID` varchar(36) DEFAULT NULL,
  `UM_ORG_TYPE` varchar(100) NOT NULL,
  PRIMARY KEY (`UM_ID`),
  KEY `UM_PARENT_ID` (`UM_PARENT_ID`),
  CONSTRAINT `um_org_ibfk_1` FOREIGN KEY (`UM_PARENT_ID`) REFERENCES `UM_ORG` (`UM_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_ORG_ATTRIBUTE`
--

DROP TABLE IF EXISTS `UM_ORG_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_ORG_ATTRIBUTE` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_ORG_ID` varchar(36) NOT NULL,
  `UM_ATTRIBUTE_KEY` varchar(255) NOT NULL,
  `UM_ATTRIBUTE_VALUE` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`UM_ID`),
  UNIQUE KEY `UM_ORG_ID` (`UM_ORG_ID`,`UM_ATTRIBUTE_KEY`),
  CONSTRAINT `um_org_attribute_ibfk_1` FOREIGN KEY (`UM_ORG_ID`) REFERENCES `UM_ORG` (`UM_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_ORG_HIERARCHY`
--

DROP TABLE IF EXISTS `UM_ORG_HIERARCHY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_ORG_HIERARCHY` (
  `UM_PARENT_ID` varchar(36) NOT NULL,
  `UM_ID` varchar(36) NOT NULL,
  `DEPTH` int DEFAULT NULL,
  PRIMARY KEY (`UM_PARENT_ID`,`UM_ID`),
  KEY `UM_ID` (`UM_ID`),
  CONSTRAINT `um_org_hierarchy_ibfk_1` FOREIGN KEY (`UM_PARENT_ID`) REFERENCES `UM_ORG` (`UM_ID`) ON DELETE CASCADE,
  CONSTRAINT `um_org_hierarchy_ibfk_2` FOREIGN KEY (`UM_ID`) REFERENCES `UM_ORG` (`UM_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_ORG_PERMISSION`
--

DROP TABLE IF EXISTS `UM_ORG_PERMISSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_ORG_PERMISSION` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_RESOURCE_ID` varchar(255) NOT NULL,
  `UM_ACTION` varchar(255) NOT NULL,
  `UM_TENANT_ID` int DEFAULT '0',
  PRIMARY KEY (`UM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_ORG_ROLE`
--

DROP TABLE IF EXISTS `UM_ORG_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_ORG_ROLE` (
  `UM_ROLE_ID` varchar(255) NOT NULL,
  `UM_ROLE_NAME` varchar(255) NOT NULL,
  `UM_ORG_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`UM_ROLE_ID`),
  KEY `FK_UM_ORG_ROLE_UM_ORG` (`UM_ORG_ID`),
  CONSTRAINT `FK_UM_ORG_ROLE_UM_ORG` FOREIGN KEY (`UM_ORG_ID`) REFERENCES `UM_ORG` (`UM_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_ORG_ROLE_GROUP`
--

DROP TABLE IF EXISTS `UM_ORG_ROLE_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_ORG_ROLE_GROUP` (
  `UM_GROUP_ID` varchar(255) NOT NULL,
  `UM_ROLE_ID` varchar(255) NOT NULL,
  KEY `FK_UM_ORG_ROLE_GROUP_UM_ORG_ROLE` (`UM_ROLE_ID`),
  CONSTRAINT `FK_UM_ORG_ROLE_GROUP_UM_ORG_ROLE` FOREIGN KEY (`UM_ROLE_ID`) REFERENCES `UM_ORG_ROLE` (`UM_ROLE_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_ORG_ROLE_PERMISSION`
--

DROP TABLE IF EXISTS `UM_ORG_ROLE_PERMISSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_ORG_ROLE_PERMISSION` (
  `UM_PERMISSION_ID` int NOT NULL,
  `UM_ROLE_ID` varchar(255) NOT NULL,
  KEY `FK_UM_ORG_ROLE_PERMISSION_UM_ORG_ROLE` (`UM_ROLE_ID`),
  KEY `FK_UM_ORG_ROLE_PERMISSION_UM_ORG_PERMISSION` (`UM_PERMISSION_ID`),
  CONSTRAINT `FK_UM_ORG_ROLE_PERMISSION_UM_ORG_PERMISSION` FOREIGN KEY (`UM_PERMISSION_ID`) REFERENCES `UM_ORG_PERMISSION` (`UM_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_UM_ORG_ROLE_PERMISSION_UM_ORG_ROLE` FOREIGN KEY (`UM_ROLE_ID`) REFERENCES `UM_ORG_ROLE` (`UM_ROLE_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_ORG_ROLE_USER`
--

DROP TABLE IF EXISTS `UM_ORG_ROLE_USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_ORG_ROLE_USER` (
  `UM_USER_ID` varchar(255) NOT NULL,
  `UM_ROLE_ID` varchar(255) NOT NULL,
  KEY `FK_UM_ORG_ROLE_USER_UM_ORG_ROLE` (`UM_ROLE_ID`),
  CONSTRAINT `FK_UM_ORG_ROLE_USER_UM_ORG_ROLE` FOREIGN KEY (`UM_ROLE_ID`) REFERENCES `UM_ORG_ROLE` (`UM_ROLE_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_PERMISSION`
--

DROP TABLE IF EXISTS `UM_PERMISSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_PERMISSION` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_RESOURCE_ID` varchar(255) NOT NULL,
  `UM_ACTION` varchar(255) NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  `UM_MODULE_ID` int DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_PROFILE_CONFIG`
--

DROP TABLE IF EXISTS `UM_PROFILE_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_PROFILE_CONFIG` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_DIALECT_ID` int NOT NULL,
  `UM_PROFILE_NAME` varchar(255) DEFAULT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  KEY `UM_DIALECT_ID` (`UM_DIALECT_ID`,`UM_TENANT_ID`),
  CONSTRAINT `um_profile_config_ibfk_1` FOREIGN KEY (`UM_DIALECT_ID`, `UM_TENANT_ID`) REFERENCES `UM_DIALECT` (`UM_ID`, `UM_TENANT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_ROLE`
--

DROP TABLE IF EXISTS `UM_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_ROLE` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_ROLE_NAME` varchar(255) NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  UNIQUE KEY `UM_ROLE_NAME` (`UM_ROLE_NAME`,`UM_TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_ROLE_PERMISSION`
--

DROP TABLE IF EXISTS `UM_ROLE_PERMISSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_ROLE_PERMISSION` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_PERMISSION_ID` int NOT NULL,
  `UM_ROLE_NAME` varchar(255) NOT NULL,
  `UM_IS_ALLOWED` int NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  `UM_DOMAIN_ID` int DEFAULT NULL,
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_SHARED_USER_ROLE`
--

DROP TABLE IF EXISTS `UM_SHARED_USER_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_SHARED_USER_ROLE` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `UM_ROLE_ID` int NOT NULL,
  `UM_USER_ID` int NOT NULL,
  `UM_USER_TENANT_ID` int NOT NULL,
  `UM_ROLE_TENANT_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UM_USER_ID` (`UM_USER_ID`,`UM_ROLE_ID`,`UM_USER_TENANT_ID`,`UM_ROLE_TENANT_ID`),
  KEY `UM_ROLE_ID` (`UM_ROLE_ID`,`UM_ROLE_TENANT_ID`),
  KEY `UM_USER_ID_2` (`UM_USER_ID`,`UM_USER_TENANT_ID`),
  CONSTRAINT `um_shared_user_role_ibfk_1` FOREIGN KEY (`UM_ROLE_ID`, `UM_ROLE_TENANT_ID`) REFERENCES `UM_ROLE` (`UM_ID`, `UM_TENANT_ID`) ON DELETE CASCADE,
  CONSTRAINT `um_shared_user_role_ibfk_2` FOREIGN KEY (`UM_USER_ID`, `UM_USER_TENANT_ID`) REFERENCES `UM_USER` (`UM_ID`, `UM_TENANT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_SYSTEM_ROLE`
--

DROP TABLE IF EXISTS `UM_SYSTEM_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_SYSTEM_ROLE` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_ROLE_NAME` varchar(255) NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  UNIQUE KEY `UM_ROLE_NAME` (`UM_ROLE_NAME`,`UM_TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_SYSTEM_USER`
--

DROP TABLE IF EXISTS `UM_SYSTEM_USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_SYSTEM_USER` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_USER_NAME` varchar(255) NOT NULL,
  `UM_USER_PASSWORD` varchar(255) NOT NULL,
  `UM_SALT_VALUE` varchar(31) DEFAULT NULL,
  `UM_REQUIRE_CHANGE` tinyint(1) DEFAULT '0',
  `UM_CHANGED_TIME` timestamp NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  UNIQUE KEY `UM_USER_NAME` (`UM_USER_NAME`,`UM_TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_SYSTEM_USER_ROLE`
--

DROP TABLE IF EXISTS `UM_SYSTEM_USER_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_SYSTEM_USER_ROLE` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_USER_NAME` varchar(255) DEFAULT NULL,
  `UM_ROLE_ID` int NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  KEY `UM_ROLE_ID` (`UM_ROLE_ID`,`UM_TENANT_ID`),
  CONSTRAINT `um_system_user_role_ibfk_1` FOREIGN KEY (`UM_ROLE_ID`, `UM_TENANT_ID`) REFERENCES `UM_SYSTEM_ROLE` (`UM_ID`, `UM_TENANT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_TENANT`
--

DROP TABLE IF EXISTS `UM_TENANT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_TENANT` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_DOMAIN_NAME` varchar(255) NOT NULL,
  `UM_EMAIL` varchar(255) DEFAULT NULL,
  `UM_ACTIVE` tinyint(1) DEFAULT '0',
  `UM_CREATED_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UM_USER_CONFIG` longblob,
  PRIMARY KEY (`UM_ID`),
  UNIQUE KEY `UM_DOMAIN_NAME` (`UM_DOMAIN_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_USER`
--

DROP TABLE IF EXISTS `UM_USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_USER` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_USER_ID` varchar(255) NOT NULL,
  `UM_USER_NAME` varchar(255) NOT NULL,
  `UM_USER_PASSWORD` varchar(255) NOT NULL,
  `UM_SALT_VALUE` varchar(31) DEFAULT NULL,
  `UM_REQUIRE_CHANGE` tinyint(1) DEFAULT '0',
  `UM_CHANGED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  UNIQUE KEY `UM_USER_ID` (`UM_USER_ID`),
  UNIQUE KEY `UM_USER_NAME` (`UM_USER_NAME`,`UM_TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_USER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `UM_USER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_USER_ATTRIBUTE` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_ATTR_NAME` varchar(255) NOT NULL,
  `UM_ATTR_VALUE` varchar(1024) DEFAULT NULL,
  `UM_PROFILE_ID` varchar(255) DEFAULT 'default',
  `UM_USER_ID` int DEFAULT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  KEY `UM_USER_ID` (`UM_USER_ID`,`UM_TENANT_ID`),
  CONSTRAINT `um_user_attribute_ibfk_1` FOREIGN KEY (`UM_USER_ID`, `UM_TENANT_ID`) REFERENCES `UM_USER` (`UM_ID`, `UM_TENANT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_USER_PERMISSION`
--

DROP TABLE IF EXISTS `UM_USER_PERMISSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_USER_PERMISSION` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_PERMISSION_ID` int NOT NULL,
  `UM_USER_NAME` varchar(255) NOT NULL,
  `UM_IS_ALLOWED` smallint NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  KEY `UM_PERMISSION_ID` (`UM_PERMISSION_ID`,`UM_TENANT_ID`),
  CONSTRAINT `um_user_permission_ibfk_1` FOREIGN KEY (`UM_PERMISSION_ID`, `UM_TENANT_ID`) REFERENCES `UM_PERMISSION` (`UM_ID`, `UM_TENANT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_USER_ROLE`
--

DROP TABLE IF EXISTS `UM_USER_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_USER_ROLE` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_USER_ID` int NOT NULL,
  `UM_ROLE_ID` int NOT NULL,
  `UM_TENANT_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`UM_ID`,`UM_TENANT_ID`),
  UNIQUE KEY `UM_USER_ID` (`UM_USER_ID`,`UM_ROLE_ID`,`UM_TENANT_ID`),
  KEY `UM_USER_ID_2` (`UM_USER_ID`,`UM_TENANT_ID`),
  KEY `UM_ROLE_ID` (`UM_ROLE_ID`,`UM_TENANT_ID`),
  CONSTRAINT `um_user_role_ibfk_1` FOREIGN KEY (`UM_USER_ID`, `UM_TENANT_ID`) REFERENCES `UM_USER` (`UM_ID`, `UM_TENANT_ID`) ON DELETE CASCADE,
  CONSTRAINT `um_user_role_ibfk_2` FOREIGN KEY (`UM_ROLE_ID`, `UM_TENANT_ID`) REFERENCES `UM_ROLE` (`UM_ID`, `UM_TENANT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_UUID_DOMAIN_MAPPER`
--

DROP TABLE IF EXISTS `UM_UUID_DOMAIN_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_UUID_DOMAIN_MAPPER` (
  `UM_ID` int NOT NULL AUTO_INCREMENT,
  `UM_USER_ID` varchar(255) NOT NULL,
  `UM_DOMAIN_ID` int NOT NULL,
  `UM_TENANT_ID` int DEFAULT '0',
  PRIMARY KEY (`UM_ID`),
  UNIQUE KEY `UM_USER_ID` (`UM_USER_ID`),
  KEY `UM_DOMAIN_ID` (`UM_DOMAIN_ID`,`UM_TENANT_ID`),
  KEY `UUID_DM_UID_TID` (`UM_USER_ID`,`UM_TENANT_ID`),
  CONSTRAINT `um_uuid_domain_mapper_ibfk_1` FOREIGN KEY (`UM_DOMAIN_ID`, `UM_TENANT_ID`) REFERENCES `UM_DOMAIN` (`UM_DOMAIN_ID`, `UM_TENANT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WF_COORDINATOR`
--

DROP TABLE IF EXISTS `WF_COORDINATOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WF_COORDINATOR` (
  `ID` varchar(45) NOT NULL,
  `WF_NAME` varchar(255) DEFAULT NULL,
  `TENANT_ID` int DEFAULT '-1234',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WF_REQUEST`
--

DROP TABLE IF EXISTS `WF_REQUEST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WF_REQUEST` (
  `UUID` varchar(45) NOT NULL,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  `TENANT_ID` int DEFAULT '-1234',
  `OPERATION_TYPE` varchar(255) DEFAULT NULL,
  `CREATED_AT` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_AT` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `STATUS` varchar(30) DEFAULT NULL,
  `REQUEST` blob,
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WF_REQUEST_ENTITY_RELATIONSHIP`
--

DROP TABLE IF EXISTS `WF_REQUEST_ENTITY_RELATIONSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WF_REQUEST_ENTITY_RELATIONSHIP` (
  `REQUEST_ID` varchar(45) NOT NULL,
  `ENTITY_NAME` varchar(255) NOT NULL,
  `ENTITY_TYPE` varchar(50) NOT NULL,
  `TENANT_ID` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`REQUEST_ID`,`ENTITY_NAME`,`ENTITY_TYPE`,`TENANT_ID`),
  CONSTRAINT `wf_request_entity_relationship_ibfk_1` FOREIGN KEY (`REQUEST_ID`) REFERENCES `WF_REQUEST` (`UUID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WF_WORKFLOW`
--

DROP TABLE IF EXISTS `WF_WORKFLOW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WF_WORKFLOW` (
  `ID` varchar(45) NOT NULL,
  `WF_NAME` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(1024) DEFAULT NULL,
  `TEMPLATE_ID` varchar(45) DEFAULT NULL,
  `IMPL_ID` varchar(45) DEFAULT NULL,
  `TENANT_ID` int DEFAULT '-1234',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WF_WORKFLOW_ASSOCIATION`
--

DROP TABLE IF EXISTS `WF_WORKFLOW_ASSOCIATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WF_WORKFLOW_ASSOCIATION` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ASSOC_NAME` varchar(45) DEFAULT NULL,
  `EVENT_ID` varchar(45) DEFAULT NULL,
  `ASSOC_CONDITION` varchar(1024) DEFAULT NULL,
  `WORKFLOW_ID` varchar(45) DEFAULT NULL,
  `IS_ENABLED` tinyint(1) DEFAULT '0',
  `TENANT_ID` int DEFAULT '-1234',
  PRIMARY KEY (`ID`),
  KEY `WORKFLOW_ID` (`WORKFLOW_ID`),
  CONSTRAINT `wf_workflow_association_ibfk_1` FOREIGN KEY (`WORKFLOW_ID`) REFERENCES `WF_WORKFLOW` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'shared_db'
--

--
-- Dumping routines for database 'shared_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-19 16:35:03
