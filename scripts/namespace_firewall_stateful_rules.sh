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
echo "APPLY STATEFUL FIREWALL RULES INSIDE $NS"
echo "Date: $(date)"
echo "============================================================"

sudo ip netns exec "$NS" nft flush ruleset

sudo ip netns exec "$NS" nft add table inet lab_fw
sudo ip netns exec "$NS" nft add chain inet lab_fw forward '{ type filter hook forward priority 0 ; policy drop ; }'

sudo ip netns exec "$NS" nft add rule inet lab_fw forward ct state established,related counter accept
sudo ip netns exec "$NS" nft add rule inet lab_fw forward ip protocol icmp counter accept
sudo ip netns exec "$NS" nft add rule inet lab_fw forward ip saddr 10.10.1.2 ip daddr 10.10.2.2 tcp dport 8080 ct state new counter accept
sudo ip netns exec "$NS" nft add rule inet lab_fw forward counter drop

echo "[OK] Stateful firewall rules applied."
echo ""
sudo ip netns exec "$NS" nft list ruleset
