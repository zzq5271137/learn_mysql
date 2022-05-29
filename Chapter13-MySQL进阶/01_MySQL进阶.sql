/*
 * ----------------Mysql逻辑架构----------------
 * 总体分层:
 * 1. 连接层
 * 2. 服务层/业务层
 * 3. 引擎层
 * 4. 存储层
 *
 * 详情查看xmind文档;
 */

/*
 * ----------------存储引擎----------------
 * 详情查看xmind文档;
 */

/*
 * ----------------sql执行顺序----------------
 * 1. 编写顺序
 * 2. 读取顺序
 *
 * 详情查看xmind文档;
 */

/*
 * ----------------join连接----------------
 * 1. 内连接
 *    作用: 查询两张表的共有部分
 *    语句: select <select_list> from tableA A inner join tableB B on A.key = B.key;
 * 2. 左连接
 *    作用: 把左边表的内容全部查出, 右边表只查出满足条件的记录
 *    语句: select <select_list> from tableA A left join tableB B on A.key = B.key;
 * 3. 右连接
 *    作用: 把右边表的内容全部查出, 左边表只查出满足条件的记录
 *    语句: select <select_list> from tableA A right join tableB B on A.key = B.key;
 * 4. 查询左表独有数据
 *    作用: 查询A的独有数据
 *    语句: select <select_list> from tableA A left join tableB B on A.key = B.key where B.key is null;
 * 5. 查询右表独有数据
 *    作用: 查询B的独有数据
 *    语句: select <select_list> from tableA A right join tableB B on A.key = B.key where A.key is null;
 * 6. 全连接
 *    作用: 查询两个表的全部信息
 *    语句: select <select_list> from tableA A full outter join tableB B on A.key = B.key;
 *    注: MySQL默认不支持此种写法, Oracle支持; 在MySQL中想要使用全连接, 需要左连接和右连接做union
 * 7. 查询左右表各自的独有数据
 *    作用: 查询A和B各自的独有的数据
 *    语句: select <select_list> from tableA A full outter join tableB B on A.key = B.key where A.key is null or B.key is null;
 *
 * 详情查看xmind文档;
 *
 * 资料：
 * 1. mysql页结构：https://www.modb.pro/db/139052
 * 2. mysql行格式：https://www.modb.pro/db/135390
 * 3. mysql底层：https://www.bilibili.com/video/BV14v411z7M2?p=1
 */
