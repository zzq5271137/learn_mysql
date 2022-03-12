/*
 * 子查询:
 * 一个select语句中包含另一个完整的select语句, 或者两个以上的select语句, 就是子查询;
 *
 * 子查询可以出现的位置:
 * 1. where后, 把子查询的结果当做另一个select的条件值;
 * 2. from后, 把子查询的结果当做一个新表;
 */

-- 查询与项羽同部门的人
select ename
from emp
where deptno = (select deptno from emp where ename = '项羽');

-- 查询所有30号部门里薪资大于2000的人
select e.ename, e.salary
from (select * from emp where deptno = 30) e
where e.salary > 2000;

-- 查询工资高于程咬金的员工
select ename, salary
from emp
where salary >= (select salary from emp where ename = '程咬金');

-- 查询工资高于30号部门所有人的员工
select ename, salary, deptno
from emp
where salary > (select max(salary) from emp where deptno = 30);

-- 查询工作和工资与妲己完全相同的员工
-- 方式一
select ename, job, salary
from emp
where (job, salary) in (select job, salary from emp where ename = '妲己');
-- 方式二
select e.ename, e.job, e.salary
from emp e
         inner join (select * from emp where ename = '妲己') r
                    on e.job = r.job and e.salary = r.salary;

-- 查询有2个以上的直接下属的员工
select empno, ename
from emp
where empno in (select mgr from emp group by mgr having count(*) >= 2);

-- 查询有2个以上的直接下属的员工，并显示出每个人的下属数量
select e.empno, e.ename, h.count
from emp e
         inner join (select mgr, count(*) as count from emp group by mgr having count(*) >= 2) h
                    on e.empno = h.mgr;

-- 查询员工编号为7788的员工名称、工资、部门名称、部门地址
select e.ename, e.salary, d.dname, d.local
from emp e
         inner join dept d on e.deptno = d.deptno
where empno = 7788;

/*
 * 自连接:
 * 自己与自己连接, 起别名, 当成两张表;
 */
-- 查询员工编号为7369的员工姓名、上级编号和上级姓名
select e1.ename, e1.mgr as bossno, e2.ename as bossname
from emp e1
         inner join emp e2 on e1.mgr = e2.empno
where e1.empno = 7369;
