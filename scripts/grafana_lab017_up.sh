#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab017/compose.yaml"

echo "============================================================"
echo "GRAFANA LAB 017 UP"
echo "Date: $(date)"
echo "============================================================"

docker compose -f "$COMPOSE_FILE" up -d --build

echo "[OK] Grafana monitoring stack is running."
echo "[INFO] API URL: http://127.0.0.1:8901/status"
echo "[INFO] Prometheus URL: http://127.0.0.1:9096"
echo "[INFO] Grafana URL: http://127.0.0.1:3001"
echo "[INFO] Grafana login: admin / admin"
docker compose -f "$COMPOSE_FILE" ps
