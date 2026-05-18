#!/usr/bin/env bash
set -euo pipefail

NS="lab_client"
IFACE="veth_client"
RATE="${1:-512kbit}"
BURST="${2:-32kbit}"
LATENCY="${3:-400ms}"

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
echo "ADD BANDWIDTH LIMIT WITH TBF"
echo "Namespace: $NS"
echo "Interface: $IFACE"
echo "Rate: $RATE"
echo "Burst: $BURST"
echo "Latency: $LATENCY"
echo "Date: $(date)"
echo "============================================================"

sudo ip netns exec "$NS" tc qdisc del dev "$IFACE" root 2>/dev/null || true
sudo ip netns exec "$NS" tc qdisc add dev "$IFACE" root tbf rate "$RATE" burst "$BURST" latency "$LATENCY"

echo "[OK] Bandwidth limit applied."
sudo ip netns exec "$NS" tc qdisc show dev "$IFACE"
