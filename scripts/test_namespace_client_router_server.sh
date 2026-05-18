#!/usr/bin/env bash
set -euo pipefail

require_namespace() {
  local ns="$1"
  if ! ip netns list | awk '{print $1}' | grep -qx "$ns"; then
    echo "[ERROR] Missing namespace: $ns"
    echo "[INFO] Run:"
    echo "  ./scripts/setup_namespace_client_router_server.sh"
    exit 1
  fi
}

run_ping() {
  local ns="$1"
  local target="$2"
  local label="$3"

  echo ""
  echo "[TEST] $label"
  if sudo ip netns exec "$ns" ping -c 3 "$target"; then
    echo "[OK] $label"
  else
    echo "[FAIL] $label"
    return 1
  fi
}

echo "============================================================"
echo "TEST NETWORK NAMESPACE CLIENT-ROUTER-SERVER LAB"
echo "Date: $(date)"
echo "============================================================"

if ! command -v ip >/dev/null 2>&1; then
  echo "[ERROR] ip command not found. This lab requires Linux iproute2."
  exit 1
fi

require_namespace lab_client
require_namespace lab_router
require_namespace lab_server

echo ""
echo "[1] Namespace list"
ip netns list

echo ""
echo "[2] Address summary"
echo "--- lab_client ---"
sudo ip netns exec lab_client ip -br addr
echo "--- lab_router ---"
sudo ip netns exec lab_router ip -br addr
echo "--- lab_server ---"
sudo ip netns exec lab_server ip -br addr

echo ""
echo "[3] Route summary"
echo "--- lab_client ---"
sudo ip netns exec lab_client ip route
echo "--- lab_router ---"
sudo ip netns exec lab_router ip route
echo "--- lab_server ---"
sudo ip netns exec lab_server ip route

echo ""
echo "[4] Router forwarding"
sudo ip netns exec lab_router sysctl net.ipv4.ip_forward

echo ""
echo "[5] Ping tests"
run_ping lab_client 10.10.1.1 "client -> router client-side interface"
run_ping lab_server 10.10.2.1 "server -> router server-side interface"
run_ping lab_client 10.10.2.2 "client -> server through router"
run_ping lab_server 10.10.1.2 "server -> client through router"

echo ""
echo "============================================================"
echo "[OK] All namespace topology tests completed"
echo "============================================================"
