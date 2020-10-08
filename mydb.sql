/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : localhost:3306
 Source Schema         : mydb

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 08/10/2020 09:39:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Cart
-- ----------------------------
DROP TABLE IF EXISTS `Cart`;
CREATE TABLE `Cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_specs` varchar(255) DEFAULT NULL,
  `accessory` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `SPU_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Cart
-- ----------------------------
BEGIN;
INSERT INTO `Cart` VALUES (3, '{\"color\":\"black\",\"size\":\"small\"}', 'one year guarantee repair', 'black piano3', 'assets/images/SPU/black piano3.jpg', 1, 226, 12, 2);
INSERT INTO `Cart` VALUES (4, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 'video course', 'Casio piano6', 'assets/images/SPU/Casio piano6.jpg', 1, 587, 42, 2);
INSERT INTO `Cart` VALUES (5, '{\"color\":\"white\",\"size\":\"big\"}', 'music accessory', 'white piano1', 'assets/images/SPU/white piano1.jpg', 1, 36, 19, 2);
INSERT INTO `Cart` VALUES (6, '{\"color\":\"red\",\"size\":\"small\"}', 'piano book', 'red piano7', 'assets/images/SPU/red piano7.jpg', 1, 70, 7, 2);
INSERT INTO `Cart` VALUES (7, '{\"color\":\"black\",\"size\":\"small\"}', 'piano book', 'black piano5', 'assets/images/SPU/black piano5.jpg', 1, 89, 14, 2);
INSERT INTO `Cart` VALUES (8, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', NULL, 'Casio piano3', 'assets/images/SPU/Casio piano3.jpg', 1, 102, 39, 2);
INSERT INTO `Cart` VALUES (9, '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"big\"}', 'music accessory', 'piano bag4', 'assets/images/SPU/piano bag4.jpg', 2, 208, 49, 2);
INSERT INTO `Cart` VALUES (10, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', NULL, 'white piano8', 'assets/images/SPU/white piano8.jpg', 1, 44, 26, 2);
INSERT INTO `Cart` VALUES (11, '{\"color\":\"black\",\"size\":\"small\"}', 'piano book', 'black piano8', 'assets/images/SPU/black piano8.jpg', 5, 220, 22, 3);
INSERT INTO `Cart` VALUES (12, '{\"color\":\"black\",\"size\":\"small\"}', 'piano book', 'black piano1', 'assets/images/SPU/black piano1.jpg', 5, 775, 10, 3);
INSERT INTO `Cart` VALUES (13, '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', 'video course', 'piano bag6', 'assets/images/SPU/piano bag6.jpg', 5, 315, 51, 3);
INSERT INTO `Cart` VALUES (14, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', 'video course', 'Yamaha piano9', 'assets/images/SPU/Yamaha piano9.jpg', 5, 1265, 36, 3);
COMMIT;

-- ----------------------------
-- Table structure for Store
-- ----------------------------
DROP TABLE IF EXISTS `Store`;
CREATE TABLE `Store` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Store
-- ----------------------------
BEGIN;
INSERT INTO `Store` VALUES (1);
COMMIT;

-- ----------------------------
-- Table structure for User
-- ----------------------------
DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of User
-- ----------------------------
BEGIN;
INSERT INTO `User` VALUES (1, 'user01', '2314569', 'user01@163.com', '123456');
INSERT INTO `User` VALUES (2, 'user02', '2317712', 'user02@qq.com', '888888');
INSERT INTO `User` VALUES (3, 'user03', '2314677', 'user03@Gmail.com', '000000');
INSERT INTO `User` VALUES (7, 'user00', '13924609829', '273@129.com', '1234');
INSERT INTO `User` VALUES (8, 'testUser', '13923450298', '10@10.com', '10');
INSERT INTO `User` VALUES (9, 'testUser2', '13923450291', '10@101.com', '10');
INSERT INTO `User` VALUES (10, 'test-user', '18018273947', 'test@test.com', 'test');
INSERT INTO `User` VALUES (11, '123', '13627364987', '123@123.123', '123');
COMMIT;

-- ----------------------------
-- Table structure for accessory
-- ----------------------------
DROP TABLE IF EXISTS `accessory`;
CREATE TABLE `accessory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `stock_num` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Accessory_Store1_idx` (`store_id`),
  CONSTRAINT `FKitro527dms68jbileh8lgmk74` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of accessory
-- ----------------------------
BEGIN;
INSERT INTO `accessory` VALUES (1, 'music accessory', 12, 100, 1);
INSERT INTO `accessory` VALUES (2, 'default bag', 10, 80, 1);
INSERT INTO `accessory` VALUES (3, 'one year guarantee repair', 50, 10000, 1);
INSERT INTO `accessory` VALUES (4, 'piano book', 15, 800, 1);
INSERT INTO `accessory` VALUES (5, 'video course', 5, 800, 1);
COMMIT;

-- ----------------------------
-- Table structure for classification
-- ----------------------------
DROP TABLE IF EXISTS `classification`;
CREATE TABLE `classification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Classification_Classification1_idx` (`parent_id`),
  KEY `fk_Classification_Store1_idx` (`store_id`),
  CONSTRAINT `FK8jkhnurfqbctn2sgy5ydu845b` FOREIGN KEY (`parent_id`) REFERENCES `classification` (`id`),
  CONSTRAINT `FKsg9af33lkgujigcgsnyixwx0r` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classification
-- ----------------------------
BEGIN;
INSERT INTO `classification` VALUES (1, 'Child piano', NULL, 1);
INSERT INTO `classification` VALUES (2, 'Brand', NULL, 1);
INSERT INTO `classification` VALUES (3, 'Accessory', NULL, 1);
INSERT INTO `classification` VALUES (4, 'red piano', 1, 1);
INSERT INTO `classification` VALUES (5, 'black piano', 1, 1);
INSERT INTO `classification` VALUES (6, 'white piano', 1, 1);
INSERT INTO `classification` VALUES (7, 'Yamaha piano', 2, 1);
INSERT INTO `classification` VALUES (8, 'Casio piano', 2, 1);
INSERT INTO `classification` VALUES (9, 'piano bag', 3, 1);
COMMIT;

-- ----------------------------
-- Table structure for configuration_key
-- ----------------------------
DROP TABLE IF EXISTS `configuration_key`;
CREATE TABLE `configuration_key` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(45) DEFAULT NULL,
  `classification_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Configuration_key_Classification1_idx` (`classification_id`),
  CONSTRAINT `FKbhyywy44xmxrs39mitltcli7m` FOREIGN KEY (`classification_id`) REFERENCES `classification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of configuration_key
-- ----------------------------
BEGIN;
INSERT INTO `configuration_key` VALUES (1, 'color', 5);
INSERT INTO `configuration_key` VALUES (2, 'size', 5);
INSERT INTO `configuration_key` VALUES (3, 'color', 6);
INSERT INTO `configuration_key` VALUES (4, 'texture', 6);
INSERT INTO `configuration_key` VALUES (5, 'size', 6);
INSERT INTO `configuration_key` VALUES (6, 'texture', 8);
INSERT INTO `configuration_key` VALUES (7, 'version', 10);
INSERT INTO `configuration_key` VALUES (8, 'color', 10);
COMMIT;

-- ----------------------------
-- Table structure for configuration_value
-- ----------------------------
DROP TABLE IF EXISTS `configuration_value`;
CREATE TABLE `configuration_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(45) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `key_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Configuration_value_Configuration_key1_idx` (`key_id`),
  CONSTRAINT `FK1eewj0759yey0skv6e4t9jmrl` FOREIGN KEY (`key_id`) REFERENCES `configuration_key` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of configuration_value
-- ----------------------------
BEGIN;
INSERT INTO `configuration_value` VALUES (1, 'red', 10, 1);
INSERT INTO `configuration_value` VALUES (2, 'blue', 10, 1);
INSERT INTO `configuration_value` VALUES (3, 'big', 12, 2);
INSERT INTO `configuration_value` VALUES (4, 'small', 10, 2);
INSERT INTO `configuration_value` VALUES (5, 'black', 12, 3);
INSERT INTO `configuration_value` VALUES (6, 'white', 10, 3);
INSERT INTO `configuration_value` VALUES (7, 'metal', 20, 4);
INSERT INTO `configuration_value` VALUES (8, 'plastic', 10, 4);
INSERT INTO `configuration_value` VALUES (9, 'big', 5, 5);
INSERT INTO `configuration_value` VALUES (10, 'small', 3, 5);
INSERT INTO `configuration_value` VALUES (11, 'metal', 10, 6);
INSERT INTO `configuration_value` VALUES (12, 'plastic', 5, 6);
INSERT INTO `configuration_value` VALUES (13, '1.0', 10, 7);
INSERT INTO `configuration_value` VALUES (14, '2.0', 15, 7);
INSERT INTO `configuration_value` VALUES (15, '3.0', 20, 7);
INSERT INTO `configuration_value` VALUES (16, 'red', 6, 8);
INSERT INTO `configuration_value` VALUES (17, 'yellow', 6, 8);
COMMIT;

-- ----------------------------
-- Table structure for ordering
-- ----------------------------
DROP TABLE IF EXISTS `ordering`;
CREATE TABLE `ordering` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_time` varchar(45) DEFAULT NULL,
  `config_specs` varchar(255) DEFAULT NULL,
  `accessory` varchar(255) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `pay_status` varchar(45) DEFAULT NULL,
  `SPU_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Order_SPU1_idx` (`SPU_id`),
  KEY `fk_Order_User1_idx` (`user_id`),
  CONSTRAINT `FK1f7c7b00tmat11nsqhi93mvac` FOREIGN KEY (`SPU_id`) REFERENCES `spu` (`id`),
  CONSTRAINT `FKhtcyshmq2eem3spf041sg6f8l` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ordering
-- ----------------------------
BEGIN;
INSERT INTO `ordering` VALUES (1, '2020-06-01', '{\"color\":\"black\",\"size\":\"big\"}', NULL, 'black piano4', 2, 160, 'paid', 13, 1, 'assets/images/SPU/black piano4.jpg');
INSERT INTO `ordering` VALUES (2, '2020-06-01', '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 'default bag', 'Yamaha piano1', 1, 182, 'paid', 28, 1, 'assets/images/SPU/Yamaha piano1.jpg');
INSERT INTO `ordering` VALUES (3, '2020-09-17', '{\"color\":\"red\",\"size\":\"small\"}', 'music accessory', 'red piano9', 1, 42, 'unpaid', 9, 1, 'assets/images/SPU/red piano9.jpg');
INSERT INTO `ordering` VALUES (4, '2020-09-17', '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', 'one year guarantee repair', 'Casio piano3', 1, 152, 'unpaid', 39, 1, 'assets/images/SPU/Casio piano3.jpg');
INSERT INTO `ordering` VALUES (5, '2020-08-17', '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 'one year guarantee repair', 'Yamaha piano7', 1, 1049, 'paid', 34, 2, 'assets/images/SPU/Yamaha piano7.jpg');
INSERT INTO `ordering` VALUES (6, '2020-09-16', '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"big\"}', 'video course', 'piano bag9', 5, 505, 'unpaid', 54, 3, 'assets/images/SPU/piano bag9.jpg');
INSERT INTO `ordering` VALUES (7, '2020-07-04', '{\"color\":\"white\",\"size\":\"big\"}', 'piano book', 'white piano1', 10, 390, 'paid', 19, 3, 'assets/images/SPU/white piano1.jpg');
INSERT INTO `ordering` VALUES (8, '2020-09-11', '{\"color\":\"red\",\"size\":\"big\"}', 'piano book', 'red piano8', 10, 380, 'unpaid', 8, 3, 'assets/images/SPU/red piano8.jpg');
INSERT INTO `ordering` VALUES (9, '2020-09-14', '{\"color\":\"red\",\"size\":\"small\"}', 'piano book', 'red piano2', 10, 280, 'unpaid', 2, 3, 'assets/images/SPU/red piano2.jpg');
INSERT INTO `ordering` VALUES (10, '2020-05-22', '{\"color\":\"white\",\"size\":\"big\"}', 'video course', 'white piano9', 5, 1935, 'paid', 27, 3, 'assets/images/SPU/white piano9.jpg');
INSERT INTO `ordering` VALUES (11, '2020-06-29', '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', 'one year guarantee repair', 'Yamaha piano9', 5, 1490, 'paid', 36, 3, 'assets/images/SPU/Yamaha piano9.jpg');
INSERT INTO `ordering` VALUES (12, '2020-08-19', '{\"color\":\"black\",\"size\":\"small\"}', 'music accessory', 'black piano5', 8, 688, 'paid', 14, 3, 'assets/images/SPU/black piano5.jpg');
INSERT INTO `ordering` VALUES (13, '2020-06-23', '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 'default bag', 'Casio piano2', 4, 1576, 'paid', 38, 3, 'assets/images/SPU/Casio piano2.jpg');
INSERT INTO `ordering` VALUES (14, '2020-09-28 20:13:59', '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', NULL, 'piano bag3', 1, 72, 'paid', 48, 1, NULL);
INSERT INTO `ordering` VALUES (15, '2020-09-28 20:13:59', 'color: red ✖ ️size: small', '', 'red piano4', 1, 17, 'paid', 4, 1, NULL);
INSERT INTO `ordering` VALUES (28, '2020-09-28 20:30:07', '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', NULL, 'piano bag3', 1, 72, 'paid', 48, 1, NULL);
INSERT INTO `ordering` VALUES (29, '2020-09-28 20:30:07', 'color: red ✖ ️size: small', '', 'red piano4', 1, 17, 'paid', 4, 1, NULL);
INSERT INTO `ordering` VALUES (30, '2020-09-28 20:30:09', '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', NULL, 'piano bag3', 1, 72, 'paid', 48, 1, NULL);
INSERT INTO `ordering` VALUES (31, '2020-09-28 20:30:09', 'color: red ✖ ️size: small', '', 'red piano4', 1, 17, 'paid', 4, 1, NULL);
INSERT INTO `ordering` VALUES (32, '2020-09-28 20:30:30', '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', NULL, 'piano bag3', 1, 72, 'paid', 48, 1, NULL);
INSERT INTO `ordering` VALUES (33, '2020-09-28 20:30:30', 'color: red ✖ ️size: small', '', 'red piano4', 1, 17, 'paid', 4, 1, NULL);
INSERT INTO `ordering` VALUES (34, '2020-09-28 21:51:39', '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', NULL, 'piano bag3', 1, 72, 'paid', 48, 1, NULL);
INSERT INTO `ordering` VALUES (35, '2020-09-28 21:51:39', 'color: red ✖ ️size: small', '', 'red piano4', 1, 17, 'paid', 4, 1, NULL);
INSERT INTO `ordering` VALUES (36, '2020-09-28 21:52:12', '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', NULL, 'piano bag3', 1, 72, 'paid', 48, 1, NULL);
INSERT INTO `ordering` VALUES (37, '2020-09-28 21:52:12', 'color: red ✖ ️size: small', '', 'red piano4', 1, 17, 'paid', 4, 1, NULL);
INSERT INTO `ordering` VALUES (38, '2020-09-29 01:27:51', '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', NULL, 'piano bag3', 1, 72, 'paid', 48, 1, 'assets/images/SPU/piano bag3.jpg');
INSERT INTO `ordering` VALUES (39, '2020-09-29 01:27:51', 'color: red ✖ ️size: small', '', 'red piano4', 1, 17, 'paid', 4, 1, 'assets/images/SPU/red piano4.jpg');
INSERT INTO `ordering` VALUES (40, '2020-09-29 01:27:54', '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', NULL, 'piano bag3', 1, 72, 'paid', 48, 1, 'assets/images/SPU/piano bag3.jpg');
INSERT INTO `ordering` VALUES (41, '2020-09-29 01:27:54', 'color: red ✖ ️size: small', '', 'red piano4', 1, 17, 'paid', 4, 1, 'assets/images/SPU/red piano4.jpg');
INSERT INTO `ordering` VALUES (42, '2020-09-29 11:04:21', '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', NULL, 'piano bag3', 1, 72, 'paid', 48, 1, 'assets/images/SPU/piano bag3.jpg');
INSERT INTO `ordering` VALUES (43, '2020-09-29 11:04:21', 'color: white ✖ ️size: big', 'music accessory', 'white piano4', 1, 104, 'paid', 22, 1, 'assets/images/SPU/white piano4.jpg');
INSERT INTO `ordering` VALUES (44, '2020-09-30 14:17:29', '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', NULL, 'piano bag3', 1, 72, 'paid', 48, 1, 'assets/images/SPU/piano bag3.jpg');
INSERT INTO `ordering` VALUES (45, '2020-09-30 14:17:29', 'color: white ✖ ️size: big', 'music accessory', 'white piano4', 1, 104, 'paid', 22, 1, 'assets/images/SPU/white piano4.jpg');
INSERT INTO `ordering` VALUES (46, '2020-09-30 14:17:29', 'color: red ✖ ️size: small', 'music accessory➕one year guarantee repair', 'red piano4', 1, 79, 'paid', 4, 1, 'assets/images/SPU/red piano4.jpg');
INSERT INTO `ordering` VALUES (47, '2020-09-30 14:17:29', 'color: red ✖ ️size: small', 'music accessory➕one year guarantee repair', 'red piano4', 1, 79, 'paid', 4, 1, 'assets/images/SPU/red piano4.jpg');
INSERT INTO `ordering` VALUES (48, '2020-10-05 11:35:04', 'color: red ✖ ️size: small', 'music accessory', 'red piano5', 2, 29, 'paid', 5, 1, 'assets/images/SPU/red piano5.jpg');
INSERT INTO `ordering` VALUES (49, '2020-10-05 11:36:20', 'type: fabric ✖ ️color: black ✖ ️size: small', '', 'piano bag6', 1, 58, 'canceled', 51, 1, 'assets/images/SPU/piano bag6.jpg');
INSERT INTO `ordering` VALUES (50, '2020-10-07 14:20:35', 'type: plastic ✖ ️color: black ✖ ️size: big', 'music accessory➕default bag', 'Casio piano5', 3, 923, 'paid', 41, 1, 'assets/images/SPU/Casio piano5.jpg');
INSERT INTO `ordering` VALUES (51, '2020-10-07 19:26:55', 'type: plastic ✖ ️color: black ✖ ️size: small', '', 'Yamaha piano9', 2, 248, 'paid', 36, 11, 'assets/images/SPU/Yamaha piano9.jpg');
INSERT INTO `ordering` VALUES (52, '2020-10-07 19:26:55', 'type: fabric ✖ ️color: black ✖ ️size: small', 'piano book➕video course', 'piano bag8', 1, 101, 'paid', 53, 11, 'assets/images/SPU/piano bag8.jpg');
INSERT INTO `ordering` VALUES (53, '2020-10-07 19:27:47', 'type: fabric ✖ ️color: black ✖ ️size: small', '', 'piano bag8', 1, 101, 'canceled', 53, 11, 'assets/images/SPU/piano bag8.jpg');
COMMIT;

-- ----------------------------
-- Table structure for sku
-- ----------------------------
DROP TABLE IF EXISTS `sku`;
CREATE TABLE `sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `stock_num` int(11) DEFAULT NULL,
  `config_specs` varchar(255) DEFAULT NULL,
  `SPU_id` int(11) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_SKU_SPU_idx` (`SPU_id`),
  CONSTRAINT `FKehokkbtij47fmc8iwwhgepor2` FOREIGN KEY (`SPU_id`) REFERENCES `spu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sku
-- ----------------------------
BEGIN;
INSERT INTO `sku` VALUES (1, 'red piano1', 16, 56, '{\"color\":\"red\",\"size\":\"big\"}', 1, 'assets/images/SKU/red piano1.jpg');
INSERT INTO `sku` VALUES (2, 'red piano2', 13, 109, '{\"color\":\"red\",\"size\":\"small\"}', 2, 'assets/images/SKU/red piano2.jpg');
INSERT INTO `sku` VALUES (3, 'red piano3', 15, 35, '{\"color\":\"red\",\"size\":\"big\"}', 3, 'assets/images/SKU/red piano3.jpg');
INSERT INTO `sku` VALUES (4, 'red piano4', 17, 80, '{\"color\":\"red\",\"size\":\"small\"}', 4, 'assets/images/SKU/red piano4.jpg');
INSERT INTO `sku` VALUES (5, 'red piano5', 29, 89, '{\"color\":\"red\",\"size\":\"small\"}', 5, 'assets/images/SKU/red piano5.jpg');
INSERT INTO `sku` VALUES (6, 'red piano6', 89, 64, '{\"color\":\"red\",\"size\":\"big\"}', 6, 'assets/images/SKU/red piano6.jpg');
INSERT INTO `sku` VALUES (7, 'red piano7', 55, 71, '{\"color\":\"red\",\"size\":\"small\"}', 7, 'assets/images/SKU/red piano7.jpg');
INSERT INTO `sku` VALUES (8, 'red piano8', 23, 290, '{\"color\":\"red\",\"size\":\"big\"}', 8, 'assets/images/SKU/red piano8.jpg');
INSERT INTO `sku` VALUES (9, 'red piano9', 30, 11, '{\"color\":\"red\",\"size\":\"small\"}', 9, 'assets/images/SKU/red piano9.jpg');
INSERT INTO `sku` VALUES (10, 'black piano1', 140, 35, '{\"color\":\"black\",\"size\":\"small\"}', 10, 'assets/images/SKU/black piano1.jpg');
INSERT INTO `sku` VALUES (11, 'black piano2', 18, 92, '{\"color\":\"black\",\"size\":\"small\"}', 11, 'assets/images/SKU/black piano2.jpg');
INSERT INTO `sku` VALUES (12, 'black piano3', 176, 3, '{\"color\":\"black\",\"size\":\"small\"}', 12, 'assets/images/SKU/black piano3.jpg');
INSERT INTO `sku` VALUES (13, 'black piano4', 80, 94, '{\"color\":\"black\",\"size\":\"big\"}', 13, 'assets/images/SKU/black piano4.jpg');
INSERT INTO `sku` VALUES (14, 'black piano5', 74, 100, '{\"color\":\"black\",\"size\":\"small\"}', 14, 'assets/images/SKU/black piano5.jpg');
INSERT INTO `sku` VALUES (15, 'black piano6', 88, 23, '{\"color\":\"black\",\"size\":\"small\"}', 15, 'assets/images/SKU/black piano6.jpg');
INSERT INTO `sku` VALUES (16, 'black piano7', 37, 54, '{\"color\":\"black\",\"size\":\"big\"}', 16, 'assets/images/SKU/black piano7.jpg');
INSERT INTO `sku` VALUES (17, 'black piano8', 29, 84, '{\"color\":\"black\",\"size\":\"small\"}', 17, 'assets/images/SKU/black piano8.jpg');
INSERT INTO `sku` VALUES (18, 'black piano9', 333, 25, '{\"color\":\"black\",\"size\":\"small\"}', 18, 'assets/images/SKU/black piano9.jpg');
INSERT INTO `sku` VALUES (19, 'white piano1', 24, 368, '{\"color\":\"white\",\"size\":\"big\"}', 19, 'assets/images/SKU/white piano1.jpg');
INSERT INTO `sku` VALUES (20, 'white piano2', 75, 6, '{\"color\":\"white\",\"size\":\"small\"}', 20, 'assets/images/SKU/white piano2.jpg');
INSERT INTO `sku` VALUES (21, 'white piano3', 274, 26, '{\"color\":\"white\",\"size\":\"big\"}', 21, 'assets/images/SKU/white piano3.jpg');
INSERT INTO `sku` VALUES (22, 'white piano4', 92, 73, '{\"color\":\"white\",\"size\":\"big\"}', 22, 'assets/images/SKU/white piano4.jpg');
INSERT INTO `sku` VALUES (23, 'white piano5', 34, 82, '{\"color\":\"white\",\"size\":\"small\"}', 23, 'assets/images/SKU/white piano5.jpg');
INSERT INTO `sku` VALUES (24, 'white piano6', 100, 124, '{\"color\":\"white\",\"size\":\"small\"}', 24, 'assets/images/SKU/white piano6.jpg');
INSERT INTO `sku` VALUES (25, 'white piano7', 299, 194, '{\"color\":\"white\",\"size\":\"big\"}', 25, 'assets/images/SKU/white piano7.jpg');
INSERT INTO `sku` VALUES (26, 'white piano8', 44, 1045, '{\"color\":\"white\",\"size\":\"small\"}', 26, 'assets/images/SKU/white piano8.jpg');
INSERT INTO `sku` VALUES (27, 'white piano9', 382, 25, '{\"color\":\"white\",\"size\":\"big\"}', 27, 'assets/images/SKU/white piano9.jpg');
INSERT INTO `sku` VALUES (28, 'Yamaha piano1', 172, 63, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 28, 'assets/images/SKU/Yamaha piano1.jpg');
INSERT INTO `sku` VALUES (29, 'Yamaha piano2', 175, 72, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', 29, 'assets/images/SKU/Yamaha piano2.jpg');
INSERT INTO `sku` VALUES (30, 'Yamaha piano3', 283, 436, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 30, 'assets/images/SKU/Yamaha piano3.jpg');
INSERT INTO `sku` VALUES (31, 'Yamaha piano4', 294, 234, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', 31, 'assets/images/SKU/Yamaha piano4.jpg');
INSERT INTO `sku` VALUES (32, 'Yamaha piano5', 843, 237, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', 32, 'assets/images/SKU/Yamaha piano5.jpg');
INSERT INTO `sku` VALUES (33, 'Yamaha piano6', 103, 472, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 33, 'assets/images/SKU/Yamaha piano6.jpg');
INSERT INTO `sku` VALUES (34, 'Yamaha piano7', 999, 74, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 34, 'assets/images/SKU/Yamaha piano7.jpg');
INSERT INTO `sku` VALUES (35, 'Yamaha piano8', 572, 92, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', 35, 'assets/images/SKU/Yamaha piano8.jpg');
INSERT INTO `sku` VALUES (36, 'Yamaha piano9', 248, 95, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', 36, 'assets/images/SKU/Yamaha piano9.jpg');
INSERT INTO `sku` VALUES (37, 'Casio piano1', 228, 73, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', 37, 'assets/images/SKU/Casio piano1.jpg');
INSERT INTO `sku` VALUES (38, 'Casio piano2', 384, 47, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 38, 'assets/images/SKU/Casio piano2.jpg');
INSERT INTO `sku` VALUES (39, 'Casio piano3', 102, 237, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', 39, 'assets/images/SKU/Casio piano3.jpg');
INSERT INTO `sku` VALUES (40, 'Casio piano4', 150, 37, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', 40, 'assets/images/SKU/Casio piano4.jpg');
INSERT INTO `sku` VALUES (41, 'Casio piano5', 923, 85, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 41, 'assets/images/SKU/Casio piano5.jpg');
INSERT INTO `sku` VALUES (42, 'Casio piano6', 582, 65, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 42, 'assets/images/SKU/Casio piano6.jpg');
INSERT INTO `sku` VALUES (43, 'Casio piano7', 271, 55, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 43, 'assets/images/SKU/Casio piano7.jpg');
INSERT INTO `sku` VALUES (44, 'Casio piano8', 388, 274, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"small\"}', 44, 'assets/images/SKU/Casio piano8.jpg');
INSERT INTO `sku` VALUES (45, 'Casio piano9', 96, 85, '{\"type\":\"plastic\",\"color\":\"black\",\"size\":\"big\"}', 45, 'assets/images/SKU/Casio piano9.jpg');
INSERT INTO `sku` VALUES (46, 'piano bag1', 16, 72, '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', 46, 'assets/images/SKU/piano bag1.jpg');
INSERT INTO `sku` VALUES (47, 'piano bag2', 38, 295, '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"big\"}', 47, 'assets/images/SKU/piano bag2.jpg');
INSERT INTO `sku` VALUES (48, 'piano bag3', 72, 295, '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', 48, 'assets/images/SKU/piano bag3.jpg');
INSERT INTO `sku` VALUES (49, 'piano bag4', 92, 253, '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"big\"}', 49, 'assets/images/SKU/piano bag4.jpg');
INSERT INTO `sku` VALUES (50, 'piano bag5', 23, 293, '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"big\"}', 50, 'assets/images/SKU/piano bag5.jpg');
INSERT INTO `sku` VALUES (51, 'piano bag6', 58, 236, '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', 51, 'assets/images/SKU/piano bag6.jpg');
INSERT INTO `sku` VALUES (52, 'piano bag7', 71, 277, '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"big\"}', 52, 'assets/images/SKU/piano bag7.jpg');
INSERT INTO `sku` VALUES (53, 'piano bag8', 101, 96, '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"small\"}', 53, 'assets/images/SKU/piano bag8.jpg');
INSERT INTO `sku` VALUES (54, 'piano bag9', 96, 174, '{\"type\":\"fabric\",\"color\":\"black\",\"size\":\"big\"}', 54, 'assets/images/SKU/piano bag9.jpg');
COMMIT;

-- ----------------------------
-- Table structure for spu
-- ----------------------------
DROP TABLE IF EXISTS `spu`;
CREATE TABLE `spu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `launch_time` varchar(45) DEFAULT NULL,
  `classification_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `picture` varchar(45) DEFAULT NULL,
  `sales` int(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_SPU_Classification1_idx` (`classification_id`),
  KEY `fk_SPU_Store1_idx` (`store_id`),
  KEY `id` (`id`),
  CONSTRAINT `FK3sa2bjqcs3pxevkhddqu8rjcw` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`),
  CONSTRAINT `FK_spu_classification` FOREIGN KEY (`classification_id`) REFERENCES `classification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of spu
-- ----------------------------
BEGIN;
INSERT INTO `spu` VALUES (1, 'red piano1', 16, '2000-01-01', 4, 1, 'assets/images/SPU/red piano1.jpg', 100, 'Full features Digital Piano for beginners Electric keyboard with 88 premium full sized semi weighted keys', 'Casio');
INSERT INTO `spu` VALUES (2, 'red piano2', 13, '2000-02-02', 4, 1, 'assets/images/SPU/red piano2.jpg', 20, 'a piano for children, to cultivate their music talent', 'Meike');
INSERT INTO `spu` VALUES (3, 'red piano3', 15, '2000-03-03', 4, 1, 'assets/images/SPU/red piano3.jpg', 210, 'Makes a great gift for ages 4 and up, for hands-on, screen-free play', 'Casio');
INSERT INTO `spu` VALUES (4, 'red piano4', 17, '2020-07-01', 4, 1, 'assets/images/SPU/red piano4.jpg', 1000, 'Kids piano keyboard made of non-toxic environmental protection plastic, fine workmanship and smooth edge design', 'Yamaha');
INSERT INTO `spu` VALUES (5, 'red piano5', 29, '2020-06-15', 4, 1, 'assets/images/SPU/red piano5.jpg', 90, '37 keys / 8 percussion instruments / 3 teaching modes / 8 musical instruments', 'Meike');
INSERT INTO `spu` VALUES (6, 'red piano6', 89, '2017-03-15', 4, 1, 'assets/images/SPU/red piano6.jpg', 20, '49 keys kids piano with headphones, put it into headphone jack, beginners or kids can listen to music when played the piano via the included headphones', 'Casio');
INSERT INTO `spu` VALUES (7, 'red piano7', 55, '2016-05-08', 4, 1, 'assets/images/SPU/red piano7.jpg', 750, 'Width of the keys promotes proper finger placement enabling an easy transition to a larger piano when ready', 'Yamaha');
INSERT INTO `spu` VALUES (8, 'red piano8', 23, '2008-06-22', 4, 1, 'assets/images/SPU/red piano8.jpg', 420, 'Happy Grand Piano produces grand sound to accompany its grand appearance', 'Casio');
INSERT INTO `spu` VALUES (9, 'red piano9', 30, '2005-07-23', 4, 1, 'assets/images/SPU/red piano9.jpg', 180, 'Enhance hearing ability, exercises hands-eyes coordination, boost brain memory development', 'Yamaha');
INSERT INTO `spu` VALUES (10, 'black piano1', 140, '2000-11-01', 5, 1, 'assets/images/SPU/black piano1.jpg', 187, 'Kids Piano Made from non-toxic ABS environmentally friendly materials', 'Casio');
INSERT INTO `spu` VALUES (11, 'black piano2', 18, '2000-02-22', 5, 1, 'assets/images/SPU/black piano2.jpg', 123, 'The surface of the entire piano keyboard is smooth. Passed the toy CPC safety certification, quality and safety', 'Casio');
INSERT INTO `spu` VALUES (12, 'black piano3', 176, '2001-04-03', 5, 1, 'assets/images/SPU/black piano3.jpg', 345, 'Kids will love to play around with cool music. This kid’s keyboard has it all', 'Casio');
INSERT INTO `spu` VALUES (13, 'black piano4', 80, '2011-07-01', 5, 1, 'assets/images/SPU/black piano4.jpg', 2349, 'Kids piano with 24 demo, 3 tones, volume control, tempo control, FM radio functions', 'Yamaha');
INSERT INTO `spu` VALUES (14, 'black piano5', 74, '2015-06-15', 5, 1, 'assets/images/SPU/black piano5.jpg', 92, 'electric kids piano made of high quality ABS and non-toxic environmental protection plastic, No harm to children', 'Meike');
INSERT INTO `spu` VALUES (15, 'black piano6', 88, '2010-03-15', 5, 1, 'assets/images/SPU/black piano6.jpg', 48, 'This RockJam keyboard piano features 54 full size keys that gives this keyboard a traditional piano feel', 'Casio');
INSERT INTO `spu` VALUES (16, 'black piano7', 37, '2008-05-08', 5, 1, 'assets/images/SPU/black piano7.jpg', 973, 'Two Inbuilt stereo speakers provide excellent sound quality allowing you to monitor your practice and performances', 'Yamaha');
INSERT INTO `spu` VALUES (17, 'black piano8', 29, '2008-06-02', 5, 1, 'assets/images/SPU/black piano8.jpg', 575, 'Unique 61 large key piano design with double speaker system, LCD display screen, Hi-Fi sound quality, silicone function button, the bottom is made of sturdy material and is not easy to damage', 'Yamaha');
INSERT INTO `spu` VALUES (18, 'black piano9', 333, '2005-08-11', 5, 1, 'assets/images/SPU/black piano9.jpg', 292, 'Cultivate children interested in music since the childhood, let the child have a good hobby', 'Yamaha');
INSERT INTO `spu` VALUES (19, 'white piano1', 24, '2004-12-11', 6, 1, 'assets/images/SPU/white piano1.jpg', 34, 'Unique 37 large key piano design with double speaker system, Hi-Fi sound quality, silicone function button, the bottom is made of sturdy material and is not easy to damage', 'Casio');
INSERT INTO `spu` VALUES (20, 'white piano2', 75, '20010-05-29', 6, 1, 'assets/images/SPU/white piano2.jpg', 23, 'The DC power connector of the USB power cord is connected to the power jack at the back of the keyboard', 'Casio');
INSERT INTO `spu` VALUES (21, 'white piano3', 274, '2001-08-18', 6, 1, 'assets/images/SPU/white piano3.jpg', 723, 'This keyboard was memoried of many different tones, rhythms, melodies, can be play different music', 'Casio');
INSERT INTO `spu` VALUES (22, 'white piano4', 92, '2011-02-07', 6, 1, 'assets/images/SPU/white piano4.jpg', 92, 'Made of security and eco-friendly material, fine workmanship and smooth edge design, children will not hurt', 'Yamaha');
INSERT INTO `spu` VALUES (23, 'white piano5', 34, '2018-06-06', 6, 1, 'assets/images/SPU/white piano5.jpg', 84, 'Music mode lets them play the piano like a regular keyboard. The keyboard can also help little ones refine their motor skills as they practice pressing individual keys', 'Meike');
INSERT INTO `spu` VALUES (24, 'white piano6', 100, '2010-03-14', 6, 1, 'assets/images/SPU/white piano6.jpg', 95, 'There are different instruments to choose from, encouraging kids to explore different sound combinations', 'Casio');
INSERT INTO `spu` VALUES (25, 'white piano7', 299, '2007-07-17', 6, 1, 'assets/images/SPU/white piano7.jpg', 872, 'This toy helps your child with hand-eye coordination, musical theory and fine motor skills among other important skills', 'Yamaha');
INSERT INTO `spu` VALUES (26, 'white piano8', 44, '2012-11-14', 6, 1, 'assets/images/SPU/white piano8.jpg', 917, 'This children keyboard is made of non-toxic and environmentally-friendly plastic', 'Yamaha');
INSERT INTO `spu` VALUES (27, 'white piano9', 382, '2006-06-26', 6, 1, 'assets/images/SPU/white piano9.jpg', 1083, 'It comes with 1 Year Worry-free Warranty and full support from JINRUCHE, So you can purchase with confidence', 'Yamaha');
INSERT INTO `spu` VALUES (28, 'Yamaha piano1', 172, '2016-08-26', 7, 1, 'assets/images/SPU/Yamaha piano1.jpg', 943, 'The CFX Premium Grand Piano Voice recreates the power and tone of Yamaha flagship CFX concert grand piano', 'Yamaha');
INSERT INTO `spu` VALUES (29, 'Yamaha piano2', 175, '2020-01-08', 7, 1, 'assets/images/SPU/Yamaha piano2.jpg', 284, 'Graded Hammer 3 action (GH3) with synthetic ivory key tops add a tactile surface to the white keys, which absorbs finger moisture and prevents slipping', 'Yamaha');
INSERT INTO `spu` VALUES (30, 'Yamaha piano3', 283, '2009-09-10', 7, 1, 'assets/images/SPU/Yamaha piano3.jpg', 72, 'Virtual Resonance Modeling (VRM) allows for vivid and richly varied expression to reflect the limitless number of factors that create the sound of a concert grand piano', 'Yamaha');
INSERT INTO `spu` VALUES (31, 'Yamaha piano4', 294, '2014-11-07', 7, 1, 'assets/images/SPU/Yamaha piano4.jpg', 9, 'Full dot LCD display allows for smooth navigation of the instrument features and functions', 'Yamaha');
INSERT INTO `spu` VALUES (32, 'Yamaha piano5', 843, '2017-08-06', 7, 1, 'assets/images/SPU/Yamaha piano5.jpg', 27, 'A fully weighted digital piano with 88 full-sized piano-style keys', 'Yamaha');
INSERT INTO `spu` VALUES (33, 'Yamaha piano6', 103, '2018-03-14', 7, 1, 'assets/images/SPU/Yamaha piano6.jpg', 73, 'GHS weighted action is heavier in the low keys and lighter in the high keys, just like an acoustic piano', 'Yamaha');
INSERT INTO `spu` VALUES (34, 'Yamaha piano7', 999, '2013-07-25', 7, 1, 'assets/images/SPU/Yamaha piano7.jpg', 132, 'GHS weighted action is heavier in the low end and lighter in the high end, just like an acoustic pia', 'Yamaha');
INSERT INTO `spu` VALUES (35, 'Yamaha piano8', 572, '2017-12-14', 7, 1, 'assets/images/SPU/Yamaha piano8.jpg', 201, 'This bundle contains: Yamaha DGX660 88-Key Digital Piano, Black', 'Yamaha');
INSERT INTO `spu` VALUES (36, 'Yamaha piano9', 248, '2006-11-06', 7, 1, 'assets/images/SPU/Yamaha piano9.jpg', 642, 'The controller app for iOS devices adds a rich graphical user interface, allowing for quick and easy navigation and configuration', 'Yamaha');
INSERT INTO `spu` VALUES (37, 'Casio piano1', 228, '2005-03-12', 8, 1, 'assets/images/SPU/Casio piano1.jpg', 823, '61 responsive piano style keys with built in speakers perfect for practicing and performing to your friends and family', 'Casio');
INSERT INTO `spu` VALUES (38, 'Casio piano2', 384, '2004-07-18', 8, 1, 'assets/images/SPU/Casio piano2.jpg', 109, 'Includes an easy to assemble stand, a bench with three adjustable height settings, headphones, a music rest, a power adapter and even a microphone for singing along while you play', 'Casio');
INSERT INTO `spu` VALUES (39, 'Casio piano3', 102, '2008-09-22', 8, 1, 'assets/images/SPU/Casio piano3.jpg', 327, 'a durable and sturdy padded stool accompanies your musical keyboard kit meaning you can play without discomfort for hours', 'Casio');
INSERT INTO `spu` VALUES (40, 'Casio piano4', 150, '2016-08-11', 8, 1, 'assets/images/SPU/Casio piano4.jpg', 98, 'keyboard package provides a strong and adjustable keyboard stand that is designed to hold your keyboard securely and adjust to musicians of all sizes', 'Casio');
INSERT INTO `spu` VALUES (41, 'Casio piano5', 923, '2005-03-29', 8, 1, 'assets/images/SPU/Casio piano5.jpg', 20, 'Tri-Sensor Scaled Hammer Action II 88 key keyboard with simulated Ebony and Ivory feel', 'Casio');
INSERT INTO `spu` VALUES (42, 'Casio piano6', 582, '2016-12-21', 8, 1, 'assets/images/SPU/Casio piano6.jpg', 63, 'Dedicated button for Grand Piano sound, as well as 550 instrument tones and effects', 'Casio');
INSERT INTO `spu` VALUES (43, 'Casio piano7', 271, '2019-07-16', 8, 1, 'assets/images/SPU/Casio piano7.jpg', 174, 'The AiR engine provides highly-accurate grand piano sounds with seamless dynamics for a remarkably expressive and powerful performance', 'Casio');
INSERT INTO `spu` VALUES (44, 'Casio piano8', 388, '2000-12-01', 8, 1, 'assets/images/SPU/Casio piano8.jpg', 209, 'Includes a powerful stereo amplification system offering an optimal listening experience that is crystal-clear across the entire audio spectrum', 'Casio');
INSERT INTO `spu` VALUES (45, 'Casio piano9', 96, '2010-09-14', 8, 1, 'assets/images/SPU/Casio piano9.jpg', 1582, 'Concert Play allows you to play along with ten recordings of well-known orchestral pieces', 'Casio');
INSERT INTO `spu` VALUES (46, 'piano bag1', 16, '2014-06-11', 9, 1, 'assets/images/SPU/piano bag1.jpg', 865, 'Material: waterproof oxford cloth; Inside 6mm thick cotton cloth can protect the keyboard from damage', 'Tosnail');
INSERT INTO `spu` VALUES (47, 'piano bag2', 38, '2009-09-20', 9, 1, 'assets/images/SPU/piano bag2.jpg', 462, 'With the outside two pockets for storage of book and power supply etc', 'Tosnail');
INSERT INTO `spu` VALUES (48, 'piano bag3', 72, '2008-10-15', 9, 1, 'assets/images/SPU/piano bag3.jpg', 834, 'Two zipper make two big pockets safer ,two mesh pockets on both side hold little goods', 'Tosnail');
INSERT INTO `spu` VALUES (49, 'piano bag4', 92, '2017-11-11', 9, 1, 'assets/images/SPU/piano bag4.jpg', 723, 'Donner’s keyboard bag is well enough to contain your favourite keyboard', 'Tosnail');
INSERT INTO `spu` VALUES (50, 'piano bag5', 23, '2010-01-28', 9, 1, 'assets/images/SPU/piano bag5.jpg', 192, 'Very suitable for small items such as mobile phones, wallets, cosmetics, etc', 'Tosnail');
INSERT INTO `spu` VALUES (51, 'piano bag6', 58, '2020-02-16', 9, 1, 'assets/images/SPU/piano bag6.jpg', 942, 'One main zippered pocket for laptop, two front and back zippered pockets for other accessories such as charger, mobile phone, headphone, cable, mouse, power bank and etc', 'Tosnail');
INSERT INTO `spu` VALUES (52, 'piano bag7', 71, '2009-12-16', 9, 1, 'assets/images/SPU/piano bag7.jpg', 288, 'Laptop shoulder bag, adjustable and removable shoulder strap with anti-slip shoulder pad enables you carry in comfort', 'Tosnail');
INSERT INTO `spu` VALUES (53, 'piano bag8', 101, '2000-12-29', 9, 1, 'assets/images/SPU/piano bag8.jpg', 386, 'Laptop briefcase has two-side printing with advanced and exquisite printing technology, long-lasting and anti-fading', 'Tosnail');
INSERT INTO `spu` VALUES (54, 'piano bag9', 96, '2011-04-24', 9, 1, 'assets/images/SPU/piano bag9.jpg', 1229, 'Laptop brief case is made of high quality soft velvet and durable canvas fabric, provide your laptop with protection from dust, scratch, shock, bump, reduce damages caused by accidentally bumping and scratches', 'Tosnail');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
