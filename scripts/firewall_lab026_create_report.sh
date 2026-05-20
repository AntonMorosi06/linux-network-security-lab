#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
mkdir -p "$REPORT_DIR"

STAMP="$(date +%Y%m%d_%H%M%S)"
REPORT_FILE="$REPORT_DIR/lab026_defensive_firewall_rules_${STAMP}.txt"

{
  echo "Lab 026 — Defensive Firewall Rules Report"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo ""
  echo "Scope:"
  echo "  Read-only inspection and dry-run rule generation."
  echo "  No firewall rules are applied."
  echo "  No firewall rules are flushed."
  echo ""
  echo "Repository:"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "  Branch: $(git branch --show-current)"
    echo "  Commit: $(git rev-parse --short HEAD)"
  fi
  echo ""
  echo "Requirement check:"
  echo "------------------------------------------------------------"
  ./scripts/firewall_lab026_check_requirements.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Read-only inspection:"
  echo "------------------------------------------------------------"
  ./scripts/firewall_lab026_inspect_readonly.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Dry-run generation:"
  echo "------------------------------------------------------------"
  ./scripts/firewall_lab026_generate_dry_run_rules.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Safety conclusion:"
  echo "  No firewall rules were applied."
  echo "  No firewall rules were flushed."
  echo "  Generated rules are examples only."
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
