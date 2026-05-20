#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
mkdir -p "$REPORT_DIR"

STAMP="$(date +%Y%m%d_%H%M%S)"
REPORT_FILE="$REPORT_DIR/lab027_ssh_hardening_key_based_access_${STAMP}.txt"

{
  echo "Lab 027 — SSH Hardening and Key-Based Access Report"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo ""
  echo "Scope:"
  echo "  Read-only SSH inspection and dry-run config generation."
  echo "  No real SSH server configuration modified."
  echo "  sshd not restarted."
  echo "  Password login not disabled."
  echo ""
  echo "Repository:"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "  Branch: $(git branch --show-current)"
    echo "  Commit: $(git rev-parse --short HEAD)"
  fi
  echo ""
  echo "Requirement check:"
  echo "------------------------------------------------------------"
  ./scripts/ssh_lab027_check_requirements.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Read-only inspection:"
  echo "------------------------------------------------------------"
  ./scripts/ssh_lab027_inspect_readonly.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Dry-run generation:"
  echo "------------------------------------------------------------"
  ./scripts/ssh_lab027_generate_dry_run_config.sh || true
  echo "------------------------------------------------------------"
  echo ""
  echo "Safety conclusion:"
  echo "  No private key contents were printed."
  echo "  No SSH configuration was modified."
  echo "  No daemon was restarted."
  echo "  Generated files are examples only."
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
