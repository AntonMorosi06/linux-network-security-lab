#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab015/compose.yaml"

echo "============================================================"
echo "CAPSTONE LAB 015 UP"
echo "Date: $(date)"
echo "============================================================"

docker compose -f "$COMPOSE_FILE" up -d --build

echo "[OK] Capstone stack is running."
echo "[INFO] Proxy URL: http://127.0.0.1:8800/status"
echo "[INFO] Prometheus URL: http://127.0.0.1:9095"
docker compose -f "$COMPOSE_FILE" ps
