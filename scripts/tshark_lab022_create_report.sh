#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
mkdir -p "$REPORT_DIR"

STAMP="$(date +%Y%m%d_%H%M%S)"
REPORT_FILE="$REPORT_DIR/lab022_tshark_packet_analysis_${STAMP}.txt"

{
  echo "Lab 022 — Wireshark and TShark Packet Analysis Report"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo ""
  echo "Scope:"
  echo "  Synthetic PCAP analysis only."
  echo "  No live capture."
  echo "  No third-party traffic."
  echo "  No Wi-Fi monitoring."
  echo ""
  echo "Repository:"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "  Branch: $(git branch --show-current)"
    echo "  Commit: $(git rev-parse --short HEAD)"
  fi
  echo ""
  echo "Requirement check:"
  echo "------------------------------------------------------------"
  ./scripts/tshark_lab022_check_requirements.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "PCAP generation:"
  echo "------------------------------------------------------------"
  ./scripts/tshark_lab022_generate_sample_pcap.py || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Analysis:"
  echo "------------------------------------------------------------"
  ./scripts/tshark_lab022_analyze_sample_pcap.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Safety conclusion:"
  echo "  The PCAP was generated synthetically."
  echo "  No real traffic was captured."
  echo "  Review outputs before publishing."
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
