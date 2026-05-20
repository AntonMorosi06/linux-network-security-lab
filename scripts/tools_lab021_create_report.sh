#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
mkdir -p "$REPORT_DIR"

STAMP="$(date +%Y%m%d_%H%M%S)"
REPORT_FILE="$REPORT_DIR/lab021_linux_security_tools_overview_${STAMP}.txt"

{
  echo "Lab 021 — Linux Security Tools Overview Report"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo ""
  echo "Scope:"
  echo "  Local tool inventory and safe tool-awareness review."
  echo "  No third-party systems were scanned."
  echo "  No third-party traffic was captured."
  echo "  No Wi-Fi network was tested."
  echo ""
  echo "Repository:"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "  Branch: $(git branch --show-current)"
    echo "  Commit: $(git rev-parse --short HEAD)"
    echo "  Status:"
    git status --short
  else
    echo "  Not inside a Git repository."
  fi
  echo ""
  echo "Inventory output:"
  echo "------------------------------------------------------------"
  ./scripts/tools_lab021_inventory.sh
  echo "------------------------------------------------------------"
  echo ""
  echo "Interpretation:"
  echo "  Installed tools indicate what can be studied locally."
  echo "  Missing optional tools are not failures."
  echo "  Dual-use tools must remain restricted to authorized lab contexts."
  echo ""
  echo "Safety conclusion:"
  echo "  This report contains local tool inventory only."
  echo "  Review local paths and hostnames before publishing."
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
