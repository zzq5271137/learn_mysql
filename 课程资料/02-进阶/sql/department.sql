/*
Navicat MySQL Data Transfer

Source Server         : itlike
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : itlike

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2019-04-12 09:58:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deptName` varchar(30) DEFAULT NULL,
  `address` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '研发部(RD)', '2层');
INSERT INTO `department` VALUES ('2', '人事部(HR)', '3层');
INSERT INTO `department` VALUES ('3', '市场部(MK)', '4层');
INSERT INTO `department` VALUES ('4', '后勤部(MIS)', '5层');
INSERT INTO `department` VALUES ('5', '财务部(FD)', '6层');
