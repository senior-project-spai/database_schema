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
  PRIMARY KEY (`face_image_id`),
  FOREIGN KEY (`face_image_id`) REFERENCES `FaceImage` (`id`)
);