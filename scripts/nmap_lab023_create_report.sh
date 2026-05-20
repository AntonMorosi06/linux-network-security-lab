#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
mkdir -p "$REPORT_DIR"

STAMP="$(date +%Y%m%d_%H%M%S)"
REPORT_FILE="$REPORT_DIR/lab023_nmap_localhost_authorized_scanning_${STAMP}.txt"

{
  echo "Lab 023 — Nmap Localhost and Authorized Service Scanning Report"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo ""
  echo "Scope:"
  echo "  Target: 127.0.0.1"
  echo "  Authorization: local machine / lab service"
  echo "  No third-party target."
  echo ""
  echo "Repository:"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "  Branch: $(git branch --show-current)"
    echo "  Commit: $(git rev-parse --short HEAD)"
  fi
  echo ""
  echo "Requirement check:"
  echo "------------------------------------------------------------"
  ./scripts/nmap_lab023_check_requirements.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Localhost scan:"
  echo "------------------------------------------------------------"
  ./scripts/nmap_lab023_scan_localhost.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Safety conclusion:"
  echo "  This report is based on localhost scanning only."
  echo "  No third-party system was scanned."
  echo "  No exploitation or credential collection was performed."
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
