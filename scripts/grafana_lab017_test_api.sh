#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://127.0.0.1:8901}"

echo "============================================================"
echo "GRAFANA LAB 017 API TEST"
echo "Base URL: $BASE_URL"
echo "Date: $(date)"
echo "============================================================"

curl -i -sS "$BASE_URL/status"
echo ""
echo ""
curl -i -sS "$BASE_URL/health"
echo ""
echo ""
curl -sS "$BASE_URL/metrics" | head -80
echo ""
echo ""
curl -i -sS "$BASE_URL/error" || true
echo ""
echo ""
curl -i -sS "$BASE_URL/not_found_example" || true
echo ""
echo "[OK] Lab 017 API tests complete."
