#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab012/compose.yaml"

echo "============================================================"
echo "MONITORING LAB 012 UP"
echo "============================================================"

docker compose -f "$COMPOSE_FILE" up -d --build

echo "[OK] Monitoring stack is running."
echo "[INFO] API URL: http://127.0.0.1:8701/status"
echo "[INFO] Metrics URL: http://127.0.0.1:8701/metrics"
echo "[INFO] Prometheus URL: http://127.0.0.1:9090"
docker compose -f "$COMPOSE_FILE" ps
