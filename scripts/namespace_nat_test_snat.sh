#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "SNAT TEST HELPER"
echo "Date: $(date)"
echo "============================================================"

if ! command -v ip >/dev/null 2>&1; then
  echo "[ERROR] ip command not found. This lab requires Linux iproute2."
  exit 1
fi

for ns in lab_client lab_router lab_server; do
  if ! ip netns list | awk '{print $1}' | grep -qx "$ns"; then
    echo "[ERROR] Missing namespace: $ns"
    echo "[INFO] Run: ./scripts/setup_namespace_client_router_server.sh"
    exit 1
  fi
done

if ! command -v nft >/dev/null 2>&1; then
  echo "[ERROR] nft command not found. Install nftables."
  exit 1
fi

echo ""
echo "[1] Current router nftables ruleset"
sudo ip netns exec lab_router nft list ruleset || true

echo ""
echo "[2] Namespace routes"
echo "--- lab_client ---"
sudo ip netns exec lab_client ip route
echo "--- lab_router ---"
sudo ip netns exec lab_router ip route
echo "--- lab_server ---"
sudo ip netns exec lab_server ip route

echo ""
echo "[3] SNAT manual test procedure"
cat <<'INSTRUCTIONS'

Open terminal 1 and start the HTTP server:

  ./scripts/start_namespace_http_server.sh

Open terminal 2 and capture traffic on the server side:

  sudo ip netns exec lab_server tcpdump -i veth_server port 8080 -c 10

Open terminal 3 and generate traffic from the client:

  sudo ip netns exec lab_client curl http://10.10.2.2:8080

Expected tcpdump result when SNAT is enabled:

  IP 10.10.2.1.xxxxx > 10.10.2.2.8080: Flags [S]

Meaning:
  The original client is 10.10.1.2, but the server sees 10.10.2.1 because the router rewrites the source address.

INSTRUCTIONS

echo ""
echo "[OK] SNAT test helper complete."
