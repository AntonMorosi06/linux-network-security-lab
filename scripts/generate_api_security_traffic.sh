#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://127.0.0.1:8400}"
API_TOKEN="microbot-api-token"
ADMIN_TOKEN="microbot-admin-token"

if ! command -v curl >/dev/null 2>&1; then
  echo "[ERROR] curl not found."
  exit 1
fi

echo "============================================================"
echo "GENERATE CONTROLLED API SECURITY TRAFFIC"
echo "Base URL: $BASE_URL"
echo "Date: $(date)"
echo "============================================================"
echo ""

echo "[1] Checking API availability"
if ! curl -sS --max-time 3 "$BASE_URL/public/status" >/dev/null; then
  echo "[ERROR] API is not reachable."
  echo "[INFO] Start it with:"
  echo "  python3 scripts/secure_api_server_8400.py"
  exit 1
fi

echo "[OK] API reachable."

echo ""
echo "[2] Public requests"
for i in $(seq 1 4); do
  curl -s "$BASE_URL/public/status" >/dev/null
  curl -s "$BASE_URL/public/health" >/dev/null
done

echo "[3] Valid API key telemetry requests"
for i in $(seq 1 4); do
  curl -s -H "X-API-Key: $API_TOKEN" "$BASE_URL/api/telemetry?node_id=node-001" >/dev/null
done

echo "[4] Missing API key requests"
for i in $(seq 1 5); do
  curl -s "$BASE_URL/api/telemetry?node_id=node-001" >/dev/null
done

echo "[5] Invalid input requests"
for value in "../../etc/passwd" "bad-node" "node-abc" "node-9999"; do
  curl -s -H "X-API-Key: $API_TOKEN" "$BASE_URL/api/telemetry?node_id=$value" >/dev/null
done

echo "[6] Valid command request"
curl -s \
  -H "X-API-Key: $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"node_id":"node-001","command":"heartbeat"}' \
  "$BASE_URL/api/command" >/dev/null

echo "[7] Invalid command requests"
curl -s \
  -H "X-API-Key: $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"node_id":"node-001","command":"delete_everything"}' \
  "$BASE_URL/api/command" >/dev/null

curl -s \
  -H "X-API-Key: $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"node_id":"bad-node","command":"heartbeat"}' \
  "$BASE_URL/api/command" >/dev/null

echo "[8] Admin forbidden and admin success"
curl -s "$BASE_URL/admin/config" >/dev/null
curl -s -H "X-Admin-Key: $ADMIN_TOKEN" "$BASE_URL/admin/config" >/dev/null

echo "[9] Unknown paths"
for i in $(seq 1 6); do
  curl -s "$BASE_URL/unknown_path_$i" >/dev/null
done

echo "[10] Rate limit burst"
for i in $(seq 1 18); do
  curl -s "$BASE_URL/public/status" >/dev/null || true
done

echo ""
echo "[OK] Controlled API security traffic generated."
echo ""
echo "[INFO] Logs should be available under:"
echo "  ~/linux_lab/api_security_controls/logs/security_events.jsonl"
