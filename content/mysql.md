+++
date = "2016-11-22T10:47:26+08:00"
draft = true
title = "mysql"

+++

# TODO
- warm up behaviour? 

- `innodb_buffer_pool_size`
  - what is it for?

- FROM MASON, run `visits_activities` table, query that table for comparing db1, db3 performance.

    https://blog.marceloaltmann.com/en-warm-up-innodb-buffer-pool-pt-esquentando-o-innodb-buffer-pool/

    https://blog.gslin.org/archives/2013/11/20/3876/%E7%86%B1-mysql-innodb-%E7%9A%84%E6%96%B9%E5%BC%8F/

    Same as mongodb, Mysql save the data or index to RAM when used.
  - how to determine its size?


- What warm up time is needed for a system.
  - will it be warm up if do nothing to the db?
  - Warm up is per whole db or per table/operation.

- Filter out reports which is no needed to tune.

- What report is suitable as tuning basis.

- How to set up a standard for allowable latency for every report?

- Parameters which may affect performance.
  - Query Cache on or off
  - `innodb_buffer_pool_size`
  - Passenger worker which comsumes high CPU or RAM

- temp table
  - use what RAM?

- [link](https://www.percona.com/blog/2015/06/02/80-ram-tune-innodb_buffer_pool_size/)
  - `innodb_buffer_pool_size` 80% rule of thumb is not always right.
  - RAM usages
    - OS Usage: Kernel, running processes, filesystem cache, etc.
    - MySQL fixed usage: query cache, InnoDB buffer pool size, mysqld rss, etc.
    - MySQL workload based usage: connections, per-query buffers (join buffer, sort buffer, etc.)
    - MySQL replication usage:  binary log cache, replication connections, Galera gcache and cert index, etc.
    - Any other services on the same server: Web server, caching server, cronjobs, etc.
  - So what’s a better rule of thumb?  My rule is that you tune the innodb_buffer_pool_size as large as possible without using swap when the system is running the production workload.  This sounds good in principle, but again, it requires a bunch of restarts and may be easier said than done.
    - Mysql 5.7 can set that without restarting server. https://dev.mysql.com/doc/refman/5.7/en/innodb-buffer-pool-online-resize.html

- [link](https://www.percona.com/blog/2007/11/03/choosing-innodb_buffer_pool_size/)
  -  You need buffer pool a bit (say 10%) larger than your data (total size of Innodb TableSpaces) because it does not only contain data pages – it also contain adaptive hash indexes, insert buffer, locks which also take some time.
  - Another thing you should keep into account is Innodb allocates more memory in structures related to buffer pool than you specify for it. make sure to leave space for other MySQL needs while factoring this in.
  -  Idle connections for example will consume significantly less memory than connections doing work with huge temporary tables and otherwise running complex queries. It is usually much better to simply check it. Start MySQL With 10GB Innodb buffer pool for example and see how large RSS and VSZ get in “ps” output on Unix Systems. If it gets to 12GB when you need 2GB for other stuff, and you can increase it a bit to be on the safe size and scale appropriately. 
  - The third important memory consumer would be OS cache. You want to bypass cache for your Innodb tables but there are other things you need OS cache for – MyISAM tables (mysql database, temporary etc) will need it, .frm file, binary logs, or relay logs, Innodb Transactional Logs also like to be cached otherwise OS will need to do reads to serve writes to these log files as IO to the log files is not aligned to the page boundary. Finally you likely have some system script/processes running on the system which also need some cache. The number can be a lot different depending on system workload but generally I’d see values from 200MB to 1GB good estimates for this number.
  - I could tell you some numbers, for example sum up all your global buffers plus add 1MB for each connection you’re planning to have but in reality the number can vary significantly depending on the load. Idle connections for example will consume significantly less memory than connections doing work with huge temporary tables and otherwise running complex queries. It is usually much better to simply check it. Start MySQL With 10GB Innodb buffer pool for example and see how large RSS and VSZ get in “ps” output on Unix Systems. If it gets to 12GB when you need 2GB for other stuff, and you can increase it a bit to be on the safe size and scale appropriately.
    - (global buffers + 1MB) * connections counts
    - Idle connections for example will consume significantly less memory than connections doing work with huge temporary tables and otherwise running complex queries.
    - RSS and VSZ get in “ps” output on Unix Systems.
  - OS cache
    - MyISAM tables (mysql database, temporary etc) 
    - .frm file, binary logs, or relay logs, Innodb Transactional Logs also like to be cached otherwise OS will need to do reads to serve writes to these log files as IO to the log files is not aligned to the page boundary. 
  - system script/processes running on the system which also need some cache
  - Make sure however the swapping is not happening ie your VMSTAT “si/so” columns are zero on Linux.

- [link](http://dba.stackexchange.com/questions/48659/finding-swap-causes-of-mysql)
  - connections * (tmp_table_size + max_heap_table_size) = RAM per connection may used

- [link](http://stackoverflow.com/questions/13381489/innodb-buffer-pool-size-on-mysql-with-db-bigger-than-ram)
  - You are allocating too much RAM and getting into swapping.

- [link](https://www.percona.com/forums/questions-discussions/mysql-and-percona-server/31575-2-questions-about-innodb_buffer_pool_size-parameter-on-rds)
  - Now to answer the question of "is X innodb_buffer_pool_size large enough for my server", that is more complex. You could have 1TB of data, but only access 1GB of it regularly, in which case you would only need a couple gigs in the buffer pool. Or you could have 20GB of data, and constantly access all of it, in which case you'd want as large a buffer pool as possible to cover the data + index size.
  - Aside from that, to get an idea of how often MySQL cannot satisfy a read request from the InnoDB buffer pool and has to go to disk, you can use this calculation: (innodb_buffer_pool_reads / innodb_buffer_pool_read_requests) * 100. These two values come from "show global status", and will give you a percentage of reads that end up going to disk. So if you have a high percentage here, then that means your InnoDB buffer pool is not doing as much as it could be.
  - To see how well your server is using the InnoDB buffer pool, you can check a few different areas. Run "show engine innodb status \G" and check to see if you have any free buffers. If you consistently have a large percentage of free buffers over time compared to the buffer pool size, then the buffer pool might be too large. Then in the same "show engine innodb status \G" output, look for "evicted without access X.XX/s". If that value is anything but 0, then your innodb_buffer_pool size is probably too small (basically it means data is getting loaded into the buffer pool but is never accessed again before it gets pushed out to make room for new data - a.k.a. buffer pool churn).
  - Keep in mind that MySQL can use up a lot of memory in other ways, like with temp tables, so be careful not to over allocate the buffer pool and it up running out of memory later. That's why it is best to up the value in small increments so you can watch stability, and leave yourself a good cushion for when you get an unexpected load or your usage behavior changes all of a sudden (i.e. someone sets up an ETL job that is pumping out temp tables due to huge / poorly written queries).


high performance mysql p.44

```
#!/bin/sh
INTERVAL=5
PREFIX=$INTERVAL-sec-status RUNFILE=/home/benchmarks/running
mysql -e 'SHOW GLOBAL VARIABLES' >> mysql-variables while test -e $RUNFILE; do
file=$(date +%F_%I)
sleep=$(date +%s.%N | awk "{print $INTERVAL - (\$1 % $INTERVAL)}")
sleep $sleep
ts="$(date +"TS %s.%N %F %T")"
loadavg="$(uptime)"
echo "$ts $loadavg" >> $PREFIX-${file}-status
mysql -e 'SHOW GLOBAL STATUS' >> $PREFIX-${file}-status &
echo "$ts $loadavg" >> $PREFIX-${file}-innodbstatus
mysql -e 'SHOW ENGINE INNODB STATUS\G' >> $PREFIX-${file}-innodbstatus & echo "$ts $loadavg" >> $PREFIX-${file}-processlist
mysql -e 'SHOW FULL PROCESSLIST\G' >> $PREFIX-${file}-processlist &
echo $ts
done
echo Exiting because $RUNFILE does not exist.
```



```
select SUM(index_length_gb) from
(
SELECT table_name,
concat( round( data_length / ( 1024 *1024*1024 ) , 2 ) , 'Gb' ) AS 'data_length_gb',
concat( round( index_length / ( 1024 *1024*1024 ) , 2 ) , 'Gb' ) AS 'index_length_gb',
concat( round( round( data_length + index_length ) / ( 1024 *1024*1024 ) , 2 ) , 'Gb' )  AS 'total_size_gb'
FROM information_schema.tables
WHERE table_schema ='optimis_production'
ORDER BY data_length desc) AS A<Paste>
```

db1 index size: 112.78GB
db1 innodb_buffer_pool_size size 108GB


check v2 1yr generating time is acceptable. By some statistics method.

[link](http://stackoverflow.com/questions/9620198/how-to-get-the-sizes-of-the-tables-of-a-mysql-database) Show table size belong to specific db.

```
SELECT 
    table_name AS `Table`, 
    round(((data_length + index_length) / 1024 / 1024), 2) `Size in MB` 
FROM information_schema.TABLES 
WHERE table_schema = "$DB_NAME"
    AND table_name = "$TABLE_NAME";
```

show db size.
```
SELECT table_schema AS "Database name", SUM(data_length + index_length) / 1024 / 1024 /1024 AS "Size (GB)" FROM information_schema.TABLES GROUP BY table_schema;
```

show query now
```
```

show variables
```
SHOW SESSION VARIABLES LIKE '%query%'
```

show query cache status
```
SHOW STATUS LIKE 'Qcache%'
```

http://dba.stackexchange.com/questions/50905/mysql-stores-blob-in-innodb-buffer-pool-innodb-buffer-pool-size
InnoDB will cache the page data you selected with select statement. Will not no selected cache data.

SELECT from a table, and some number of the pages from that table's tablespace on disk will be loaded into the pool, but not usually all of them. Which pages depends on which rows you retrieve, what indexes are needed to find them, whether it's doing read-ahead, etc.

# benchmark SOP

1. check there is no high cpu and ram usage passenger workers.
2. check no long running query on db.
3. queue is empty.
4. run script.

# Going to do

1. change to mysql client to `active_record`
2. [link](http://dev.mysql.com/doc/refman/5.7/en/analyze-table.html) Then rerun tests.

# May

- remove unnessary data out of slave. Some no use db or no use table.
- partial replication


# 20161130 todo

1. check putting data into innodb buffer pool is by queried data.
  - quried different datarange for the v2(db3) now.
  - restart db3
  - queried with on date range.
  - queried with another date range.
2. analysis user behaviour.
3. find out why mysql ram grow slowly.

db3 original innodb_buffer_pool_size 24G, physical ram 44G

p.87

- Notice that “Sorting result” takes up a very small portion of the time, not enough to be worth optimizing. This is rather typical, which is why we encourage people not to spend time on “tuning the sort buffers” and similar activities.
