# Lab 017 — Grafana Dashboard and Prometheus Alert Rules

## Objective

The objective of this lab is to extend the local monitoring work by adding Grafana dashboards and Prometheus alert rules.

This lab teaches:

- Grafana provisioning
- Prometheus datasource configuration
- JSON dashboard provisioning
- Prometheus alert rule files
- alert state inspection
- local monitoring dashboards
- metrics visualization
- controlled traffic generation
- defensive interpretation of monitoring signals

## Safety boundary

This lab is local and defensive.

It publishes services only on localhost:

```text
Observable API: http://127.0.0.1:8901
Prometheus:     http://127.0.0.1:9096
Grafana:        http://127.0.0.1:3001
```

It does not monitor third-party infrastructure and does not perform unauthorized testing.

## Architecture

```text
Host
  |
  | http://127.0.0.1:8901
  v
observable_api container
  |
  | /metrics scraped by Prometheus
  v
prometheus container
  |
  | datasource for Grafana
  v
grafana container
```

## Services

The Docker Compose stack contains:

```text
observable_api
prometheus
grafana
```

## Grafana login

Default local lab credentials:

```text
username: admin
password: admin
```

These are intentionally weak default lab credentials. They are acceptable only because the lab is local-only.

## Metrics

The API exposes:

```text
lab017_requests_total
lab017_status_requests_total
lab017_error_requests_total
lab017_not_found_total
lab017_uptime_seconds
lab017_build_info
```

## Alert rules

Prometheus loads alert rules from:

```text
docker/lab017/prometheus/alert_rules.yml
```

The rules include:

```text
Lab017ApiTargetDown
Lab017HighErrorCount
Lab017HighNotFoundCount
```

## Step 1 — Check requirements

```bash
./scripts/grafana_lab017_check_requirements.sh
```

Expected output:

```text
[OK] docker command found
[OK] Docker daemon is reachable
[OK] docker compose is available
```

## Step 2 — Start the stack

```bash
./scripts/grafana_lab017_up.sh
```

Expected output:

```text
[OK] Grafana monitoring stack is running.
[INFO] API URL: http://127.0.0.1:8901/status
[INFO] Prometheus URL: http://127.0.0.1:9096
[INFO] Grafana URL: http://127.0.0.1:3001
```

## Step 3 — Test API and metrics

```bash
./scripts/grafana_lab017_test_api.sh
```

This tests:

```text
/status
/health
/metrics
/error
/not_found_example
```

## Step 4 — Generate controlled traffic

```bash
./scripts/grafana_lab017_generate_traffic.sh
```

This generates normal requests, controlled errors and 404 responses.

## Step 5 — Query Prometheus

```bash
./scripts/grafana_lab017_query_prometheus.sh
```

This queries:

```text
up
lab017_requests_total
lab017_error_requests_total
lab017_not_found_total
rate(lab017_requests_total[1m])
```

## Step 6 — Check alert rules

```bash
./scripts/grafana_lab017_check_alerts.sh
```

This queries Prometheus alert state through the HTTP API.

Expected output includes a JSON response from:

```text
/api/v1/alerts
```

## Step 7 — Open Grafana

Open:

```text
http://127.0.0.1:3001
```

Login with:

```text
admin / admin
```

Open the dashboard:

```text
Linux Security Lab — Lab 017
```

You should see panels for:

```text
target up
request count
error count
404 count
uptime
request rate
```

## Step 8 — View logs

```bash
./scripts/grafana_lab017_logs.sh
```

## Step 9 — Inspect stack

```bash
./scripts/grafana_lab017_inspect.sh
```

## Step 10 — Cleanup

```bash
./scripts/grafana_lab017_down.sh
```

Expected output:

```text
[OK] Grafana monitoring stack stopped and removed.
```

## Defensive interpretation

This lab shows how observability can become operational:

```text
metrics endpoint
-> Prometheus scrape
-> alert rules
-> Grafana dashboard
-> local investigation
```

The key defensive idea is that a service should not only run; it should be observable.

## Common issues

### Docker Desktop not running

Open Docker Desktop and retry.

### Port 3001 already in use

Check:

```bash
lsof -i :3001 -P -n
```

### Port 9096 already in use

Check:

```bash
lsof -i :9096 -P -n
```

### Grafana dashboard missing

Check Grafana logs:

```bash
./scripts/grafana_lab017_logs.sh
```

### Prometheus target down

Open:

```text
http://127.0.0.1:9096/targets
```

Check target:

```text
observable_api:8901
```

## Final conclusion

The core chain is:

```text
observable API
-> Prometheus scrape
-> Prometheus alert rules
-> Grafana datasource
-> Grafana dashboard
-> local report
```

This lab upgrades the repository from simple monitoring to dashboard-based observability.
