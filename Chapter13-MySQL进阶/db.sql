/*
 Navicat Premium Data Transfer

 Source Server         : MySQL-local
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : learnmysql_advanced

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 17/03/2020 21:55:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deptName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '研发部(RD)', '2层');
INSERT INTO `department` VALUES (2, '人事部(HR)', '3层');
INSERT INTO `department` VALUES (3, '市场部(MK)', '4层');
INSERT INTO `department` VALUES (4, '后勤部(MIS)', '5层');
INSERT INTO `department` VALUES (5, '财务部(FD)', '6层');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dep_id` int(11) NULL DEFAULT NULL,
  `age` int(11) NULL DEFAULT NULL,
  `salary` decimal(10, 2) NULL DEFAULT NULL,
  `cus_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '鲁班', 1, 10, 1000.00, 1);
INSERT INTO `employee` VALUES (2, '后裔', 1, 20, 2000.00, 1);
INSERT INTO `employee` VALUES (3, '孙尚香', 1, 20, 2500.00, 1);
INSERT INTO `employee` VALUES (4, '凯', 2, 20, 3000.00, 1);
INSERT INTO `employee` VALUES (5, '典韦', 2, 40, 3500.00, 2);
INSERT INTO `employee` VALUES (6, '貂蝉', 3, 20, 5000.00, 1);
INSERT INTO `employee` VALUES (7, '孙膑', 4, 50, 5000.00, 1);
INSERT INTO `employee` VALUES (8, '蔡文姬', 30, 35, 4000.00, 1);

SET FOREIGN_KEY_CHECKS = 1;
