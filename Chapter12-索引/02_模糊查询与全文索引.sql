/*
 * 尽量不要使用 like 进行模糊查询。
 * 使用Ngram全文检索替代。
 *
 * ref：
 * 1. https://www.bilibili.com/video/BV1xv411G7Cv/?spm_id_from=333.788.recommend_more_video.4
 * 2. https://www.bilibili.com/video/BV1Qk4y1q75z?
 */

drop table if exists ngram_test;
create table ngram_test
(
    title varchar(40),
    fulltext (title) with parser ngram -- 创建全文索引
) default charset = utf8;

insert into ngram_test
values ('新闻是包含海量咨询的新闻服务平台'),
       ('真实反应每时每刻，的新闻热点'),
       ('搜索新闻事件、热点话题、人物动态'),
       ('Some like it hot, some like it cold'),
       ('Some like it in the pot'),
       ('Nine days old'),
       ('Pease porridge in the pot'),
       ('Pease porridage hot, pease orridge cold');

-- 查询结果默认会按照score倒序排列
select title, match(title) against('hot pot') as score
from ngram_test
where match(title) against('hot pot');

select title, match(title) against('新闻') as score
from ngram_test
where match(title) against('新闻');

-- 全文检索的模式：
-- 1. 自然语言模式（natural language mode）：是默认的检索模式，不能使用操作符，不能指定关键词必须出现或者不能出现等复杂的查询
-- 无操作符，表示或，要么出现'新闻'，要么出现'人物'
select title, match(title) against('新闻 人物' in natural language mode) as score
from ngram_test
where match(title) against('新闻 人物' in natural language mode);

-- 2. BOOLEAN模式（boolean mode）：BOOLEAN模式可以使用操作符
-- 必须同时包含'新闻'和'人物'
select title, match(title) against('+新闻 +人物' in boolean mode) as score
from ngram_test
where match(title) against('+新闻 +人物' in boolean mode);

-- 必须包含'新闻'，但如果也包含'人物'，那么相关性更高
select title, match(title) against('+新闻 人物' in boolean mode) as score
from ngram_test
where match(title) against('+新闻 人物' in boolean mode);

-- 必须包含'新闻'，但不能包含'人物'
select title, match(title) against('+新闻 -人物' in boolean mode) as score
from ngram_test
where match(title) against('+新闻 -人物' in boolean mode);

-- 必须包含'新闻'，但如果也包含'人物'，相关性要比不包含'人物'的低
select title, match(title) against('+新闻 ~人物' in boolean mode) as score
from ngram_test
where match(title) against('+新闻 ~人物' in boolean mode);

-- 必须包含'新闻'和'人物'或者'事件'，'人物'的相关性更高
select title, match(title) against('+新闻 +(>人物 <事件)' in boolean mode) as score
from ngram_test
where match(title) against('+新闻 +(>人物 <事件)' in boolean mode);

-- 查询以'新闻'开头的记录
select title, match(title) against('新闻*' in boolean mode) as score
from ngram_test
where match(title) against('新闻*' in boolean mode);

-- 使用双引号把要搜索的词括起来，类似于 like '%新闻%'
select title, match(title) against('"新闻"' in boolean mode) as score
from ngram_test
where match(title) against('"新闻"' in boolean mode);
