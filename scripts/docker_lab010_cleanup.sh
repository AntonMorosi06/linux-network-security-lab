#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="lab010_api_server"
NETWORK_NAME="lab010_bridge_net"

echo "============================================================"
echo "DOCKER LAB 010 CLEANUP"
echo "Date: $(date)"
echo "============================================================"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker command not found."
  exit 1
fi

if docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
  docker rm -f "$CONTAINER_NAME" >/dev/null
  echo "[OK] Removed container: $CONTAINER_NAME"
else
  echo "[INFO] Container not present: $CONTAINER_NAME"
fi

if docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
  docker network rm "$NETWORK_NAME" >/dev/null
  echo "[OK] Removed network: $NETWORK_NAME"
else
  echo "[INFO] Network not present: $NETWORK_NAME"
fi

echo ""
echo "[INFO] Remaining lab010 resources:"
docker ps -a --filter "name=lab010" || true
docker network ls --filter "name=lab010" || true

echo ""
echo "[OK] Cleanup complete."
