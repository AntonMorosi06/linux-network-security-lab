#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab011/compose.yaml"

echo "============================================================"
echo "COMPOSE LAB 011 INSPECT"
echo "Compose file: $COMPOSE_FILE"
echo "Date: $(date)"
echo "============================================================"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker command not found."
  exit 1
fi

echo ""
echo "===== DOCKER VERSION ====="
docker --version
docker compose version || true

echo ""
echo "===== COMPOSE PS ====="
docker compose -f "$COMPOSE_FILE" ps || true

echo ""
echo "===== CONTAINERS ====="
docker ps --filter "name=lab011" || true

echo ""
echo "===== NETWORKS ====="
docker network ls | grep -E 'lab011|linux-sec-lab011' || true

echo ""
echo "===== REVERSE PROXY INSPECT SUMMARY ====="
if docker container inspect lab011_reverse_proxy >/dev/null 2>&1; then
  docker inspect lab011_reverse_proxy --format 'Name: {{.Name}}'
  docker inspect lab011_reverse_proxy --format 'State: {{json .State}}'
  docker inspect lab011_reverse_proxy --format 'Ports: {{json .NetworkSettings.Ports}}'
  docker inspect lab011_reverse_proxy --format 'Networks: {{json .NetworkSettings.Networks}}'
else
  echo "[INFO] lab011_reverse_proxy not found."
fi

echo ""
echo "===== API INSPECT SUMMARY ====="
if docker container inspect lab011_api >/dev/null 2>&1; then
  docker inspect lab011_api --format 'Name: {{.Name}}'
  docker inspect lab011_api --format 'State: {{json .State}}'
  docker inspect lab011_api --format 'Ports: {{json .NetworkSettings.Ports}}'
  docker inspect lab011_api --format 'Networks: {{json .NetworkSettings.Networks}}'
else
  echo "[INFO] lab011_api not found."
fi
