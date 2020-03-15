/*
 * 创建数据库
 */
create database mydb character set utf8;

/*
 * 修改数据库
 */
alter database mydb character set gbk;

/*
 * 创建表
 */
create table student
(
    id       bigint primary key auto_increment,
    stu_name varchar(50),
    stu_age  int
);

/*
 * 查看表的结构
 */
desc student;

/*
 * 查看表的创建细节
 */
show create table student;

/*
 * 修改表, 添加一列
 */
alter table student
    add stu_gender tinyint;

/*
 * 修改表, 修改字段类型
 */
alter table student
    modify stu_name varchar(30);

/*
 * 修改表名
 */
rename table student to newstudent;

/*
 * 修改表的字符集
 */
alter table student
    character set utf8;

/*
 * 修改表的字段名
 */
alter table student
    change id stu_id bigint auto_increment;

/*
 * 删除一列
 */
alter table student
    drop stu_gender;

/*
 * 删除表
 */
drop table student;
