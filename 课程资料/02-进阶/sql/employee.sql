/*
Navicat MySQL Data Transfer

Source Server         : itlike
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : itlike

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2019-04-12 09:58:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `dep_id` int(11) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `cus_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('1', '鲁班', '1', '10', '1000.00', '1');
INSERT INTO `employee` VALUES ('2', '后裔', '1', '20', '2000.00', '1');
INSERT INTO `employee` VALUES ('3', '孙尚香', '1', '20', '2500.00', '1');
INSERT INTO `employee` VALUES ('4', '凯', '4', '20', '3000.00', '1');
INSERT INTO `employee` VALUES ('5', '典韦', '4', '40', '3500.00', '2');
INSERT INTO `employee` VALUES ('6', '貂蝉', '6', '20', '5000.00', '1');
INSERT INTO `employee` VALUES ('7', '孙膑', '6', '50', '5000.00', '1');
INSERT INTO `employee` VALUES ('8', '蔡文姬', '30', '35', '4000.00', '1');