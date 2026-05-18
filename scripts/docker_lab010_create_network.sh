#!/usr/bin/env bash
set -euo pipefail

NETWORK_NAME="lab010_bridge_net"

echo "============================================================"
echo "DOCKER LAB 010 CREATE NETWORK"
echo "Network: $NETWORK_NAME"
echo "Date: $(date)"
echo "============================================================"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker command not found."
  exit 1
fi

if docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
  echo "[INFO] Network already exists: $NETWORK_NAME"
else
  docker network create "$NETWORK_NAME"
  echo "[OK] Network created: $NETWORK_NAME"
fi

echo ""
echo "[OK] Network ready: $NETWORK_NAME"
docker network inspect "$NETWORK_NAME" --format '{{json .Name}} {{json .Driver}} {{json .Scope}}'
