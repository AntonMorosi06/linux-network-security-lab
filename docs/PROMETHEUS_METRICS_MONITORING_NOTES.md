# Prometheus Metrics Monitoring Notes

Metrics are numeric measurements collected over time. Logs describe events; metrics describe measurable system state.

Prometheus commonly scrapes an HTTP `/metrics` endpoint using the Prometheus text exposition format.

Example:

```text
# HELP lab012_requests_total Total number of HTTP requests handled by the API.
# TYPE lab012_requests_total counter
lab012_requests_total 42
```

A counter goes up over time. A gauge can go up or down. The `up` metric is especially important: `up == 1` means Prometheus can scrape a target, while `up == 0` means scraping failed.

A useful query for counters is:

```text
rate(lab012_requests_total[1m])
```

This estimates the per-second request rate over one minute.

The basic monitoring workflow is:

```text
service exposes /metrics
-> Prometheus scrapes
-> user queries metrics
-> analyst interprets behavior
-> report documents findings
```

This is directly useful for API monitoring, defensive operations, telemetry systems, dashboards and MicroBot-style service health.
