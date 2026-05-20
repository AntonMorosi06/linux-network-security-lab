#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 023 requirement check"

if command -v python3 >/dev/null 2>&1; then
  echo "[OK] python3 found: $(command -v python3)"
else
  echo "[ERROR] python3 not found"
  exit 1
fi

if command -v nmap >/dev/null 2>&1; then
  echo "[OK] nmap found: $(command -v nmap)"
  nmap --version 2>&1 | head -n 5 || true
else
  echo "[WARN] nmap not found"
  echo "[INFO] macOS install option: brew install nmap"
  echo "[INFO] Debian/Ubuntu install option: sudo apt install nmap"
  echo "[INFO] The lab can still create documentation, but scans require nmap."
fi

echo "[OK] Requirement check completed."
