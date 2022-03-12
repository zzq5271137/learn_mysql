/*
 * 查询所有列
 */
select *
from student;

/*
 * 查询指定的列
 */
select stu_id, stu_name
from student;

/*
 * 条件查询
 */
select stu_id, stu_name, stu_age, stu_email, stu_score
from student
where stu_score > 60
  and stu_age between 5 and 20
  and stu_email is not null;

select *
from student
where stu_id in (1, 3, 5);

/*
 * 模糊查询;
 * 通配符:
 * 1. _: 任意一个字符
 * 2. %: 任意0~n个字符
 */
select stu_id, stu_name
from student
where stu_name like '__';

select stu_id, stu_name
from student
where stu_name like '____s';

select stu_id, stu_name
from student
where stu_name like '张%';

select stu_id, stu_name
from student
where stu_name like '_b%';

select stu_id, stu_name
from student
where stu_name like '%废物%';

/*
 * 字段控制查询: 去除重复记录
 */
select distinct stu_name
from student
where stu_name = '毛毛的大脚';

/*
 * 字段控制查询: 对查询结果进行运算(必须都是数值类型)
 */
select *, stu_age + stu_score as age_plus_score
from student;

select *, ifnull(stu_age, 1) + ifnull(stu_score, 0) as age_plus_score
from student;

/*
 * 字段控制查询: 对查询结果进行排序
 */
select stu_id, stu_name, stu_score
from student
order by stu_score desc, stu_id asc;

/*
 * 聚合函数: count(), 统计不为null的记录行数
 */
select count(*) as total
from student;

select count(distinct stu_score) as score_count
from student;

select count(*) as age_count
from student
where stu_age > 20;

select count(*) as count
from student
where ifnull(stu_age, 1) + ifnull(stu_score, 0) > 50;

select count(stu_age) as age_count, count(stu_email) as email_count
from student;

/*
 * 聚合函数: sum(), 求和
 */
select sum(stu_age) as age_sum, sum(stu_score) as score_sum
from student;

select sum(ifnull(stu_age, 1) + ifnull(stu_score, 0)) as age_score_sum
from student;

/*
 * 聚合函数: avg(), 求平均
 */
select avg(ifnull(stu_score, 0)) as score_avg
from student;

/*
 * 聚合函数: max(), min()
 */
select max(stu_score) as score_max, min(stu_score) as score_min
from student;

/*
 * 分组查询: group by
 * 当group by单独使用时, 只显示出每组的第一条记录, 所以group by单独使用时, 意义不大;
 */
select *
from student
group by department;

/*
 * group by + group_concat()
 * group by并不是单纯的去重, 和distinct有区别;
 */
select department, group_concat(stu_name) as members
from student
group by department;

/*
 * 通常, 在使用分组时, select后面直接跟的字段一般都出现在group by后
 */
select department
from student
group by department;

select department, stu_gender, group_concat(stu_name)
from student
group by department, stu_gender;

/*
 * group by + 聚合函数
 */
select department, group_concat(stu_score), avg(stu_score)
from student
group by department;

select department, group_concat(stu_name), count(*), max(stu_score)
from student
group by department;

select department, count(*) as num, group_concat(stu_name, '_', stu_score) as member_score, avg(stu_score) as avg
from student
group by department;

/*
 * group by + where
 * where写在group by之前, 是先对数据进行where条件筛选, 再进行分组
 */
select department, group_concat(stu_score), count(*)
from student
where stu_score > 60
group by department;

/*
 * group by + having
 * having写在group by之后, 是已经分过组后, 对分组结果再进行条件筛选
 */
select department, group_concat(stu_name), avg(stu_score) as score_avg
from student
where stu_score > 60
group by department
having score_avg > 80;

/*
 * where与having的区别总结:
 * 1. where是在分组前对数据进行过滤;
 * 2. having是在分组后对数据进行过滤;
 * 3. where是对数据分组前设定的条件, 如果某条记录不满足where子句的条件, 那么这条记录不会参与分组, 而having是对分组后数据的约束;
 * 4. having后面可以使用聚合函数, where后面不行;
 */

select department, group_concat(stu_name), avg(stu_score), avg(stu_age)
from student
where stu_score > 60
group by department
having avg(stu_age) > 20
   and avg(stu_score) > 80
order by avg(stu_score) desc;

/*
 * limit: 从哪一条开始查, 总共查几条(角标从0开始);
 * 语法: limit 参数1 参数2
 * 参数1: 从哪一条开始查
 * 参数2: 总共查几条
 *
 * limit可以用于实现分页, 思路:
 * int currentPage = 1; // 当前页
 * int pageSize = 3; // 每页多少条数据
 * 当前页为1, 第一页从0开始: (1 - 1) * 3 = 0
 * 当前页为2, 第二页从3开始: (2 - 1) * 3 = 3
 * 当前页为3, 第三页从6开始: (3 - 1) * 3 = 6
 * ...
 * 所以, SQL语句可以写成:
 * select * from table limit (currentPage-1)*pageSize, pageSize;
 */
select *
from student
limit 0, 3;

select *
from student
limit 3, 3;

/*
 * SQL书写顺序:
 * select
 * from
 * where
 * group by
 * having
 * order by
 * limit
 */
