# Lab 015 — Final Capstone Secure Local Service

## Objective

The objective of this capstone lab is to combine the main skills developed in the repository into one local, controlled and defensible service stack.

This lab brings together:

- Docker Compose
- Python local API service
- Nginx reverse proxy
- localhost-only port publishing
- API key authentication
- structured JSON responses
- structured JSONL logs
- Prometheus-style metrics
- Prometheus scraping
- controlled traffic generation
- service diagnostics
- final report generation
- cleanup workflow

This lab is the closing capstone for the first 15-lab baseline of the Linux Network Security Lab repository.

## Safety boundary

This lab is local-only.

The reverse proxy is published to:

```text
127.0.0.1:8800
```

Prometheus is published to:

```text
127.0.0.1:9095
```

The API container is not directly exposed to the host. It is reachable through the Docker Compose internal network and through the reverse proxy.

No external systems are scanned, attacked or tested.

## Architecture

```text
Host
  |
  | http://127.0.0.1:8800
  v
Nginx reverse proxy
  |
  | http://api:8801
  v
Capstone API container
  |
  | /metrics scraped by
  v
Prometheus container

Prometheus UI:
http://127.0.0.1:9095
```

## Services

The Compose stack contains:

```text
api
reverse_proxy
prometheus
```

## Local endpoints

Through the reverse proxy:

```text
GET  http://127.0.0.1:8800/status
GET  http://127.0.0.1:8800/health
GET  http://127.0.0.1:8800/metrics
GET  http://127.0.0.1:8800/protected
GET  http://127.0.0.1:8800/events
POST http://127.0.0.1:8800/command
```

Prometheus:

```text
http://127.0.0.1:9095
```

## API key

Protected endpoints require:

```text
X-API-Key: capstone-local-token
```

This token is fake and local-only. It must not be confused with a real secret.

## Step 1 — Check requirements

```bash
./scripts/capstone_lab015_check_requirements.sh
```

Expected output:

```text
[OK] docker command found
[OK] Docker daemon is reachable
[OK] docker compose is available
```

## Step 2 — Start the capstone stack

```bash
./scripts/capstone_lab015_up.sh
```

Expected output:

```text
[OK] Capstone stack is running.
[INFO] Proxy URL: http://127.0.0.1:8800/status
[INFO] Prometheus URL: http://127.0.0.1:9095
```

## Step 3 — Test the stack

```bash
./scripts/capstone_lab015_test.sh
```

This tests:

```text
/status
/health
/protected without token
/protected with token
/command with valid token
/metrics
/unknown
```

Expected behavior:

```text
/status -> 200
/health -> 200
/protected without token -> 401
/protected with token -> 200
/command valid -> 202
/metrics -> Prometheus text format
/unknown -> 404
```

## Step 4 — Generate controlled traffic

```bash
./scripts/capstone_lab015_generate_traffic.sh
```

This creates:

```text
normal requests
authorized protected requests
unauthorized requests
valid command requests
unknown path requests
metrics requests
```

The purpose is to generate observable logs and metrics.

## Step 5 — Query metrics

```bash
./scripts/capstone_lab015_query_metrics.sh
```

This queries Prometheus for:

```text
up
capstone_requests_total
capstone_auth_failures_total
capstone_commands_total
capstone_not_found_total
capstone_uptime_seconds
```

## Step 6 — Inspect the stack

```bash
./scripts/capstone_lab015_inspect.sh
```

This shows:

```text
Compose services
running containers
published ports
network state
container summaries
Prometheus configuration
```

## Step 7 — View logs

```bash
./scripts/capstone_lab015_logs.sh
```

This shows logs from:

```text
api
reverse_proxy
prometheus
```

## Step 8 — Create final report

```bash
./scripts/capstone_lab015_create_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/capstone_lab015_report_YYYYMMDD_HHMMSS.txt
```

The report includes:

```text
system identity
Git state
Compose state
endpoint test output
Prometheus query output
recent logs
security interpretation
recommended next actions
```

## Step 9 — Cleanup

```bash
./scripts/capstone_lab015_down.sh
```

Expected output:

```text
[OK] Capstone stack stopped and removed.
```

## Defensive interpretation

This capstone demonstrates a realistic local service architecture:

```text
client -> reverse proxy -> API -> metrics -> Prometheus -> report
```

The security-relevant controls are:

```text
localhost-only publishing
API not directly exposed
API key for protected endpoints
structured logs
metrics endpoint
Prometheus scraping
controlled report generation
cleanup scripts
CI already present in repository
threat model already present in repository
```

## Common issues

### Docker Desktop not running

Open Docker Desktop and retry.

### Port 8800 already in use

Check:

```bash
lsof -i :8800 -P -n
```

### Port 9095 already in use

Check:

```bash
lsof -i :9095 -P -n
```

### Prometheus target down

Open:

```text
http://127.0.0.1:9095/targets
```

Check target:

```text
api:8801
```

### 502 Bad Gateway

The reverse proxy is running but the API may be unavailable. Check:

```bash
./scripts/capstone_lab015_logs.sh
```

## Final conclusion

The first 15 labs now form a complete baseline:

```text
Linux diagnostics
network diagnostics
local services
ports and logs
DNS and routing
network namespaces
firewall and NAT
traffic shaping
local APIs
API security
Docker networking
Docker Compose
Prometheus metrics
CI validation
threat modeling
final secure service capstone
```

This is a strong public proof-of-work repository for Linux, networking, defensive cybersecurity, DevOps basics and local observability.
