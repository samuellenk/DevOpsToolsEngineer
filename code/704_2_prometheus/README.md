# Scenario Brief

You are setting up monitoring for a web application node.

You need to configure Prometheus to scrape metrics from a local `node_exporter`, write PromQL queries to check system status, and configure an alert rule for high CPU usage.

# Setup

To complete this task, you should set up and run Prometheus as described in the [Getting started](https://prometheus.io/docs/prometheus/latest/getting_started/) section.

# Getting Started with PromQL

You can get up and running with PromQL using [this document](/code/704_2_prometheus/promQL_starter.md).

# Task 1: Basic Configuration (`prometheus.yml`)

Configure Prometheus to scrape two targets:

1. Itself on `localhost:9090` with a scrape interval of 15s.
2. A node exporter target on `localhost:9100` with a scrape interval of `10s` under the job name `node_exporter`.

# Task 2: Writing PromQL Queries

Write the appropriate PromQL expression for each requirement:

1. Query the overall uptime of the target `node_exporter` instance.
2. Calculate the average per-second rate of CPU utilization over the last 5 minutes for the `idle` mode across all CPUs.
3. Calculate the percentage of free memory using `node_memory_MemAvailable_bytes` and `node_memory_MemTotal_bytes`.

# Task 3: Alert Rules (`alert.rules.yml`)

Write an Alertmanager rule named `HighCpuLoad` inside a group called `node_alerts` that triggers when average CPU usage goes above 85% for more than 2 minutes.

# Solution 1: Basic Configuration (`prometheus.yml`)

Configuration in prometheus.yml:
```yaml
global:
  scrape_interval: 15s

rule_files:
  - "alert.rules.yml"

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "node_exporter"
    scrape_interval: 10s
    static_configs:
      - targets: ["localhost:9100"]
```

# Solution 2: Writing PromQL Queries

1. Target Status/Uptime: `time() - process_start_time_seconds{job="node_exporter"}`
2. Idle CPU Rate (5m): `avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m]))`
3. Percentage of Free Memory: `(node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) * 100`

# Solution 3: Alert Rules (`alert.rules.yml`)

Content of `alert.rules.yml`:
```yaml
groups:
  - name: node_alerts
    rules:
      - alert: HighCpuLoad
        expr: (1 - avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m]))) * 100 > 85
        for: 2m
        labels:
          severity: critical
        annotations:
          summary: "High CPU usage detected on {{ $labels.instance }}"
          description: "CPU usage has exceeded 85% for more than 2 minutes."
```
