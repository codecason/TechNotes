#### sql

```sql
CREATE TABLE temp1 (
    uid int,
    uzhi varchar(20)
);

SELECT * FROM temp1 LEFT JOIN temp2 on id = uid and uzhi = 2;
SELECT * FROM temp1 RIGHT JOIN temp2 on id = uid and uzhi = 2;
SELECT * FROM temp1 OUTER JOIN temp2 on id = uid and uzhi = 2;

SELECT * FROM temp1 OUTER JOIN temp2 as t2 on id = uid and uzhi = '2' where t2.uid = 2;

```

需要强调的是 ANY、ALL 关键字必须与一个比较操作符一起使用。因为如果你不使用比较操作符，就起不到集合比较的作用，那么使用 ANY 和 ALL 就没有任何意义。

2. JOIN 和UNION
JOIN是合并列

UNION是合并行

UNION是合并行,并且不去重

