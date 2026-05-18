#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="${1:-$HOME/linux_lab/json_api_mini_soc/logs/api_events.jsonl}"

if ! command -v python3 >/dev/null 2>&1; then
  echo "[ERROR] python3 not found."
  exit 1
fi

if [ ! -f "$LOG_FILE" ]; then
  echo "[ERROR] Log file not found:"
  echo "$LOG_FILE"
  echo ""
  echo "[INFO] Start the API and generate traffic first:"
  echo "  python3 scripts/local_json_api_server_8300.py"
  echo "  ./scripts/generate_api_lab_traffic.sh"
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
http_200 = status_counts.get("200", 0)
http_401 = status_counts.get("401", 0)
http_404 = status_counts.get("404", 0)

severity = "LOW"
findings = []

if http_401 >= 5:
    findings.append("elevated unauthorized access attempts")
    severity = "MEDIUM"

if http_404 >= 10:
    findings.append("elevated not-found requests")
    severity = "MEDIUM"

if http_401 >= 5 and http_404 >= 10:
    severity = "HIGH"
    findings.append("combined elevated 401 and 404 pattern")

print("============================================================")
print("API JSON LOG ANALYSIS")
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
for path, count in path_counts.most_common(10):
    print(f"  {path}: {count}")
print("")
print(f"Severity: {severity}")

if findings:
    print("Findings:")
    for item in findings:
        print(f"  - {item}")
else:
    print("Findings:")
    print("  - no elevated local API pattern detected")

print("")
print("Interpretation:")
if severity == "LOW":
    print("  The local API log pattern appears normal for the current lab thresholds.")
elif severity == "MEDIUM":
    print("  The local API log contains a pattern that should be reviewed.")
else:
    print("  The local API log contains combined elevated patterns that deserve attention.")

print("============================================================")
PY
