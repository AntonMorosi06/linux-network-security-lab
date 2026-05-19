#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://127.0.0.1:8800}"
TOKEN="capstone-local-token"

echo "============================================================"
echo "CAPSTONE LAB 015 GENERATE TRAFFIC"
echo "Date: $(date)"
echo "============================================================"

if ! curl -sS --max-time 3 "$BASE_URL/status" >/dev/null; then
  echo "[ERROR] Capstone API not reachable. Run ./scripts/capstone_lab015_up.sh"
  exit 1
fi

for i in $(seq 1 20); do
  curl -s "$BASE_URL/status" >/dev/null
  curl -s "$BASE_URL/health" >/dev/null
done

for i in $(seq 1 8); do
  curl -s "$BASE_URL/protected" >/dev/null || true
done

for i in $(seq 1 8); do
  curl -s -H "X-API-Key: $TOKEN" "$BASE_URL/protected" >/dev/null
done

for i in $(seq 1 6); do
  curl -s -H "X-API-Key: $TOKEN" -H "Content-Type: application/json" -d '{"command":"heartbeat"}' "$BASE_URL/command" >/dev/null
done

for i in $(seq 1 6); do
  curl -s "$BASE_URL/not_found_$i" >/dev/null || true
done

for i in $(seq 1 5); do
  curl -s "$BASE_URL/metrics" >/dev/null
done

echo "[OK] Controlled capstone traffic generated."
