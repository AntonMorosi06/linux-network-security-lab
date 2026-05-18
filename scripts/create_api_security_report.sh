#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME/linux_lab/json_api_mini_soc"
LOG_FILE="$BASE_DIR/logs/api_events.jsonl"
REPORT_DIR="$BASE_DIR/reports"
REPORT_FILE="$REPORT_DIR/api_security_report_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$REPORT_DIR"

if [ ! -f "$LOG_FILE" ]; then
  echo "[ERROR] Log file not found:"
  echo "$LOG_FILE"
  echo ""
  echo "[INFO] Start the API and generate traffic first:"
  echo "  python3 scripts/local_json_api_server_8300.py"
  echo "  ./scripts/generate_api_lab_traffic.sh"
  exit 1
fi

{
echo "============================================================"
echo "LOCAL JSON API SECURITY REPORT"
echo "Date: $(date)"
echo "Host: $(hostname 2>/dev/null || echo unknown)"
echo "User: $(whoami 2>/dev/null || echo unknown)"
echo "Log file: $LOG_FILE"
echo "============================================================"
echo

echo "===== RAW ANALYSIS ====="
./scripts/analyze_api_json_logs.sh "$LOG_FILE"
echo

echo "===== LAST 20 EVENTS ====="
tail -20 "$LOG_FILE"
echo

echo "===== REPORT NOTES ====="
echo "This report was generated from a local JSON API lab."
echo "The API was bound to 127.0.0.1 and used for defensive structured logging practice."
echo
echo "Main defensive interpretation points:"
echo "- HTTP 200 events indicate successful normal requests."
echo "- HTTP 401 events indicate unauthorized protected endpoint access."
echo "- HTTP 404 events indicate unknown endpoint requests."
echo "- Elevated 401 or 404 counts can be used as simple detection signals."
echo
echo "============================================================"
echo "END OF REPORT"
echo "============================================================"

} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
echo ""
echo "[INFO] Preview:"
head -120 "$REPORT_FILE"
