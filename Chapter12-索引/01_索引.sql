/*
 * --------------------索引--------------------
 * 什么是索引:
 * 索引用于快速找出在某个列中有一特定值的行;
 * 不使用索引, MySQL必须从第一条记录开始读完整个表, 直到找出相关的行;
 * 表越大, 查询数据所花费的时间就越多;
 * 如果表中查询的列有一个索引, MySQL能够快速到达一个位置去搜索数据文件,
 * 而不必查看所有数据, 那么将会节省很大一部分时间;
 *
 * 索引的优势与劣势:
 * 优势
 *   1. 类似大学图书馆建书目索引, 提高数据检索效率, 降低数据库的IO成本;
 *   2. 通过索引对数据进行排序, 降低数据排序的成本, 降低了CPU的消耗;
 * 劣势
 *   1. 实际上索引也是一张表, 该表保存了主键与索引字段, 并指向实体表的记录, 所以索引列也是要占空间的;
 *   2. 虽然索引大大提高了查询速度, 同时确会降低更新表的速度, 如对表进行insert、update、delete;
 *
 * 索引的分类:
 * 1. 单值索引
 *    即一个索引只包含单个列, 一个表可以有多个单列索引;
 * 2. 唯一索引
 *    索引列的值必须唯一, 但允许有空值(比如标记了unique的字段);
 * 3. 复合索引
 *    一个索引包含多个列;
 *    例如, INDEX MultiIdx(id,name,age)
 * 4. 全文索引
 *    只能在char,varchar,text类型字段上使用全文索引;
 * 5. 空间索引
 *    只有在MyISAM引擎上才能使用, 空间索引是对空间数据类型的字段建立的索引
 *
 * 索引操作:
 * 1. 创建索引
 *    create index 索引名称 on table (column[, column]...);
 *    例如, create index salary_index on emp(salary);
 * 2. 删除索引
 *    drop index 索引名称 on 表名;
 * 3. 查看索引
 *    show index from 表名;
 * 4. 自动创建索引
 *    a). 在表上定义了主键时, 会自动创建一个对应的唯一索引;
 *    b). 在表上定义了一个外键时, 会自动创建一个普通索引;
 *
 * explain:
 * 用来查看索引是否正在被使用, 并且输出其使用的索引的信息;
 * 例如: explain select * from newemp where id = 1 \G;
 *
 * 索引结构:
 * 1. 先会对数据进行排序
 * 2. B-Tree索引
 *    B+树索引, B+树是一个平衡的多叉树, 从根节点到每个叶子节点的高度差值不超过1, 而且同层级的节点间有指针相互链接;
 * 3. Hash索引
 *    哈希索引就是采用一定的哈希算法, 把键值换算成新的哈希值, 检索时不需要类似B+树那样从根节点到叶子节点逐级查找,
 *    只需一次哈希算法即可立刻定位到相应的位置, 速度非常快;
 *    Hash索引结构的特殊性, 其检索效率非常高, 索引的检索可以一次定位, 不像B-Tree索引需要从根节点到枝节点,
 *    最后才能访问到页节点这样多次的IO访问, 所以Hash索引的查询效率要远高于B-Tree索引;
 *    但是InnoDB引擎不支持hash索引, 只支持B-Tree索引;
 *
 * 哪些情况需要创建索引:
 * 1. 主键自动建立唯一索引;
 * 2. 频繁作为查询条件的字段应该创建索引;
 * 3. 查询中与其他表关联的字段, 外键关系建立索引(自动);
 * 4. 查询中排序的字段, 排序的字段若通过索引去访问将大大提高排序速度;
 * 5. 查询中统计或者分组字段;
 * 6. 频繁更新的字段不适合建立索引, 因为每次更新不单单是更新了记录还会更新索引;
 * 7. WHERE条件里用不到的字段不创建索引;
 *
 * 哪些情况不需要创建索引
 * 1. 表记录太少
 * 2. 经常增删改的表
 * 3. 如果某个数据列包含许多重复的内容，为它建立索引就没有太大的实际效果
 *
 * 详见: https://www.bilibili.com/video/BV1aE41117sk
 *      https://www.bilibili.com/video/BV1BJ411i7WR
 *      https://baijiahao.baidu.com/s?id=1708771812652657010&wfr=spider&for=pc
 *      https://www.bilibili.com/video/BV14v411z7M2
 *      https://blog.csdn.net/XueyinGuo/article/details/119222878
*       https://www.cnblogs.com/hld123/p/14150349.html
 */
