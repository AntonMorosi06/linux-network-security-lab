#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab015/compose.yaml"
LINES="${1:-180}"

echo "============================================================"
echo "CAPSTONE LAB 015 LOGS"
echo "Date: $(date)"
echo "============================================================"

docker compose -f "$COMPOSE_FILE" logs --tail "$LINES"
