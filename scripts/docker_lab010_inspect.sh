#!/usr/bin/env bash
set -euo pipefail

NETWORK_NAME="lab010_bridge_net"
CONTAINER_NAME="lab010_api_server"

echo "============================================================"
echo "DOCKER LAB 010 INSPECT"
echo "Date: $(date)"
echo "============================================================"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker command not found."
  exit 1
fi

echo ""
echo "===== DOCKER VERSION ====="
docker --version

echo ""
echo "===== RUNNING LAB CONTAINERS ====="
docker ps --filter "name=lab010" || true

echo ""
echo "===== LAB NETWORKS ====="
docker network ls --filter "name=$NETWORK_NAME" || true

echo ""
echo "===== NETWORK INSPECT ====="
if docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
  docker network inspect "$NETWORK_NAME"
else
  echo "[INFO] Network not found: $NETWORK_NAME"
fi

echo ""
echo "===== CONTAINER INSPECT SUMMARY ====="
if docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
  echo "Name:"
  docker inspect "$CONTAINER_NAME" --format '{{.Name}}'
  echo "State:"
  docker inspect "$CONTAINER_NAME" --format '{{json .State}}'
  echo "Network settings:"
  docker inspect "$CONTAINER_NAME" --format '{{json .NetworkSettings.Networks}}'
  echo "Port bindings:"
  docker inspect "$CONTAINER_NAME" --format '{{json .NetworkSettings.Ports}}'
else
  echo "[INFO] Container not found: $CONTAINER_NAME"
fi
