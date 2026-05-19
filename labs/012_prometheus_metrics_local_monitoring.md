# Lab 012 — Prometheus-style Metrics and Local Monitoring

## Objective

The objective of this lab is to build a local monitoring stack using Docker Compose, a Python API that exposes Prometheus-style metrics, and a Prometheus container that scrapes those metrics.

This lab teaches metrics endpoint design, Prometheus exposition format, Docker Compose monitoring, scrape targets, counters, gauges, traffic generation, Prometheus API queries, logs, inspection and cleanup.

## Safety boundary

This lab is local and defensive. It publishes services only on localhost:

```text
API:        http://127.0.0.1:8701
Prometheus: http://127.0.0.1:9090
```

It does not scan external systems and does not monitor unauthorized infrastructure.

## Architecture

```text
Host
  |
  | http://127.0.0.1:8701/status
  | http://127.0.0.1:8701/metrics
  v
metrics_api container
  |
  | scraped by Prometheus over Docker Compose network
  v
prometheus container
  |
  | http://127.0.0.1:9090
  v
Prometheus UI and HTTP API
```

## Metrics exposed by the API

The API exposes metrics such as:

```text
lab012_requests_total
lab012_status_requests_total
lab012_health_requests_total
lab012_metrics_requests_total
lab012_error_requests_total
lab012_not_found_requests_total
lab012_uptime_seconds
lab012_last_request_timestamp_seconds
lab012_build_info
```

Example Prometheus-style metric:

```text
# HELP lab012_requests_total Total number of HTTP requests handled by the API.
# TYPE lab012_requests_total counter
lab012_requests_total 42
```

## Step 1 — Check requirements

```bash
./scripts/monitoring_lab012_check_requirements.sh
```

Expected output:

```text
[OK] docker command found
[OK] Docker daemon is reachable
[OK] docker compose is available
```

## Step 2 — Start the monitoring stack

```bash
./scripts/monitoring_lab012_up.sh
```

Expected output:

```text
[OK] Monitoring stack is running.
[INFO] API URL: http://127.0.0.1:8701/status
[INFO] Metrics URL: http://127.0.0.1:8701/metrics
[INFO] Prometheus URL: http://127.0.0.1:9090
```

## Step 3 — Test the API and metrics endpoint

```bash
./scripts/monitoring_lab012_test_api.sh
```

This tests `/status`, `/health`, `/metrics`, `/error` and a controlled 404.

## Step 4 — Generate traffic

```bash
./scripts/monitoring_lab012_generate_traffic.sh
```

This creates normal requests and controlled error requests so that metrics change.

## Step 5 — Query Prometheus

```bash
./scripts/monitoring_lab012_query_prometheus.sh
```

The script queries:

```text
up
lab012_requests_total
lab012_status_requests_total
lab012_error_requests_total
lab012_not_found_requests_total
lab012_uptime_seconds
rate(lab012_requests_total[1m])
```

## Step 6 — Open Prometheus UI

Open:

```text
http://127.0.0.1:9090
```

Try queries:

```text
up
lab012_requests_total
lab012_error_requests_total
rate(lab012_requests_total[1m])
```

Also check targets:

```text
http://127.0.0.1:9090/targets
```

## Step 7 — Inspect and read logs

```bash
./scripts/monitoring_lab012_inspect.sh
./scripts/monitoring_lab012_logs.sh
```

## Step 8 — Cleanup

```bash
./scripts/monitoring_lab012_down.sh
```

## Manual command summary

```bash
docker compose -f docker/lab012/compose.yaml up -d --build
curl http://127.0.0.1:8701/status
curl http://127.0.0.1:8701/metrics
curl --get "http://127.0.0.1:9090/api/v1/query" --data-urlencode "query=lab012_requests_total"
docker compose -f docker/lab012/compose.yaml logs
docker compose -f docker/lab012/compose.yaml down
```

## Diagnostic interpretation

If the API metrics endpoint works but Prometheus does not show the metric, check Prometheus target status, `prometheus.yml`, the Compose network, service name and Prometheus logs.

If Prometheus UI opens but `up` is `0` for the API target, Prometheus is running but cannot scrape the API.

If `lab012_requests_total` increases after traffic generation, metrics are being exported and scraped correctly.

## Defensive value

Metrics are critical for defensive operations because they help answer whether a service is up, how many requests were handled, whether errors are increasing, whether traffic spiked and how long a service has been running.

This lab prepares future work on dashboards, alerting, service health monitoring, incident detection, MicroBot telemetry, local SOC-style observability and DevOps workflows.

## Final conclusion

The core chain is:

```text
API service
-> /metrics endpoint
-> Prometheus scrape
-> query API
-> interpretation
-> logs and inspect
-> cleanup
```
