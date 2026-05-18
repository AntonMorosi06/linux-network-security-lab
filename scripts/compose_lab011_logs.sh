#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab011/compose.yaml"
LINES="${1:-120}"

echo "============================================================"
echo "COMPOSE LAB 011 LOGS"
echo "Compose file: $COMPOSE_FILE"
echo "Lines: $LINES"
echo "Date: $(date)"
echo "============================================================"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker command not found."
  exit 1
fi

docker compose -f "$COMPOSE_FILE" logs --tail "$LINES"
