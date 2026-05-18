# Lab 008 Report — Local JSON API, Structured Logs and Mini Detector

## Date

YYYY-MM-DD

## Machine

Hostname:

Operating system:

Kernel:

User:

## Objective

The objective of this lab is to run a local JSON API, generate controlled HTTP traffic, write JSONL structured logs, analyze those logs, and produce a simple defensive report.

## Commands executed

Terminal 1:

```bash
python3 scripts/local_json_api_server_8300.py
```

Terminal 2:

```bash
curl http://127.0.0.1:8300/status
curl http://127.0.0.1:8300/health
curl -i http://127.0.0.1:8300/protected
curl -i -H "X-Lab-Token: microbot-lab-token" http://127.0.0.1:8300/protected
./scripts/generate_api_lab_traffic.sh
./scripts/analyze_api_json_logs.sh
./scripts/create_api_security_report.sh
```

## API endpoints tested

```text
/status
/health
/metrics
/protected
/not_found_*
```

## Expected behavior

```text
/status     -> 200
/health     -> 200
/metrics    -> 200
/protected without token -> 401
/protected with token    -> 200
unknown paths            -> 404
```

## Log file

Default path:

```text
~/linux_lab/json_api_mini_soc/logs/api_events.jsonl
```

## Observed log sample

Paste relevant JSONL lines:

```json
PASTE_LOG_LINES_HERE
```

## Analysis output

Paste output from:

```bash
./scripts/analyze_api_json_logs.sh
```

## Report output

Generated report path:

```text
PASTE_REPORT_PATH_HERE
```

## Interpretation

Explain:

- total number of events
- HTTP 200 count
- HTTP 401 count
- HTTP 404 count
- event type distribution
- whether the detector produced LOW, MEDIUM, or HIGH severity
- whether the finding is expected because traffic was controlled

## Problems encountered

Possible issues:

- port 8300 already in use
- API server not running
- curl not available
- log file not found
- Python not available

## Cleanup

Stop the API server with:

```text
CTRL + C
```

Optional cleanup of generated logs:

```bash
rm -f ~/linux_lab/json_api_mini_soc/logs/api_events.jsonl
```

## Security note

The API is local-only and binds to `127.0.0.1`. It is used only for defensive structured logging and detection practice.
