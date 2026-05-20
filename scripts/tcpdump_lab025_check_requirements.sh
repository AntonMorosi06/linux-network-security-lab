#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 025 requirement check"

if command -v python3 >/dev/null 2>&1; then
  echo "[OK] python3 found: $(command -v python3)"
else
  echo "[ERROR] python3 not found"
  exit 1
fi

if command -v curl >/dev/null 2>&1; then
  echo "[OK] curl found: $(command -v curl)"
else
  echo "[WARN] curl not found"
fi

if command -v tcpdump >/dev/null 2>&1; then
  echo "[OK] tcpdump found: $(command -v tcpdump)"
  tcpdump --version 2>&1 | head -n 3 || true
else
  echo "[WARN] tcpdump not found"
  echo "[INFO] macOS usually includes tcpdump."
  echo "[INFO] Debian/Ubuntu install option: sudo apt install tcpdump"
fi

echo "[OK] Requirement check completed."
