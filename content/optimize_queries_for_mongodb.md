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
