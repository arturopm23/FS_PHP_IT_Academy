-- Drop existing tables if they exist
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `customers`;
DROP TABLE IF EXISTS `address`;
DROP TABLE IF EXISTS `item`;
DROP TABLE IF EXISTS `staff`;
DROP TABLE IF EXISTS `store`;
DROP TABLE IF EXISTS `positions`;


CREATE TABLE IF NOT EXISTS `positions` (
    `position_id` int NOT NULL AUTO_INCREMENT,
    `position_name` varchar(50) NOT NULL,
    PRIMARY KEY (`position_id`)
);

CREATE TABLE IF NOT EXISTS `store` (
    `store_id` int NOT NULL AUTO_INCREMENT,
    `store_address1` varchar(200) NOT NULL,
    `store_address2` varchar(200) NULL,
    `store_city` varchar(50) NOT NULL,
    `store_zipcode` varchar(20) NOT NULL,
    PRIMARY KEY (`store_id`)
);

CREATE TABLE IF NOT EXISTS `customers` (
    `cust_id` int NOT NULL AUTO_INCREMENT,
    `cust_firstname` varchar(50) NOT NULL,
    `cust_lastname` varchar(50) NOT NULL,
    `cust_phone` varchar(15) NOT NULL,
    PRIMARY KEY (`cust_id`)
);


CREATE TABLE IF NOT EXISTS `address` (
    `add_id` int NOT NULL AUTO_INCREMENT,
    `delivery` boolean NOT NULL,
    `delivery_address1` varchar(200) NOT NULL,
    `delivery_address2` varchar(200) NULL,
    `delivery_city` varchar(50) NOT NULL,
    `delivery_zipcode` varchar(20) NOT NULL,
    `delivery_time` datetime NULL,
    PRIMARY KEY (`add_id`)
);

CREATE TABLE IF NOT EXISTS `item` (
    `item_id` int NOT NULL AUTO_INCREMENT,
    `item_name` varchar(50) NOT NULL,
    `item_cat` varchar(50) NOT NULL,
    `item_image` BLOB NULL,
    `item_price` decimal(5,2) NOT NULL,
    PRIMARY KEY (`item_id`)
);

CREATE TABLE IF NOT EXISTS `staff` (
    `staff_id` int NOT NULL AUTO_INCREMENT,
    `staff_firstname` varchar(50) NOT NULL,
    `staff_lastname` varchar(50) NOT NULL,
    `staff_nif` varchar(50) NOT NULL,
    `position_id` int NOT NULL,
    `store_id` int NOT NULL,
    PRIMARY KEY (`staff_id`),
    FOREIGN KEY (`position_id`) REFERENCES `positions` (`position_id`),
    FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`)
);

CREATE TABLE IF NOT EXISTS `orders` (
    `row_id` int NOT NULL AUTO_INCREMENT,
    `order_id` varchar(10) NOT NULL,
    `created_at` datetime NOT NULL,
    `item_id` int NOT NULL,
    `quantity` int NOT NULL,
    `cust_id` int NOT NULL,
    `add_id` int NOT NULL,
    `store_id` int NOT NULL,
    PRIMARY KEY (`row_id`),
    FOREIGN KEY (`cust_id`) REFERENCES `customers` (`cust_id`),
    FOREIGN KEY (`add_id`) REFERENCES `address` (`add_id`),
    FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
    FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`)
);

INSERT INTO `positions` (`position_name`) VALUES ('Delivery'), ('Cashier'), ('Cook');

INSERT INTO `store` (`store_address1`, `store_address2`, `store_city`, `store_zipcode`) 
VALUES ('123 Main St', NULL, 'Anytown', '12345'),
       ('456 Elm St', 'Suite 2', 'Othertown', '67890');

INSERT INTO `customers` (`cust_firstname`, `cust_lastname`, `cust_phone`) 
VALUES ('John', 'Doe', '555-1234'), 
       ('Jane', 'Smith', '555-5678');

INSERT INTO `address` (`delivery`, `delivery_address1`, `delivery_address2`, `delivery_city`, `delivery_zipcode`, `delivery_time`)
VALUES (TRUE, '789 Maple St', NULL, 'Anytown', '12345', '2024-05-01 10:00:00'),
       (FALSE, '321 Oak St', 'Apt 4', 'Othertown', '67890', '2024-05-02 15:00:00');

INSERT INTO `item` (`item_name`, `item_cat`, `item_image`, `item_price`) 
VALUES ('Widget', 'Gadgets', NULL, 19.99), 
       ('Gizmo', 'Gadgets', NULL, 29.99);

INSERT INTO `staff` (`staff_firstname`, `staff_lastname`, `staff_nif`, `position_id`, `store_id`)
VALUES ('Alice', 'Brown', 'AB123456C', 1, 1),
       ('Bob', 'Johnson', 'BJ654321D', 2, 2);

INSERT INTO `orders` (`order_id`, `created_at`, `item_id`, `quantity`, `cust_id`, `add_id`, `store_id`) 
VALUES ('ORD001', '2024-05-01 09:00:00', 1, 2, 1, 1, 1),
       ('ORD002', '2024-05-02 14:00:00', 2, 1, 2, 2, 2);
