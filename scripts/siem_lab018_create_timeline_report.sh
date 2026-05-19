#!/usr/bin/env bash
set -euo pipefail

EVENTS_FILE="${1:-data/lab018/sample_events.jsonl}"
RULES_FILE="${2:-data/lab018/detection_rules.json}"
REPORT_DIR="$HOME/linux_lab/reports"
REPORT_FILE="$REPORT_DIR/siem_lab018_timeline_report_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$REPORT_DIR"

if [ ! -f "$EVENTS_FILE" ]; then
  echo "[ERROR] Events file not found: $EVENTS_FILE"
  exit 1
fi

{
echo "============================================================"
echo "SIEM LAB 018 TIMELINE REPORT"
echo "Date: $(date)"
echo "Repository: $(basename "$(pwd)")"
echo "Events file: $EVENTS_FILE"
echo "Rules file: $RULES_FILE"
echo "============================================================"
echo

echo "===== ANALYSIS ====="
./scripts/siem_lab018_analyze_events.py "$EVENTS_FILE" "$RULES_FILE"
echo

echo "===== TIMELINE ====="
python3 - "$EVENTS_FILE" <<'PY'
from pathlib import Path
import json
import sys

path = Path(sys.argv[1])
events = []

with path.open("r", encoding="utf-8") as handle:
    for line in handle:
        line = line.strip()
        if not line:
            continue
        try:
            events.append(json.loads(line))
        except json.JSONDecodeError:
            pass

events.sort(key=lambda item: str(item.get("timestamp", "")))

for event in events:
    print(
        f"{event.get('timestamp','-')} | "
        f"{event.get('source','-')} | "
        f"{event.get('event_type','-')} | "
        f"status={event.get('status','-')} | "
        f"path={event.get('path','-')} | "
        f"user={event.get('user','-')} | "
        f"{event.get('message','')}"
    )
PY
echo

echo "===== DEFENSIVE INTERPRETATION ====="
echo "Authentication failures may indicate missing credentials, bad configuration, or unauthorized attempts."
echo "404 events may indicate broken routes, wrong clients, or path probing."
echo "5xx events may indicate backend failures or intentionally controlled local test errors."
echo "Admin access events should be reviewed and correlated with expected maintenance activity."
echo

echo "===== RECOMMENDED NEXT ACTIONS ====="
echo "1. Confirm that events are synthetic/local."
echo "2. Review findings and decide whether they are expected."
echo "3. Do not commit private real logs."
echo "4. Use this report format as a model for future SIEM-style labs."
echo
echo "============================================================"
echo "END OF SIEM LAB 018 REPORT"
echo "============================================================"
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
echo ""
echo "[INFO] Preview:"
head -160 "$REPORT_FILE"
