#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 026 firewall requirement check"
echo "[INFO] This script does not modify firewall rules."
echo ""

TOOLS=(
  ss
  nft
  iptables
  ufw
  pfctl
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
echo "[OK] Requirement check completed."
