#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
mkdir -p "$REPORT_DIR"

STAMP="$(date +%Y%m%d_%H%M%S)"
REPORT_FILE="$REPORT_DIR/lab025_tcpdump_advanced_capture_filters_${STAMP}.txt"

{
  echo "Lab 025 — tcpdump Advanced Capture Filters Report"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo ""
  echo "Scope:"
  echo "  Target: 127.0.0.1"
  echo "  Port: 8090"
  echo "  Traffic: local loopback HTTP service"
  echo "  No third-party traffic."
  echo ""
  echo "Repository:"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "  Branch: $(git branch --show-current)"
    echo "  Commit: $(git rev-parse --short HEAD)"
  fi
  echo ""
  echo "Requirement check:"
  echo "------------------------------------------------------------"
  ./scripts/tcpdump_lab025_check_requirements.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Capture attempt:"
  echo "------------------------------------------------------------"
  ./scripts/tcpdump_lab025_capture_loopback.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Safety conclusion:"
  echo "  The intended capture scope is loopback only."
  echo "  No third-party traffic is targeted."
  echo "  Review generated PCAP before publishing."
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
