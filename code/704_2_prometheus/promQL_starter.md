# Starter Queries for PromQL

## Installation

Use one of the ways to install Prometheus as described on the [website](https://prometheus.io/docs/prometheus/latest/installation/).

## Basic Metric Name

* `up`: Checks whether a monitored target is currently reachable. A value of `1` means online, `0` means offline. offline.

## Filtering with Labels

* `http_requests_total{status="200"}`: Selects exactly those data points where the `status` label has the value `200`.
* `http_requests_total{status=~"5.."}`: Uses a regular expression (=~) to filter all HTTP server errors (status codes 500 to 599).

## Time Ranges and Rates (Range Vectors)

* `rate(http_requests_total[5m])`: Calculates the per-second rate of increase of counters over a rolling 5-minute time window. Ideal for dashboard graphs.
* `increase(prometheus_tsdb_reloads_total[1h])`: Shows the absolute increase of a counter within the last hour.

## Aggregations (Combining Data)

* `sum(http_requests_total)`: Adds up the values of all time series for this metric into a single total sum.
* `sum by (job) (http_requests_total)`: Groups the sum of requests broken down by the job label to see the workload per service.

## Simple Arithmetic

* `node_memory_Active_bytes / 1024 / 1024`: Divides the raw byte value twice by 1024 to display active memory directly in megabytes (MB).
