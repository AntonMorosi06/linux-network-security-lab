#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab017/compose.yaml"
LINES="${1:-200}"

echo "============================================================"
echo "GRAFANA LAB 017 LOGS"
echo "Date: $(date)"
echo "============================================================"

docker compose -f "$COMPOSE_FILE" logs --tail "$LINES"
