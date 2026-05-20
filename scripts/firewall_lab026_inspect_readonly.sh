#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 026 read-only firewall inspection"
echo "[INFO] No firewall rules will be modified."
echo "[INFO] OS: $(uname -s)"
echo ""

echo "============================================================"
echo "[Socket inventory]"
echo "============================================================"
if command -v ss >/dev/null 2>&1; then
  ss -tulpen 2>/dev/null || ss -tuln 2>/dev/null || true
else
  echo "[INFO] ss not available."
  if command -v lsof >/dev/null 2>&1; then
    echo "[INFO] macOS fallback: lsof -nP -iTCP -sTCP:LISTEN"
    lsof -nP -iTCP -sTCP:LISTEN 2>/dev/null | head -n 30 || true
  fi
fi

echo ""
echo "============================================================"
echo "[nftables read-only listing]"
echo "============================================================"
if command -v nft >/dev/null 2>&1; then
  nft list ruleset 2>/dev/null || echo "[WARN] nft list ruleset failed, possibly due to permissions."
else
  echo "[INFO] nft not found."
fi

echo ""
echo "============================================================"
echo "[iptables read-only listing]"
echo "============================================================"
if command -v iptables >/dev/null 2>&1; then
  iptables -S 2>/dev/null || echo "[WARN] iptables -S failed, possibly due to permissions."
else
  echo "[INFO] iptables not found."
fi

echo ""
echo "============================================================"
echo "[ufw read-only status]"
echo "============================================================"
if command -v ufw >/dev/null 2>&1; then
  ufw status verbose 2>/dev/null || echo "[WARN] ufw status failed, possibly due to permissions."
else
  echo "[INFO] ufw not found."
fi

echo ""
echo "============================================================"
echo "[macOS pfctl read-only awareness]"
echo "============================================================"
if command -v pfctl >/dev/null 2>&1; then
  pfctl -s info 2>/dev/null || echo "[WARN] pfctl read-only info failed, possibly due to permissions."
else
  echo "[INFO] pfctl not found."
fi

echo ""
echo "[OK] Read-only inspection completed."
echo "[INFO] No firewall rules were modified."
