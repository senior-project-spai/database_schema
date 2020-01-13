CREATE TABLE `Product` (
  `id` INT,
  `name` TEXT,
  `price` INT,
  PRIMARY KEY (`id`)
);

CREATE TABLE `Customer` (
  `id` INT,
  `name` TEXT,
  PRIMARY KEY (`id`)
);

CREATE TABLE `Transaction` (
  `id` INT,
  `time` INT,
  `branch_id` INT,
  `customer_id` INT,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`id`)
);

CREATE TABLE `FaceImage` (
  `id` INT,
  `image_path` TEXT,
  `camera_id` INT,
  `branch_id` INT,
  `time` INT,
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
  `product_id` INT,
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
  `time` INT,
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
  `time` INT,
  PRIMARY KEY (`face_image_id`),
  FOREIGN KEY (`face_image_id`) REFERENCES `FaceImage` (`id`)
);
