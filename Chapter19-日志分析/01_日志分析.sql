/*
 * -------------------慢查询日志-------------------
 * 概述:
 * MySQL的慢查询日志是MySQL提供的一种日志记录, 它用来记录在MySQL中响应时间超过阀值的语句;
 * 具体指运行时间超过long_query_time值的SQL, 则会被记录到慢查询日志中;
 * long_query_time的默认值为10, 意思是运行10S以上的语句, 就会被认作是慢查询;
 * 默认情况下, Mysql数据库并不启动慢查询日志, 需要我们手动来设置这个参数;
 * 如果不是调优需要的话, 一般不建议启动该参数, 因为开启慢查询日志会或多或少带来一定的性能影响;
 * 慢查询日志支持将日志记录写入文件, 也支持将日志记录写入数据库表;
 *
 * 慢查询日志相关配置:
 * 1. 查看是否开启慢查询日志
 *    show variables like '%slow_query_log%';
 * 2. 开启
 *    set global slow_query_log = 1;
 *    只对当前数据库生效, 如果重启后, 则会失效;
 *    如果想要发永久生效, 必须要修改配置文件, 添加:
 *      a). slow_query_log=1
 *      b). slow_query_log_file=地址
 *
 * 详见xmind文档;
 */

/*
 * 模拟慢查询及查看慢查询日志
 */
-- 1. 查看当前慢查询阈值
show variables like 'long_query_time';
-- 2. 设置慢查询阈值
set global long_query_time = 4;
-- 3. 模拟慢查询
select sleep(5);
-- 4. 查询是否有日志
show global status like '%slow_queries%';
-- 5. 查看日志信息, 可以直接去看日志文件, 或者用mysqldumpslow工具进行查看分析

/*
 * -------------------Show Profile分析-------------------
 * 概述:
 * Show Profile是mysql提供的可以用来分析当前会话中sql语句执行的资源消耗情况的工具, 可用于sql调优的测量;
 * 把一条sql在mysql当中每一个环节耗费的时候都记录下来;
 * 默认该功能是关闭的, 使用前需开启, 默认保存最近15次运行的结果;
 *
 * 使用:
 * 1. 查看当前版本是否支持
 *    show variables like 'profiling';
 * 2. 打开profile
 *    set profiling = on;
 * 3. 查看结果
 *    show profiles;
 * 4. 诊断sql, queryId为你想分析的语句的id(通过show profiles查看)
 *    show profile cpu, block io for query queryId;
 *    当出现以下选项时, 要进行优化:
 *    a). Converting HEAP to MyIsAM: 查询结果太大, 内存都不够用了, 往磁盘上存了;
 *    b). Creating tmp table: 创建临时表, copy数据到临时表, 用完再进行删除;
 *    c). Copying to tmp table on disk: 把内存中临时表复制到磁盘, 危险操作;
 *    d). Locked: 被锁定;
 */

/*
 * -------------------全局查询日志-------------------
 * 概述:
 * 可以把所有执行的sql抓取出来查看;
 * 只允许在测试环境用, 不能在生产环境使用;
 *
 * 使用:
 * 1. 设置启用
 *    set global general_log = 1;
 *    set global log_output = 'TABLE';
 * 2. 此后所编写的sql语句将会记录到mysql库里的general_log表中
 *    select * from mysql.general_log;
 *    在Navicat中看不了具体语句, 需要去命令行查看, 解决乱码问题, 可以这么登录:
 *    mysql -uroot -pZZQ930603 --default-character-set=utf8
 */
