#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://127.0.0.1:8701}"

echo "============================================================"
echo "MONITORING LAB 012 GENERATE TRAFFIC"
echo "Base URL: $BASE_URL"
echo "============================================================"

if ! curl -sS --max-time 3 "$BASE_URL/status" >/dev/null; then
  echo "[ERROR] API is not reachable. Start stack with ./scripts/monitoring_lab012_up.sh"
  exit 1
fi

for i in $(seq 1 30); do
  curl -s "$BASE_URL/status" >/dev/null
  curl -s "$BASE_URL/health" >/dev/null
done

for i in $(seq 1 10); do
  curl -s "$BASE_URL/metrics" >/dev/null
done

for i in $(seq 1 5); do
  curl -s "$BASE_URL/error" >/dev/null || true
done

for i in $(seq 1 5); do
  curl -s "$BASE_URL/not_found_$i" >/dev/null || true
done

echo "[OK] Traffic generated. Wait a few seconds, then query Prometheus."
