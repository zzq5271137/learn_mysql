/*
 * ------------------排序与分组优化------------------
 * 0. 数据库对DQL的解析顺序:
 *    a). 在分析排序与分组的优化时, 要结合数据库对DQL的解析顺序进行分析;
 *        数据库对一条DQL的解析顺序为:
 *        from -> on -> join -> where -> group by -> having -> select -> order by -> limit
 *    b). 在分析时, 还要注意此语句是不是Using index, 即是不是索引覆盖;
 *        也就是select的东西是不是索引字段的子集;
 *        如果是索引覆盖, 索引就会被用到;
 *        这对分析有很大影响;
 * 1. order by:
 *    排序时(order by), 使用不当会出现Using filesort;
 *    Using filesort是指需要一次额外的排序或查找(排序前必查找);
 * 2. group by:
 *    分组时(group by), 使用不当会出现Using temporary;
 *    Using temporary是指, 额外需要一张临时表进行分组操作;
 *
 * 所以, 结合数据库对DQL的解析顺序(也就是一条DQL的执行顺序), 可以总结出对索引生失效及对SQL优化的分析的大致思路:
 * 先不看order by, 先看它是怎么获取数据的, 即, 有没有where, where的字段是不是索引字段;
 * 再看group by, 有没有用到索引;
 * 再看select的是不是索引覆盖;
 * 由此可以分析出到目前为止有没有使用索引;
 * 分析完这个, 得到一张表(结果集)后, 再去分析order by;
 * 即, 采用当前这张表(结果集)和使用的索引(如果前面用的话)能不能满足我的排序需求(DQL语句中order by后面的内容);
 * 即select索引覆盖、where条件和group by是在获得第一个结果集(order by之前的结果集)之前执行的;
 * 他们三个联合在一起会主动地去调用索引;
 * 而order by不会主动地调用索引, 它会采用之前那三个用的索引(如果有的话), 如果没有, 就是Using filesort;
 * 不要强行去记忆SQL优化准则或者索引生失效准则, 要自己分析;
 */

/*
 * 在使用order by时, 经常出现Using filesort:
 */
-- 正常情况下
explain
select *
from employee
where name = '鲁班'
  and dep_id = 1
  and age = 10;
-- 索引做为排序时, 会导致用于排序的那部分索引失效(只用到了name和dep_id, age是作为排序, 而不是查找)
explain
select *
from employee
where name = '鲁班'
  and dep_id = 1
order by age;

-- 使用order by排序时, 如果没有按照索引顺序, 会出现Using filesort(没有按照顺序是指, 违反了最佳左前缀法则)
-- 正常情况(order by按照索引顺序并且使用了覆盖索引)
explain
select name, dep_id, age
from employee
order by name, dep_id, age;
-- order by没有按照索引顺序, 出现Using filesort
explain
select name, dep_id, age
from employee
order by name, age;

-- 当使用select *时(或者select了没有索引的字段时), order by即使使用了全部索引, 也会出现Using filesort
explain
select *
from employee
order by name, dep_id, age;

-- 当索引字段为常量时, 可以当作是存在索引的
explain
select name, dep_id, age
from employee
where name = '鲁班'
order by dep_id, age;

-- 由于dep_id使用了range(范围查询), 导致它之后的索引失效
-- 也就是说, 这是数据库不知道怎样以age进行排序, 所以需要额外的一次查找或排序, 所以是Using filesort
explain
select name, dep_id, age
from employee
where name = '鲁班'
  and dep_id > 1
order by age;

-- 使用排序一升一降会造成filesort
explain
select name, dep_id, age
from employee
where name = '鲁班'
order by dep_id desc, age asc;

/*
 * 使用group by时, 使用不当, 会出现Using temporary:
 * 解决办法和排序一样, 都要按索引顺序进行分组(不要违反最佳左前缀法则);
 * (分组前必排序)
 */
explain
select age
from employee
where name = '鲁班'
group by age;

/*
 * ------------------面试题分析------------------
 * 详见xmind文档
 */
explain
select *
from employee
where dep_id = 1
order by name;

explain
select age, dep_id
from employee
where name = ''
group by age, dep_id;

/*
 * ------------------分页------------------
 * 建表以及插入百万条数据, 详见db.sql或xmind文档
 *
 * 传统分析查询:
 * 使用limit随着offset增大, 查询的速度会越来越慢, 因为它会把前面的数据都取出, 找到对应位置;
 */
-- 传统分页
select *
from testemployee
limit 900000, 10;

explain
select *
from testemployee
limit 900000, 10;

/*
 * 优化方式一: 使用子查询优化分页
 */
select *
from testemployee t1
         inner join (select id from testemployee t limit 900000, 10) t2
                    on t1.id = t2.id;
-- 执行计划分析
explain
select *
from testemployee t1
         inner join (select id from testemployee t limit 900000, 10) t2
                    on t1.id = t2.id;

-- 或者可以这么写
select *
from testemployee
where id > (select id from testemployee t limit 900000, 1)
limit 10;
-- 执行计划分析
explain
select *
from testemployee
where id > (select id from testemployee t limit 900000, 1)
limit 10;

/*
 * 优化方式二: 使用id限定的方式优化分页
 * 记录上一页最大的id号, 使用范围查询;
 * 限制是只能使用于明确知道id的情况, 不过一般建立表的时候, 都会添加基本的id字段, 这为分页查询带来很多便利;
 */
-- 假设上一页最大的id值为900000
select *
from testemployee
where id > 900000
limit 10;

/*
 * ------------------max()优化------------------
 */
-- 优化前
select max(age)
from testemployee;
-- 执行计划分析
explain
select max(age)
from testemployee;

-- 优化, 针对max的对象创建索引
create index idx_age on testemployee (age);
-- 执行计划分析
explain
select max(age)
from testemployee;

/*
 * ------------------count()使用方式的注意------------------
 */
-- 插入一条空数据
insert into employee(id, dep_id) value (9, 8);

-- count(*): 统计所有记录的数量, 即使记录里有null
select count(*)
from employee;

-- count(name): 统计name不为空的记录数量, 不包含null
select count(name)
from employee;
-- 想要包含null, 得这么写
select count(name or name is null)
from employee;

/*
 * ------------------小表驱动大表------------------
 * 小表驱动大表
 * 小表驱动大表, 即小的数据集驱动大得数据集;
 * 类似嵌套循环
 * for (int i = 5;.......) {
 *     for (int j = 1000;......){
 *         ...
 *     }
 * }
 * 如果小的循环在外层, 对于数据库连接来说就只连接5次, 进行1000次操作;
 * 如果1000在外, 则需要进行1000次数据库连接, 从而浪费资源, 增加消耗, 这就是为什么要小表驱动大表;
 */
-- 小表驱动大表, department为小表, employee为大表, 先查小表, 再查大表, 即小表驱动大表
select *
from employee
where dep_id in
      (select id from department);

/*
 * ------------------小表驱动大表: in与exists的选择------------------
 * 1. exist可以替代in
 * 2. in与exist选择:
 *    当A表中数据多于B表中的数据时, 这时我们使用in优于exists;
 *    当B表中数据多于A表中的数据时, 这时我们使用exists优于in;
 *    因此是使用in还是使用exists就需要根据我们的需求决定了;
 *    但是如果两张表中的数据量差不多时那么是使用in还是使用exists差别不大;
 *    exists子查询只返回true或false, 因此子查询中的select * 可以是select 1或者其他;
 */
-- in
select *
from employee
where dep_id in (select id from department);

-- exists
select *
from employee e
where exists(select 1 from department d where e.dep_id = d.id);
