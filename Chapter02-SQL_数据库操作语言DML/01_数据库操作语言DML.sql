/*
 * 插入一条数据(指定字段插入)
 */
insert into student (stu_name, stu_age, stu_gender)
    value ('毛毛的大脚', 100, 1);

/*
 * 直接写value(插入全部字段)
 */
insert into student value (2, '深海的星星', 100, 1, 28);

/*
 * 插入多条数据
 */
insert into student (stu_name, stu_age, stu_gender)
values ('废物1', 100, 1),
       ('废物2', 100, 1),
       ('废物3', 100, 1);

/*
 * 更新数据(没有写where条件, 就会把这一列所有数据都改)
 */
update student
set stu_score = 90;

/*
 * 更新指定记录(带where条件)
 */
update student
set stu_score = stu_score + 2,
    stu_age   = 20
where stu_id = 2;

/*
 * 删除表中数据
 */
delete
from student
where stu_id = 5;

/*
 * 清空表中数据(delete如果不指定where条件, 就会清空表中数据)
 */
delete
from student;

/*
 * 清空表中数据
 */
truncate table student;

/*
 * truncate与delete, 清空表中数据的区别:
 * 1. delete是直接删除表中数据, 表的结构还在;
 * 2. truncate是先drop掉整个表, 再创建一个同样的新表, 执行速度比delete快;
 * 3. 如果主键是auto_increment, 使用delete清空表数据后, 再插入数据, id会继续往下增, 而使用truncate, 会从1开始;
 */
