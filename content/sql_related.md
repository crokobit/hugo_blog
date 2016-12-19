+++
date = "2016-12-19T15:50:01+08:00"
draft = true
title = "sql_related"

+++

How To Optimized ?

0. Syntax
  - [](https://arm1.ru/img/uploaded/shmargalka-po-join-v-mysql.jpeg)
  - [](http://stevestedman.com/wp-content/uploads/MySqlJoinTypesThumbnail-774x1024.png)

1. Use `explain` to check the index usage for specific query.
  - if you have 'using temporary table' in explain output. You may have subquery in your sql.
  - Can find the losing index.
  - Optimizer will decide whether using index or not.
  - [examples](http://www.slideshare.net/phpcodemonkey/mysql-explain-explained)

2. InnoDB setting.
  - Rule of Thumb: 80% of your memory.
  - Or Bigger than the frequently use data set.

3. Some way to improve performance.
  - view
    - can set up query as a view. Then we can treat it as a table.
    - some rails way example.
    - need to update value if related value is change. save in RAM.
  - Analyse table
