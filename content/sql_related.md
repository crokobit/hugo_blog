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

2. Config
  - Ram Usage 
    - OS Usage: Kernel, running processes, filesystem cache, etc.
    - MySQL fixed usage: query cache, InnoDB buffer pool size, mysqld rss, etc.
    - MySQL workload based usage: connections, per-query buffers (join buffer, sort buffer, etc.)
    - MySQL replication usage:  binary log cache, replication connections, Galera gcache and cert index, etc.
    - Any other services on the same server: Web server, caching server, cronjobs, etc.
  - InnoDB setting.
    - Rule of Thumb: 80% of your memory.
    - a better rule of thumb?  My rule is that you tune the `innodb_buffer_pool_size` as large as possible without using swap when the system is running the production workload.  This sounds good in principle, but again, it requires a bunch of restarts and may be easier said than done.
  - InnoDB
    - Need warm up.
  - Close Query Cache to improve performance.

3. Some way to improve performance.
  - view
    - can set up query as a view. Then we can treat it as a table.
    - some rails way example.
    - need to update value if related value is change. save in RAM.
  - Analyse table

4. benchmark SOP
  - Need to set up a SOP as a base of tunning db.
  - Need to run the test case several times until its performance is stable. (Because Mysql have cache system)

5. c.f.
  - High Performance Mysql 3rd
