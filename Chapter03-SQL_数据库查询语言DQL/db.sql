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

 Date: 15/03/2020 18:50:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `stu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stu_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `stu_age` int(11) NULL DEFAULT NULL,
  `stu_email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `stu_gender` tinyint(4) NULL DEFAULT NULL,
  `stu_score` float NULL DEFAULT NULL,
  `department` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`stu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, '毛毛的大脚', 45, 'mm@gmail.com', 1, 25, '研发部');
INSERT INTO `student` VALUES (2, '深海的星星', 24, 'xx@gmail.com', 1, 55, '营销部');
INSERT INTO `student` VALUES (3, '废物1', 9, 'ff1@gmail.com', 1, 62, '宣传部');
INSERT INTO `student` VALUES (4, '废物2', 17, 'ff2@gmail.com', 1, 93, '法务部');
INSERT INTO `student` VALUES (5, '废物3', 27, 'ff3@gmail.com', 0, 85, '研发部');
INSERT INTO `student` VALUES (6, '废物4', 19, NULL, 1, 77, '营销部');
INSERT INTO `student` VALUES (7, 'a', 19, NULL, 0, 70, '研发部');
INSERT INTO `student` VALUES (8, 'aa', 25, NULL, 0, 70, '法务部');
INSERT INTO `student` VALUES (9, 'aab', 25, NULL, 1, 70, '宣传部');
INSERT INTO `student` VALUES (10, 'abcd', 25, NULL, 1, 90, '宣传部');
INSERT INTO `student` VALUES (11, 'bbacs', 13, NULL, 1, 55, '研发部');
INSERT INTO `student` VALUES (12, 'aabcd', NULL, NULL, 0, 55, '宣传部');
INSERT INTO `student` VALUES (13, '张三', NULL, NULL, 1, 93, '研发部');
INSERT INTO `student` VALUES (14, '张四', NULL, NULL, 1, 77, '研发部');
INSERT INTO `student` VALUES (15, '李四', NULL, NULL, 0, 25, '宣传部');
INSERT INTO `student` VALUES (16, '王五', NULL, NULL, 0, 15, '法务部');
INSERT INTO `student` VALUES (17, '王六', NULL, NULL, 1, 15, '法务部');
INSERT INTO `student` VALUES (18, 'abcds', NULL, NULL, 1, 19, '宣传部');
INSERT INTO `student` VALUES (19, '毛毛的大脚', NULL, NULL, 1, 21, '法务部');
INSERT INTO `student` VALUES (20, '毛毛的大脚', NULL, NULL, 0, 35, '营销部');

SET FOREIGN_KEY_CHECKS = 1;
