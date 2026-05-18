#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab011/compose.yaml"

echo "============================================================"
echo "COMPOSE LAB 011 UP"
echo "Compose file: $COMPOSE_FILE"
echo "Date: $(date)"
echo "============================================================"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker command not found."
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "[ERROR] docker compose not available."
  exit 1
fi

docker compose -f "$COMPOSE_FILE" up -d --build

echo ""
echo "[OK] Compose stack is running."
echo "[INFO] Proxy URL: http://127.0.0.1:8600/status"
echo ""
docker compose -f "$COMPOSE_FILE" ps
