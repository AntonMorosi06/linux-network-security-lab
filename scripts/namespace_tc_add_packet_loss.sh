#!/usr/bin/env bash
set -euo pipefail

NS="lab_client"
IFACE="veth_client"
LOSS="${1:-30%}"

if ! command -v ip >/dev/null 2>&1; then
  echo "[ERROR] ip command not found. This lab requires Linux iproute2."
  exit 1
fi

if ! command -v tc >/dev/null 2>&1; then
  echo "[ERROR] tc command not found. Install iproute2."
  exit 1
fi

if ! ip netns list | awk '{print $1}' | grep -qx "$NS"; then
  echo "[ERROR] Missing namespace: $NS"
  echo "[INFO] Run: ./scripts/setup_namespace_client_router_server.sh"
  exit 1
fi

echo "============================================================"
echo "ADD PACKET LOSS WITH NETEM"
echo "Namespace: $NS"
echo "Interface: $IFACE"
echo "Loss: $LOSS"
echo "Date: $(date)"
echo "============================================================"

sudo ip netns exec "$NS" tc qdisc del dev "$IFACE" root 2>/dev/null || true
sudo ip netns exec "$NS" tc qdisc add dev "$IFACE" root netem loss "$LOSS"

echo "[OK] Packet loss applied."
sudo ip netns exec "$NS" tc qdisc show dev "$IFACE"
