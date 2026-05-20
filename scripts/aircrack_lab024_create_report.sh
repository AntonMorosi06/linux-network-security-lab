#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
mkdir -p "$REPORT_DIR"

STAMP="$(date +%Y%m%d_%H%M%S)"
REPORT_FILE="$REPORT_DIR/lab024_aircrack_ng_wireless_security_awareness_${STAMP}.txt"

{
  echo "Lab 024 — Aircrack-ng Wireless Security Awareness Report"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo ""
  echo "Scope:"
  echo "  Tool awareness only."
  echo "  Help/version output only."
  echo "  No live wireless testing."
  echo "  No third-party networks."
  echo ""
  echo "Repository:"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "  Branch: $(git branch --show-current)"
    echo "  Commit: $(git rev-parse --short HEAD)"
  fi
  echo ""
  echo "Requirement check:"
  echo "------------------------------------------------------------"
  ./scripts/aircrack_lab024_check_requirements.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Help inventory:"
  echo "------------------------------------------------------------"
  ./scripts/aircrack_lab024_help_inventory.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Safety conclusion:"
  echo "  No Wi-Fi network was targeted."
  echo "  No wireless traffic was captured."
  echo "  No deauthentication was performed."
  echo "  No handshakes were collected."
  echo "  No password cracking was performed."
  echo ""
  echo "Defensive conclusion:"
  echo "  Aircrack-ng is documented here only as a wireless security awareness topic."
  echo "  Any real wireless testing requires ownership or explicit written authorization."
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
