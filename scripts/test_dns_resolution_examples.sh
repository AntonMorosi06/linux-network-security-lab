#!/usr/bin/env bash
set -euo pipefail

DOMAIN="${1:-example.com}"

echo "============================================================"
echo "DNS RESOLUTION EXAMPLES"
echo "Domain: $DOMAIN"
echo "Date: $(date)"
echo "============================================================"
echo ""

echo "[1] /etc/resolv.conf"
if [ -f /etc/resolv.conf ]; then
  cat /etc/resolv.conf
else
  echo "[WARN] /etc/resolv.conf not found."
fi

echo ""
echo "[2] getent hosts"
if command -v getent >/dev/null 2>&1; then
  getent hosts "$DOMAIN" || true
else
  echo "[INFO] getent not available."
fi

echo ""
echo "[3] dig A record"
if command -v dig >/dev/null 2>&1; then
  dig A "$DOMAIN" || true
else
  echo "[INFO] dig not available."
fi

echo ""
echo "[4] dig AAAA record"
if command -v dig >/dev/null 2>&1; then
  dig AAAA "$DOMAIN" || true
else
  echo "[INFO] dig not available."
fi

echo ""
echo "[5] nslookup"
if command -v nslookup >/dev/null 2>&1; then
  nslookup "$DOMAIN" || true
else
  echo "[INFO] nslookup not available."
fi

echo ""
echo "[6] curl headers"
if command -v curl >/dev/null 2>&1; then
  curl -I --max-time 10 "https://$DOMAIN" || true
else
  echo "[INFO] curl not available."
fi

echo ""
echo "============================================================"
echo "END OF DNS RESOLUTION EXAMPLES"
echo "============================================================"
