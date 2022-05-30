/*
 * ------------------explain------------------
 * 查询执行计划:
 * 使用explain关键字, 可以模拟优化器执行的SQL语句, 从而知道MYSQL是如何处理sql语句的;
 * 通过explain可以分析查询语句或表结构的性能瓶颈;
 *
 * 作用
 * 1. 查看表的读取顺序
 * 2. 数据读取操作的操作类型
 * 3. 查看哪些索引可以使用
 * 4. 查看哪些索引被实际使用
 * 5. 查看表之间的引用
 * 6. 查看每张表有多少行被优化器执行
 *
 * 使用方法:
 * explain sql语句;
 *
 * 分析包含信息:
 * 1. id
 * 2. select_type
 * 3. table
 * 4. partitions
 * 5. type
 * 6. possible_keys
 * 7. key
 * 8. key_len
 * 9. ref
 * 10. rows
 * 11. filtered
 * 12. extra
 *
 * 详见xmind文档
 */

/*
 * explain: id
 * 作用: select查询的序列号, 包含一组数字, 表示查询中执行select子句或操作表的顺序;
 * 结果值, 三种情况:
 * 1. id相同
 *    执行顺序由上到下;
 * 2. id不同
 *    如果是子查询, id的序号会递增, id值越大优先级越高, 优先被执行;
 * 3. id相同不同, 同时存在
 *    可以认为是一组, 从上往下顺序执行;
 *    在所有组中, id值越大, 优先级越高, 越先执行;
 *    derived是衍生出来的虚表;
 */
-- id相同
explain
select *
from employee e,
     department d,
     customer c
where e.dep_id = d.id
  and e.cus_id = c.id;

-- id不同
explain
select *
from department
where id = (select id from employee where id = (select id from customer where id = 1));

-- id有相同有不同
EXPLAIN
select *
from department d,
     (select dep_id from employee group by dep_id) t
where d.id = t.dep_id;

/*
 * explain: select_type
 * 作用: 查询类型, 主要用于区别普通查询, 联合查询, 子查询等复杂查询;
 * 结果值:
 * 1. SIMPLE
 *    简单select查询, 查询中不包含子查询或者union;
 * 2. PRIMARY
 *    查询中若包含任何复杂的子查询, 最外层查询则被标记为PRIMARY;
 * 3. SUBQUERY
 *    在select或where中包含的子查询;
 * 4. DERIVED
 *    在from列表中包含的子查询被标记为derived(衍生), 把结果放在临时表当中;
 * 5. UNION
 *    若第二个select出现在union之后,则被标记为union;
 *    若union包含在from子句的子查询中, 外层select将被标记为deriver;
 * 6. UNION RESULT
 *    从union获取的结果;
 *    两个union合并的结果集在最后;
 */
-- select_type: SIMPLE
explain
select *
from employee e,
     department d,
     customer c
where e.dep_id = d.id
  and e.cus_id = c.id;

-- select_type: PRIMARY, SUBQUERY
explain
select *
from department
where id = (select id from employee where id = (select id from customer where id = 1));

-- select_type: PRIMARY, DERIVED
EXPLAIN
select *
from department d,
     (select dep_id from employee group by dep_id) t
where d.id = t.dep_id;

-- select_type: UNION, UNION RESULT
explain
select *
from employee e
         left join department d on e.dep_id = d.id
union
select *
from employee e
         right join department d on e.dep_id = d.id;

/*
 * explain: table
 * 作用: 显示这一行的数据是关于哪张表的;
 */

/*
 * explain: partitions
 * 作用: 如果查询是基于分区表的话, 会显示查询访问的分区;
 */

/*
 * explain: type
 * 作用: 访问类型排列;
 * 结果值(从最好到最差):
 * 1. system
 *    表中只有一行记录(系统表), 这是const类型的特例, 平时不会出现;
 * 2. const
 *    表示通过索引一次就找到了;
 *    const用于比较primary或者unique索引, 直接查询主键或者唯一索引;
 *    因为只匹配一行数据,所以很快;
 * 3. eq_ref
 *    唯一性索引扫描;
 *    对于每个索引键, 表中只有一条记录与之匹配;
 *    常见于主键或唯一索引扫描;
 * 4. ref
 *    非唯一性索引扫描, 返回匹配某个单独值的所有行;
 *    本质上也是一种索引访问;
 *    它返回所有匹配某个单独值的行;
 *    可能会找到多个符合条件的行, 所以它应该属于查找和扫描的混合体;
 * 5.range
 *   只检索给定范围的行, 使用一个索引来选择行;
 *   key列显示使用了哪个索引;
 *   一般就是在你的where语句中出现between, <, >, in等查询;
 *   这种范围扫描索引比全表扫描要好;
 *   因为它只需要开始于索引的某一点.而结束语另一点;
 *   不用扫描全部索引;
 * 6. index
 *    Full Index Scan;
 *    index与All区别为index类型只遍历索引树, 通常比All要快, 因为索引文件通常比数据文件要小;
 *    all和index都是读全表, 但index是从索引中读取, all是从硬盘当中读取;
 * 7. ALL
 *    将全表进行扫描, 从硬盘当中读取数据;
 *    如果出现了all且数据量非常大, 一定要去做优化;
 * 要求
 * 一般来说, 保证查询至少达到range级别, 最好能达到ref;
 */
-- type: const
explain
select *
from employee
where id = 1;

-- type: eq_ref
explain
select *
from employee e,
     department d
where e.dep_id = d.id;

-- type: ref(给employee表中的dep_id设置了一个索引)
explain
select e.dep_id
from employee e,
     department d
where e.dep_id = d.id;

-- type: range
explain
select *
from employee
where id > 2;

-- type: index
explain
select id
from employee;

-- type: ALL
explain
select *
from employee;

/*
 * explain: possible_keys
 * 作用: key与possible_keys主要作用, 是查看是否使用了建立的索引, 也即判断索引失效;
 *      显示可能应用在这张表中的索引, 一个或者多个;
 *      查询涉及到的字段上若存在索引, 则该索引将被列出, 但不一定被查询实际使用;
 *      可能自己创建了4个索引, 在执行的时候, 可能根据内部的自动判断, 只使用了3个;
 *
 * explain: key
 * 作用: 实际使用的索引, 如果为NULL, 则没有使用索引;
 *      查询中若使用了覆盖索引, 则该索引仅出现在key列表中;
 *
 * possible_keys与key关系:
 * possible_keys是理论应该用到哪些索引, key是实际用到了哪些索引;
 * 覆盖索引: 查询的字段和建立索引的字段刚好吻合, 这种我们称为覆盖索引;
 */
explain
select dep_id
from employee;

explain
select *
from employee e,
     department d
where e.dep_id = d.id;

explain
select e.dep_id, d.id
from employee e,
     department d
where e.dep_id = d.id;

/*
 * explain: key_len
 * 作用: 表示索引中使用的字节数, 可通过该列计算查询中使用的索引长度;
 */
-- 在employee表中创建了一个(name, age)的复合索引, 在此次查询中用到了此复合索引
-- key_len = 68
explain
select *
from employee
where name = '鲁班'
  and age = 10;

-- 用到了复合索引, 因为复合索引(name, age)中的第一个字段是name
-- key_len = 63, 比上面的少, 因为只用到了复合索引中的第一个字段
explain
select *
from employee
where name = '鲁班';

-- 没用到复合索引, 因为复合索引(name, age)中的第一个字段是name
explain
select *
from employee
where age = 10;

/*
 * explain: ref
 * 作用: 索引引用的情况, 引用索引的是一个常量? 还是别的表的字段值? 是别的表的哪一个字段?
 */
-- department表的主键索引被引用, 引用它的是employee表中的dep_id字段(因为where条件)
explain
select *
from employee e,
     department d
where e.dep_id = d.id
  and e.cus_id = 1;

-- 用到了表中的(name, age)索引, ref为(const, const), 因为where条件中, 两个值都是常量
explain
select *
from employee
where name = '鲁班'
  and age = 10;

-- 自行分析
explain
select *
from employee e,
     department d,
     customer c
where e.dep_id = d.id
  and e.cus_id = c.id
  and e.name = '鲁班';

-- 自行分析
explain
select c.name
from customer c,
     employee e
where e.name = c.name
  and e.dep_id = 1;

/*
 * explain: rows
 * 作用: 根据表统计信息及索引选用情况, 大致估算出找到所需的一条记录所需要读取的行数;
 *      每张表有多少行被优化器查询过;
 */
explain
select *
from employee e,
     department d
where e.dep_id = d.id;

/*
 * explain: filtered
 * 作用: 满足查询的记录数量的比例, 即由存储引擎返回的数据经过过滤后满足条件的比例，注意是百分比, 不是具体记录数;
 *      值越大越好, filtered列的值依赖统计信息, 并不十分准确;
 */
explain
select *
from employee e,
     department d
where e.dep_id = d.id;

/*
 * explain: Extra
 * 产生的值:
 * 1. Using filesort
 *    说明mysql会对数据使用一个外部的索引排序, 而不是按照表内的索引顺序进行
 *    Mysql中无法利用索引完成排序操作称为"filesort(文件排序)";
 *    如果碰到这种情况, 就要立马对它做优化;
 * 2. Using temporary
 *    使用了临时表保存中间结果, Mysql在对查询结果排序时, 使用了临时表;
 *    常见于排序orderby和分组查询group by;
 * 3. Using index
 *    表示相应的select中使用了覆盖索引, 避免访问了表的数据行, 效率很好;
 *    如果同时出现Using where表明索引被用来执行索引键值的查找(即需要回表查询);
 *    如果没有同时出现Using where表明直接从索引读取数据而非执行查找动作(即不需要回表查询);
 * 4. Using where
 *    表明使用了where过滤(需要回表查询);
 *    Using index和Using where总结:
 *    有Using index说明直接从索引读取数据, 有Using where说明需要根据where条件回表查询;
 * 5. Using join buffer
 *    使用了连接缓存;
 * 6. Impossible where
 *    where子句的值总是false, 不能用来获取任何元组;
 */
-- Extra: Using filesort
explain
select *
from employee
where name = '鲁班'
order by cus_id;
