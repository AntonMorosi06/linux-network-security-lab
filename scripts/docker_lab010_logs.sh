#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="lab010_api_server"

echo "============================================================"
echo "DOCKER LAB 010 LOGS"
echo "Container: $CONTAINER_NAME"
echo "Date: $(date)"
echo "============================================================"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker command not found."
  exit 1
fi

if ! docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
  echo "[ERROR] Container not found: $CONTAINER_NAME"
  echo "[INFO] Run: ./scripts/docker_lab010_run_server.sh"
  exit 1
fi

docker logs "$CONTAINER_NAME"
