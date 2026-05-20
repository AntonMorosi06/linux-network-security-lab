#!/usr/bin/env bash
set -euo pipefail

PCAP_FILE="data/lab022/local_http_dns_sample.pcap"

if [ ! -f "$PCAP_FILE" ]; then
  echo "[INFO] PCAP file not found. Generating it now."
  ./scripts/tshark_lab022_generate_sample_pcap.py
fi

if ! command -v tshark >/dev/null 2>&1; then
  echo "[WARN] tshark not found."
  echo "[INFO] PCAP generated safely at: $PCAP_FILE"
  echo "[INFO] Install TShark to analyze it:"
  echo "  brew install wireshark"
  echo "  sudo apt install tshark"
  exit 0
fi

echo "[INFO] Packet summary"
tshark -r "$PCAP_FILE" || true

echo ""
echo "[INFO] DNS packets"
tshark -r "$PCAP_FILE" -Y "dns" || true

echo ""
echo "[INFO] HTTP packets"
tshark -r "$PCAP_FILE" -Y "http" || true

echo ""
echo "[INFO] Selected fields"
tshark -r "$PCAP_FILE" -T fields -e frame.number -e ip.src -e ip.dst -e _ws.col.Protocol -e _ws.col.Info || true

echo ""
echo "[OK] Analysis completed."
