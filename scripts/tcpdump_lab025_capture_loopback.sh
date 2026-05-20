#!/usr/bin/env bash
set -euo pipefail

PORT="8090"
HOST="127.0.0.1"
DATA_DIR="data/lab025"
PCAP_FILE="$DATA_DIR/lab025_loopback_http.pcap"
LOG_FILE="$DATA_DIR/lab025_tcpdump_output.txt"
FILTER="tcp port $PORT and host $HOST"

mkdir -p "$DATA_DIR"

if [ "$(uname -s)" = "Darwin" ]; then
  IFACE="lo0"
else
  IFACE="lo"
fi

echo "[INFO] Lab 025 loopback capture"
echo "[INFO] Interface: $IFACE"
echo "[INFO] Filter: $FILTER"
echo "[INFO] Output PCAP: $PCAP_FILE"
echo "[INFO] Safety: loopback only"
echo ""

if ! command -v python3 >/dev/null 2>&1; then
  echo "[ERROR] python3 not found"
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "[WARN] curl not found; cannot generate HTTP requests"
  exit 0
fi

if ! command -v tcpdump >/dev/null 2>&1; then
  echo "[WARN] tcpdump not found"
  exit 0
fi

python3 scripts/tcpdump_lab025_start_local_service.py > "$DATA_DIR/lab025_local_service.log" 2>&1 &
SERVICE_PID="$!"

cleanup() {
  if kill -0 "$SERVICE_PID" >/dev/null 2>&1; then
    kill "$SERVICE_PID" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT

sleep 1

echo "[INFO] Starting tcpdump capture in background"

TCPDUMP_CMD=(tcpdump -i "$IFACE" -nn -c 10 -w "$PCAP_FILE" "$FILTER")

if [ "$(id -u)" -eq 0 ]; then
  "${TCPDUMP_CMD[@]}" > "$LOG_FILE" 2>&1 &
  TCPDUMP_PID="$!"
elif command -v sudo >/dev/null 2>&1 && sudo -n true >/dev/null 2>&1; then
  sudo "${TCPDUMP_CMD[@]}" > "$LOG_FILE" 2>&1 &
  TCPDUMP_PID="$!"
else
  echo "[WARN] tcpdump capture may require sudo/root privileges."
  echo "[INFO] Trying without sudo. If it fails, rerun with:"
  echo "  sudo ./scripts/tcpdump_lab025_capture_loopback.sh"
  "${TCPDUMP_CMD[@]}" > "$LOG_FILE" 2>&1 &
  TCPDUMP_PID="$!"
fi

sleep 1

echo "[INFO] Generating local curl requests"
curl -s "http://$HOST:$PORT/status" >/dev/null || true
curl -s "http://$HOST:$PORT/health" >/dev/null || true
curl -s "http://$HOST:$PORT/demo" >/dev/null || true

echo "[INFO] Waiting for tcpdump to finish"
set +e
wait "$TCPDUMP_PID"
TCPDUMP_STATUS="$?"
set -e

if [ "$TCPDUMP_STATUS" -ne 0 ]; then
  echo "[WARN] tcpdump exited with status $TCPDUMP_STATUS"
  echo "[INFO] tcpdump log:"
  cat "$LOG_FILE" || true
  echo "[INFO] No third-party traffic was captured."
  exit 0
fi

echo "[OK] Capture completed."

if [ -f "$PCAP_FILE" ]; then
  echo "[INFO] PCAP size: $(wc -c < "$PCAP_FILE") bytes"
  echo "[INFO] Reading capture summary:"
  tcpdump -nn -r "$PCAP_FILE" 2>/dev/null | head -n 20 || true
fi
