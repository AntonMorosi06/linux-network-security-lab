#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab015/compose.yaml"

echo "============================================================"
echo "CAPSTONE LAB 015 DOWN"
echo "Date: $(date)"
echo "============================================================"

docker compose -f "$COMPOSE_FILE" down

echo "[OK] Capstone stack stopped and removed."
docker ps -a --filter "name=lab015" || true
docker network ls | grep -E 'lab015|linux-sec-lab015' || true
