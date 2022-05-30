/*
 * ref:
 * 1. https://zhuanlan.zhihu.com/p/409561328
 * 2. https://blog.csdn.net/luobing_csdn/article/details/103156538
 */

CREATE TABLE sales
(
    employee VARCHAR(50)    NOT NULL,
    year     INT            NOT NULL,
    month    INT            NOT NULL,
    sale     DECIMAL(14, 2) NOT NULL,
    PRIMARY KEY (employee, year, month)
);

INSERT INTO sales(employee, year, month, sale)
VALUES ('Alice', 2016, 01, 100),
       ('Alice', 2016, 02, 100),
       ('Alice', 2016, 03, 100),
       ('Alice', 2017, 01, 130),
       ('Alice', 2017, 02, 130),
       ('Alice', 2017, 03, 130),
       ('Bob', 2016, 01, 110),
       ('Bob', 2016, 02, 110),
       ('Bob', 2016, 03, 110),
       ('Bob', 2017, 01, 120),
       ('Bob', 2017, 02, 120),
       ('Bob', 2017, 03, 120),
       ('John', 2016, 01, 200),
       ('John', 2016, 02, 200),
       ('John', 2016, 03, 200),
       ('John', 2017, 01, 150),
       ('John', 2017, 02, 150),
       ('John', 2017, 03, 150);

select a.*,
       sum(sales) over (partition by year order by month) total
from (
         select year, month, sum(sale) as sales
         from sales
         group by year, month) a;

select a.*,
       row_number() over (order by month) rank1,
       rank() over (order by month)       rank2,
       dense_rank() over (order by month) rank3
from (
         select year, month, sum(sale) as sales
         from sales
         group by year, month) a;