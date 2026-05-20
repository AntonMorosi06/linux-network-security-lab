#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 022 requirement check"

if command -v python3 >/dev/null 2>&1; then
  echo "[OK] python3 found: $(command -v python3)"
else
  echo "[ERROR] python3 not found"
  exit 1
fi

if command -v tshark >/dev/null 2>&1; then
  echo "[OK] tshark found: $(command -v tshark)"
  tshark --version 2>&1 | head -n 3 || true
else
  echo "[WARN] tshark not found"
  echo "[INFO] macOS install option: brew install wireshark"
  echo "[INFO] Debian/Ubuntu install option: sudo apt install tshark"
  echo "[INFO] This lab can still generate the synthetic PCAP without tshark."
fi

echo "[OK] Requirement check completed."
