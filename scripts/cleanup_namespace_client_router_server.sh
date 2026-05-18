#!/usr/bin/env bash
set -euo pipefail

delete_namespace_if_exists() {
  local ns="$1"
  if ip netns list 2>/dev/null | awk '{print $1}' | grep -qx "$ns"; then
    sudo ip netns delete "$ns"
    echo "[OK] Deleted namespace: $ns"
  else
    echo "[INFO] Namespace not present: $ns"
  fi
}

echo "============================================================"
echo "CLEANUP NETWORK NAMESPACE CLIENT-ROUTER-SERVER LAB"
echo "Date: $(date)"
echo "============================================================"

if ! command -v ip >/dev/null 2>&1; then
  echo "[ERROR] ip command not found."
  exit 1
fi

delete_namespace_if_exists lab_client
delete_namespace_if_exists lab_router
delete_namespace_if_exists lab_server

echo ""
echo "[INFO] Remaining namespaces:"
ip netns list || true

echo ""
echo "[OK] Cleanup complete"
