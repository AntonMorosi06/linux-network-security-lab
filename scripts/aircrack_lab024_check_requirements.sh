#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 024 Aircrack-ng requirement check"
echo "[INFO] Safety: help/version awareness only"
echo ""

TOOLS=(
  aircrack-ng
  airmon-ng
  airodump-ng
)

FOUND_ANY=0

for tool in "${TOOLS[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "[OK] $tool found: $(command -v "$tool")"
    FOUND_ANY=1
  else
    echo "[WARN] $tool not found"
  fi
done

echo ""

if [ "$FOUND_ANY" -eq 0 ]; then
  echo "[INFO] No Aircrack-ng suite tools found."
  echo "[INFO] This is not a lab failure."
  echo "[INFO] The lab remains awareness-first and defensive."
  echo "[INFO] macOS install option, if needed for authorized lab study: brew install aircrack-ng"
  echo "[INFO] Debian/Ubuntu install option, if needed for authorized lab study: sudo apt install aircrack-ng"
else
  echo "[INFO] One or more tools found."
  echo "[INFO] Only help/version output is used by this lab."
fi

echo ""
echo "[OK] Requirement check completed."
