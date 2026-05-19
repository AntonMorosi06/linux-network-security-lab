# Lab 012 Report — Prometheus-style Metrics and Local Monitoring

## Date

YYYY-MM-DD

## Machine

Hostname:

Operating system:

Docker version:

Docker Compose version:

User:

## Objective

Run a local metrics API and a Prometheus container, generate traffic, scrape metrics and query Prometheus.

## Commands executed

```bash
./scripts/monitoring_lab012_check_requirements.sh
./scripts/monitoring_lab012_up.sh
./scripts/monitoring_lab012_test_api.sh
./scripts/monitoring_lab012_generate_traffic.sh
./scripts/monitoring_lab012_query_prometheus.sh
./scripts/monitoring_lab012_inspect.sh
./scripts/monitoring_lab012_logs.sh
./scripts/monitoring_lab012_down.sh
```

## API metrics output

Paste output from:

```bash
curl http://127.0.0.1:8701/metrics
```

## Prometheus target status

Open:

```text
http://127.0.0.1:9090/targets
```

Paste target status summary.

## Prometheus query output

Paste output from:

```bash
./scripts/monitoring_lab012_query_prometheus.sh
```

## Interpretation

Explain whether the API exposed metrics, whether Prometheus scraped the API, whether `up` was 1, whether counters increased after traffic generation and whether cleanup removed the stack.

## Security note

This lab is local-only. Services are bound to `127.0.0.1` and are not exposed publicly.
