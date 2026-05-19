#!/usr/bin/env bash
set -euo pipefail

PROM_URL="${1:-http://127.0.0.1:9095}"

query_prom() {
  local query="$1"
  echo ""
  echo "QUERY: $query"
  curl -sS --get "$PROM_URL/api/v1/query" --data-urlencode "query=$query"
  echo ""
}

echo "============================================================"
echo "CAPSTONE LAB 015 PROMETHEUS QUERY"
echo "Date: $(date)"
echo "============================================================"

if ! curl -sS --max-time 5 "$PROM_URL/-/ready" >/dev/null; then
  echo "[ERROR] Prometheus not reachable. Run ./scripts/capstone_lab015_up.sh"
  exit 1
fi

query_prom "up"
query_prom "capstone_requests_total"
query_prom "capstone_auth_failures_total"
query_prom "capstone_commands_total"
query_prom "capstone_not_found_total"
query_prom "capstone_uptime_seconds"
query_prom "rate(capstone_requests_total[1m])"

echo "[OK] Capstone metric queries complete."
