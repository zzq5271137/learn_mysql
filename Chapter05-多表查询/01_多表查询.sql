/*
 * 合并结果集
 * 就是把两个select语句的查询结果合并到一起;
 *
 * 合并结果集的两种方法:
 * 1. union: 合并时去除重复记录;
 *    格式: select * from table1 union select * from table2
 * 2. union all: 合并时不去除重复记录;
 *    格式: select * from table1 union all select * from table2
 * 使用union和union all的注意事项: 两张表的列数、列类型必须相同
 */
select *
from a
union
select *
from b;

select *
from a
union all
select *
from b;

/*
 * 笛卡尔积:
 * 查询时, 如果直接查询两张表, 默认是出现笛卡尔积, 即两表相乘
 */
select *
from person,
     car;

/*
 * 去除笛卡尔积:
 * 查询时, 让主键和外键保持一致, 即99查询
 */
select *
from person p,
     car c
where p.pid = c.pid;

/*
 * 内连接: 等值连接
 * 只会查询出主外键匹配的记录(如果有些记录的外键是空的, 不会查出)
 */
select *
from person p
         inner join car c on p.pid = c.pid;

/*
 * 外连接: 左外连接
 * 会查出左边表的所有记录(即使有些记录没有外键匹配)和右边表的匹配记录
 */
select *
from person p
         left join car c on p.pid = c.pid;

/*
 * 外连接: 右外连接
 * 会查出右边表的所有记录(即使有些记录没有外键匹配)和左边表的匹配记录
 */
select *
from person p
         right join car c on p.pid = c.pid;

/*
 * 内连接: 多表连接
 * 同时查询多张表, 有99查询和内连接等值查询(inner join)两种写法
 */
-- 使用99查询
select p.pname, c.cname, c.ccolor, coun.countryName
from person p,
     car c,
     country coun
where c.pid = p.pid
  and c.countryId = coun.countryId;

-- 使用内连接等值查询(inner join)
select p.pname, c.cname, c.ccolor, coun.countryName
from person p
         inner join car c
                    on p.pid = c.pid
         inner join country coun
                    on c.countryId = coun.countryId;

/*
 * 内连接: 非等值连接(使用inner join或99连接都可以)
 */
select e.ename, e.salary, d.dname, g.grade
from emp e
         inner join dept d
                    on e.deptno = d.deptno
         inner join salgrade g
                    on e.salary between g.lowSalary and g.highSalary;

/*
 * 内连接: 自然连接
 * 连接会产生无用的笛卡尔积, 我们通常使用主外键关系等式去去除它;
 * 而自然连接无需你去主动给出主外键等式, 它会自动找到这一等式, 也就是说不需要去写连接条件;
 * 但是使用它有要求:
 * 1. 两张连接的表中列名称和类型完全一样的列作为条件
 *    a). 如果找不到, 就会产生笛卡尔积;
 *    b). 如果找到多组列都是名称和类型一样, 那么它会匹配全部;
 * 2. 会去除相同的列;
 */
select *
from emp e
         natural join dept d;
