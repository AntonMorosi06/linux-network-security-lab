#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab011/compose.yaml"

echo "============================================================"
echo "COMPOSE LAB 011 DOWN"
echo "Compose file: $COMPOSE_FILE"
echo "Date: $(date)"
echo "============================================================"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker command not found."
  exit 1
fi

docker compose -f "$COMPOSE_FILE" down

echo ""
echo "[OK] Compose stack stopped and removed."
echo ""
echo "[INFO] Remaining lab011 resources:"
docker ps -a --filter "name=lab011" || true
docker network ls | grep -E 'lab011|linux-sec-lab011' || true
