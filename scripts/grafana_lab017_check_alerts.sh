#!/usr/bin/env bash
set -euo pipefail

PROM_URL="${1:-http://127.0.0.1:9096}"

echo "============================================================"
echo "GRAFANA LAB 017 ALERT CHECK"
echo "Date: $(date)"
echo "============================================================"

if ! curl -sS --max-time 5 "$PROM_URL/-/ready" >/dev/null; then
  echo "[ERROR] Prometheus not reachable. Run ./scripts/grafana_lab017_up.sh"
  exit 1
fi

echo ""
echo "===== RULES ====="
curl -sS "$PROM_URL/api/v1/rules"
echo ""
echo ""
echo "===== ALERTS ====="
curl -sS "$PROM_URL/api/v1/alerts"
echo ""
echo "[OK] Alert check complete."
