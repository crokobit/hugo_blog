+++
date = "2015-11-28T21:25:03+08:00"
draft = false
title = "optimize_queries_for_mongodb"

+++

# get mongodb.log

# get tools

## mtools
https://github.com/rueckstiess/mtools

Introducing mtools
http://blog.mongodb.org/post/85123256973/introducing-mtools

install with sudo command

### mloginfo 

see the statics of queries
mloginfo mongodb.log --queries
get result like below
```
namespace                                                     operation    pattern                                                                                                                                                             count     min (ms)    max (ms)    mean (ms)    95%-ile (ms)    sum (ms)

optimis_reporting_production.raw_cases                        query        {"clinic_id": 1, "date_last_seen": 1, "discharged": 1, "one_time_evaluation": {"$ne": 1}, "resource_id": 1}                                                           2250         101       76940         2938        11023.45    6612314

```


## mlogfilter 

filte the log by query time, specific operation or collection
mlogfilter mongodb.log --slow 10000 --word optimis_reporting_production.raw_visits --operation query



# add index
1. check ram related things

official guide seems suggest that all index size + working set < RAM size.

check index now
db.system.indexes.find()

change the data umber showed from find
http://stackoverflow.com/questions/3705517/how-to-print-out-more-than-20-items-documents-in-mongodbs-shell
DBQuery.shellBatchSize = 300


see the size of each index
http://jasonwilder.com/blog/2012/02/08/optimizing-mongodb-indexes/


the operation of with indexed queries
http://stackoverflow.com/questions/2811299/mongodb-index-ram-relationship
http://centaurea.io/blog?name=how-mongodb-indexes-depends-on-ram-and-io-operations

When quering, mongodb load the index that query need into RAM. Not all indexed!!
loaded index will remain in memory.
Other query, needing other index, will be loaded to RAM.
If the size needed for the new query index is bigger than the remained RAM, deleteing previous. If Still have insufficient RAM, partially loading index to RAM, which will cause loading I/O frequently and slowing down the system.
loading index to RAM also need additional I/O and will slow down the system.

the meaning of db.stats() dataSize, storageSize and fileSize.
http://blog.mongolab.com/2014/01/how-big-is-your-mongodb/

extent can be data or indexes.
extent(data) and extent(indexes) compose collection.
one collection can have many parts.
extent(data) contain many sets of document and padding stored, and space.
mongodb ask disk a space for saving data, the space with data called document, the space without space called padding stored. The spec is allocated by mongodb, other application can not use that even the data there is deleting. So the dataSize will remain even deleting the data.

The dataSize is the size of all document and padding set.

document, padding stored, unused space constitute extent(data).
storageSize is the sum of extent(data).

fileSize is the sum of extent(data) + extent(index)


maybe can use this
https://github.com/jwilder/mongodb-tools


http://blog.mongolab.com/2014/01/managing-disk-space-in-mongodb/
compact

http://www.briancarpio.com/2012/05/03/mongodb-memory-management/
use free -tm to check memory used now
low free RAM is not nessary a problem ?? mongodb will cached recent loaded file to cache as a memory mapped file.

new relic do not show the right RAM information !!
https://blog.jixee.me/understanding-new-relic-physical-memory-usage/
use free or top command

how to add index
yet
https://emptysqua.re/blog/optimizing-mongodb-compound-indexes/#range

Great article!
http://snmaynard.com/2012/10/17/things-i-wish-i-knew-about-mongodb-a-year-ago/
```
Index all the queries

When I first started using Mongo, I would sometimes run queries on an ad-hoc basis or from a cron job. I initially left those queries unindexed, as they weren’t user facing and weren’t run often. However this caused performance problems for other indexed queries, as the unindexed queries do a lot of disk reads, which impacted the retrieval of any documents that weren’t cached. I decided to make sure the queries are at least partially indexed to prevent things like this happening.


Always run explain on new queries
```

we have replication set

Defragmentation

upgrade mongodb

