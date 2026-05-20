#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 030 Fail2ban requirement check"
echo "[INFO] This script does not start, stop or modify Fail2ban."
echo ""

if command -v python3 >/dev/null 2>&1; then
  echo "[OK] found: python3 -> $(command -v python3)"
else
  echo "[ERROR] python3 not found"
  exit 1
fi

if command -v fail2ban-client >/dev/null 2>&1; then
  echo "[OK] found: fail2ban-client -> $(command -v fail2ban-client)"
  fail2ban-client --version 2>&1 || true
else
  echo "[INFO] optional tool not found: fail2ban-client"
  echo "[INFO] This is not a lab failure."
  echo "[INFO] macOS install option, if needed: brew install fail2ban"
  echo "[INFO] Debian/Ubuntu install option, if needed: sudo apt install fail2ban"
fi

echo ""
echo "[OK] Requirement check completed."
