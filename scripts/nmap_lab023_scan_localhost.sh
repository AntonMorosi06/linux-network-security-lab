#!/usr/bin/env bash
set -euo pipefail

TARGET="127.0.0.1"
PORT="8088"
OUT_DIR="$HOME/linux_lab/reports"
mkdir -p "$OUT_DIR"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT_FILE="$OUT_DIR/lab023_nmap_localhost_${STAMP}.txt"

echo "[INFO] Lab 023 localhost Nmap scan"
echo "[INFO] Target: $TARGET"
echo "[INFO] Port: $PORT"
echo "[INFO] Output: $OUT_FILE"
echo "[INFO] Safety: localhost only"
echo ""

if ! command -v nmap >/dev/null 2>&1; then
  echo "[WARN] nmap not found"
  echo "[INFO] Install with:"
  echo "  brew install nmap"
  echo "  sudo apt install nmap"
  exit 0
fi

{
  echo "Lab 023 Nmap localhost scan"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo "Target: $TARGET"
  echo "Port: $PORT"
  echo "Scope: localhost only"
  echo ""
  echo "Command: nmap -sV -p $PORT $TARGET"
  echo "------------------------------------------------------------"
  nmap -sV -p "$PORT" "$TARGET"
  echo "------------------------------------------------------------"
  echo ""
  echo "Command: nmap -p $PORT $TARGET"
  echo "------------------------------------------------------------"
  nmap -p "$PORT" "$TARGET"
  echo "------------------------------------------------------------"
} | tee "$OUT_FILE"

echo ""
echo "[OK] Scan completed."
echo "[INFO] Report saved to: $OUT_FILE"
echo "[INFO] Review output before publishing."
