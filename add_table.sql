CREATE TABLE `ServicesData` (
  `id` INT,
  `gender` TEXT,
  `gender_confident` DOUBLE,
  `race` TEXT,
  `race_confident` DOUBLE,
  `position_top` INT,
  `position_left` INT,
  `position_right` INT,
  `position_bottom` INT,
  PRIMARY KEY (`id`)
);

CREATE TABLE `Product` (
  `id` INT,
  `name` TEXT,
  `price` DECIMAL(10,2),
  `description` LONGBLOB,
  PRIMARY KEY (`id`)
);

CREATE TABLE `Branch` (
  `id` INT,
  `latitude` DOUBLE,
  `longtitude` DOUBLE,
  `detail` LONGBLOB,
  PRIMARY KEY (`id`)
);

CREATE TABLE `Transaction` (
  `id` INT,
  `product_id` INT,
  `quantity` INT,
  PRIMARY KEY (`id`),
  FOREIGN key (`product_id`) REFERENCES `Product` (`id`)
);

CREATE TABLE `Customer` (
  `id` INT,
  `branch_id` INT,
  `camera_id` INT,
  `filepath` TEXT,
  `epoch` INT,
  `time` DATETIME,
  `transaction_id` INT,
  PRIMARY KEY (`id`),
  FOREIGN key (`branch_id`) REFERENCES `Branch` (`id`),
  FOREIGN key (`id`) REFERENCES `ServicesData` (`id`),
  FOREIGN key (`transaction_id`) REFERENCES `Transaction` (`id`)
);