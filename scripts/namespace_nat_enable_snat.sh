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

echo "============================================================"
echo "ENABLE SNAT INSIDE $NS"
echo "Date: $(date)"
echo "============================================================"

sudo ip netns exec "$NS" nft flush ruleset

sudo ip netns exec "$NS" nft add table ip lab_nat
sudo ip netns exec "$NS" nft add chain ip lab_nat postrouting '{ type nat hook postrouting priority 100 ; }'
sudo ip netns exec "$NS" nft add rule ip lab_nat postrouting ip saddr 10.10.1.2 ip daddr 10.10.2.2 snat to 10.10.2.1

echo "[OK] SNAT enabled."
echo "[INFO] Server-side traffic should now appear to come from 10.10.2.1 instead of 10.10.1.2."
echo ""
sudo ip netns exec "$NS" nft list ruleset
