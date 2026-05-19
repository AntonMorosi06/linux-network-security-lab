#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab017/compose.yaml"

echo "============================================================"
echo "GRAFANA LAB 017 DOWN"
echo "Date: $(date)"
echo "============================================================"

docker compose -f "$COMPOSE_FILE" down

echo "[OK] Grafana monitoring stack stopped and removed."
docker ps -a --filter "name=lab017" || true
docker network ls | grep -E 'lab017|linux-sec-lab017' || true
