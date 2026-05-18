#!/usr/bin/env bash
set -euo pipefail

NS="lab_client"
TARGET="${1:-10.10.2.2}"
COUNT="${2:-10}"

if ! command -v ip >/dev/null 2>&1; then
  echo "[ERROR] ip command not found. This lab requires Linux iproute2."
  exit 1
fi

if ! ip netns list | awk '{print $1}' | grep -qx "$NS"; then
  echo "[ERROR] Missing namespace: $NS"
  echo "[INFO] Run: ./scripts/setup_namespace_client_router_server.sh"
  exit 1
fi

echo "============================================================"
echo "PING LATENCY TEST FROM $NS"
echo "Target: $TARGET"
echo "Count: $COUNT"
echo "Date: $(date)"
echo "============================================================"

sudo ip netns exec "$NS" ping -c "$COUNT" "$TARGET"
