# Lab 018 — Local SIEM-style Log Pipeline and Detection Rules

## Objective

The objective of this lab is to build a local SIEM-style log pipeline using fake JSONL security events, detection rules, analysis scripts, severity scoring and a timeline report.

This lab teaches:

- JSONL event structure
- event normalization
- detection rules
- threshold-based detection
- severity assignment
- timeline reconstruction
- local report generation
- defensive investigation workflow
- safe synthetic event generation

This lab is defensive and local-only. It does not collect real private logs, does not scan systems and does not interact with unauthorized infrastructure.

## Safety boundary

All events used in this lab are fake, synthetic and generated locally.

The lab does not contain real credentials, real logs, real attacks or real user data.

Allowed use:

```text
local repository
fake event files
controlled generated events
defensive analysis
portfolio demonstration
```

## Why SIEM-style thinking matters

A SIEM, or Security Information and Event Management system, collects and correlates security events.

This lab does not implement a real SIEM. It builds a small local model of the same reasoning process:

```text
event source
-> JSONL log file
-> normalization
-> detection rules
-> findings
-> severity
-> timeline
-> report
```

The goal is to understand the logic before using larger platforms.

## Files

This lab adds:

```text
data/lab018/sample_events.jsonl
data/lab018/detection_rules.json
scripts/siem_lab018_generate_sample_events.py
scripts/siem_lab018_validate_rules.py
scripts/siem_lab018_analyze_events.py
scripts/siem_lab018_create_timeline_report.sh
scripts/siem_lab018_run_pipeline.sh
docs/SIEM_LOG_PIPELINE_DETECTION_NOTES.md
```

## Event format

Each event is a JSON object stored on one line.

Example:

```json
{
  "timestamp": "2026-05-20T10:00:00Z",
  "source": "local_api",
  "event_type": "auth_failure",
  "status": 401,
  "src_ip": "127.0.0.1",
  "user": "lab-user",
  "path": "/protected",
  "message": "missing or invalid local API key"
}
```

## Detection rules

Rules are stored in:

```text
data/lab018/detection_rules.json
```

Example rule concept:

```text
If auth_failure occurs at least 5 times in the event file, raise a MEDIUM finding.
```

## Step 1 — Validate detection rules

```bash
./scripts/siem_lab018_validate_rules.py
```

Expected output:

```text
[OK] Loaded rules: 5
[OK] Rule validation completed.
```

## Step 2 — Analyze sample events

```bash
./scripts/siem_lab018_analyze_events.py
```

Expected output:

```text
Total events: 22
Findings:
- AUTH_FAILURE_THRESHOLD severity=MEDIUM
- NOT_FOUND_THRESHOLD severity=LOW
```

## Step 3 — Generate a fresh synthetic event file

```bash
./scripts/siem_lab018_generate_sample_events.py
```

Expected output:

```text
[OK] Generated synthetic events:
~/linux_lab/lab018_siem/events/generated_events.jsonl
```

## Step 4 — Analyze generated events

```bash
./scripts/siem_lab018_analyze_events.py ~/linux_lab/lab018_siem/events/generated_events.jsonl
```

## Step 5 — Create timeline report

```bash
./scripts/siem_lab018_create_timeline_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/siem_lab018_timeline_report_YYYYMMDD_HHMMSS.txt
```

## Step 6 — Run the full pipeline

```bash
./scripts/siem_lab018_run_pipeline.sh
```

This runs:

```text
rule validation
synthetic event generation
event analysis
timeline report generation
```

## Detection logic

This lab uses simple transparent logic. It is intentionally explainable.

The default rules detect:

```text
multiple authentication failures
multiple 404/not-found events
controlled 5xx errors
admin access events
mixed auth failure + not-found pattern
```

## Defensive interpretation

The point is not that every finding is malicious. The point is to document how a defensive analyst reasons from event counts and event context.

Example:

```text
Many 401 events can mean a broken client, a misconfigured integration, or unauthorized attempts.
Many 404 events can mean a wrong route, a broken frontend, or path probing.
Many 5xx events can mean a service bug or backend failure.
```

## Common issues

### Python not found

Install or activate Python 3.

```bash
python3 --version
```

### No generated file found

Run:

```bash
./scripts/siem_lab018_generate_sample_events.py
```

### JSON error

Validate that each JSONL line is a complete JSON object.

### Reports include local path

Generated reports may include local paths. Review before committing or publishing.

## Final conclusion

The core chain is:

```text
synthetic events
-> JSONL event file
-> detection rules
-> rule validation
-> analysis
-> timeline report
-> defensive interpretation
```

This lab adds a SIEM-style layer to the repository without requiring a full SIEM platform.
