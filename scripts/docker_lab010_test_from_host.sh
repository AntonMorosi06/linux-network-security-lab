#!/usr/bin/env bash
set -euo pipefail

URL="${1:-http://127.0.0.1:8500/status}"

echo "============================================================"
echo "DOCKER LAB 010 TEST FROM HOST"
echo "URL: $URL"
echo "Date: $(date)"
echo "============================================================"

if ! command -v curl >/dev/null 2>&1; then
  echo "[ERROR] curl not found."
  exit 1
fi

curl -sS "$URL"
echo ""
echo ""
echo "[OK] Host-to-container test complete."
