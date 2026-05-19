# Lab 017 Report — Grafana Dashboard and Prometheus Alert Rules

## Date

YYYY-MM-DD

## Objective

The objective is to run a local Grafana and Prometheus monitoring stack, generate traffic, query metrics and inspect alert rules.

## Commands executed

```bash
./scripts/grafana_lab017_check_requirements.sh
./scripts/grafana_lab017_up.sh
./scripts/grafana_lab017_test_api.sh
./scripts/grafana_lab017_generate_traffic.sh
./scripts/grafana_lab017_query_prometheus.sh
./scripts/grafana_lab017_check_alerts.sh
./scripts/grafana_lab017_inspect.sh
./scripts/grafana_lab017_logs.sh
./scripts/grafana_lab017_down.sh
```

## Grafana URL

```text
http://127.0.0.1:3001
```

## Prometheus URL

```text
http://127.0.0.1:9096
```

## Metrics output

Paste relevant output here.

## Alert output

Paste `/api/v1/alerts` output here.

## Dashboard verification

Describe whether the dashboard loaded correctly.

## Interpretation

Explain whether metrics, dashboard and alert rules worked as expected.

## Cleanup

Paste cleanup output here.
