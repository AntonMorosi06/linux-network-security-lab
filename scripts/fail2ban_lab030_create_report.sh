#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
mkdir -p "$REPORT_DIR"

STAMP="$(date +%Y%m%d_%H%M%S)"
REPORT_FILE="$REPORT_DIR/lab030_fail2ban_local_log_based_protection_${STAMP}.txt"

{
  echo "Lab 030 — Fail2ban Local Log-Based Protection Report"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo ""
  echo "Scope:"
  echo "  Synthetic authentication logs only."
  echo "  Dry-run config only."
  echo "  Fail2ban not modified."
  echo "  No real IPs banned."
  echo ""
  echo "Repository:"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "  Branch: $(git branch --show-current)"
    echo "  Commit: $(git rev-parse --short HEAD)"
  fi
  echo ""
  echo "Requirement check:"
  echo "------------------------------------------------------------"
  ./scripts/fail2ban_lab030_check_requirements.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Synthetic log generation:"
  echo "------------------------------------------------------------"
  ./scripts/fail2ban_lab030_generate_synthetic_auth_log.py || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Synthetic analysis:"
  echo "------------------------------------------------------------"
  ./scripts/fail2ban_lab030_analyze_synthetic_auth_log.py || true
  echo "------------------------------------------------------------"
  echo ""
  if [ -f data/lab030/synthetic_fail2ban_findings.jsonl ]; then
    echo "Synthetic findings preview:"
    cat data/lab030/synthetic_fail2ban_findings.jsonl
    echo ""
  fi
  echo "Dry-run config generation:"
  echo "------------------------------------------------------------"
  ./scripts/fail2ban_lab030_generate_dry_run_config.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Safety conclusion:"
  echo "  No real authentication logs were used."
  echo "  No Fail2ban configuration was applied."
  echo "  No service was restarted."
  echo "  No IP was banned."
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
