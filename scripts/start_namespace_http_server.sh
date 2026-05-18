#!/usr/bin/env bash
set -euo pipefail

if ! command -v ip >/dev/null 2>&1; then
  echo "[ERROR] ip command not found. This lab requires Linux iproute2."
  exit 1
fi

if ! ip netns list | awk '{print $1}' | grep -qx "lab_server"; then
  echo "[ERROR] Missing namespace: lab_server"
  echo "[INFO] Run:"
  echo "  ./scripts/setup_namespace_client_router_server.sh"
  exit 1
fi

echo "============================================================"
echo "START HTTP SERVER INSIDE lab_server NAMESPACE"
echo "Date: $(date)"
echo "============================================================"
echo ""
echo "[INFO] Starting HTTP server inside lab_server"
echo "[INFO] URL from lab_client: http://10.10.2.2:8080"
echo "[INFO] Stop with CTRL + C"
echo ""

sudo ip netns exec lab_server bash -c '
set -e
mkdir -p /tmp/lab_server_http
cd /tmp/lab_server_http
echo "HTTP server inside lab_server namespace" > index.html
python3 -m http.server 8080 --bind 10.10.2.2
'
