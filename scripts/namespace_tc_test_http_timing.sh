#!/usr/bin/env bash
set -euo pipefail

NS="lab_client"
URL="${1:-http://10.10.2.2:8080}"

if ! command -v ip >/dev/null 2>&1; then
  echo "[ERROR] ip command not found. This lab requires Linux iproute2."
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "[ERROR] curl not found."
  exit 1
fi

if ! ip netns list | awk '{print $1}' | grep -qx "$NS"; then
  echo "[ERROR] Missing namespace: $NS"
  echo "[INFO] Run: ./scripts/setup_namespace_client_router_server.sh"
  exit 1
fi

echo "============================================================"
echo "HTTP TIMING TEST FROM $NS"
echo "URL: $URL"
echo "Date: $(date)"
echo "============================================================"

sudo ip netns exec "$NS" curl -o /dev/null -s -w \
"DNS lookup: %{time_namelookup}
Connect: %{time_connect}
Start transfer: %{time_starttransfer}
Total: %{time_total}
Speed download: %{speed_download} bytes/s
HTTP code: %{http_code}
" "$URL"
