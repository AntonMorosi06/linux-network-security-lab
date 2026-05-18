#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://127.0.0.1:8300}"
TOKEN="microbot-lab-token"

if ! command -v curl >/dev/null 2>&1; then
  echo "[ERROR] curl not found."
  exit 1
fi

echo "============================================================"
echo "GENERATE CONTROLLED API LAB TRAFFIC"
echo "Base URL: $BASE_URL"
echo "Date: $(date)"
echo "============================================================"
echo ""

echo "[1] Checking API availability"
if ! curl -sS --max-time 3 "$BASE_URL/status" >/dev/null; then
  echo "[ERROR] API is not reachable."
  echo "[INFO] Start it with:"
  echo "  python3 scripts/local_json_api_server_8300.py"
  exit 1
fi

echo "[OK] API reachable."

echo ""
echo "[2] Generating normal traffic"
for i in $(seq 1 15); do
  curl -s "$BASE_URL/status" >/dev/null
  curl -s "$BASE_URL/health" >/dev/null
done

echo "[3] Generating metrics traffic"
for i in $(seq 1 5); do
  curl -s "$BASE_URL/metrics" >/dev/null
done

echo "[4] Generating authorized protected traffic"
for i in $(seq 1 5); do
  curl -s -H "X-Lab-Token: $TOKEN" "$BASE_URL/protected" >/dev/null
done

echo "[5] Generating unauthorized protected traffic"
for i in $(seq 1 8); do
  curl -s "$BASE_URL/protected" >/dev/null
done

echo "[6] Generating not-found traffic"
for i in $(seq 1 12); do
  curl -s "$BASE_URL/not_found_$i" >/dev/null
done

echo ""
echo "[OK] Controlled API traffic generated."
echo ""
echo "[INFO] Logs should be available under:"
echo "  ~/linux_lab/json_api_mini_soc/logs/api_events.jsonl"
