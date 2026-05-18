#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME/linux_lab/api_security_controls"
LOG_FILE="$BASE_DIR/logs/security_events.jsonl"
REPORT_DIR="$BASE_DIR/reports"
REPORT_FILE="$REPORT_DIR/api_security_controls_report_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$REPORT_DIR"

if [ ! -f "$LOG_FILE" ]; then
  echo "[ERROR] Log file not found:"
  echo "$LOG_FILE"
  echo ""
  echo "[INFO] Start the API and generate traffic first:"
  echo "  python3 scripts/secure_api_server_8400.py"
  echo "  ./scripts/generate_api_security_traffic.sh"
  exit 1
fi

{
echo "============================================================"
echo "LOCAL API SECURITY CONTROLS REPORT"
echo "Date: $(date)"
echo "Host: $(hostname 2>/dev/null || echo unknown)"
echo "User: $(whoami 2>/dev/null || echo unknown)"
echo "Log file: $LOG_FILE"
echo "============================================================"
echo

echo "===== RAW ANALYSIS ====="
./scripts/analyze_api_security_logs.sh "$LOG_FILE"
echo

echo "===== LAST 25 EVENTS ====="
tail -25 "$LOG_FILE"
echo

echo "===== SECURITY CONTROL SUMMARY ====="
echo "Controls implemented in the local lab API:"
echo "- Local-only bind address: 127.0.0.1"
echo "- API key for /api endpoints"
echo "- Separate admin key for /admin endpoint"
echo "- Rate limiting per client IP"
echo "- Input validation for node_id"
echo "- Command allowlist"
echo "- JSON body validation"
echo "- Security headers"
echo "- Structured JSONL event logs"
echo "- Defensive detector script"
echo

echo "===== REPORT NOTES ====="
echo "This report was generated from a local API security controls lab."
echo "All traffic was controlled and generated locally."
echo "The findings are expected if the traffic generator was used."
echo
echo "============================================================"
echo "END OF REPORT"
echo "============================================================"

} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
echo ""
echo "[INFO] Preview:"
head -140 "$REPORT_FILE"
