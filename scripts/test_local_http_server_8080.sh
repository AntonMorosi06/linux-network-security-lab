#!/usr/bin/env bash
set -euo pipefail

URL="http://127.0.0.1:8080"

echo "============================================================"
echo "LOCAL HTTP SERVER TEST"
echo "URL: $URL"
echo "Date: $(date)"
echo "============================================================"
echo ""

echo "[1] Testing HTTP body"
if curl -sS "$URL"; then
  echo ""
  echo "[OK] HTTP body received."
else
  echo "[ERROR] Could not connect to $URL"
  echo "Check whether the server is running:"
  echo "  ./scripts/start_local_http_server_8080.sh"
  exit 1
fi

echo ""
echo "[2] Testing HTTP headers"
curl -I "$URL"

echo ""
echo "[3] Verbose connection test"
curl -v "$URL" -o /dev/null

echo ""
echo "[4] Listening port inspection"
if ss -ltnp | grep 8080; then
  echo "[OK] Port 8080 is listening."
else
  echo "[WARN] Port 8080 was not found in listening state."
  echo "If the server runs in another terminal, try:"
  echo "  sudo ss -ltnp | grep 8080"
fi

echo ""
echo "============================================================"
echo "END OF LOCAL HTTP SERVER TEST"
echo "============================================================"
