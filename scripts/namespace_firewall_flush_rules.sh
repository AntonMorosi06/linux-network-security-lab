#!/usr/bin/env bash
set -euo pipefail

NS="lab_router"

if ! command -v ip >/dev/null 2>&1; then
  echo "[ERROR] ip command not found. This lab requires Linux iproute2."
  exit 1
fi

if ! command -v nft >/dev/null 2>&1; then
  echo "[ERROR] nft command not found. Install nftables."
  exit 1
fi

if ! ip netns list | awk '{print $1}' | grep -qx "$NS"; then
  echo "[ERROR] Missing namespace: $NS"
  echo "[INFO] Run: ./scripts/setup_namespace_client_router_server.sh"
  exit 1
fi

echo "[INFO] Flushing nftables ruleset inside $NS"
sudo ip netns exec "$NS" nft flush ruleset
echo "[OK] Ruleset flushed inside $NS"
