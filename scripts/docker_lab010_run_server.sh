#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="linux-sec-lab010-api"
NETWORK_NAME="lab010_bridge_net"
CONTAINER_NAME="lab010_api_server"
HOST_BIND="127.0.0.1"
HOST_PORT="8500"
CONTAINER_PORT="8500"

echo "============================================================"
echo "DOCKER LAB 010 RUN SERVER"
echo "Container: $CONTAINER_NAME"
echo "Network: $NETWORK_NAME"
echo "Host URL: http://$HOST_BIND:$HOST_PORT/status"
echo "Date: $(date)"
echo "============================================================"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker command not found."
  exit 1
fi

if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
  echo "[ERROR] Missing image: $IMAGE_NAME"
  echo "[INFO] Run: ./scripts/docker_lab010_build_image.sh"
  exit 1
fi

if ! docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
  echo "[INFO] Missing network. Creating it now."
  ./scripts/docker_lab010_create_network.sh
fi

if docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
  echo "[INFO] Removing existing container: $CONTAINER_NAME"
  docker rm -f "$CONTAINER_NAME" >/dev/null
fi

docker run -d \
  --name "$CONTAINER_NAME" \
  --network "$NETWORK_NAME" \
  -p "$HOST_BIND:$HOST_PORT:$CONTAINER_PORT" \
  "$IMAGE_NAME"

echo ""
echo "[OK] Server container running: $CONTAINER_NAME"
echo "[INFO] Host URL: http://$HOST_BIND:$HOST_PORT/status"
docker ps --filter "name=$CONTAINER_NAME"
