#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab015/compose.yaml"

echo "============================================================"
echo "CAPSTONE LAB 015 INSPECT"
echo "Date: $(date)"
echo "============================================================"

docker --version
docker compose version || true
echo ""
docker compose -f "$COMPOSE_FILE" ps || true
echo ""
docker ps --filter "name=lab015" || true
echo ""
docker network ls | grep -E 'lab015|linux-sec-lab015' || true
echo ""
cat docker/lab015/prometheus/prometheus.yml
