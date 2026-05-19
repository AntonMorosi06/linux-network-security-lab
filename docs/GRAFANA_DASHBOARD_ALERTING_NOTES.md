# Grafana Dashboard and Prometheus Alerting Notes

## Grafana

Grafana is a visualization platform commonly used to build dashboards from metric sources such as Prometheus.

## Prometheus datasource

In this lab, Grafana is automatically provisioned with Prometheus as a datasource:

```text
http://prometheus:9090
```

This address works inside the Docker Compose network.

## Dashboard provisioning

Grafana loads dashboard JSON files from:

```text
docker/lab017/grafana/dashboards/
```

The dashboard is provisioned through:

```text
docker/lab017/grafana/provisioning/dashboards/dashboard.yml
```

## Prometheus alert rules

Prometheus loads alert rules from:

```text
docker/lab017/prometheus/alert_rules.yml
```

Rules are evaluated every few seconds in this local lab.

## Defensive value

Dashboards and alerts help turn raw metrics into operational visibility.

They help answer:

```text
Is the service up?
Are requests increasing?
Are errors increasing?
Are 404 responses increasing?
How long has the service been running?
```

## Important limitation

This lab does not send notifications through Alertmanager. It only demonstrates local Prometheus alert rule evaluation and Grafana dashboards.
