#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://127.0.0.1:8800}"
TOKEN="capstone-local-token"

echo "============================================================"
echo "CAPSTONE LAB 015 TEST"
echo "Base URL: $BASE_URL"
echo "Date: $(date)"
echo "============================================================"

curl -i -sS "$BASE_URL/status"
echo ""
echo ""
curl -i -sS "$BASE_URL/health"
echo ""
echo ""
curl -i -sS "$BASE_URL/protected" || true
echo ""
echo ""
curl -i -sS -H "X-API-Key: $TOKEN" "$BASE_URL/protected"
echo ""
echo ""
curl -i -sS -H "X-API-Key: $TOKEN" -H "Content-Type: application/json" -d '{"command":"heartbeat"}' "$BASE_URL/command"
echo ""
echo ""
curl -sS "$BASE_URL/metrics" | head -80
echo ""
echo ""
curl -i -sS "$BASE_URL/unknown" || true
echo ""
echo "[OK] Capstone tests complete."
