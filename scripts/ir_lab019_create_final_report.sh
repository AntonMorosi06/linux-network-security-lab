#!/usr/bin/env bash
set -euo pipefail

EVENTS_FILE="${1:-data/lab019/ir_case_events.jsonl}"
REPORT_DIR="$HOME/linux_lab/reports"
REPORT_FILE="$REPORT_DIR/ir_lab019_final_report_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$REPORT_DIR"

if [ ! -f "$EVENTS_FILE" ]; then
  echo "[ERROR] Events file not found: $EVENTS_FILE"
  exit 1
fi

{
echo "============================================================"
echo "IR LAB 019 FINAL INCIDENT RESPONSE REPORT"
echo "Date: $(date)"
echo "Repository: $(basename "$(pwd)")"
echo "Events file: $EVENTS_FILE"
echo "============================================================"
echo

echo "===== CASE FILE ====="
cat incident_response/lab019/CASE_FILE.md
echo

echo "===== CASE ANALYSIS ====="
./scripts/ir_lab019_analyze_case.py "$EVENTS_FILE"
echo

echo "===== EVIDENCE INDEX ====="
cat incident_response/lab019/EVIDENCE_INDEX.md
echo

echo "===== TRIAGE CHECKLIST ====="
cat incident_response/lab019/TRIAGE_CHECKLIST.md
echo

echo "===== CONTAINMENT NOTES ====="
cat incident_response/lab019/CONTAINMENT_NOTES.md
echo

echo "===== LESSONS LEARNED ====="
cat incident_response/lab019/LESSONS_LEARNED.md
echo

echo "===== FINAL ANALYST SUMMARY ====="
echo "This is a synthetic local incident response case."
echo "The observed pattern includes authentication failures, not-found events, controlled errors and admin review."
echo "No real compromise is implied."
echo "The case is useful for practicing evidence handling, timeline writing and final reporting."
echo

echo "============================================================"
echo "END OF IR LAB 019 FINAL REPORT"
echo "============================================================"
} > "$REPORT_FILE"

echo "[OK] Final incident response report created:"
echo "$REPORT_FILE"
echo ""
echo "[INFO] Preview:"
head -180 "$REPORT_FILE"
