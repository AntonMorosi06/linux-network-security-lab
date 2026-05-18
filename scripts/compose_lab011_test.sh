#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://127.0.0.1:8600}"

echo "============================================================"
echo "COMPOSE LAB 011 TEST"
echo "Base URL: $BASE_URL"
echo "Date: $(date)"
echo "============================================================"

if ! command -v curl >/dev/null 2>&1; then
  echo "[ERROR] curl not found."
  exit 1
fi

echo ""
echo "[1] /proxy-status"
curl -i -sS "$BASE_URL/proxy-status"
echo ""
echo ""

echo "[2] /status"
curl -i -sS "$BASE_URL/status"
echo ""
echo ""

echo "[3] /health"
curl -i -sS "$BASE_URL/health"
echo ""
echo ""

echo "[4] /headers"
curl -i -sS "$BASE_URL/headers"
echo ""
echo ""

echo "[5] /unknown should return 404"
curl -i -sS "$BASE_URL/unknown" || true
echo ""
echo ""

echo "[OK] Compose Lab 011 tests complete."
