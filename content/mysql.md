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
