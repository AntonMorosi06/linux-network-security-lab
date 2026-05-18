#!/usr/bin/env bash
set -euo pipefail

if ! command -v ip >/dev/null 2>&1; then
  echo "[ERROR] ip command not found. This lab requires Linux iproute2."
  exit 1
fi

if ! ip netns list | awk '{print $1}' | grep -qx "lab_router"; then
  echo "[ERROR] Missing namespace: lab_router"
  echo "[INFO] Run:"
  echo "  ./scripts/setup_namespace_client_router_server.sh"
  exit 1
fi

if ! command -v tcpdump >/dev/null 2>&1; then
  echo "[ERROR] tcpdump not found."
  echo "[INFO] Install it on Debian/Ubuntu with:"
  echo "  sudo apt install tcpdump -y"
  exit 1
fi

echo "============================================================"
echo "CAPTURE HTTP TRAFFIC INSIDE lab_router NAMESPACE"
echo "Date: $(date)"
echo "============================================================"
echo ""
echo "[INFO] Interface: veth_router_server"
echo "[INFO] Filter: port 8080"
echo "[INFO] Packet count: 30"
echo ""
echo "[INFO] In another terminal, generate traffic with:"
echo "  sudo ip netns exec lab_client curl http://10.10.2.2:8080"
echo ""

sudo ip netns exec lab_router tcpdump -i veth_router_server port 8080 -c 30
