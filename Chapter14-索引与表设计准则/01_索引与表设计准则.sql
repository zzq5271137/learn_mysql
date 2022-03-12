/*
 * 重点学习:
 * 1. 如果写出高质量的sql
 * 2. 如果保证索引不失效
 */

/*
 * -------------------索引-------------------
 * 详见xmind文档
 */

/*
 * -------------------性能分析-------------------
 * 表设计准则:
 * 1. 满足关系数据库的三范式
 *    a). 1NF
 *        是指数据库表的每一列都是不可分割的基本数据项, 同一列中不能有多个值;
 *        第一范式(1NF)是对关系模式的基本要求, 不满足第一范式(1NF)的数据库就不是关系数据库;
 *    b). 2NF
 *        要求数据库表中的每个实例或行必须可以被惟一地区分;
 *        设置主键;
 *    c). 3NF
 *        要求一个数据库表中不包含已在其它表中已包含的非主关键字信息
 *        两张表不要重复的字段, 通常都是设置外键;
 * 有的时候我们也会采用反第三范式的设计，就是不设置外健，而是把其他表的非主键字段也放到表中，这样做是因为，当这些其他表的字段会被经常访问时，这样做可以减少联表查询。
 *
 * 2. 大表拆小表, 有大数据的列单独拆成小表
 *    在一个数据库中, 一般不会设计属性过多的表;
 *    在一个数据库中, 一般不会有超过500/1000万数据的表, 拆表;
 *    有大数据的列单独拆成小表(富文本编辑器, CKeditor);
 *
 * 详见xmind文档
 */

/*
 * -------------------DQL的执行过程-------------------
 * 这里DQL的执行过程, 不是指DQL语句的解析过程, 而是客户端向数据库发送一条DQL语句, 它整个经历的过程;
 *
 * 详见xmind文档
 */
