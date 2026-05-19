#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab017/compose.yaml"

echo "============================================================"
echo "GRAFANA LAB 017 INSPECT"
echo "Date: $(date)"
echo "============================================================"

docker --version
docker compose version || true
echo ""
docker compose -f "$COMPOSE_FILE" ps || true
echo ""
docker ps --filter "name=lab017" || true
echo ""
docker network ls | grep -E 'lab017|linux-sec-lab017' || true
echo ""
echo "===== PROMETHEUS CONFIG ====="
cat docker/lab017/prometheus/prometheus.yml
echo ""
echo "===== ALERT RULES ====="
cat docker/lab017/prometheus/alert_rules.yml
