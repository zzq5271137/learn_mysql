/*
 Navicat Premium Data Transfer

 Source Server         : MySQL-local
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : learnmysql

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 16/03/2020 23:08:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ls_account
-- ----------------------------
DROP TABLE IF EXISTS `ls_account`;
CREATE TABLE `ls_account`  (
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `money` decimal(10, 0) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ls_account
-- ----------------------------
INSERT INTO `ls_account` VALUES ('李四', 1000);

-- ----------------------------
-- Table structure for zs_account
-- ----------------------------
DROP TABLE IF EXISTS `zs_account`;
CREATE TABLE `zs_account`  (
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `money` decimal(10, 0) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zs_account
-- ----------------------------
INSERT INTO `zs_account` VALUES ('张三', 5000);

SET FOREIGN_KEY_CHECKS = 1;
