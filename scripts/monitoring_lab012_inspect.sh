#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker/lab012/compose.yaml"

echo "============================================================"
echo "MONITORING LAB 012 INSPECT"
echo "============================================================"

docker --version
docker compose version || true

echo ""
echo "===== COMPOSE PS ====="
docker compose -f "$COMPOSE_FILE" ps || true

echo ""
echo "===== CONTAINERS ====="
docker ps --filter "name=lab012" || true

echo ""
echo "===== NETWORKS ====="
docker network ls | grep -E 'lab012|linux-sec-lab012' || true

echo ""
echo "===== API INSPECT SUMMARY ====="
if docker container inspect lab012_metrics_api >/dev/null 2>&1; then
  docker inspect lab012_metrics_api --format 'Name: {{.Name}}'
  docker inspect lab012_metrics_api --format 'State: {{json .State}}'
  docker inspect lab012_metrics_api --format 'Ports: {{json .NetworkSettings.Ports}}'
  docker inspect lab012_metrics_api --format 'Networks: {{json .NetworkSettings.Networks}}'
else
  echo "[INFO] lab012_metrics_api not found."
fi

echo ""
echo "===== PROMETHEUS INSPECT SUMMARY ====="
if docker container inspect lab012_prometheus >/dev/null 2>&1; then
  docker inspect lab012_prometheus --format 'Name: {{.Name}}'
  docker inspect lab012_prometheus --format 'State: {{json .State}}'
  docker inspect lab012_prometheus --format 'Ports: {{json .NetworkSettings.Ports}}'
  docker inspect lab012_prometheus --format 'Networks: {{json .NetworkSettings.Networks}}'
else
  echo "[INFO] lab012_prometheus not found."
fi

echo ""
echo "===== PROMETHEUS CONFIG ====="
cat docker/lab012/prometheus/prometheus.yml
