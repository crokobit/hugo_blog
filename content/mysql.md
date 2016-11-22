+++
date = "2016-11-22T10:47:26+08:00"
draft = true
title = "mysql"

+++

# TODO
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

- `innodb_buffer_pool_size`
  - what is it for?
  - how to determine its size?

- temp table
  - use what RAM?

