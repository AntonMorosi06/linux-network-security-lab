#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 024 Aircrack-ng help inventory"
echo "[INFO] This script prints help/version text only."
echo "[INFO] It does not target wireless networks."
echo ""

run_help() {
  local tool="$1"
  if command -v "$tool" >/dev/null 2>&1; then
    echo "============================================================"
    echo "[$tool --help]"
    echo "============================================================"
    "$tool" --help 2>&1 | head -n 40 || true
    echo ""
  else
    echo "[INFO] $tool not installed; skipping help output."
  fi
}

run_help aircrack-ng
run_help airmon-ng
run_help airodump-ng

echo "[OK] Help inventory completed."
echo "[INFO] No network was targeted. No capture was performed."
