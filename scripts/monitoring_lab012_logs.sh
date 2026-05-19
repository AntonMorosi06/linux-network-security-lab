#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab012/compose.yaml"
LINES="${1:-160}"

echo "============================================================"
echo "MONITORING LAB 012 LOGS"
echo "============================================================"

docker compose -f "$COMPOSE_FILE" logs --tail "$LINES"
