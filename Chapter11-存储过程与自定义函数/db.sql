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

 Date: 17/03/2020 15:20:33
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
-- Table structure for newemp
-- ----------------------------
DROP TABLE IF EXISTS `newemp`;
CREATE TABLE `newemp`  (
  `id` bigint(20) NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `age` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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

-- ----------------------------
-- Procedure structure for add_num
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_num`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_num`(inout num int, in inc int)
begin
    set num = num + inc;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for get_by_name
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_by_name`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_by_name`(in targetName varchar(255))
begin
    select * from emp where ename = targetName;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for get_sal_by_name
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_sal_by_name`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sal_by_name`(in targetName varchar(255), out salary int)
begin
    select e.salary into salary from emp as e where e.ename = targetName;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_emp
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_emp`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_emp`(in startNum int, in amount int)
begin
    declare i int default 0;
    -- 默认情况下, 是自动提交sql的, 也就是每循环一次, 就插入一条, 这是非常慢的
    set autocommit = 0; -- 设置一下autocommit = 0, 它就不会自动提交了, 我们需要手动提交
    repeat
        set i = i + 1;
        -- 插入一条数据, name为长度5的随机字符串, age为10到30的随机数
        insert into newemp values (startNum + i, rand_str(5), floor(10 + rand() * 30));
    until i = amount
        end repeat;
    commit; -- 一次性提交所有的插入语句, 会大大的提高插入效率
end
;;
delimiter ;

-- ----------------------------
-- Function structure for rand_str
-- ----------------------------
set global log_bin_trust_function_creators = TRUE;
DROP FUNCTION IF EXISTS `rand_str`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `rand_str`(len int) RETURNS varchar(255) CHARSET utf8mb4
begin
    declare str varchar(100) default 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    declare i int default 0;
    declare res varchar(255) default '';
    while i < len
        do
            set res = concat(res, substr(str, floor(1 + rand() * 52), 1));
            set i = i + 1;
        end while;
    return res;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for show_emp
-- ----------------------------
DROP PROCEDURE IF EXISTS `show_emp`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_emp`()
begin
    select * from emp;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for test
-- ----------------------------
DROP PROCEDURE IF EXISTS `test`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `test`()
begin
    -- 声明
    declare avgRes double default 0;
    declare x,y int default 0;
    -- 赋值
    set x = 3;
    select avg(salary) into avgRes from emp;
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
