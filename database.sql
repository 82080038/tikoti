-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: togeli_db
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `achievements`
--

DROP TABLE IF EXISTS `achievements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `achievements` (
  `achievement_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `xp_reward` int(11) DEFAULT NULL,
  `badge_url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`achievement_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `achievements`
--

LOCK TABLES `achievements` WRITE;
/*!40000 ALTER TABLE `achievements` DISABLE KEYS */;
INSERT INTO `achievements` VALUES (1,'FIRST_BET','First Bet','Place your first bet','trophy',100,NULL,1,'2026-04-17 05:16:46'),(2,'WINNER_10','Winner 10','Win 10 bets','medal',500,NULL,1,'2026-04-17 05:16:46'),(3,'WINNER_100','Winner 100','Win 100 bets','star',2000,NULL,1,'2026-04-17 05:16:46'),(4,'HIGH_ROLLER','High Roller','Bet more than 1M in total','crown',1000,NULL,1,'2026-04-17 05:16:46'),(5,'LOYAL_MEMBER','Loyal Member','Active for 30 days','heart',300,NULL,1,'2026-04-17 05:16:46');
/*!40000 ALTER TABLE `achievements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_recommendations`
--

DROP TABLE IF EXISTS `ai_recommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_recommendations` (
  `recommendation_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `recommendation_type_id` int(11) NOT NULL,
  `recommended_item` varchar(100) NOT NULL,
  `confidence_score` decimal(5,2) DEFAULT NULL,
  `is_shown` tinyint(1) DEFAULT 0,
  `is_accepted` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`recommendation_id`),
  KEY `idx_ai_recommendations_user_id` (`user_id`),
  KEY `idx_ai_recommendations_type` (`recommendation_type_id`),
  CONSTRAINT `ai_recommendations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `ai_recommendations_ibfk_2` FOREIGN KEY (`recommendation_type_id`) REFERENCES `recommendation_types` (`recommendation_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_recommendations`
--

LOCK TABLES `ai_recommendations` WRITE;
/*!40000 ALTER TABLE `ai_recommendations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_recommendations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logs` (
  `audit_log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `entity_type` varchar(50) DEFAULT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`audit_log_id`),
  KEY `idx_audit_logs_user_id` (`user_id`),
  KEY `idx_audit_logs_action` (`action`),
  KEY `idx_audit_logs_entity` (`entity_type`,`entity_id`),
  KEY `idx_audit_logs_created_at` (`created_at`),
  CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bet_history`
--

DROP TABLE IF EXISTS `bet_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bet_history` (
  `bet_history_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bet_id` bigint(20) NOT NULL,
  `old_status` enum('pending','won','lost','cancelled','refunded') DEFAULT NULL,
  `new_status` enum('pending','won','lost','cancelled','refunded') DEFAULT NULL,
  `old_amount` decimal(20,2) DEFAULT NULL,
  `new_amount` decimal(20,2) DEFAULT NULL,
  `changed_by` bigint(20) DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `change_reason` text DEFAULT NULL,
  PRIMARY KEY (`bet_history_id`),
  KEY `changed_by` (`changed_by`),
  KEY `idx_bet_history_bet_id` (`bet_id`),
  KEY `idx_bet_history_changed_at` (`changed_at`),
  CONSTRAINT `bet_history_ibfk_1` FOREIGN KEY (`bet_id`) REFERENCES `bets` (`bet_id`) ON DELETE CASCADE,
  CONSTRAINT `bet_history_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bet_history`
--

LOCK TABLES `bet_history` WRITE;
/*!40000 ALTER TABLE `bet_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `bet_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bets`
--

DROP TABLE IF EXISTS `bets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bets` (
  `bet_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `market_id` int(11) NOT NULL,
  `game_type_id` int(11) NOT NULL,
  `bet_number` varchar(20) NOT NULL,
  `amount` decimal(20,2) NOT NULL,
  `potential_payout` decimal(20,2) DEFAULT NULL,
  `discount_amount` decimal(20,2) DEFAULT 0.00,
  `net_amount` decimal(20,2) DEFAULT NULL,
  `status` enum('pending','won','lost','cancelled','refunded') DEFAULT 'pending',
  `result_id` bigint(20) DEFAULT NULL,
  `payout_amount` decimal(20,2) DEFAULT NULL,
  `placed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `result_time` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`bet_id`),
  KEY `idx_bets_user_id` (`user_id`),
  KEY `idx_bets_market_id` (`market_id`),
  KEY `idx_bets_game_type_id` (`game_type_id`),
  KEY `idx_bets_status` (`status`),
  KEY `idx_bets_placed_at` (`placed_at`),
  KEY `idx_bets_result_id` (`result_id`),
  KEY `idx_bets_bet_number` (`bet_number`),
  CONSTRAINT `bets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `bets_ibfk_2` FOREIGN KEY (`market_id`) REFERENCES `markets` (`market_id`),
  CONSTRAINT `bets_ibfk_3` FOREIGN KEY (`game_type_id`) REFERENCES `game_types` (`game_type_id`),
  CONSTRAINT `bets_ibfk_4` FOREIGN KEY (`result_id`) REFERENCES `market_results` (`result_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bets`
--

LOCK TABLES `bets` WRITE;
/*!40000 ALTER TABLE `bets` DISABLE KEYS */;
/*!40000 ALTER TABLE `bets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `betting_group_members`
--

DROP TABLE IF EXISTS `betting_group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `betting_group_members` (
  `membership_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `role` varchar(20) DEFAULT 'member' COMMENT 'admin, member',
  `contribution_amount` decimal(20,2) DEFAULT 0.00,
  `commission_share_percentage` decimal(5,2) DEFAULT 0.00,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`membership_id`),
  UNIQUE KEY `unique_group_member` (`group_id`,`user_id`,`is_active`),
  KEY `idx_group_members_group_id` (`group_id`),
  KEY `idx_group_members_user_id` (`user_id`),
  CONSTRAINT `betting_group_members_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `betting_groups` (`group_id`) ON DELETE CASCADE,
  CONSTRAINT `betting_group_members_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `betting_group_members`
--

LOCK TABLES `betting_group_members` WRITE;
/*!40000 ALTER TABLE `betting_group_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `betting_group_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `betting_groups`
--

DROP TABLE IF EXISTS `betting_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `betting_groups` (
  `group_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) NOT NULL,
  `group_code` varchar(20) NOT NULL,
  `creator_user_id` bigint(20) NOT NULL,
  `description` text DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT 1,
  `total_members` int(11) DEFAULT 1,
  `total_wallet_balance` decimal(20,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `group_code` (`group_code`),
  KEY `idx_betting_groups_creator` (`creator_user_id`),
  KEY `idx_betting_groups_code` (`group_code`),
  CONSTRAINT `betting_groups_ibfk_1` FOREIGN KEY (`creator_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `betting_groups`
--

LOCK TABLES `betting_groups` WRITE;
/*!40000 ALTER TABLE `betting_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `betting_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biometric_data`
--

DROP TABLE IF EXISTS `biometric_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biometric_data` (
  `biometric_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `biometric_type_id` int(11) NOT NULL,
  `biometric_template` text NOT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_used_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`biometric_id`),
  KEY `biometric_type_id` (`biometric_type_id`),
  KEY `idx_biometric_data_user_id` (`user_id`),
  CONSTRAINT `biometric_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `biometric_data_ibfk_2` FOREIGN KEY (`biometric_type_id`) REFERENCES `biometric_types` (`biometric_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biometric_data`
--

LOCK TABLES `biometric_data` WRITE;
/*!40000 ALTER TABLE `biometric_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `biometric_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biometric_types`
--

DROP TABLE IF EXISTS `biometric_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biometric_types` (
  `biometric_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`biometric_type_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biometric_types`
--

LOCK TABLES `biometric_types` WRITE;
/*!40000 ALTER TABLE `biometric_types` DISABLE KEYS */;
INSERT INTO `biometric_types` VALUES (1,'fingerprint','Fingerprint','Fingerprint biometric authentication',1),(2,'face_id','Face ID','Facial recognition authentication',1),(3,'iris','Iris Scan','Iris scan authentication',1);
/*!40000 ALTER TABLE `biometric_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blockchain_verifications`
--

DROP TABLE IF EXISTS `blockchain_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blockchain_verifications` (
  `verification_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(50) NOT NULL COMMENT 'result, transaction, bet',
  `entity_id` bigint(20) NOT NULL,
  `block_height` bigint(20) DEFAULT NULL,
  `block_hash` varchar(255) DEFAULT NULL,
  `tx_hash` varchar(255) DEFAULT NULL,
  `merkle_root` varchar(255) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `verification_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`verification_data`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`verification_id`),
  KEY `idx_blockchain_verifications_entity` (`entity_type`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blockchain_verifications`
--

LOCK TABLES `blockchain_verifications` WRITE;
/*!40000 ALTER TABLE `blockchain_verifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `blockchain_verifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_messages`
--

DROP TABLE IF EXISTS `chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_messages` (
  `message_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `session_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `message` text NOT NULL,
  `message_type` varchar(20) DEFAULT 'text' COMMENT 'text, system, announcement',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`message_id`),
  KEY `idx_chat_messages_session_id` (`session_id`),
  KEY `idx_chat_messages_user_id` (`user_id`),
  KEY `idx_chat_messages_created_at` (`created_at`),
  CONSTRAINT `chat_messages_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `live_streaming_sessions` (`session_id`) ON DELETE SET NULL,
  CONSTRAINT `chat_messages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_messages`
--

LOCK TABLES `chat_messages` WRITE;
/*!40000 ALTER TABLE `chat_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) NOT NULL COMMENT 'ISO 3166-1 alpha-2',
  `name` varchar(100) NOT NULL,
  `dialing_code` varchar(5) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`country_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'ID','Indonesia','+62',1),(2,'SG','Singapore','+65',1),(3,'HK','Hong Kong','+852',1),(4,'AU','Australia','+61',1),(5,'MY','Malaysia','+60',1),(6,'TH','Thailand','+66',1),(7,'VN','Vietnam','+84',1),(8,'CN','China','+86',1),(9,'TW','Taiwan','+886',1),(10,'JP','Japan','+81',1);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crypto_transactions`
--

DROP TABLE IF EXISTS `crypto_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crypto_transactions` (
  `crypto_transaction_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `transaction_type` enum('deposit','withdrawal','bet','payout','refund','commission','bonus','adjustment') NOT NULL,
  `cryptocurrency_id` int(11) NOT NULL,
  `amount` decimal(20,8) NOT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `tx_hash` varchar(255) DEFAULT NULL,
  `confirmations` int(11) DEFAULT 0,
  `status` varchar(20) DEFAULT 'pending' COMMENT 'pending, confirmed, failed',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `confirmed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`crypto_transaction_id`),
  KEY `cryptocurrency_id` (`cryptocurrency_id`),
  KEY `idx_crypto_transactions_user_id` (`user_id`),
  KEY `idx_crypto_transactions_tx_hash` (`tx_hash`),
  CONSTRAINT `crypto_transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `crypto_transactions_ibfk_2` FOREIGN KEY (`cryptocurrency_id`) REFERENCES `cryptocurrencies` (`cryptocurrency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crypto_transactions`
--

LOCK TABLES `crypto_transactions` WRITE;
/*!40000 ALTER TABLE `crypto_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `crypto_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cryptocurrencies`
--

DROP TABLE IF EXISTS `cryptocurrencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cryptocurrencies` (
  `cryptocurrency_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `symbol` varchar(10) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`cryptocurrency_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cryptocurrencies`
--

LOCK TABLES `cryptocurrencies` WRITE;
/*!40000 ALTER TABLE `cryptocurrencies` DISABLE KEYS */;
INSERT INTO `cryptocurrencies` VALUES (1,'BTC','Bitcoin','₿',1),(2,'ETH','Ethereum','Ξ',1),(3,'USDT','Tether','₮',1),(4,'USDC','USD Coin','$',1),(5,'BNB','Binance Coin','₮',1),(6,'SOL','Solana','◎',1),(7,'XRP','Ripple','X',1),(8,'ADA','Cardano','₳',1);
/*!40000 ALTER TABLE `cryptocurrencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `currency_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `symbol` varchar(10) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`currency_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (1,'IDR','Indonesian Rupiah','Rp',1),(2,'SGD','Singapore Dollar','S$',1),(3,'HKD','Hong Kong Dollar','HK$',1),(4,'AUD','Australian Dollar','A$',1),(5,'MYR','Malaysian Ringgit','RM',1),(6,'THB','Thai Baht','฿',1),(7,'VND','Vietnamese Dong','₫',1),(8,'CNY','Chinese Yuan','¥',1),(9,'TWD','Taiwan Dollar','NT$',1),(10,'JPY','Japanese Yen','¥',1),(11,'USD','US Dollar','$',1),(12,'EUR','Euro','€',1),(13,'BTC','Bitcoin','₿',1),(14,'ETH','Ethereum','Ξ',1),(15,'USDT','Tether','₮',1);
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_missions`
--

DROP TABLE IF EXISTS `daily_missions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_missions` (
  `mission_id` int(11) NOT NULL AUTO_INCREMENT,
  `mission_type` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `xp_reward` int(11) DEFAULT NULL,
  `bonus_reward` decimal(20,2) DEFAULT NULL,
  `target_value` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`mission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_missions`
--

LOCK TABLES `daily_missions` WRITE;
/*!40000 ALTER TABLE `daily_missions` DISABLE KEYS */;
/*!40000 ALTER TABLE `daily_missions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_types`
--

DROP TABLE IF EXISTS `document_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_types` (
  `document_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`document_type_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_types`
--

LOCK TABLES `document_types` WRITE;
/*!40000 ALTER TABLE `document_types` DISABLE KEYS */;
INSERT INTO `document_types` VALUES (1,'id_card','ID Card','National ID card',1),(2,'passport','Passport','International passport',1),(3,'proof_of_address','Proof of Address','Utility bill or bank statement',1),(4,'selfie','Selfie','Selfie with ID card',1);
/*!40000 ALTER TABLE `document_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_types`
--

DROP TABLE IF EXISTS `game_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_types` (
  `game_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `payout_multiplier` decimal(10,2) DEFAULT NULL,
  `odds` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`game_type_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_types`
--

LOCK TABLES `game_types` WRITE;
/*!40000 ALTER TABLE `game_types` DISABLE KEYS */;
INSERT INTO `game_types` VALUES (1,'2D','Togel 2D','Menebak 2 angka terakhir (Kepala, Ekor)',70.00,'1:100',1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(2,'3D','Togel 3D','Menebak 3 angka terakhir (Kop, Kepala, Ekor)',400.00,NULL,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(3,'4D','Togel 4D','Menebak seluruh 4 angka',3000.00,'1:10000',1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(4,'COLOK_BEBAS','Colok Bebas','Menebak 1 angka di posisi mana saja',NULL,NULL,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(5,'COLOK_JITU','Colok Jitu','Menebak 1 angka dengan posisi tepat',NULL,NULL,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(6,'COLOK_MACAU','Colok Macau','Menebak 2 angka di posisi mana saja',NULL,NULL,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(7,'COLOK_NAGA','Colok Naga','Menebak 3 angka di posisi mana saja',NULL,NULL,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(8,'BESAR_KECIL','Besar/Kecil','Menebab angka 2D besar atau kecil',NULL,NULL,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(9,'GANJIL_GENAP','Ganjil/Genap','Menebak angka terakhir ganjil atau genap',NULL,NULL,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(10,'TENGAH_TEPI','Tengah Tepi','Menebab 2 angka tengah atau tepi',NULL,NULL,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(11,'DASAR','Dasar','Menebab besar/kecil dan genap/ganjil',NULL,NULL,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(12,'SILANG_HOMO','Silang Homo','Menebab silang atau homo',NULL,NULL,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(13,'KEMBANG_KEMPIS','Kembang Kempis','Menebab kembang, kempis, atau kembar',NULL,NULL,1,'2026-04-17 05:16:46','2026-04-17 05:16:46');
/*!40000 ALTER TABLE `game_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hardware_keys`
--

DROP TABLE IF EXISTS `hardware_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hardware_keys` (
  `key_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `key_name` varchar(100) DEFAULT NULL,
  `credential_id` varchar(255) NOT NULL,
  `public_key` text NOT NULL,
  `counter` bigint(20) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_used_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `credential_id` (`credential_id`),
  KEY `idx_hardware_keys_user_id` (`user_id`),
  CONSTRAINT `hardware_keys_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hardware_keys`
--

LOCK TABLES `hardware_keys` WRITE;
/*!40000 ALTER TABLE `hardware_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `hardware_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kyc_documents`
--

DROP TABLE IF EXISTS `kyc_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kyc_documents` (
  `kyc_document_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `document_type_id` int(11) NOT NULL,
  `document_number` varchar(100) DEFAULT NULL,
  `document_file_url` varchar(500) DEFAULT NULL,
  `document_file_hash` varchar(255) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `status` enum('not_submitted','pending','approved','rejected','expired') DEFAULT 'pending',
  `verified_by` bigint(20) DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`kyc_document_id`),
  KEY `document_type_id` (`document_type_id`),
  KEY `verified_by` (`verified_by`),
  KEY `idx_kyc_documents_user_id` (`user_id`),
  KEY `idx_kyc_documents_status` (`status`),
  CONSTRAINT `kyc_documents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `kyc_documents_ibfk_2` FOREIGN KEY (`document_type_id`) REFERENCES `document_types` (`document_type_id`),
  CONSTRAINT `kyc_documents_ibfk_3` FOREIGN KEY (`verified_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kyc_documents`
--

LOCK TABLES `kyc_documents` WRITE;
/*!40000 ALTER TABLE `kyc_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `kyc_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `language_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `native_name` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`language_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'id','Indonesian','Bahasa Indonesia',1),(2,'en','English','English',1),(3,'zh','Chinese','中文',1),(4,'ms','Malay','Bahasa Melayu',1),(5,'th','Thai','ไทย',1),(6,'vn','Vietnamese','Tiếng Việt',1);
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaderboard_entries`
--

DROP TABLE IF EXISTS `leaderboard_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leaderboard_entries` (
  `entry_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `leaderboard_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `rank_position` int(11) DEFAULT NULL,
  `score` decimal(20,2) DEFAULT NULL,
  `total_bets` int(11) DEFAULT NULL,
  `total_wins` int(11) DEFAULT NULL,
  `total_profit_loss` decimal(20,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`entry_id`),
  UNIQUE KEY `unique_leaderboard_entry` (`leaderboard_id`,`user_id`),
  KEY `user_id` (`user_id`),
  KEY `idx_leaderboard_entries_leaderboard` (`leaderboard_id`),
  KEY `idx_leaderboard_entries_rank` (`rank_position`),
  CONSTRAINT `leaderboard_entries_ibfk_1` FOREIGN KEY (`leaderboard_id`) REFERENCES `leaderboards` (`leaderboard_id`) ON DELETE CASCADE,
  CONSTRAINT `leaderboard_entries_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaderboard_entries`
--

LOCK TABLES `leaderboard_entries` WRITE;
/*!40000 ALTER TABLE `leaderboard_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `leaderboard_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaderboards`
--

DROP TABLE IF EXISTS `leaderboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leaderboards` (
  `leaderboard_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `period` varchar(20) NOT NULL COMMENT 'daily, weekly, monthly, all_time',
  `period_start_date` date DEFAULT NULL,
  `period_end_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`leaderboard_id`),
  KEY `idx_leaderboards_period` (`period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaderboards`
--

LOCK TABLES `leaderboards` WRITE;
/*!40000 ALTER TABLE `leaderboards` DISABLE KEYS */;
/*!40000 ALTER TABLE `leaderboards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `limit_types`
--

DROP TABLE IF EXISTS `limit_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `limit_types` (
  `limit_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`limit_type_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `limit_types`
--

LOCK TABLES `limit_types` WRITE;
/*!40000 ALTER TABLE `limit_types` DISABLE KEYS */;
INSERT INTO `limit_types` VALUES (1,'daily','Daily Limit','Daily betting or spending limit',1),(2,'weekly','Weekly Limit','Weekly betting or spending limit',1),(3,'monthly','Monthly Limit','Monthly betting or spending limit',1),(4,'session','Session Limit','Per session time or betting limit',1);
/*!40000 ALTER TABLE `limit_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `live_streaming_sessions`
--

DROP TABLE IF EXISTS `live_streaming_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_streaming_sessions` (
  `session_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `market_id` int(11) NOT NULL,
  `stream_url` varchar(500) DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_time` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `viewer_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`session_id`),
  KEY `market_id` (`market_id`),
  CONSTRAINT `live_streaming_sessions_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `markets` (`market_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live_streaming_sessions`
--

LOCK TABLES `live_streaming_sessions` WRITE;
/*!40000 ALTER TABLE `live_streaming_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `live_streaming_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loyalty_tiers`
--

DROP TABLE IF EXISTS `loyalty_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_tiers` (
  `tier_id` int(11) NOT NULL AUTO_INCREMENT,
  `subscription_tier_id` int(11) NOT NULL,
  `min_xp_required` bigint(20) NOT NULL,
  `benefits` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`benefits`)),
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`tier_id`),
  KEY `subscription_tier_id` (`subscription_tier_id`),
  CONSTRAINT `loyalty_tiers_ibfk_1` FOREIGN KEY (`subscription_tier_id`) REFERENCES `subscription_tiers` (`subscription_tier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loyalty_tiers`
--

LOCK TABLES `loyalty_tiers` WRITE;
/*!40000 ALTER TABLE `loyalty_tiers` DISABLE KEYS */;
INSERT INTO `loyalty_tiers` VALUES (1,1,0,'{\"commission\": 0.05, \"bonus_multiplier\": 1.0}',1,'2026-04-17 05:16:46'),(2,2,1000,'{\"commission\": 0.07, \"bonus_multiplier\": 1.1}',1,'2026-04-17 05:16:46'),(3,3,5000,'{\"commission\": 0.10, \"bonus_multiplier\": 1.2}',1,'2026-04-17 05:16:46'),(4,4,20000,'{\"commission\": 0.12, \"bonus_multiplier\": 1.3}',1,'2026-04-17 05:16:46'),(5,5,100000,'{\"commission\": 0.15, \"bonus_multiplier\": 1.5}',1,'2026-04-17 05:16:46');
/*!40000 ALTER TABLE `loyalty_tiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_draw_schedules`
--

DROP TABLE IF EXISTS `market_draw_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_draw_schedules` (
  `schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `market_id` int(11) NOT NULL,
  `day_of_week` tinyint(4) NOT NULL COMMENT '0=Sunday, 1=Monday, etc.',
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`schedule_id`),
  UNIQUE KEY `unique_market_day` (`market_id`,`day_of_week`),
  CONSTRAINT `market_draw_schedules_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `markets` (`market_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_draw_schedules`
--

LOCK TABLES `market_draw_schedules` WRITE;
/*!40000 ALTER TABLE `market_draw_schedules` DISABLE KEYS */;
INSERT INTO `market_draw_schedules` VALUES (1,1,1,1),(2,1,3,1),(3,1,4,1),(4,1,6,1),(5,1,7,1),(6,2,0,1),(7,2,1,1),(8,2,2,1),(9,2,3,1),(10,2,4,1),(11,2,5,1),(12,2,6,1),(13,3,0,1),(14,3,1,1),(15,3,2,1),(16,3,3,1),(17,3,4,1),(18,3,5,1),(19,3,6,1);
/*!40000 ALTER TABLE `market_draw_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_result_times`
--

DROP TABLE IF EXISTS `market_result_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_result_times` (
  `result_time_id` int(11) NOT NULL AUTO_INCREMENT,
  `market_id` int(11) NOT NULL,
  `start_time` varchar(10) NOT NULL,
  `end_time` varchar(10) NOT NULL,
  `timezone_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`result_time_id`),
  KEY `market_id` (`market_id`),
  KEY `timezone_id` (`timezone_id`),
  CONSTRAINT `market_result_times_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `markets` (`market_id`) ON DELETE CASCADE,
  CONSTRAINT `market_result_times_ibfk_2` FOREIGN KEY (`timezone_id`) REFERENCES `timezones` (`timezone_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_result_times`
--

LOCK TABLES `market_result_times` WRITE;
/*!40000 ALTER TABLE `market_result_times` DISABLE KEYS */;
INSERT INTO `market_result_times` VALUES (1,1,'17:40','17:50',1,1),(2,2,'23:00','23:10',3,1),(3,3,'13:50','14:00',1,1);
/*!40000 ALTER TABLE `market_result_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_results`
--

DROP TABLE IF EXISTS `market_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_results` (
  `result_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `market_id` int(11) NOT NULL,
  `draw_date` date NOT NULL,
  `result_number` varchar(10) NOT NULL,
  `as_digit` int(11) DEFAULT NULL,
  `kop_digit` int(11) DEFAULT NULL,
  `kepala_digit` int(11) DEFAULT NULL,
  `ekor_digit` int(11) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`result_id`),
  UNIQUE KEY `unique_market_result` (`market_id`,`draw_date`),
  KEY `idx_market_results_market_id` (`market_id`),
  KEY `idx_market_results_draw_date` (`draw_date`),
  KEY `idx_market_results_result_number` (`result_number`),
  CONSTRAINT `market_results_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `markets` (`market_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_results`
--

LOCK TABLES `market_results` WRITE;
/*!40000 ALTER TABLE `market_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `markets`
--

DROP TABLE IF EXISTS `markets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `markets` (
  `market_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `authority_name` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`market_id`),
  UNIQUE KEY `code` (`code`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `markets_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `markets`
--

LOCK TABLES `markets` WRITE;
/*!40000 ALTER TABLE `markets` DISABLE KEYS */;
INSERT INTO `markets` VALUES (1,'SGP','Singapore Pools',2,'Singapore Pools (Private) Limited',1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(2,'HK','Hong Kong Pools',3,'Hong Kong Jockey Club',1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(3,'SDY','Sydney Pools',4,'New South Wales',1,'2026-04-17 05:16:46','2026-04-17 05:16:46');
/*!40000 ALTER TABLE `markets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_preferences`
--

DROP TABLE IF EXISTS `notification_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_preferences` (
  `preference_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `email_bets` tinyint(1) DEFAULT 1,
  `email_results` tinyint(1) DEFAULT 1,
  `email_promotions` tinyint(1) DEFAULT 0,
  `sms_bets` tinyint(1) DEFAULT 0,
  `sms_results` tinyint(1) DEFAULT 0,
  `sms_alerts` tinyint(1) DEFAULT 1,
  `push_bets` tinyint(1) DEFAULT 1,
  `push_results` tinyint(1) DEFAULT 1,
  `push_promotions` tinyint(1) DEFAULT 0,
  `in_app_alerts` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`preference_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `notification_preferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_preferences`
--

LOCK TABLES `notification_preferences` WRITE;
/*!40000 ALTER TABLE `notification_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_method_types`
--

DROP TABLE IF EXISTS `payment_method_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_method_types` (
  `payment_method_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`payment_method_type_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method_types`
--

LOCK TABLES `payment_method_types` WRITE;
/*!40000 ALTER TABLE `payment_method_types` DISABLE KEYS */;
INSERT INTO `payment_method_types` VALUES (1,'traditional','Traditional','Bank-based payment methods',1),(2,'digital_wallet','Digital Wallet','E-wallet and mobile payment services',1),(3,'cryptocurrency','Cryptocurrency','Blockchain-based payment methods',1);
/*!40000 ALTER TABLE `payment_method_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_methods` (
  `payment_method_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `payment_method_type_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`payment_method_id`),
  UNIQUE KEY `code` (`code`),
  KEY `payment_method_type_id` (`payment_method_type_id`),
  CONSTRAINT `payment_methods_ibfk_1` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`payment_method_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_methods`
--

LOCK TABLES `payment_methods` WRITE;
/*!40000 ALTER TABLE `payment_methods` DISABLE KEYS */;
INSERT INTO `payment_methods` VALUES (1,'CREDIT_CARD','Credit Card',1,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(2,'DEBIT_CARD','Debit Card',1,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(3,'BANK_TRANSFER','Bank Transfer',1,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(4,'PAYPAL','PayPal',2,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(5,'SKRILL','Skrill',2,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(6,'NETELLER','Neteller',2,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(7,'OVO','OVO',2,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(8,'GOPAY','GoPay',2,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(9,'DANA','Dana',2,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(10,'BITCOIN','Bitcoin',3,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(11,'ETHEREUM','Ethereum',3,1,'2026-04-17 05:16:46','2026-04-17 05:16:46'),(12,'USDT','USDT',3,1,'2026-04-17 05:16:46','2026-04-17 05:16:46');
/*!40000 ALTER TABLE `payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendation_types`
--

DROP TABLE IF EXISTS `recommendation_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendation_types` (
  `recommendation_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`recommendation_type_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendation_types`
--

LOCK TABLES `recommendation_types` WRITE;
/*!40000 ALTER TABLE `recommendation_types` DISABLE KEYS */;
INSERT INTO `recommendation_types` VALUES (1,'market','Market','Market recommendations based on user preferences',1),(2,'game_type','Game Type','Game type recommendations based on user history',1),(3,'bonus','Bonus','Bonus and promotion recommendations',1);
/*!40000 ALTER TABLE `recommendation_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responsible_gambling_limits`
--

DROP TABLE IF EXISTS `responsible_gambling_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `responsible_gambling_limits` (
  `limit_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `limit_type_id` int(11) NOT NULL,
  `limit_amount` decimal(20,2) DEFAULT NULL,
  `limit_time_minutes` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `set_by` varchar(50) DEFAULT 'user' COMMENT 'user, system, admin',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`limit_id`),
  UNIQUE KEY `unique_limit` (`user_id`,`limit_type_id`,`is_active`),
  KEY `limit_type_id` (`limit_type_id`),
  KEY `idx_responsible_limits_user_id` (`user_id`),
  CONSTRAINT `responsible_gambling_limits_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `responsible_gambling_limits_ibfk_2` FOREIGN KEY (`limit_type_id`) REFERENCES `limit_types` (`limit_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsible_gambling_limits`
--

LOCK TABLES `responsible_gambling_limits` WRITE;
/*!40000 ALTER TABLE `responsible_gambling_limits` DISABLE KEYS */;
/*!40000 ALTER TABLE `responsible_gambling_limits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `risk_assessments`
--

DROP TABLE IF EXISTS `risk_assessments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risk_assessments` (
  `assessment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `risk_level_id` int(11) NOT NULL,
  `risk_score` decimal(5,2) DEFAULT NULL,
  `betting_frequency` int(11) DEFAULT NULL,
  `amount_trend` decimal(10,2) DEFAULT NULL,
  `loss_ratio` decimal(5,2) DEFAULT NULL,
  `time_spent_minutes` int(11) DEFAULT NULL,
  `chasing_losses` tinyint(1) DEFAULT NULL,
  `assessment_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`assessment_data`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`assessment_id`),
  KEY `idx_risk_assessments_user_id` (`user_id`),
  KEY `idx_risk_assessments_risk_level` (`risk_level_id`),
  CONSTRAINT `risk_assessments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `risk_assessments_ibfk_2` FOREIGN KEY (`risk_level_id`) REFERENCES `risk_levels` (`risk_level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `risk_assessments`
--

LOCK TABLES `risk_assessments` WRITE;
/*!40000 ALTER TABLE `risk_assessments` DISABLE KEYS */;
/*!40000 ALTER TABLE `risk_assessments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `risk_levels`
--

DROP TABLE IF EXISTS `risk_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risk_levels` (
  `risk_level_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `min_score` decimal(5,2) DEFAULT NULL,
  `max_score` decimal(5,2) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`risk_level_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `risk_levels`
--

LOCK TABLES `risk_levels` WRITE;
/*!40000 ALTER TABLE `risk_levels` DISABLE KEYS */;
INSERT INTO `risk_levels` VALUES (1,'low','Low Risk','Low risk level - safe gambling behavior',0.00,30.00,1),(2,'medium','Medium Risk','Medium risk level - moderate gambling behavior',31.00,60.00,1),(3,'high','High Risk','High risk level - concerning gambling behavior',61.00,85.00,1),(4,'critical','Critical Risk','Critical risk level - dangerous gambling behavior',86.00,100.00,1);
/*!40000 ALTER TABLE `risk_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_plans`
--

DROP TABLE IF EXISTS `subscription_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_plans` (
  `plan_id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_name` varchar(100) NOT NULL,
  `subscription_tier_id` int(11) NOT NULL,
  `monthly_price` decimal(20,2) DEFAULT NULL,
  `yearly_price` decimal(20,2) DEFAULT NULL,
  `benefits` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`benefits`)),
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_plans`
--

LOCK TABLES `subscription_plans` WRITE;
/*!40000 ALTER TABLE `subscription_plans` DISABLE KEYS */;
INSERT INTO `subscription_plans` VALUES (1,'Basic',1,0.00,0.00,'{\"features\": [\"basic_betting\", \"email_support\"]}',1,'2026-04-17 05:16:46'),(2,'Silver',2,50000.00,500000.00,'{\"features\": [\"basic_betting\", \"email_support\", \"priority_support\"]}',1,'2026-04-17 05:16:46'),(3,'Gold',3,100000.00,1000000.00,'{\"features\": [\"basic_betting\", \"email_support\", \"priority_support\", \"exclusive_promotions\"]}',1,'2026-04-17 05:16:46'),(4,'Platinum',4,250000.00,2500000.00,'{\"features\": [\"basic_betting\", \"email_support\", \"priority_support\", \"exclusive_promotions\", \"personal_manager\"]}',1,'2026-04-17 05:16:46'),(5,'Diamond',5,500000.00,5000000.00,'{\"features\": [\"basic_betting\", \"email_support\", \"priority_support\", \"exclusive_promotions\", \"personal_manager\", \"vip_events\"]}',1,'2026-04-17 05:16:46');
/*!40000 ALTER TABLE `subscription_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_tiers`
--

DROP TABLE IF EXISTS `subscription_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_tiers` (
  `subscription_tier_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`subscription_tier_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_tiers`
--

LOCK TABLES `subscription_tiers` WRITE;
/*!40000 ALTER TABLE `subscription_tiers` DISABLE KEYS */;
INSERT INTO `subscription_tiers` VALUES (1,'basic','Basic','Basic subscription tier',1),(2,'silver','Silver','Silver subscription tier',1),(3,'gold','Gold','Gold subscription tier',1),(4,'platinum','Platinum','Platinum subscription tier',1),(5,'diamond','Diamond','Diamond subscription tier',1);
/*!40000 ALTER TABLE `subscription_tiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `syndicate_members`
--

DROP TABLE IF EXISTS `syndicate_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `syndicate_members` (
  `membership_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `syndicate_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `contribution_amount` decimal(20,2) DEFAULT 0.00,
  `commission_percentage` decimal(5,2) DEFAULT 0.00,
  `role` varchar(20) DEFAULT 'member' COMMENT 'leader, member',
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`membership_id`),
  UNIQUE KEY `unique_syndicate_member` (`syndicate_id`,`user_id`,`is_active`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `syndicate_members_ibfk_1` FOREIGN KEY (`syndicate_id`) REFERENCES `syndicates` (`syndicate_id`) ON DELETE CASCADE,
  CONSTRAINT `syndicate_members_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `syndicate_members`
--

LOCK TABLES `syndicate_members` WRITE;
/*!40000 ALTER TABLE `syndicate_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `syndicate_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `syndicates`
--

DROP TABLE IF EXISTS `syndicates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `syndicates` (
  `syndicate_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `syndicate_name` varchar(100) NOT NULL,
  `syndicate_code` varchar(20) NOT NULL,
  `leader_user_id` bigint(20) NOT NULL,
  `description` text DEFAULT NULL,
  `total_members` int(11) DEFAULT 1,
  `shared_wallet_balance` decimal(20,2) DEFAULT 0.00,
  `commission_structure` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`commission_structure`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`syndicate_id`),
  UNIQUE KEY `syndicate_code` (`syndicate_code`),
  KEY `leader_user_id` (`leader_user_id`),
  CONSTRAINT `syndicates_ibfk_1` FOREIGN KEY (`leader_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `syndicates`
--

LOCK TABLES `syndicates` WRITE;
/*!40000 ALTER TABLE `syndicates` DISABLE KEYS */;
/*!40000 ALTER TABLE `syndicates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timezones`
--

DROP TABLE IF EXISTS `timezones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timezones` (
  `timezone_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `offset` varchar(10) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`timezone_id`),
  UNIQUE KEY `name` (`name`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `timezones_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timezones`
--

LOCK TABLES `timezones` WRITE;
/*!40000 ALTER TABLE `timezones` DISABLE KEYS */;
INSERT INTO `timezones` VALUES (1,'Asia/Jakarta','+07:00',1,1),(2,'Asia/Singapore','+08:00',2,1),(3,'Asia/Hong_Kong','+08:00',3,1),(4,'Australia/Sydney','+10:00',4,1),(5,'Asia/Kuala_Lumpur','+08:00',5,1),(6,'Asia/Bangkok','+07:00',6,1),(7,'Asia/Ho_Chi_Minh','+07:00',7,1),(8,'Asia/Shanghai','+08:00',8,1),(9,'Asia/Taipei','+08:00',9,1),(10,'Asia/Tokyo','+09:00',10,1);
/*!40000 ALTER TABLE `timezones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `transaction_type` enum('deposit','withdrawal','bet','payout','refund','commission','bonus','adjustment') NOT NULL,
  `amount` decimal(20,2) NOT NULL,
  `fee` decimal(20,2) DEFAULT 0.00,
  `status` enum('pending','processing','completed','failed','cancelled','reversed') DEFAULT 'pending',
  `payment_method_id` int(11) DEFAULT NULL,
  `reference_id` varchar(100) DEFAULT NULL,
  `external_reference` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `completed_at` timestamp NULL DEFAULT NULL,
  `failed_at` timestamp NULL DEFAULT NULL,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `payment_method_id` (`payment_method_id`),
  KEY `idx_transactions_user_id` (`user_id`),
  KEY `idx_transactions_type` (`transaction_type`),
  KEY `idx_transactions_status` (`status`),
  KEY `idx_transactions_reference_id` (`reference_id`),
  KEY `idx_transactions_created_at` (`created_at`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `translations` (
  `translation_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `page` varchar(100) NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `value` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`translation_id`),
  UNIQUE KEY `unique_translation` (`language_id`,`page`,`key_name`),
  KEY `idx_translations_language` (`language_id`),
  KEY `idx_translations_page` (`page`),
  CONSTRAINT `translations_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_achievements`
--

DROP TABLE IF EXISTS `user_achievements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_achievements` (
  `user_achievement_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `achievement_id` int(11) NOT NULL,
  `unlocked_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `progress` int(11) DEFAULT 0,
  `max_progress` int(11) DEFAULT 100,
  PRIMARY KEY (`user_achievement_id`),
  UNIQUE KEY `unique_user_achievement` (`user_id`,`achievement_id`),
  KEY `achievement_id` (`achievement_id`),
  KEY `idx_user_achievements_user_id` (`user_id`),
  CONSTRAINT `user_achievements_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_achievements_ibfk_2` FOREIGN KEY (`achievement_id`) REFERENCES `achievements` (`achievement_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_achievements`
--

LOCK TABLES `user_achievements` WRITE;
/*!40000 ALTER TABLE `user_achievements` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_achievements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_loyalty`
--

DROP TABLE IF EXISTS `user_loyalty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_loyalty` (
  `user_loyalty_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `loyalty_tier_id` int(11) DEFAULT NULL,
  `tier_progress` int(11) DEFAULT 0,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_loyalty_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `loyalty_tier_id` (`loyalty_tier_id`),
  CONSTRAINT `user_loyalty_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_loyalty_ibfk_2` FOREIGN KEY (`loyalty_tier_id`) REFERENCES `loyalty_tiers` (`tier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_loyalty`
--

LOCK TABLES `user_loyalty` WRITE;
/*!40000 ALTER TABLE `user_loyalty` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_loyalty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_mission_progress`
--

DROP TABLE IF EXISTS `user_mission_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_mission_progress` (
  `progress_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mission_id` int(11) NOT NULL,
  `progress` int(11) DEFAULT 0,
  `is_completed` tinyint(1) DEFAULT 0,
  `completed_at` timestamp NULL DEFAULT NULL,
  `reward_claimed` tinyint(1) DEFAULT 0,
  `claimed_at` timestamp NULL DEFAULT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`progress_id`),
  UNIQUE KEY `unique_user_mission` (`user_id`,`mission_id`,`date`),
  KEY `mission_id` (`mission_id`),
  KEY `idx_user_mission_progress_user_date` (`user_id`,`date`),
  CONSTRAINT `user_mission_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_mission_progress_ibfk_2` FOREIGN KEY (`mission_id`) REFERENCES `daily_missions` (`mission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_mission_progress`
--

LOCK TABLES `user_mission_progress` WRITE;
/*!40000 ALTER TABLE `user_mission_progress` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_mission_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_preferences`
--

DROP TABLE IF EXISTS `user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_preferences` (
  `preference_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `language_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `timezone_id` int(11) DEFAULT NULL,
  `notification_email` tinyint(1) DEFAULT 1,
  `notification_sms` tinyint(1) DEFAULT 0,
  `notification_push` tinyint(1) DEFAULT 1,
  `theme` varchar(20) DEFAULT 'light',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`preference_id`),
  UNIQUE KEY `unique_user_preferences` (`user_id`),
  KEY `language_id` (`language_id`),
  KEY `currency_id` (`currency_id`),
  KEY `timezone_id` (`timezone_id`),
  CONSTRAINT `user_preferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_preferences_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`),
  CONSTRAINT `user_preferences_ibfk_3` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`currency_id`),
  CONSTRAINT `user_preferences_ibfk_4` FOREIGN KEY (`timezone_id`) REFERENCES `timezones` (`timezone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_preferences`
--

LOCK TABLES `user_preferences` WRITE;
/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `role` enum('pemain','agen','pengelola','pemilik') NOT NULL,
  `assigned_by` bigint(20) DEFAULT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`user_role_id`),
  UNIQUE KEY `unique_user_role` (`user_id`,`role`,`is_active`),
  KEY `assigned_by` (`assigned_by`),
  KEY `idx_user_roles_user_id` (`user_id`),
  KEY `idx_user_roles_role` (`role`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_sessions`
--

DROP TABLE IF EXISTS `user_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_sessions` (
  `session_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `token` varchar(500) NOT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `device_name` varchar(100) DEFAULT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_accessed_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`session_id`),
  KEY `idx_user_sessions_user_id` (`user_id`),
  KEY `idx_user_sessions_token` (`token`),
  KEY `idx_user_sessions_is_active` (`is_active`),
  CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_sessions`
--

LOCK TABLES `user_sessions` WRITE;
/*!40000 ALTER TABLE `user_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_subscriptions`
--

DROP TABLE IF EXISTS `user_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_subscriptions` (
  `subscription_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `plan_id` int(11) NOT NULL,
  `start_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_active` tinyint(1) DEFAULT 1,
  `auto_renew` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`subscription_id`),
  KEY `user_id` (`user_id`),
  KEY `plan_id` (`plan_id`),
  CONSTRAINT `user_subscriptions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_subscriptions_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `subscription_plans` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_subscriptions`
--

LOCK TABLES `user_subscriptions` WRITE;
/*!40000 ALTER TABLE `user_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_xp`
--

DROP TABLE IF EXISTS `user_xp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_xp` (
  `xp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `total_xp` bigint(20) DEFAULT 0,
  `current_level` int(11) DEFAULT 1,
  `xp_to_next_level` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`xp_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_xp_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_xp`
--

LOCK TABLES `user_xp` WRITE;
/*!40000 ALTER TABLE `user_xp` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_xp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `status` enum('pending','active','suspended','banned','deleted') DEFAULT 'pending',
  `kyc_status` enum('not_submitted','pending','approved','rejected','expired') DEFAULT 'not_submitted',
  `email_verified` tinyint(1) DEFAULT 0,
  `phone_verified` tinyint(1) DEFAULT 0,
  `two_factor_enabled` tinyint(1) DEFAULT 0,
  `two_factor_secret` varchar(255) DEFAULT NULL,
  `referral_code` varchar(20) DEFAULT NULL,
  `referred_by` bigint(20) DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `last_login_ip` varchar(45) DEFAULT NULL,
  `failed_login_attempts` int(11) DEFAULT 0,
  `locked_until` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `referral_code` (`referral_code`),
  KEY `country_id` (`country_id`),
  KEY `referred_by` (`referred_by`),
  KEY `idx_users_email` (`email`),
  KEY `idx_users_username` (`username`),
  KEY `idx_users_phone` (`phone`),
  KEY `idx_users_status` (`status`),
  KEY `idx_users_kyc_status` (`kyc_status`),
  KEY `idx_users_referral_code` (`referral_code`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`referred_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_active_bets`
--

DROP TABLE IF EXISTS `v_active_bets`;
/*!50001 DROP VIEW IF EXISTS `v_active_bets`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_active_bets` AS SELECT 
 1 AS `bet_id`,
 1 AS `user_id`,
 1 AS `username`,
 1 AS `market_code`,
 1 AS `market_name`,
 1 AS `country_code`,
 1 AS `game_type_code`,
 1 AS `game_type_name`,
 1 AS `bet_number`,
 1 AS `amount`,
 1 AS `potential_payout`,
 1 AS `status`,
 1 AS `placed_at`,
 1 AS `result_number`,
 1 AS `draw_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_betting_statistics`
--

DROP TABLE IF EXISTS `v_betting_statistics`;
/*!50001 DROP VIEW IF EXISTS `v_betting_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_betting_statistics` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `total_bets`,
 1 AS `won_bets`,
 1 AS `lost_bets`,
 1 AS `pending_bets`,
 1 AS `total_bet_amount`,
 1 AS `total_payout`,
 1 AS `net_profit_loss`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_market_results`
--

DROP TABLE IF EXISTS `v_market_results`;
/*!50001 DROP VIEW IF EXISTS `v_market_results`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_market_results` AS SELECT 
 1 AS `result_id`,
 1 AS `market_code`,
 1 AS `market_name`,
 1 AS `country_code`,
 1 AS `draw_date`,
 1 AS `result_number`,
 1 AS `as_digit`,
 1 AS `kop_digit`,
 1 AS `kepala_digit`,
 1 AS `ekor_digit`,
 1 AS `is_verified`,
 1 AS `verified_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_user_transactions`
--

DROP TABLE IF EXISTS `v_user_transactions`;
/*!50001 DROP VIEW IF EXISTS `v_user_transactions`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_user_transactions` AS SELECT 
 1 AS `transaction_id`,
 1 AS `user_id`,
 1 AS `username`,
 1 AS `transaction_type`,
 1 AS `amount`,
 1 AS `fee`,
 1 AS `status`,
 1 AS `payment_method`,
 1 AS `payment_method_name`,
 1 AS `payment_method_type`,
 1 AS `reference_id`,
 1 AS `description`,
 1 AS `created_at`,
 1 AS `completed_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_user_wallet_summary`
--

DROP TABLE IF EXISTS `v_user_wallet_summary`;
/*!50001 DROP VIEW IF EXISTS `v_user_wallet_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_user_wallet_summary` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `email`,
 1 AS `currency_code`,
 1 AS `currency_name`,
 1 AS `currency_symbol`,
 1 AS `balance`,
 1 AS `locked_balance`,
 1 AS `total_balance`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `voice_command_logs`
--

DROP TABLE IF EXISTS `voice_command_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voice_command_logs` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `command_text` text NOT NULL,
  `parsed_action` varchar(100) DEFAULT NULL,
  `parsed_parameters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`parsed_parameters`)),
  `execution_result` varchar(20) DEFAULT NULL COMMENT 'success, failed, partial',
  `confidence_score` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`log_id`),
  KEY `idx_voice_command_logs_user_id` (`user_id`),
  CONSTRAINT `voice_command_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voice_command_logs`
--

LOCK TABLES `voice_command_logs` WRITE;
/*!40000 ALTER TABLE `voice_command_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `voice_command_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet_transactions`
--

DROP TABLE IF EXISTS `wallet_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet_transactions` (
  `wallet_transaction_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `wallet_id` bigint(20) NOT NULL,
  `transaction_id` bigint(20) DEFAULT NULL,
  `transaction_type` enum('deposit','withdrawal','bet','payout','refund','commission','bonus','adjustment') NOT NULL,
  `amount` decimal(20,2) NOT NULL,
  `balance_before` decimal(20,2) NOT NULL,
  `balance_after` decimal(20,2) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`wallet_transaction_id`),
  KEY `idx_wallet_transactions_wallet_id` (`wallet_id`),
  KEY `idx_wallet_transactions_transaction_id` (`transaction_id`),
  KEY `idx_wallet_transactions_created_at` (`created_at`),
  CONSTRAINT `wallet_transactions_ibfk_1` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`wallet_id`) ON DELETE CASCADE,
  CONSTRAINT `wallet_transactions_ibfk_2` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_transactions`
--

LOCK TABLES `wallet_transactions` WRITE;
/*!40000 ALTER TABLE `wallet_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallet_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallets`
--

DROP TABLE IF EXISTS `wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallets` (
  `wallet_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `balance` decimal(20,2) DEFAULT 0.00,
  `locked_balance` decimal(20,2) DEFAULT 0.00,
  `currency_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`wallet_id`),
  UNIQUE KEY `unique_wallet` (`user_id`,`currency_id`),
  KEY `currency_id` (`currency_id`),
  KEY `idx_wallets_user_id` (`user_id`),
  CONSTRAINT `wallets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `wallets_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallets`
--

LOCK TABLES `wallets` WRITE;
/*!40000 ALTER TABLE `wallets` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `v_active_bets`
--

/*!50001 DROP VIEW IF EXISTS `v_active_bets`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_active_bets` AS select `b`.`bet_id` AS `bet_id`,`b`.`user_id` AS `user_id`,`u`.`username` AS `username`,`m`.`code` AS `market_code`,`m`.`name` AS `market_name`,`co`.`code` AS `country_code`,`gt`.`code` AS `game_type_code`,`gt`.`name` AS `game_type_name`,`b`.`bet_number` AS `bet_number`,`b`.`amount` AS `amount`,`b`.`potential_payout` AS `potential_payout`,`b`.`status` AS `status`,`b`.`placed_at` AS `placed_at`,`mr`.`result_number` AS `result_number`,`mr`.`draw_date` AS `draw_date` from (((((`bets` `b` join `users` `u` on(`b`.`user_id` = `u`.`user_id`)) join `markets` `m` on(`b`.`market_id` = `m`.`market_id`)) left join `countries` `co` on(`m`.`country_id` = `co`.`country_id`)) join `game_types` `gt` on(`b`.`game_type_id` = `gt`.`game_type_id`)) left join `market_results` `mr` on(`b`.`result_id` = `mr`.`result_id`)) where `b`.`status` = 'pending' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_betting_statistics`
--

/*!50001 DROP VIEW IF EXISTS `v_betting_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_betting_statistics` AS select `b`.`user_id` AS `user_id`,`u`.`username` AS `username`,count(0) AS `total_bets`,sum(case when `b`.`status` = 'won' then 1 else 0 end) AS `won_bets`,sum(case when `b`.`status` = 'lost' then 1 else 0 end) AS `lost_bets`,sum(case when `b`.`status` = 'pending' then 1 else 0 end) AS `pending_bets`,sum(`b`.`amount`) AS `total_bet_amount`,sum(case when `b`.`status` = 'won' then `b`.`payout_amount` else 0 end) AS `total_payout`,sum(case when `b`.`status` = 'won' then `b`.`payout_amount` - `b`.`amount` else -`b`.`amount` end) AS `net_profit_loss` from (`bets` `b` join `users` `u` on(`b`.`user_id` = `u`.`user_id`)) group by `b`.`user_id`,`u`.`username` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_market_results`
--

/*!50001 DROP VIEW IF EXISTS `v_market_results`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_market_results` AS select `mr`.`result_id` AS `result_id`,`m`.`code` AS `market_code`,`m`.`name` AS `market_name`,`co`.`code` AS `country_code`,`mr`.`draw_date` AS `draw_date`,`mr`.`result_number` AS `result_number`,`mr`.`as_digit` AS `as_digit`,`mr`.`kop_digit` AS `kop_digit`,`mr`.`kepala_digit` AS `kepala_digit`,`mr`.`ekor_digit` AS `ekor_digit`,`mr`.`is_verified` AS `is_verified`,`mr`.`verified_at` AS `verified_at` from ((`market_results` `mr` join `markets` `m` on(`mr`.`market_id` = `m`.`market_id`)) left join `countries` `co` on(`m`.`country_id` = `co`.`country_id`)) order by `mr`.`draw_date` desc,`m`.`code` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_user_transactions`
--

/*!50001 DROP VIEW IF EXISTS `v_user_transactions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_transactions` AS select `t`.`transaction_id` AS `transaction_id`,`t`.`user_id` AS `user_id`,`u`.`username` AS `username`,`t`.`transaction_type` AS `transaction_type`,`t`.`amount` AS `amount`,`t`.`fee` AS `fee`,`t`.`status` AS `status`,`pm`.`code` AS `payment_method`,`pm`.`name` AS `payment_method_name`,`pmt`.`code` AS `payment_method_type`,`t`.`reference_id` AS `reference_id`,`t`.`description` AS `description`,`t`.`created_at` AS `created_at`,`t`.`completed_at` AS `completed_at` from (((`transactions` `t` join `users` `u` on(`t`.`user_id` = `u`.`user_id`)) left join `payment_methods` `pm` on(`t`.`payment_method_id` = `pm`.`payment_method_id`)) left join `payment_method_types` `pmt` on(`pm`.`payment_method_type_id` = `pmt`.`payment_method_type_id`)) order by `t`.`created_at` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_user_wallet_summary`
--

/*!50001 DROP VIEW IF EXISTS `v_user_wallet_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_wallet_summary` AS select `u`.`user_id` AS `user_id`,`u`.`username` AS `username`,`u`.`email` AS `email`,`c`.`code` AS `currency_code`,`c`.`name` AS `currency_name`,`c`.`symbol` AS `currency_symbol`,`w`.`balance` AS `balance`,`w`.`locked_balance` AS `locked_balance`,`w`.`balance` + `w`.`locked_balance` AS `total_balance` from ((`users` `u` left join `wallets` `w` on(`u`.`user_id` = `w`.`user_id` and `w`.`is_active` = 1)) left join `currencies` `c` on(`w`.`currency_id` = `c`.`currency_id`)) where `u`.`status` = 'active' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-17 13:02:47
