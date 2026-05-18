# Lab 009 — Local API Security Controls

## Objective

The objective of this lab is to build a local API with basic defensive security controls and then test those controls with controlled traffic.

This lab teaches:

- API key authentication
- admin token separation
- rate limiting
- input validation
- method validation
- CORS/security headers
- structured security event logs
- defensive API event analysis
- security report generation

This is a local-only defensive lab. It does not attack external services and does not scan networks.

## Safety boundary

The API binds only to:

```text
127.0.0.1:8400
```

This means the service is local to the machine.

Do not change the bind address to `0.0.0.0` unless you understand the risk and are inside a controlled lab.

## Theory

A local API can fail securely or insecurely. Even in a small lab, useful defensive controls include:

```text
authentication
authorization
rate limiting
input validation
logging
error handling
security headers
```

This lab is intentionally simple. It is not production-grade security. Its purpose is to make each security control visible, testable and documentable.

## API tokens

The lab uses two tokens:

```text
API token:   microbot-api-token
Admin token: microbot-admin-token
```

The API token is sent with:

```text
X-API-Key: microbot-api-token
```

The admin token is sent with:

```text
X-Admin-Key: microbot-admin-token
```

## Endpoints

```text
GET  /public/status
GET  /public/health
GET  /api/telemetry?node_id=node-001
POST /api/command
GET  /admin/config
GET  /metrics
```

## Expected behavior

```text
/public/status                  -> 200 without token
/public/health                  -> 200 without token
/api/telemetry without token     -> 401
/api/telemetry with token        -> 200
/api/telemetry invalid node_id   -> 400
/api/command without token       -> 401
/api/command invalid JSON        -> 400
/api/command valid token/body    -> 202
/admin/config without admin key  -> 403
/admin/config with admin key     -> 200
too many requests                -> 429
unknown endpoint                 -> 404
unsupported method               -> 405
```

## Step 1 — Start the secure local API

In terminal 1:

```bash
python3 scripts/secure_api_server_8400.py
```

Expected output:

```text
[SECURE-API] Listening on http://127.0.0.1:8400
[SECURE-API] Logs: ~/linux_lab/api_security_controls/logs/security_events.jsonl
```

The server stays active. Stop it with:

```text
CTRL + C
```

## Step 2 — Test public endpoint

In terminal 2:

```bash
curl http://127.0.0.1:8400/public/status
```

Expected output:

```json
{
  "service": "secure_api_lab",
  "status": "ok",
  "public": true
}
```

## Step 3 — Test protected endpoint without token

```bash
curl -i "http://127.0.0.1:8400/api/telemetry?node_id=node-001"
```

Expected output:

```text
HTTP/1.0 401 Unauthorized
```

## Step 4 — Test protected endpoint with API key

```bash
curl -i -H "X-API-Key: microbot-api-token" "http://127.0.0.1:8400/api/telemetry?node_id=node-001"
```

Expected output:

```text
HTTP/1.0 200 OK
```

Expected body:

```json
{
  "node_id": "node-001",
  "battery": 87,
  "temperature_c": 31.5,
  "status": "nominal"
}
```

## Step 5 — Test input validation

```bash
curl -i -H "X-API-Key: microbot-api-token" "http://127.0.0.1:8400/api/telemetry?node_id=../../etc/passwd"
```

Expected output:

```text
HTTP/1.0 400 Bad Request
```

Interpretation:

The API rejects unsafe or invalid input instead of processing it.

## Step 6 — Test command endpoint

Valid command:

```bash
curl -i \
  -H "X-API-Key: microbot-api-token" \
  -H "Content-Type: application/json" \
  -d '{"node_id":"node-001","command":"heartbeat"}' \
  http://127.0.0.1:8400/api/command
```

Expected output:

```text
HTTP/1.0 202 Accepted
```

Invalid command:

```bash
curl -i \
  -H "X-API-Key: microbot-api-token" \
  -H "Content-Type: application/json" \
  -d '{"node_id":"node-001","command":"delete_everything"}' \
  http://127.0.0.1:8400/api/command
```

Expected output:

```text
HTTP/1.0 400 Bad Request
```

## Step 7 — Test admin endpoint

Without admin key:

```bash
curl -i http://127.0.0.1:8400/admin/config
```

Expected output:

```text
HTTP/1.0 403 Forbidden
```

With admin key:

```bash
curl -i -H "X-Admin-Key: microbot-admin-token" http://127.0.0.1:8400/admin/config
```

Expected output:

```text
HTTP/1.0 200 OK
```

## Step 8 — Generate controlled security traffic

Run:

```bash
./scripts/generate_api_security_traffic.sh
```

This creates controlled events:

- public requests
- valid API key requests
- missing token requests
- invalid input requests
- forbidden admin requests
- rate limit traffic
- unknown paths

## Step 9 — Analyze security logs

Run:

```bash
./scripts/analyze_api_security_logs.sh
```

Expected output example:

```text
Total events: 80
auth_failure: 10
forbidden: 5
validation_error: 8
rate_limited: 12
not_found: 6
Severity: HIGH
```

## Step 10 — Create report

Run:

```bash
./scripts/create_api_security_controls_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/api_security_controls/reports/api_security_controls_report_YYYYMMDD_HHMMSS.txt
```

## Defensive interpretation

This lab shows how an API can generate useful defensive signals.

Important patterns include:

```text
401 -> authentication failure
403 -> authorization failure
400 -> validation failure
404 -> unknown path
405 -> unsupported method
429 -> rate limit exceeded
```

A simple local detector can count these events and produce a finding.

## Common issues

### Port already in use

```bash
lsof -i :8400 -P -n
```

Stop the old process or change the port in the Python script.

### API unreachable

Start the server:

```bash
python3 scripts/secure_api_server_8400.py
```

### No log file found

Generate traffic first:

```bash
./scripts/generate_api_security_traffic.sh
```

### Rate limit appears too quickly

This is expected because the lab intentionally generates many requests to show HTTP 429 behavior.

## Final conclusion

This lab introduces local API security controls in a visible and testable way.

The core chain is:

```text
secure local API
-> authentication and validation controls
-> controlled traffic
-> structured security logs
-> detector
-> report
```

This is useful for Linux security labs, backend security, API design, telemetry systems, dashboard safety and MicroBot-style command/control architecture.
