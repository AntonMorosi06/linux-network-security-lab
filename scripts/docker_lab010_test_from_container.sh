#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="linux-sec-lab010-api"
NETWORK_NAME="lab010_bridge_net"
CLIENT_NAME="lab010_api_client"
TARGET_URL="${1:-http://lab010_api_server:8500/status}"

echo "============================================================"
echo "DOCKER LAB 010 TEST FROM CLIENT CONTAINER"
echo "Client: $CLIENT_NAME"
echo "Network: $NETWORK_NAME"
echo "Target URL: $TARGET_URL"
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
  echo "[ERROR] Missing network: $NETWORK_NAME"
  echo "[INFO] Run: ./scripts/docker_lab010_create_network.sh"
  exit 1
fi

echo "[CLIENT] Testing container DNS name: lab010_api_server"

docker run --rm \
  --name "$CLIENT_NAME" \
  --network "$NETWORK_NAME" \
  "$IMAGE_NAME" \
  python3 /app/client_check.py "$TARGET_URL"

echo ""
echo "[OK] Container-to-container test complete."
