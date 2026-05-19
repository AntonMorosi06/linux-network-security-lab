#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab012/compose.yaml"

echo "============================================================"
echo "MONITORING LAB 012 DOWN"
echo "============================================================"

docker compose -f "$COMPOSE_FILE" down

echo "[OK] Monitoring stack stopped and removed."
docker ps -a --filter "name=lab012" || true
docker network ls | grep -E 'lab012|linux-sec-lab012' || true
