/*
 * ------------------权限------------------
 * 什么是权限:
 * 限制一个用户能够做什么事情，在MySQL中，可以设置全局权限，指定数据库权限，指定表权限，指定字段权限;
 *
 * 有哪些权限:
 * CREATE: 创建数据库、表或索引权限
 * DROP: 除数据库或表权限
 * ALTER: ALTER更改表，比如添加字段、索引等
 * DELETE: 删除数据权限
 * INDEX: 索引权限
 * INSERT: 插入权限
 * SELECT: 查询权限
 * UPDATE: 更新权限
 * CREATE VIEW: 创建视图权限
 * EXECUTE: 执行存储过程权限
 *
 * 创建用户:
 * create user '用户名'@'localhost' identified by '密码';
 *
 * 删除用户:
 * drop user 用户名称;
 *
 * 分配权限:
 * grant 权限 (columns) on 数据库对象 to 用户 identified by "密码" with grant option;
 * flush privileges;
 * (with grant option是指, 这个被授予权限的用户具不具备再给其他用户分配权限的能力)
 *
 * 创建对指定数据库的所有权限:
 * grant all privileges on 数据库名.* to 用户 identified by '密码' with grant option;
 * flush privileges;
 *
 * 创建一个超级管理员mylk, 密码为1234, 拥有所有权限, 并能继续授予权限:
 * create user 'mylk'@'localhost' identified by '1234';
 * grant all privileges on *.* to mylk@localhost identified by '1234' with grant option;
 * flush privileges;
 *
 * 查看权限:
 * show grants;
 * 查看指定用户的权限:
 * show grants for root@localhost;
 *
 * 删除权限
 * revoke 权限 on 数据库对象 from 用户;
 * flush privileges;
 */
