#!/usr/bin/env bash
set -euo pipefail

require_linux_netns() {
  if ! command -v ip >/dev/null 2>&1; then
    echo "[ERROR] ip command not found. Install iproute2 on Linux."
    exit 1
  fi

  if ! ip netns list >/dev/null 2>&1; then
    echo "[ERROR] ip netns is not available or cannot be used here."
    echo "[INFO] This lab requires Linux network namespaces."
    exit 1
  fi
}

delete_namespace_if_exists() {
  local ns="$1"
  if ip netns list | awk '{print $1}' | grep -qx "$ns"; then
    echo "[INFO] Removing existing namespace: $ns"
    sudo ip netns delete "$ns" || true
  fi
}

create_namespace() {
  local ns="$1"
  sudo ip netns add "$ns"
  echo "[OK] Created namespace: $ns"
}

echo "============================================================"
echo "SETUP NETWORK NAMESPACE CLIENT-ROUTER-SERVER LAB"
echo "Date: $(date)"
echo "============================================================"

require_linux_netns

echo ""
echo "[1] Cleaning old lab namespaces if present"
delete_namespace_if_exists lab_client
delete_namespace_if_exists lab_router
delete_namespace_if_exists lab_server

echo ""
echo "[2] Creating namespaces"
create_namespace lab_client
create_namespace lab_router
create_namespace lab_server

echo ""
echo "[3] Creating veth pairs"
sudo ip link add veth_client type veth peer name veth_router_client
sudo ip link add veth_server type veth peer name veth_router_server
echo "[OK] Created veth pairs"

echo ""
echo "[4] Moving interfaces into namespaces"
sudo ip link set veth_client netns lab_client
sudo ip link set veth_router_client netns lab_router
sudo ip link set veth_server netns lab_server
sudo ip link set veth_router_server netns lab_router
echo "[OK] Moved interfaces"

echo ""
echo "[5] Assigning IP addresses"
sudo ip netns exec lab_client ip addr add 10.10.1.2/24 dev veth_client
sudo ip netns exec lab_router ip addr add 10.10.1.1/24 dev veth_router_client
sudo ip netns exec lab_server ip addr add 10.10.2.2/24 dev veth_server
sudo ip netns exec lab_router ip addr add 10.10.2.1/24 dev veth_router_server
echo "[OK] Assigned IP addresses"

echo ""
echo "[6] Bringing interfaces up"
sudo ip netns exec lab_client ip link set lo up
sudo ip netns exec lab_router ip link set lo up
sudo ip netns exec lab_server ip link set lo up

sudo ip netns exec lab_client ip link set veth_client up
sudo ip netns exec lab_router ip link set veth_router_client up
sudo ip netns exec lab_server ip link set veth_server up
sudo ip netns exec lab_router ip link set veth_router_server up
echo "[OK] Interfaces are up"

echo ""
echo "[7] Adding default routes"
sudo ip netns exec lab_client ip route add default via 10.10.1.1
sudo ip netns exec lab_server ip route add default via 10.10.2.1
echo "[OK] Default routes configured"

echo ""
echo "[8] Enabling IPv4 forwarding in lab_router"
sudo ip netns exec lab_router sysctl -w net.ipv4.ip_forward=1
echo "[OK] Enabled IPv4 forwarding inside lab_router"

echo ""
echo "[9] Final topology summary"
echo "--- lab_client ---"
sudo ip netns exec lab_client ip -br addr
sudo ip netns exec lab_client ip route

echo ""
echo "--- lab_router ---"
sudo ip netns exec lab_router ip -br addr
sudo ip netns exec lab_router ip route
sudo ip netns exec lab_router sysctl net.ipv4.ip_forward

echo ""
echo "--- lab_server ---"
sudo ip netns exec lab_server ip -br addr
sudo ip netns exec lab_server ip route

echo ""
echo "[OK] Namespace topology ready"
echo ""
echo "Next commands:"
echo "./scripts/test_namespace_client_router_server.sh"
echo "./scripts/start_namespace_http_server.sh"
