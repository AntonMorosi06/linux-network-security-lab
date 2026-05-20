#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 027 SSH requirement check"
echo "[INFO] This script does not modify SSH configuration."
echo ""

TOOLS=(
  ssh
  ssh-keygen
  ssh-agent
  ssh-add
  sshd
)

for tool in "${TOOLS[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "[OK] found: $tool -> $(command -v "$tool")"
  else
    echo "[INFO] optional tool not found: $tool"
  fi
done

echo ""
if command -v ssh >/dev/null 2>&1; then
  echo "[ssh -V]"
  ssh -V 2>&1 || true
fi

echo ""
echo "[OK] Requirement check completed."
