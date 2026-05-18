#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="linux-sec-lab010-api"
BUILD_DIR="docker/lab010"

echo "============================================================"
echo "DOCKER LAB 010 BUILD IMAGE"
echo "Image: $IMAGE_NAME"
echo "Build dir: $BUILD_DIR"
echo "Date: $(date)"
echo "============================================================"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker command not found."
  exit 1
fi

docker build -t "$IMAGE_NAME" "$BUILD_DIR"

echo ""
echo "[OK] Docker image built: $IMAGE_NAME"
docker image ls "$IMAGE_NAME"
