#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="$HOME/linux_lab/pcaps"
OUT_FILE="$OUT_DIR/local_http_8080_$(date +%Y%m%d_%H%M%S).pcap"

mkdir -p "$OUT_DIR"

echo "============================================================"
echo "LOCAL HTTP TCPDUMP CAPTURE"
echo "Interface: lo"
echo "Filter: port 8080"
echo "Output: $OUT_FILE"
echo "============================================================"
echo ""
echo "[INFO] This command captures 50 packets and then stops."
echo "[INFO] In another terminal, generate traffic with:"
echo "      curl http://127.0.0.1:8080"
echo ""

sudo tcpdump -i lo port 8080 -w "$OUT_FILE" -c 50

echo ""
echo "[OK] Capture saved to: $OUT_FILE"
echo ""
echo "[INFO] Preview:"
tcpdump -r "$OUT_FILE" | head -20
