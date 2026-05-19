# Logs and System Diagnostics

This file explains Linux logs and system diagnostics in depth. Logs are one of the most important sources of evidence in system administration, cybersecurity, DevOps, monitoring and incident response. A command can show that something is currently running; logs can explain what happened before, when it happened, which service produced it, whether it repeated, and whether it matches an expected lab action.

The goal is to teach a safe and structured diagnostic workflow: identify the system or service, locate the relevant logs, inspect recent entries, filter carefully, avoid leaking private data, summarize the evidence and connect it to a technical conclusion.


## 1. What a log is

A log is a record of events produced by a system, service, application, container or script. Logs can include timestamps, severity levels, messages, process names, request paths, status codes, errors and operational details.


## 2. Why logs matter

Logs matter because they preserve evidence over time. A process listing shows what is happening now; logs can show what happened earlier, why a service failed, when an error started and which action triggered it.


## 3. System logs

System logs contain operating-system level events such as service starts, hardware messages, authentication events and kernel messages. On systemd Linux, many system logs are accessed through journalctl.


## 4. Application logs

Application logs are produced by programs such as APIs, reverse proxies, dashboards, scripts and monitoring systems. They often contain request paths, status codes, errors and internal state.


## 5. Service logs

Service logs are associated with long-running background processes. They help diagnose whether a service started correctly, crashed, restarted or rejected requests.


## 6. Kernel logs

Kernel logs contain low-level messages from the kernel and drivers. Commands such as `dmesg` can show kernel ring buffer messages.


## 7. Journal

The systemd journal stores structured logs for many Linux services. `journalctl` is the primary command for querying it.


## 8. journalctl -xe

`journalctl -xe` shows recent journal entries with explanatory context. It is useful for general diagnosis but can be broad and noisy.


## 9. journalctl -u service

`journalctl -u service` filters logs for a specific systemd service. It is more focused than reading the entire journal.


## 10. dmesg

`dmesg` shows kernel ring buffer messages. It is useful for hardware, driver, network and kernel-level events.


## 11. tail

`tail` reads the end of a file. `tail -f` follows new lines as they are appended. It is useful for watching logs while generating test traffic.


## 12. head

`head` reads the start of a file. It is useful to verify file identity and format before analyzing a long log.


## 13. grep

`grep` filters lines containing a pattern. It is one of the main tools for extracting relevant events from large text logs.


## 14. less

`less` allows controlled reading of a large file. It is safer than dumping long logs into the terminal with `cat`.


## 15. Structured logs

Structured logs use consistent fields, often JSON. They are easier to parse, filter and analyze than free-form text logs.


## 16. JSONL logs

JSONL means one JSON object per line. This format is useful for SIEM-style pipelines because each line is an independent event.


## 17. Timestamps

Timestamps allow events to be ordered. A useful incident report depends on accurate event ordering.


## 18. Severity levels

Logs often include severity such as debug, info, warning, error or critical. Severity helps prioritize investigation but must be interpreted in context.


## 19. Status codes

HTTP logs often include status codes. 200 means success, 401/403 indicate auth/access issues, 404 indicates missing path, and 500 indicates server-side error.


## 20. Log privacy

Logs can contain private paths, usernames, tokens, IP addresses, request data or secrets. They must be reviewed before committing or publishing.


## 21. Docker logs

Docker logs show stdout and stderr for containers. `docker logs` and `docker compose logs` are essential in containerized labs.


## 22. Compose logs

Compose logs aggregate logs from multiple services. They help correlate API, proxy, Prometheus and Grafana behavior.


## 23. Prometheus logs

Prometheus logs can show scrape failures, configuration errors and target availability issues.


## 24. Grafana logs

Grafana logs can show provisioning errors, datasource problems and dashboard loading issues.


## 25. Reverse proxy logs

Reverse proxy logs can show whether traffic reached the proxy and what status code was returned to the client.


## 26. API logs

API logs can show endpoints, authentication failures, controlled errors, command acceptance and service state.


## 27. Log correlation

Log correlation means connecting related events across sources. For example, a curl request may appear in API logs, proxy logs and metrics.


## 28. Timeline building

Timeline building orders events by timestamp. It is a core incident response skill.


## 29. Noise versus signal

Logs contain noise. The analyst must decide which entries are relevant to the question being investigated.


## 30. Diagnostics workflow

A diagnostic workflow starts with the symptom, identifies likely sources, inspects recent logs, filters relevant lines and writes an interpretation.


## 31. Reports from logs

A report should not paste huge logs blindly. It should include the relevant excerpt or summary, explain why it matters and state the conclusion.


## 32. Generated reports

Repository scripts may generate reports under `~/linux_lab/reports`. These are useful locally but should be reviewed before publication.


## 33. macOS difference

macOS does not use systemd journalctl. It has different logging tools such as `log show`. Docker logs and plain text logs remain relevant.


## 34. Safety boundary

Only inspect logs you are authorized to access. Do not collect or publish private logs without review and consent.


## Command card 1: `journalctl -xe`

### Purpose

Show recent systemd journal entries.

### Example

```bash
journalctl -xe
```

### Expected output

```text
Recent system/service logs.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Linux/systemd only; may contain sensitive data.


## Command card 2: `journalctl -u service`

### Purpose

Show logs for one service.

### Example

```bash
journalctl -u ssh
```

### Expected output

```text
Logs for selected service.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Focused and useful for service diagnosis.


## Command card 3: `journalctl --since`

### Purpose

Filter logs by time.

### Example

```bash
journalctl --since '1 hour ago'
```

### Expected output

```text
Recent entries only.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Good for incident timelines.


## Command card 4: `dmesg`

### Purpose

Show kernel ring buffer.

### Example

```bash
dmesg
```

### Expected output

```text
Kernel and driver messages.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

May require privileges on some systems.


## Command card 5: `tail -f`

### Purpose

Follow a log file live.

### Example

```bash
tail -f app.log
```

### Expected output

```text
New appended lines.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Stop with Ctrl+C.


## Command card 6: `tail -100`

### Purpose

Show last 100 lines.

### Example

```bash
tail -100 app.log
```

### Expected output

```text
Recent log lines.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Safe read-only.


## Command card 7: `head -20`

### Purpose

Show first 20 lines.

### Example

```bash
head -20 app.log
```

### Expected output

```text
Initial file lines.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Safe preview.


## Command card 8: `grep`

### Purpose

Filter matching lines.

### Example

```bash
grep 'ERROR' app.log
```

### Expected output

```text
Matching lines.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Safe if read-only.


## Command card 9: `grep -i`

### Purpose

Case-insensitive filtering.

### Example

```bash
grep -i 'error' app.log
```

### Expected output

```text
Matching lines regardless of case.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Useful for inconsistent logs.


## Command card 10: `less`

### Purpose

Read long log interactively.

### Example

```bash
less app.log
```

### Expected output

```text
Pager view.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Press q to quit.


## Command card 11: `cat`

### Purpose

Print file content.

### Example

```bash
cat small.log
```

### Expected output

```text
File content.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Avoid for huge logs.


## Command card 12: `docker logs`

### Purpose

Show one container log.

### Example

```bash
docker logs container
```

### Expected output

```text
Container stdout/stderr.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Review before sharing.


## Command card 13: `docker compose logs`

### Purpose

Show stack logs.

### Example

```bash
docker compose logs
```

### Expected output

```text
Logs from Compose services.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Useful for multi-service labs.


## Command card 14: `python json tool`

### Purpose

Pretty-print JSON logs.

### Example

```bash
python3 -m json.tool file.json
```

### Expected output

```text
Formatted JSON.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

Works for JSON, not JSONL directly.


## Command card 15: `jq`

### Purpose

Filter JSON if installed.

### Example

```bash
jq . file.json
```

### Expected output

```text
Formatted JSON.
```

### Interpretation

This command helps inspect or filter evidence. A strong interpretation should state the source, time range, relevant event type, important fields and conclusion.

### Safety note

May need installation.


## Logs and diagnostics reference tables

| Log source | Typical command | Use case |
|---|---|---|
| systemd journal | `journalctl -xe` | broad system diagnosis |
| specific service | `journalctl -u service` | service failure analysis |
| kernel | `dmesg` | hardware/driver/kernel events |
| text file | `tail`, `grep`, `less` | application log analysis |
| Docker container | `docker logs` | container stdout/stderr |
| Compose stack | `docker compose logs` | multi-service correlation |
| JSONL events | Python script / grep | SIEM-style analysis |

| HTTP status | Log interpretation |
|---|---|
| 200 | request succeeded |
| 202 | accepted for processing |
| 301/302 | redirect |
| 401 | authentication required or failed |
| 403 | forbidden |
| 404 | route/path not found |
| 500 | server-side error |
| 502/504 | proxy/upstream problem |


## Logs and diagnostics study card 1: Evidence mindset

### Concept

Logs are evidence, but they must be interpreted, not dumped blindly.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 2: Timestamp discipline

### Concept

Timestamps create event order and timeline context.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 3: Service filter

### Concept

Filter logs by service to reduce noise.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 4: Recent logs

### Concept

Start with recent entries when diagnosing current failures.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 5: Error search

### Concept

Search for error, failed, denied, refused and timeout patterns.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 6: Privacy review

### Concept

Logs can leak private paths, tokens or usernames.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 7: Docker logs

### Concept

Container logs explain runtime behavior inside Docker labs.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 8: Compose correlation

### Concept

Compose logs help correlate multiple services.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 9: HTTP logs

### Concept

HTTP status codes distinguish app behavior from network behavior.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 10: JSONL events

### Concept

JSONL supports structured event pipelines.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 11: Timeline

### Concept

Incident response requires ordered events.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 12: Signal versus noise

### Concept

Not every warning is an incident.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 13: Report summary

### Concept

Reports should summarize relevant log evidence.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 14: macOS logging

### Concept

macOS logging differs from systemd Linux.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 15: Safe collection

### Concept

Collect only authorized logs.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 16: Evidence mindset

### Concept

Logs are evidence, but they must be interpreted, not dumped blindly.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 17: Timestamp discipline

### Concept

Timestamps create event order and timeline context.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 18: Service filter

### Concept

Filter logs by service to reduce noise.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 19: Recent logs

### Concept

Start with recent entries when diagnosing current failures.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 20: Error search

### Concept

Search for error, failed, denied, refused and timeout patterns.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 21: Privacy review

### Concept

Logs can leak private paths, tokens or usernames.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 22: Docker logs

### Concept

Container logs explain runtime behavior inside Docker labs.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 23: Compose correlation

### Concept

Compose logs help correlate multiple services.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 24: HTTP logs

### Concept

HTTP status codes distinguish app behavior from network behavior.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 25: JSONL events

### Concept

JSONL supports structured event pipelines.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 26: Timeline

### Concept

Incident response requires ordered events.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 27: Signal versus noise

### Concept

Not every warning is an incident.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 28: Report summary

### Concept

Reports should summarize relevant log evidence.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 29: macOS logging

### Concept

macOS logging differs from systemd Linux.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 30: Safe collection

### Concept

Collect only authorized logs.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 31: Evidence mindset

### Concept

Logs are evidence, but they must be interpreted, not dumped blindly.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 32: Timestamp discipline

### Concept

Timestamps create event order and timeline context.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 33: Service filter

### Concept

Filter logs by service to reduce noise.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 34: Recent logs

### Concept

Start with recent entries when diagnosing current failures.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 35: Error search

### Concept

Search for error, failed, denied, refused and timeout patterns.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 36: Privacy review

### Concept

Logs can leak private paths, tokens or usernames.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 37: Docker logs

### Concept

Container logs explain runtime behavior inside Docker labs.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 38: Compose correlation

### Concept

Compose logs help correlate multiple services.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 39: HTTP logs

### Concept

HTTP status codes distinguish app behavior from network behavior.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 40: JSONL events

### Concept

JSONL supports structured event pipelines.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 41: Timeline

### Concept

Incident response requires ordered events.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 42: Signal versus noise

### Concept

Not every warning is an incident.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 43: Report summary

### Concept

Reports should summarize relevant log evidence.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 44: macOS logging

### Concept

macOS logging differs from systemd Linux.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 45: Safe collection

### Concept

Collect only authorized logs.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 46: Evidence mindset

### Concept

Logs are evidence, but they must be interpreted, not dumped blindly.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 47: Timestamp discipline

### Concept

Timestamps create event order and timeline context.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 48: Service filter

### Concept

Filter logs by service to reduce noise.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 49: Recent logs

### Concept

Start with recent entries when diagnosing current failures.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 50: Error search

### Concept

Search for error, failed, denied, refused and timeout patterns.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 51: Privacy review

### Concept

Logs can leak private paths, tokens or usernames.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 52: Docker logs

### Concept

Container logs explain runtime behavior inside Docker labs.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 53: Compose correlation

### Concept

Compose logs help correlate multiple services.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 54: HTTP logs

### Concept

HTTP status codes distinguish app behavior from network behavior.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 55: JSONL events

### Concept

JSONL supports structured event pipelines.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 56: Timeline

### Concept

Incident response requires ordered events.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 57: Signal versus noise

### Concept

Not every warning is an incident.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 58: Report summary

### Concept

Reports should summarize relevant log evidence.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 59: macOS logging

### Concept

macOS logging differs from systemd Linux.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 60: Safe collection

### Concept

Collect only authorized logs.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 61: Evidence mindset

### Concept

Logs are evidence, but they must be interpreted, not dumped blindly.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 62: Timestamp discipline

### Concept

Timestamps create event order and timeline context.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 63: Service filter

### Concept

Filter logs by service to reduce noise.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 64: Recent logs

### Concept

Start with recent entries when diagnosing current failures.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 65: Error search

### Concept

Search for error, failed, denied, refused and timeout patterns.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 66: Privacy review

### Concept

Logs can leak private paths, tokens or usernames.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 67: Docker logs

### Concept

Container logs explain runtime behavior inside Docker labs.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 68: Compose correlation

### Concept

Compose logs help correlate multiple services.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.


## Logs and diagnostics study card 69: HTTP logs

### Concept

HTTP status codes distinguish app behavior from network behavior.

### Practical check

```bash
tail -100 app.log
grep -i "error" app.log
docker compose logs
journalctl -xe
```

These commands inspect recent logs, filter errors, review container stack logs and inspect systemd logs where available. On macOS, systemd commands are not available, but text logs and Docker logs remain useful.

### Interpretation pattern

A good interpretation should identify log source, time window, event type, severity, repeated pattern and whether the behavior was expected in the lab.

### Repository connection

This concept appears in ports/processes/logs diagnostics, API security, Docker Compose, Prometheus/Grafana, SIEM-style detection and incident response case files.

### Safety note

Do not commit raw real logs without review. Prefer synthetic examples or sanitized excerpts.
