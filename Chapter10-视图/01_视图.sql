/*
 * ----------------------视图----------------------
 * 什么是视图:
 * 视图是一个虚拟表, 其内容由查询定义;
 * 同真实的表一样, 视图包含一系列带有名称的列和行数据;
 * 行和列数据来自定义视图的查询所引用的表, 并且在引用视图时动态生成;
 * 简单的来说视图是由select结果组成的表;
 *
 * 视图的特性:
 * 视图是对若干张基本表的引用, 一张虚表, 查询语句执行的结果,
 * 不存储具体的数据(基本表数据发生了改变, 视图也会跟着改变);
 * 可以跟基本表一样, 进行增删改查操作(增删改操作有条件限制);
 *
 * 视图的作用:
 * 1. 安全性
 *    创建一个视图, 定义好该视图所操作的数据, 之后将用户权限与视图绑定;
 *    这样的方式是使用到了一个特性: grant语句可以针对视图进行授予权限;
 * 2. 查询性能提高
 * 3. 提高了数据的独立性
 *
 * 创建视图:
 * create [algorithm]={undefined|merge|temptable}] view 视图名 [(属性清单)]
 * as select 语句
 * [with [cascaded|local] check option];
 *
 * algorithm参数(设置视图机制):
 * merge
 *     替换式, 可以进行更新真实表中的数据;
 * temptable
 *     具化式, 由于数据存储在临时表中, 所以不可以进行更新操作;
 * undefined
 *     没有定义algorithm参数;
 *     mysql更倾向于选择替换方式, 是因为它更加有效;
 *
 * with check option:
 * 更新数据时不能插入或更新不符合视图限制条件的记录;
 * local和cascaded:
 * 为可选参数, 决定了检查测试的范围, 默认值为cascaded;
 *
 * 视图机制:
 * 1. 替换式(merge)
 *    操作视图时, 视图名直接被视图定义给替换掉
 * 2. 具化式(temptable)
 *    mysql先得到了视图执行的结果, 该结果形成一个中间结果暂时存在内存中;
 *    外面的select语句就调用了这些中间结果(临时表);
 * 替换式与具化式区别:
 * 替换方式, 将视图公式替换后, 当成一个整体sql进行处理了;
 * 具体化方式, 先处理视图结果, 后处理外面的查询需求;
 *
 * 视图不可更新部分:
 * 1. 聚合函数;
 * 2. distinct关键字;
 * 3. group by子句;
 * 4. having子句;
 * 5. union运算符;
 * 6. from子句中包含多个表;
 * 7. select语句中引用了不可更新视图;
 * 总结一句话, 只要视图当中的数据不是来自于基表, 就不能够直接修改;
 */

-- 创建
create or replace algorithm = merge view emp_sal_view
as
(
select empno, ename, salary
from emp
where salary > 2000
    )
with check option;

create or replace algorithm = merge view emp_dep_sal_avg_view
as
(
select deptno, avg(salary)
from emp
group by deptno
    );

-- 查询
select *
from emp_sal_view
where ename = '项羽';

-- 删除
drop view emp_sal_view;
