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

 Date: 16/03/2020 18:12:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for a
-- ----------------------------
DROP TABLE IF EXISTS `a`;
CREATE TABLE `a`  (
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `score` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of a
-- ----------------------------
INSERT INTO `a` VALUES ('a', 10);
INSERT INTO `a` VALUES ('b', 20);
INSERT INTO `a` VALUES ('c', 30);

-- ----------------------------
-- Table structure for b
-- ----------------------------
DROP TABLE IF EXISTS `b`;
CREATE TABLE `b`  (
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `score` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b
-- ----------------------------
INSERT INTO `b` VALUES ('a', 10);
INSERT INTO `b` VALUES ('b', 20);
INSERT INTO `b` VALUES ('d', 40);

-- ----------------------------
-- Table structure for car
-- ----------------------------
DROP TABLE IF EXISTS `car`;
CREATE TABLE `car`  (
  `cid` bigint(20) NOT NULL AUTO_INCREMENT,
  `cname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ccolor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pid` bigint(20) NULL DEFAULT NULL,
  `countryId` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`cid`) USING BTREE,
  INDEX `car_person_fk`(`pid`) USING BTREE,
  INDEX `car_country_fk`(`countryId`) USING BTREE,
  CONSTRAINT `car_person_fk` FOREIGN KEY (`pid`) REFERENCES `person` (`pid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `car_country_fk` FOREIGN KEY (`countryId`) REFERENCES `country` (`countryId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of car
-- ----------------------------
INSERT INTO `car` VALUES (1, '宝马', '蓝', 1, 1);
INSERT INTO `car` VALUES (2, '宝马', '黑', 2, 1);
INSERT INTO `car` VALUES (3, '奔驰', '灰', 2, 1);
INSERT INTO `car` VALUES (4, '雷克萨斯', '白', 3, 2);
INSERT INTO `car` VALUES (5, '尼桑', '黄', 4, 2);
INSERT INTO `car` VALUES (6, '马自达', '黑', NULL, 2);
INSERT INTO `car` VALUES (7, '高尔夫', '白', NULL, 3);

-- ----------------------------
-- Table structure for country
-- ----------------------------
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country`  (
  `countryId` bigint(20) NOT NULL AUTO_INCREMENT,
  `countryName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`countryId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of country
-- ----------------------------
INSERT INTO `country` VALUES (1, '德国');
INSERT INTO `country` VALUES (2, '日本');
INSERT INTO `country` VALUES (3, '美国');
INSERT INTO `country` VALUES (4, '中国');

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept`  (
  `deptno` bigint(2) NOT NULL AUTO_INCREMENT COMMENT '表示部门编号，由两位数字所组成',
  `dname` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称，最多由14个字符所组成',
  `local` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门所在的位置',
  PRIMARY KEY (`deptno`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES (10, '财务部', '北京');
INSERT INTO `dept` VALUES (20, '调研部', '上海');
INSERT INTO `dept` VALUES (30, '销售部', '王者峡谷');
INSERT INTO `dept` VALUES (40, '运营部', '腾讯大楼');

-- ----------------------------
-- Table structure for emp
-- ----------------------------
DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp`  (
  `empno` int(11) NOT NULL,
  `ename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mgr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上级的编号',
  `hiredate` date NULL DEFAULT NULL,
  `salary` decimal(10, 0) NULL DEFAULT NULL,
  `comm` double NULL DEFAULT NULL COMMENT '绩效/奖金',
  `deptno` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`empno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of emp
-- ----------------------------
INSERT INTO `emp` VALUES (7369, '孙悟空', '职员', '7902', '2010-12-17', 800, NULL, 20);
INSERT INTO `emp` VALUES (7499, '孙尚香', '销售人员', '7698', '2011-02-20', 1600, 300, 30);
INSERT INTO `emp` VALUES (7521, '李白', '销售人员', '7698', '2011-02-22', 1250, 500, 30);
INSERT INTO `emp` VALUES (7566, '程咬金', '经理', '7839', '2011-04-02', 2975, NULL, 20);
INSERT INTO `emp` VALUES (7654, '妲己', '销售人员', '7698', '2011-09-28', 1250, 1400, 30);
INSERT INTO `emp` VALUES (7698, '兰陵王', '经理', '7839', '2011-05-01', 2854, NULL, 30);
INSERT INTO `emp` VALUES (7782, '虞姬', '经理', '7839', '2011-06-09', 2450, NULL, 10);
INSERT INTO `emp` VALUES (7788, '项羽', '检查员', '7566', '2017-04-19', 3000, NULL, 20);
INSERT INTO `emp` VALUES (7839, '张飞', '总裁', NULL, '2010-06-12', 5000, NULL, 10);
INSERT INTO `emp` VALUES (7844, '蔡文姬', '销售人员', '7698', '2011-09-08', 1500, 0, 30);
INSERT INTO `emp` VALUES (7876, '阿珂', '职员', '7788', '2017-05-23', 1100, NULL, 20);
INSERT INTO `emp` VALUES (7900, '刘备', '职员', '7698', '2011-12-03', 950, NULL, 30);
INSERT INTO `emp` VALUES (7902, '诸葛亮', '检查员', '7566', '2011-12-03', 3000, NULL, 20);
INSERT INTO `emp` VALUES (7934, '鲁班', '职员', '7782', '2012-01-23', 1300, NULL, 10);

-- ----------------------------
-- Table structure for person
-- ----------------------------
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person`  (
  `pid` bigint(20) NOT NULL AUTO_INCREMENT,
  `pname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of person
-- ----------------------------
INSERT INTO `person` VALUES (1, '张三');
INSERT INTO `person` VALUES (2, '李四');
INSERT INTO `person` VALUES (3, '王五');
INSERT INTO `person` VALUES (4, '赵六');
INSERT INTO `person` VALUES (5, '深海的星星');
INSERT INTO `person` VALUES (6, '毛毛的大脚');

-- ----------------------------
-- Table structure for salgrade
-- ----------------------------
DROP TABLE IF EXISTS `salgrade`;
CREATE TABLE `salgrade`  (
  `grade` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '工资等级',
  `lowSalary` int(11) NULL DEFAULT NULL COMMENT '此等级的最低工资',
  `highSalary` int(11) NULL DEFAULT NULL COMMENT '此等级的最高工资',
  PRIMARY KEY (`grade`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of salgrade
-- ----------------------------
INSERT INTO `salgrade` VALUES (1, 700, 1200);
INSERT INTO `salgrade` VALUES (2, 1201, 1400);
INSERT INTO `salgrade` VALUES (3, 1401, 2000);
INSERT INTO `salgrade` VALUES (4, 2001, 3000);
INSERT INTO `salgrade` VALUES (5, 3001, 9999);

SET FOREIGN_KEY_CHECKS = 1;
