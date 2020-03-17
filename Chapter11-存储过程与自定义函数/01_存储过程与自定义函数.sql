/*
 * ----------------------存储过程----------------------
 * 什么是存储过程:
 * 一组可编程的函数, 是为了完成特定功能的SQL语句集;
 * 经编译创建并保存在数据库中, 用户可通过指定存储过程的名字并给定参数(需要时)来调用执行;
 * 存储过程就是具有名字的一段代码, 用来完成一个特定的功能;
 * 创建的存储过程保存在数据库的数据字典中;
 *
 * 为什么要用存储过程:
 * 1. 将重复性很高的一些操作, 封装到一个存储过程中, 简化了对这些SQL的调用;
 * 2. 批量处理;
 * 3. 统一接口, 确保数据的安全;
 * 4. 相对于oracle数据库来说, MySQL的存储过程相对功能较弱, 使用较少;
 *
 * delimiter $$:
 * 它与存储过程语法无关;
 * delimiter语句将标准分隔符-分号(;)更改为: $$;
 * 因为我们想将存储过程作为整体传递给服务器, 而不是让mysql工具一次解释每个语句;
 * 告诉mysql解释器, 该段命令是否已经结束了, mysql是否可以执行了;
 * 默认情况下, delimiter是分号(;)
 * 在命令行客户端中, 如果有一行命令以分号结束, 那么回车后, mysql将会执行该命令;
 * 但有时候, 不希望MySQL这么做, 因为可能输入较多的语句, 且语句中包含有分号,
 * 所以使用delimiter $$, 这样只有当$$出现之后, mysql解释器才会执行这段语句;
 *
 * 创建存储过程:
 * create procedure 名称()
 * begin
 * 语句
 * end $$
 *
 * 调用存储过程:
 * call 名称();
 *
 * 查看存储过程:
 * 1. 查看所有存储过程
 *    show procedure status;
 * 2. 查看指定数据库中的存储过程
 *    show procedure status where db = 'learnmysql';
 * 3. 查看指定存储过程源代码
 *    show create procedure 存储过程名;
 *
 * 删除存储过程:
 * drop procedure 名称;
 *
 * 存储过程变量:
 * 1. 在存储过程中声明一个变量, 使用declare语句
 *    语法: declare 变量名 数据类型(大小) default 默认值;
 *    例如, 可以声明一个名为total_sale的变量, 数据类型为INT, 默认值为0
 *        declare total_sale int default 0;
 *    声明共享相同数据类型的两个或多个变量
 *        declare x, y int default 0;
 * 2. 分配变量值
 *    a). 可以使用set语句:
 *        set total_count = 10;
 *    b). 使用select into语句将查询的结果分配给一个变量:
 *        select count(*) into total_products from products
 * 3. 变量的范围
 *    如果在存储过程中声明一个变量, 那么当达到存储过程的END语句时, 它将超出范围, 因此在其它代码块中无法访问;
 *
 * 存储过程参数:
 * 1. 参数有三种类型, 传入值可以是字面量或变量:
 *    a). in
 *        表示调用者向过程传入值
 *    b). out
 *        表示过程向调用者传出值
 *    c). inout
 *        inout参数是in和out参数的组合。
 * 2. 定义参数
 *    create produce name(类型 参数名称 数据类型(大小))
 * 例如: create procedure get_sal_by_name(in targetName varchar(255), out salary int)
 *
 * 存储过程语句:
 * 1. if语句
 *    if expression then
 *        statements;
 *    else
 *        else-statements;
 *    end if;
 * 2. case语句
 *    case case_expression
 *        when when_expression_1 then commands;
 *        when when_expression_2 then commands;
 *        ...
 *        else commands;
 *    end case;
 * 3. 循环
 * (1). while expression do
 *          statements;
 *      end while;
 * (2). repeat
 *          statements;
 *      until expression
 *      end repeat;
 */

-- 创建
delimiter $$
create procedure show_emp()
begin
    select * from emp;
end $$
delimiter ;

-- 调用
call show_emp();

-- 查看
show procedure status;
show procedure status where db = 'learnmysql';
show create procedure show_emp;

-- 删除
drop procedure show_emp;

-- 变量
delimiter $$
create procedure test()
begin
    -- 声明
    declare avgRes double default 0;
    declare x,y int default 0;
    -- 赋值
    set x = 3;
    select avg(salary) into avgRes from emp;
end $$
delimiter ;

-- 参数: in类型
delimiter $$
create procedure get_by_name(in targetName varchar(255))
begin
    select * from emp where ename = targetName;
end $$
delimiter ;

call get_by_name('项羽');

-- 参数: out类型
delimiter $$
create procedure get_sal_by_name(in targetName varchar(255), out salary int)
begin
    select e.salary into salary from emp as e where e.ename = targetName;
end $$
delimiter ;

-- @salary是与当前session绑定的
call get_sal_by_name('鲁班', @salary);
select @salary;

-- 参数: inout类型
delimiter $$
create procedure add_num(inout num int, in inc int)
begin
    set num = num + inc;
end $$
delimiter ;

set @num1 = 20; -- 在存储过程外定义变量, 是与当前session绑定的
set @num2 = 10;
call add_num(@num1, @num2);
select @num1;

/*
 * 自定义函数
 */
-- 定义函数前, 先执行这个
set global log_bin_trust_function_creators = TRUE;

-- 定义一个函数, 随机生成指定长度的字符串
delimiter $$
create function rand_str(len int) returns varchar(255)
begin
    declare str varchar(100) default 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    declare i int default 0;
    declare res varchar(255) default '';
    while i < len
        do
            set res = concat(res, substr(str, floor(1 + rand() * 52), 1));
            set i = i + 1;
        end while;
    return res;
end $$
delimiter ;

-- 调用函数
select rand_str(5);

/*
 * 运用存储过程构建千万条数据
 */
delimiter $$
create procedure insert_emp(in startNum int, in amount int)
begin
    declare i int default 0;
    -- 默认情况下, 是自动提交sql的, 也就是每循环一次, 就插入一条, 这是非常慢的
    set autocommit = 0; -- 设置一下autocommit = 0, 它就不会自动提交了, 我们需要手动提交
    repeat
        set i = i + 1;
        -- 插入一条数据, name为长度5的随机字符串, age为10到30的随机数
        insert into newemp values (startNum + i, rand_str(5), floor(10 + rand() * 30));
    until i = amount
        end repeat;
    commit; -- 一次性提交所有的插入语句, 会大大的提高插入效率
end $$
delimiter ;

-- 执行插入数据, 插入一千万条
call insert_emp(0, 10000000);
