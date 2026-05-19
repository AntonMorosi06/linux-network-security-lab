#!/usr/bin/env bash
set -euo pipefail

PROM_URL="${1:-http://127.0.0.1:9090}"

query_prom() {
  local query="$1"
  echo ""
  echo "------------------------------------------------------------"
  echo "QUERY: $query"
  echo "------------------------------------------------------------"
  curl -sS --get "$PROM_URL/api/v1/query" --data-urlencode "query=$query"
  echo ""
}

echo "============================================================"
echo "MONITORING LAB 012 PROMETHEUS QUERY"
echo "Prometheus URL: $PROM_URL"
echo "============================================================"

if ! curl -sS --max-time 5 "$PROM_URL/-/ready" >/dev/null; then
  echo "[ERROR] Prometheus is not reachable or not ready."
  exit 1
fi

query_prom "up"
query_prom "lab012_requests_total"
query_prom "lab012_status_requests_total"
query_prom "lab012_error_requests_total"
query_prom "lab012_not_found_requests_total"
query_prom "lab012_uptime_seconds"
query_prom "rate(lab012_requests_total[1m])"

echo "[OK] Prometheus query test complete."
