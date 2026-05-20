#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 028 auditd requirement check"
echo "[INFO] This script does not install or modify auditd."
echo ""

TOOLS=(
  auditctl
  ausearch
  aureport
  auditd
  systemctl
  journalctl
)

for tool in "${TOOLS[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "[OK] found: $tool -> $(command -v "$tool")"
  else
    echo "[INFO] optional tool not found: $tool"
  fi
done

echo ""
echo "[INFO] OS: $(uname -s)"
if [ "$(uname -s)" = "Darwin" ]; then
  echo "[INFO] macOS note: this lab is Linux auditd-oriented. Missing auditd tools are expected."
fi

echo "[OK] Requirement check completed."
