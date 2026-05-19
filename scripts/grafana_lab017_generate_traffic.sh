#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://127.0.0.1:8901}"

echo "============================================================"
echo "GRAFANA LAB 017 GENERATE TRAFFIC"
echo "Date: $(date)"
echo "============================================================"

if ! curl -sS --max-time 3 "$BASE_URL/status" >/dev/null; then
  echo "[ERROR] API not reachable. Run ./scripts/grafana_lab017_up.sh"
  exit 1
fi

for i in $(seq 1 30); do
  curl -s "$BASE_URL/status" >/dev/null
  curl -s "$BASE_URL/health" >/dev/null
done

for i in $(seq 1 4); do
  curl -s "$BASE_URL/error" >/dev/null || true
done

for i in $(seq 1 7); do
  curl -s "$BASE_URL/not_found_$i" >/dev/null || true
done

for i in $(seq 1 5); do
  curl -s "$BASE_URL/metrics" >/dev/null
done

echo "[OK] Controlled Lab 017 traffic generated."
echo "[INFO] Wait 10 seconds, then run:"
echo "  ./scripts/grafana_lab017_query_prometheus.sh"
echo "  ./scripts/grafana_lab017_check_alerts.sh"
