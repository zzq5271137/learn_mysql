/*
 * ------------------索引失效------------------
 */

/*
 * 索引全值匹配(最好):
 * 1. 使用到了一个
 * 2. 使用到了两个个
 * 3. 使用到了三个
 */
-- 创建索引(如果没有)
create index idx_name_dep_age on employee (name, dep_id, age);

-- 使用到了一个
explain
select *
from employee
where name = '鲁班';

-- 使用到了两个
explain
select *
from employee
where name = '鲁班'
  and dep_id = 1;

-- 使用到了三个
explain
select *
from employee
where name = '鲁班'
  and dep_id = 1
  and age = 10;

/*
 * 最佳左前缀法则:
 * 如果索引是多列字段, 要遵守最左前缀法则, 指的就是从索引的最左列开始, 并且不跳过索引中的列;
 */
-- 跳过第一个, 索引失效
explain
select *
from employee
where dep_id = 1
  and age = 10;

-- 跳过前两个, 索引失效
explain
select *
from employee
where age = 10;

-- 跳过中间一个, 只有第一个生效
explain
select *
from employee
where name = '鲁班'
  and age = 10;

-- 顺序可以乱
explain
select *
from employee
where age = 10
  and name = '鲁班'
  and dep_id = 1;

/*
 * 在索引字段上加函数计算导致索引失效:
 * 计算, 函数, 类型转换, 会导致索引失效而转向全表扫描;
 */
-- 正常状态(索引没失效)
explain
select *
from employee
where name = '鲁班';

-- 添加了运算, 索引失效
explain
select *
from employee
where trim(name) = '鲁班';

/*
 * 范围条件右边的索引失效:
 */
-- 正常状态(索引没失效)
explain
select *
from employee
where name = '鲁班'
  and dep_id = 1
  and age = 10;

-- 使用了范围, 由于是在索引(name, dep_id, age)中的第二个上使用了范围, 所以dep_id右边的索引失效(只使用了前两个)
explain
select *
from employee
where name = '鲁班'
  and dep_id > 1
  and age = 10;

/*
 * mysql在使用不等于(!=或者<>)的时候无法使用索引会导致全表扫描:
 */
-- 正常状态(索引没失效)
explain
select *
from employee
where name = '鲁班';

-- 使用了不等于, 索引失效
explain
select *
from employee
where name != '鲁班';

/*
 * is not null无法使用索引:
 */
explain
select *
from employee
where name is not null;

/*
 * 用or连接时, 会导致索引失效:
 */
explain
select *
from employee
where name = '鲁班'
   or dep_id = 1;

/*
 * like以通配符开头(%qw)索引失效变成全表扫描:
 */
-- 使用%开头, 索引失效
explain
select *
from employee
where name like '%鲁';

-- 使用%结尾, 索引没失效
explain
select *
from employee
where name like '鲁%';

-- 使用覆盖索引, 解决两边%导致索引失效
explain
select name, dep_id, age
from employee
where name like '%鲁%';

/*
 * 字符串不加引号索引失效:
 */
-- 字符串加了单引号, 索引没失效
explain
select *
from employee
where name = '200';

-- 字符串没加单引号, 索引失效
explain
select *
from employee
where name = 200;

/*
 * 尽量使用覆盖索引:
 * 覆盖索引, 即查询的字段和建立索引的字段刚好吻合(或者是索引字段的子集), 这种我们称为覆盖索引;
 * 上面提到的那些索引失效, 几乎都可以使用覆盖索引去解决;
 */
explain
select name, dep_id, age
from employee
where name = '鲁班'
  and dep_id = 1
  and age = 10;
