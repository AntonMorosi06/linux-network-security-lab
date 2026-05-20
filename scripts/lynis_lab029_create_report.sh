#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
mkdir -p "$REPORT_DIR"

STAMP="$(date +%Y%m%d_%H%M%S)"
REPORT_FILE="$REPORT_DIR/lab029_lynis_local_security_audit_${STAMP}.txt"

{
  echo "Lab 029 — Lynis Local Security Audit Report"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo ""
  echo "Scope:"
  echo "  Requirement check and synthetic findings by default."
  echo "  Optional real local audit is gated by RUN_LYNIS_LOCAL_AUDIT=yes."
  echo "  Raw real output must remain private until sanitized."
  echo ""
  echo "Repository:"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "  Branch: $(git branch --show-current)"
    echo "  Commit: $(git rev-parse --short HEAD)"
  fi
  echo ""
  echo "Requirement check:"
  echo "------------------------------------------------------------"
  ./scripts/lynis_lab029_check_requirements.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Synthetic findings generation:"
  echo "------------------------------------------------------------"
  ./scripts/lynis_lab029_create_synthetic_findings.py || true
  echo "------------------------------------------------------------"
  echo ""
  if [ -f data/lab029/synthetic_lynis_findings.jsonl ]; then
    echo "Synthetic findings preview:"
    head -n 5 data/lab029/synthetic_lynis_findings.jsonl
    echo ""
  fi
  echo "Optional audit guidance:"
  echo "  To run a real local Lynis audit on an owned/administered system:"
  echo "  RUN_LYNIS_LOCAL_AUDIT=yes ./scripts/lynis_lab029_run_local_audit.sh"
  echo ""
  echo "Safety conclusion:"
  echo "  Synthetic findings are safe for GitHub."
  echo "  Real Lynis output must be reviewed and sanitized before publication."
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
