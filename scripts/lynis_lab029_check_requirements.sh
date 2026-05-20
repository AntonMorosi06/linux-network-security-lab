#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 029 Lynis requirement check"
echo "[INFO] This script does not run a full audit."
echo ""

if command -v lynis >/dev/null 2>&1; then
  echo "[OK] found: lynis -> $(command -v lynis)"
  echo "[lynis --version]"
  lynis --version 2>&1 || true
else
  echo "[INFO] optional tool not found: lynis"
  echo "[INFO] This is not a lab failure."
  echo "[INFO] macOS install option: brew install lynis"
  echo "[INFO] Debian/Ubuntu install option: sudo apt install lynis"
fi

echo ""
echo "[OK] Requirement check completed."
