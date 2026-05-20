#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
mkdir -p "$REPORT_DIR"

STAMP="$(date +%Y%m%d_%H%M%S)"
REPORT_FILE="$REPORT_DIR/lab028_auditd_linux_event_auditing_${STAMP}.txt"

{
  echo "Lab 028 — auditd and Linux Event Auditing Report"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo ""
  echo "Scope:"
  echo "  Read-only inspection, dry-run rules and synthetic events."
  echo "  No audit rules loaded."
  echo "  auditd not restarted."
  echo "  No real audit logs collected."
  echo ""
  echo "Repository:"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "  Branch: $(git branch --show-current)"
    echo "  Commit: $(git rev-parse --short HEAD)"
  fi
  echo ""
  echo "Requirement check:"
  echo "------------------------------------------------------------"
  ./scripts/auditd_lab028_check_requirements.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Read-only inspection:"
  echo "------------------------------------------------------------"
  ./scripts/auditd_lab028_inspect_readonly.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Dry-run rule generation:"
  echo "------------------------------------------------------------"
  ./scripts/auditd_lab028_generate_dry_run_rules.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Synthetic event generation:"
  echo "------------------------------------------------------------"
  ./scripts/auditd_lab028_create_synthetic_events.py || true
  echo "------------------------------------------------------------"
  echo ""
  if [ -f data/lab028/synthetic_audit_events.jsonl ]; then
    echo "Synthetic events preview:"
    head -n 5 data/lab028/synthetic_audit_events.jsonl
    echo ""
  fi
  echo "Safety conclusion:"
  echo "  No audit rules were loaded."
  echo "  No real user activity was collected."
  echo "  Generated events are synthetic."
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
