#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="${1:-$HOME/linux_lab/api_security_controls/logs/security_events.jsonl}"

if ! command -v python3 >/dev/null 2>&1; then
  echo "[ERROR] python3 not found."
  exit 1
fi

if [ ! -f "$LOG_FILE" ]; then
  echo "[ERROR] Log file not found:"
  echo "$LOG_FILE"
  echo ""
  echo "[INFO] Start the API and generate traffic first:"
  echo "  python3 scripts/secure_api_server_8400.py"
  echo "  ./scripts/generate_api_security_traffic.sh"
  exit 1
fi

python3 - "$LOG_FILE" <<'PY'
from __future__ import annotations

from collections import Counter
from pathlib import Path
import json
import sys


log_file = Path(sys.argv[1])

events = []
bad_lines = 0

with log_file.open("r", encoding="utf-8") as handle:
    for line in handle:
        line = line.strip()
        if not line:
            continue
        try:
            events.append(json.loads(line))
        except json.JSONDecodeError:
            bad_lines += 1

status_counts = Counter(str(event.get("status", "unknown")) for event in events)
event_type_counts = Counter(str(event.get("event_type", "unknown")) for event in events)
path_counts = Counter(str(event.get("path", "unknown")) for event in events)

total = len(events)
auth_failure = event_type_counts.get("auth_failure", 0)
forbidden = event_type_counts.get("forbidden", 0)
validation_error = event_type_counts.get("validation_error", 0)
rate_limited = event_type_counts.get("rate_limited", 0)
not_found = event_type_counts.get("not_found", 0)
method_not_allowed = event_type_counts.get("method_not_allowed", 0)

score = 0
findings = []

if auth_failure >= 5:
    score += 2
    findings.append("elevated authentication failures")

if forbidden >= 1:
    score += 1
    findings.append("forbidden admin access attempts observed")

if validation_error >= 4:
    score += 2
    findings.append("multiple validation failures observed")

if rate_limited >= 1:
    score += 2
    findings.append("rate limit triggered")

if not_found >= 5:
    score += 1
    findings.append("multiple unknown path requests observed")

if method_not_allowed >= 1:
    score += 1
    findings.append("unsupported HTTP method attempts observed")

if score >= 6:
    severity = "HIGH"
elif score >= 3:
    severity = "MEDIUM"
else:
    severity = "LOW"

print("============================================================")
print("API SECURITY LOG ANALYSIS")
print(f"Log file: {log_file}")
print("============================================================")
print(f"Total events: {total}")
print(f"Bad JSON lines: {bad_lines}")
print("")
print("Status counts:")
for status, count in sorted(status_counts.items()):
    print(f"  HTTP {status}: {count}")
print("")
print("Event type counts:")
for event_type, count in sorted(event_type_counts.items()):
    print(f"  {event_type}: {count}")
print("")
print("Top paths:")
for path, count in path_counts.most_common(12):
    print(f"  {path}: {count}")
print("")
print(f"Detection score: {score}")
print(f"Severity: {severity}")
print("")
print("Findings:")
if findings:
    for finding in findings:
        print(f"  - {finding}")
else:
    print("  - no elevated local API security pattern detected")
print("")
print("Interpretation:")
if severity == "LOW":
    print("  The local API security event pattern appears normal for the current lab thresholds.")
elif severity == "MEDIUM":
    print("  The local API security event pattern contains signals that should be reviewed.")
else:
    print("  The local API security event pattern contains multiple elevated defensive signals.")
print("============================================================")
PY
