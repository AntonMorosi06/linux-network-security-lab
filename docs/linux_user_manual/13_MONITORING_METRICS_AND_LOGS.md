# Monitoring, Metrics and Logs

Monitoring helps answer whether a service is alive, healthy and behaving normally.

## Concepts

```text
status endpoint
health endpoint
metrics endpoint
logs
alerts
dashboards
```

## Prometheus-style metrics

Example:

```text
# HELP requests_total Total requests.
# TYPE requests_total counter
requests_total 42
```

## Useful endpoints

```text
/status
/health
/metrics
```

## Repository connection

```text
Lab 012 -> Prometheus metrics
Lab 017 -> Grafana dashboard and alert rules
```

## Defensive value

Metrics show trends. Logs show events. Dashboards help humans interpret current state.
