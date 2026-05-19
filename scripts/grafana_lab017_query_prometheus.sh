#!/usr/bin/env bash
set -euo pipefail

PROM_URL="${1:-http://127.0.0.1:9096}"

query_prom() {
  local query="$1"
  echo ""
  echo "QUERY: $query"
  curl -sS --get "$PROM_URL/api/v1/query" --data-urlencode "query=$query"
  echo ""
}

echo "============================================================"
echo "GRAFANA LAB 017 PROMETHEUS QUERY"
echo "Date: $(date)"
echo "============================================================"

if ! curl -sS --max-time 5 "$PROM_URL/-/ready" >/dev/null; then
  echo "[ERROR] Prometheus not reachable. Run ./scripts/grafana_lab017_up.sh"
  exit 1
fi

query_prom "up"
query_prom "lab017_requests_total"
query_prom "lab017_error_requests_total"
query_prom "lab017_not_found_total"
query_prom "lab017_uptime_seconds"
query_prom "rate(lab017_requests_total[1m])"

echo "[OK] Prometheus queries complete."
