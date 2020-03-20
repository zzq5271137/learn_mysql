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

 Date: 17/03/2020 18:20:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for newemp
-- ----------------------------
DROP TABLE IF EXISTS `newemp`;
CREATE TABLE `newemp`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `age` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `age_index`(`age`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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

SET FOREIGN_KEY_CHECKS = 1;
