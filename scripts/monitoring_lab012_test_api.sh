#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://127.0.0.1:8701}"

echo "============================================================"
echo "MONITORING LAB 012 API TEST"
echo "Base URL: $BASE_URL"
echo "============================================================"

curl -i -sS "$BASE_URL/status"; echo; echo
curl -i -sS "$BASE_URL/health"; echo; echo
curl -sS "$BASE_URL/metrics" | head -80; echo
curl -i -sS "$BASE_URL/error" || true; echo; echo
curl -i -sS "$BASE_URL/not-found-example" || true; echo; echo

echo "[OK] API and metrics tests complete."
