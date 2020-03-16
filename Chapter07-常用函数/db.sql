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

 Date: 16/03/2020 21:35:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
