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

writing script to generate performance of every report with different range (1 day, 1 year).

compare between v1 and v2(db3) and v2(db1)

change the mysql config file and checking db performance by script. (query cache on and off, innodb_buffer_pool_size)

to make sure the warm up is by table of by whole db. Run A query about 100 times to see the trend. Then run B query, see its trend (on staging). Also need to check the warm up time.

check v2 1yr generating time is acceptable. By some statistics method.

run sys-bench to check mysql server performance.


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
