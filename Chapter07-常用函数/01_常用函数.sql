/*
 * --------------字符串函数--------------
 * 1. concat(s1,s2...sn):
 *	  将传入的字符连接成一个字符串, 任何字符串与null进行连接结果都是null;
 * 2. insert(str,x,y,instr):
 *    将字符串str从x位置开始, y个字符长的子串替换为instr;
 * 3. lower(str)和upper(str):
 *    将字符串转成小写或大写;
 * 4. left(str,x)和right(str,x):
 *    分别返回字符串最左边的x个字符和最右边的x个字符, 如果第二个参数为null, 那么不返回任何字符;
 * 5. lpad(str,n,pad)和rpad(str,n,pad):
 *    用字符串pad对str最左边或最右边进行填充, 直接到长度为n个字符长度;
 * 6. ltrim(str)和rtrim(str):
 *    去掉字符串当中最左侧和最右侧的空格;
 * 7. trim(str):
 *    去掉字符串左右的空格;
 * 8. repeat(str,x):
 *    返回str重复x次的结果;
 * 9. replace(str,a,b):
 *    用字符串b替换字符串str中所有出现的字符串a;
 * 10. SUBSTRING(str,x,y):
 *     返回字符串str中第x位置起y个字符长度的字符;
 */
select concat('aa', 'bb', 'cc', null);
select insert('zhu123', 1, 3, 'feiwu');
select rpad('my', 5, '123456');

/*
 * --------------数值函数--------------
 * 1. abs(x):
 *    返回X的绝对值;
 * 2. ceil(x):
 *    小数不为零部分上取整, 即向上取最近的整数;
 * 3. floor(x):
 *    小数部分下取整, 即向下取最近的整数;
 * 4. mod(X,Y):
 *    返回X/Y的模;
 * 5. rand():
 *    返回0-1内容的随机值;
 */
select ceil(2.3);
select floor(2.3);
select floor(rand() * 10);

/*
 * --------------日期和时间函数--------------
 * 1. curdate():
 *    返回当前日期, 只包含年月日;
 * 2. curtime():
 *    返回当前时间, 只包含时分秒;
 * 3. now():
 *    返回当前日期和时间, 年月日时分秒都包含;
 * 4. unix_timestamp:
 *    返回当前日期的时间戳;
 * 5. from_unixtime(unixtime):
 *    将一个时间戳转换成日期;
 * 6. week(date):
 *    返回当前是一年中的第几周;
 * 7. year(date):
 *    返回所给日期是那一年;
 * 8. hour(time):
 *    返回当前时间的小时;
 * 9. minute(time):
 *    返回当前时间的分钟;
 * 10. date_format(date,fmt):
 *     按字符串格式化日期date值;
 * 11. date_add(date,interval expr type):
 *     计算日期间隔;
 * 12. datediff(date1,date2):
 *     计算两个日期相差的天数;
 */
select now();
select from_unixtime(unix_timestamp());
select date_format(now(), '%M,%D,%Y');
select date_add(now(), interval -3 day);
select datediff('2020-03-13', now());

/*
 * --------------流程函数--------------
 * 1. if(value,t,f):
 *    如果value是真，返回t,否则返回f;
 * 2. ifnull(value1,value2):
 *    如果value1不为空, 返回value1否者返回value2;
 * 3. case when then end
 */
select if(salary > 5000, '经理', '普通员工')
from emp
where ename = '李白';

select case when 2 > 3 then '对' else '错' end;

/*
 * --------------系统相关函数--------------
 * 1. database():
 *    返回当前数据库名;
 * 2. version():
 *    返回当前数据库版本;
 * 3. user():
 *    返回当前登陆用户名;
 * 4. password(str):
 *    对str进行加密;
 * 5. md5(str):
 *    返回str的MD5值;
 */
select database();
select version();
select md5('zzq');
