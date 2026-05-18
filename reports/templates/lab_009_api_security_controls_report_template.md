# Lab 009 Report — Local API Security Controls

## Date

YYYY-MM-DD

## Machine

Hostname:

Operating system:

Kernel:

User:

## Objective

The objective of this lab is to run a local API with basic security controls, generate controlled traffic, analyze structured logs and produce a defensive report.

## API server

Start command:

```bash
python3 scripts/secure_api_server_8400.py
```

Bind address:

```text
127.0.0.1:8400
```

## Security controls tested

- Local-only bind address
- API key authentication
- Admin key authorization
- Input validation
- Command allowlist
- Rate limiting
- Security headers
- Structured JSONL logs
- Detector script
- Report generation

## Commands executed

```bash
curl http://127.0.0.1:8400/public/status
curl -i "http://127.0.0.1:8400/api/telemetry?node_id=node-001"
curl -i -H "X-API-Key: microbot-api-token" "http://127.0.0.1:8400/api/telemetry?node_id=node-001"
curl -i -H "X-API-Key: microbot-api-token" "http://127.0.0.1:8400/api/telemetry?node_id=../../etc/passwd"
./scripts/generate_api_security_traffic.sh
./scripts/analyze_api_security_logs.sh
./scripts/create_api_security_controls_report.sh
```

## Expected results

```text
/public/status without token -> 200
/api/telemetry without token -> 401
/api/telemetry with token -> 200
/api/telemetry invalid node_id -> 400
/api/command valid request -> 202
/admin/config without admin key -> 403
/admin/config with admin key -> 200
rate limit burst -> 429
```

## Log file

Default path:

```text
~/linux_lab/api_security_controls/logs/security_events.jsonl
```

## Observed log sample

Paste relevant JSONL lines:

```json
PASTE_LOG_LINES_HERE
```

## Analysis output

Paste output from:

```bash
./scripts/analyze_api_security_logs.sh
```

## Report output

Generated report path:

```text
PASTE_REPORT_PATH_HERE
```

## Interpretation

Explain:

- total event count
- authentication failure count
- forbidden event count
- validation error count
- rate-limited event count
- not-found count
- final severity
- whether the result is expected due to controlled traffic generation

## Problems encountered

Possible issues:

- port 8400 already in use
- API server not running
- curl not available
- Python not available
- log file not found
- rate limit triggered earlier than expected

## Cleanup

Stop server:

```text
CTRL + C
```

Optional log cleanup:

```bash
rm -f ~/linux_lab/api_security_controls/logs/security_events.jsonl
```

## Security note

The API is local-only and binds to `127.0.0.1`. All traffic in this lab is controlled and generated locally.
