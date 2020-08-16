set global sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

CREATE DATABASE IF NOT EXISTS `cashier` ;

USE `cashier` ;

CREATE TABLE `Product` (
  `id` VARCHAR(255),
  `name` TEXT,
  `price` INT,
  PRIMARY KEY (`id`)
);

CREATE TABLE `Customer` (
  `id` VARCHAR(255),
  `name` TEXT,
  PRIMARY KEY (`id`)
);

CREATE TABLE `Transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `time` INT,
  `branch_id` INT,
  `customer_id` VARCHAR(255),
  PRIMARY KEY (`id`),
  FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`id`)
);

CREATE TABLE `FaceImage` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_path` TEXT,
  `camera_id` INT,
  `branch_id` INT,
  `time` DECIMAL(17,6),
  `image_time` DECIMAL(17,6),
  `position_top` INT,
  `position_right` INT,
  `position_bottom` INT,
  `position_left` INT,
  PRIMARY KEY (`id`)
);

CREATE TABLE `TransactionFaceImage` (
  `transaction_id` INT,
  `face_image_id` INT,
  PRIMARY KEY (`transaction_id`),
  FOREIGN KEY (`transaction_id`) REFERENCES `Transaction` (`id`),
  FOREIGN KEY (`face_image_id`) REFERENCES `FaceImage` (`id`)
);

-- Have some problem below
CREATE TABLE `TransactionProduct` (
  `transaction_id` INT,
  `product_id` VARCHAR(255),
  `quantity` INT,
  PRIMARY KEY (`transaction_id`,`product_id`),
  FOREIGN KEY (`transaction_id`) REFERENCES `Transaction` (`id`),
  FOREIGN KEY (`product_id`) REFERENCES `Product` (`id`)
);

CREATE TABLE `Gender` (
  `face_image_id` INT,
  `type` TEXT,
  `confidence` DOUBLE,
  `position_top` INT,
  `position_right` INT,
  `position_bottom` INT,
  `position_left` INT,
  `time` DECIMAL(17,6),
  `added_time` DECIMAL(17,6),
  PRIMARY KEY (`face_image_id`),
  FOREIGN KEY (`face_image_id`) REFERENCES `FaceImage` (`id`)
);

CREATE TABLE `Race` (
  `face_image_id` INT,
  `type` TEXT,
  `confidence` DOUBLE,
  `position_top` INT,
  `position_right` INT,
  `position_bottom` INT,
  `position_left` INT,
  `time` DECIMAL(17,6),
  `added_time` DECIMAL(17,6),
  PRIMARY KEY (`face_image_id`),
  FOREIGN KEY (`face_image_id`) REFERENCES `FaceImage` (`id`)
);

CREATE TABLE `Age` (
  `face_image_id` INT,
  `min_age` INT,
  `max_age` INT,
  `confidence` DOUBLE,
  `position_top` INT,
  `position_right` INT,
  `position_bottom` INT,
  `position_left` INT,
  `time` DECIMAL(17,6),
  `added_time` DECIMAL(17,6),
  PRIMARY KEY (`face_image_id`),
  FOREIGN KEY (`face_image_id`) REFERENCES `FaceImage` (`id`)
);

/* Database for FADE integration */

CREATE DATABASE IF NOT EXISTS `face_recognition` ;

USE `face_recognition` ;

CREATE TABLE `image` (
  `id` varchar(32) NOT NULL,
  `path` varchar(70) NOT NULL,
  `gender_timestamp` bigint(20) DEFAULT NULL,
  `age_timestamp` bigint(20) DEFAULT NULL,
  `emotion_timestamp` bigint(20) DEFAULT NULL,
  `face_recognition_timestamp` bigint(20) DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `age` (
  `id` varchar(32) NOT NULL,
  `image_id` varchar(32) DEFAULT NULL,
  `0_to_10_confidence` float NOT NULL,
  `11_to_20_confidence` float NOT NULL,
  `21_to_30_confidence` float NOT NULL,
  `31_to_40_confidence` float NOT NULL,
  `41_to_50_confidence` float NOT NULL,
  `51_to_60_confidence` float NOT NULL,
  `61_to_70_confidence` float NOT NULL,
  `71_to_100_confidence` float NOT NULL,
  `position_top` int(10) unsigned DEFAULT NULL,
  `position_right` int(10) unsigned DEFAULT NULL,
  `position_bottom` int(10) unsigned DEFAULT NULL,
  `position_left` int(10) unsigned DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_age_image` (`image_id`),
  CONSTRAINT `FK_age_image` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`)
);

CREATE TABLE `emotion` (
  `id` varchar(32) NOT NULL,
  `image_id` varchar(32) DEFAULT NULL,
  `uncertain_confidence` float NOT NULL,
  `angry_confidence` float NOT NULL,
  `disgusted_confidence` float NOT NULL,
  `fearful_confidence` float NOT NULL,
  `happy_confidence` float NOT NULL,
  `neutral_confidence` float NOT NULL,
  `sad_confidence` float NOT NULL,
  `surprised_confidence` float NOT NULL,
  `position_top` int(10) unsigned DEFAULT NULL,
  `position_right` int(10) unsigned DEFAULT NULL,
  `position_bottom` int(10) unsigned DEFAULT NULL,
  `position_left` int(10) unsigned DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_emotion_image` (`image_id`),
  CONSTRAINT `FK_emotion_image` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`)
);

CREATE TABLE `face_recognition` (
  `id` varchar(32) NOT NULL,
  `image_id` varchar(32) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `position_top` int(10) unsigned DEFAULT NULL,
  `position_right` int(10) unsigned DEFAULT NULL,
  `position_bottom` int(10) unsigned DEFAULT NULL,
  `position_left` int(10) unsigned DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_face_recognition_image` (`image_id`),
  CONSTRAINT `FK_face_recognition_image` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`)
);

CREATE TABLE `gender` (
  `id` varchar(32) NOT NULL,
  `image_id` varchar(32) DEFAULT NULL,
  `male_confidence` float NOT NULL,
  `female_confidence` float NOT NULL,
  `position_top` int(10) unsigned DEFAULT NULL,
  `position_right` int(10) unsigned DEFAULT NULL,
  `position_bottom` int(10) unsigned DEFAULT NULL,
  `position_left` int(10) unsigned DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_gender_image` (`image_id`),
  CONSTRAINT `FK_gender_image` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`)
);
