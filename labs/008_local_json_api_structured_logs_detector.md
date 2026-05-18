# Lab 008 — Local JSON API, Structured Logs and Mini Detector

## Objective

The objective of this lab is to build a local JSON API, generate controlled traffic, write structured JSONL logs, and analyze those logs with a simple defensive detector.

This lab teaches:

- local API endpoints
- JSON responses
- structured JSONL logging
- HTTP status codes
- controlled traffic generation
- basic API security concepts
- simple threshold-based detection
- local report generation
- mini-SOC style reasoning

This is a defensive, local-only lab. It does not attack external systems and does not require network scanning.

## Safety boundary

This lab listens only on:

```text
127.0.0.1:8300
```

It is local to the machine. It does not expose a public service unless the user intentionally changes the bind address, which is not recommended for this lab.

Allowed use:

- localhost
- personal machine
- VM
- local development environment
- controlled course/lab environment

## Theory

A security analyst does not only look at raw traffic. Many investigations start from logs.

A useful defensive pipeline is:

```text
local API
-> HTTP requests
-> structured JSONL logs
-> analysis script
-> detector rule
-> report
```

Structured logs are easier to analyze than plain text logs because each event has fields such as:

```text
timestamp
client_ip
method
path
status
user_agent
event_type
```

A simple detector can count events and identify patterns such as:

```text
many 404 responses
many 401 responses
many requests to unknown paths
repeated access to protected endpoints without a valid token
```

## API endpoints

The local API provides these endpoints:

```text
GET /status
GET /health
GET /metrics
GET /protected
GET /logs-path
GET /anything-else
```

Expected behavior:

```text
/status     -> 200 OK
/health     -> 200 OK
/metrics    -> 200 OK
/protected  -> 401 without token, 200 with token
unknown     -> 404
```

The lab token is:

```text
microbot-lab-token
```

It must be passed with:

```text
X-Lab-Token: microbot-lab-token
```

## Step 1 — Start the local JSON API

In terminal 1:

```bash
python3 scripts/local_json_api_server_8300.py
```

Expected output:

```text
[API] Local JSON API listening on http://127.0.0.1:8300
[API] Logs: /Users/antonmorosi/linux_lab/json_api_mini_soc/logs/api_events.jsonl
```

The server remains active. Stop it with:

```text
CTRL + C
```

## Step 2 — Test normal endpoints

In terminal 2:

```bash
curl http://127.0.0.1:8300/status
curl http://127.0.0.1:8300/health
curl http://127.0.0.1:8300/metrics
```

Expected output example:

```json
{
  "service": "local_json_api_lab",
  "status": "ok",
  "endpoint": "/status"
}
```

## Step 3 — Test protected endpoint without token

```bash
curl -i http://127.0.0.1:8300/protected
```

Expected output:

```text
HTTP/1.0 401 Unauthorized
```

Expected JSON body:

```json
{
  "error": "unauthorized",
  "message": "missing or invalid X-Lab-Token"
}
```

## Step 4 — Test protected endpoint with token

```bash
curl -i -H "X-Lab-Token: microbot-lab-token" http://127.0.0.1:8300/protected
```

Expected output:

```text
HTTP/1.0 200 OK
```

Expected JSON body:

```json
{
  "service": "local_json_api_lab",
  "status": "authorized",
  "endpoint": "/protected"
}
```

## Step 5 — Generate controlled traffic

Run:

```bash
./scripts/generate_api_lab_traffic.sh
```

This script generates:

- normal `/status` requests
- normal `/health` requests
- valid protected requests
- invalid protected requests
- unknown path requests that produce 404

Expected output:

```text
[OK] Controlled API traffic generated.
```

## Step 6 — Inspect the JSONL log file

Default log path:

```text
~/linux_lab/json_api_mini_soc/logs/api_events.jsonl
```

Command:

```bash
tail -20 ~/linux_lab/json_api_mini_soc/logs/api_events.jsonl
```

Expected output example:

```json
{"timestamp": 1779100000.123, "client_ip": "127.0.0.1", "method": "GET", "path": "/status", "status": 200, "event_type": "normal"}
{"timestamp": 1779100001.456, "client_ip": "127.0.0.1", "method": "GET", "path": "/protected", "status": 401, "event_type": "auth_failure"}
{"timestamp": 1779100002.789, "client_ip": "127.0.0.1", "method": "GET", "path": "/not_found_1", "status": 404, "event_type": "not_found"}
```

## Step 7 — Analyze the logs

Run:

```bash
./scripts/analyze_api_json_logs.sh
```

Expected output example:

```text
Total events: 55
HTTP 200: 35
HTTP 401: 10
HTTP 404: 10
Finding: elevated number of 401 or 404 events
Severity: MEDIUM
```

## Step 8 — Create a report

Run:

```bash
./scripts/create_api_security_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/json_api_mini_soc/reports/api_security_report_YYYYMMDD_HHMMSS.txt
```

## Detection logic

The detector uses simple thresholds.

Example logic:

```text
if 404 >= 10 -> MEDIUM finding
if 401 >= 5  -> MEDIUM finding
if both are elevated -> HIGH finding
otherwise -> LOW / OK
```

This is not advanced SIEM logic. It is intentionally simple, readable, and explainable.

## Common issues

### Port already in use

If port `8300` is busy, find the process:

```bash
lsof -i :8300 -P -n
```

Then stop the process or change the API port in the Python script.

### curl cannot connect

Make sure the API server is running:

```bash
python3 scripts/local_json_api_server_8300.py
```

### No log file found

Generate traffic first:

```bash
./scripts/generate_api_lab_traffic.sh
```

### jq not installed

This lab does not require `jq`, because the analyzer uses Python. If you want to inspect logs with jq:

```bash
cat ~/linux_lab/json_api_mini_soc/logs/api_events.jsonl | jq .
```

## Defensive value

This lab is important because many security workflows involve:

```text
collect events
normalize events
count status codes
identify anomalies
write a report
```

It also connects well with API security, backend development, observability, telemetry systems, and MicroBot-style control dashboards.

## Final conclusion

This lab transforms local service testing into a small defensive analysis pipeline.

The core chain is:

```text
Python JSON API
-> curl traffic
-> JSONL event logs
-> detector script
-> security report
```

This is a practical foundation for later labs on API security, rate limiting, authentication, dashboard monitoring, and SIEM-style analysis.
