#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
REPORT_FILE="$REPORT_DIR/dns_routing_report_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$REPORT_DIR"

{
echo "============================================================"
echo "DNS, ROUTING AND CONNECTIVITY REPORT"
echo "Date: $(date)"
echo "Host: $(hostname 2>/dev/null || echo unknown)"
echo "User: $(whoami 2>/dev/null || echo unknown)"
echo "============================================================"
echo

echo "===== SYSTEM ====="
uname -a || true
echo

echo "===== NETWORK INTERFACES ====="
if command -v ip >/dev/null 2>&1; then
  ip -br addr || true
elif command -v ifconfig >/dev/null 2>&1; then
  ifconfig || true
else
  echo "No ip or ifconfig command available."
fi
echo

echo "===== ROUTING TABLE ====="
if command -v ip >/dev/null 2>&1; then
  ip route || true
  echo
  echo "Route to 1.1.1.1:"
  ip route get 1.1.1.1 2>/dev/null || true
elif command -v netstat >/dev/null 2>&1; then
  netstat -rn || true
else
  echo "No routing command available."
fi
echo

echo "===== DEFAULT GATEWAY ====="
if command -v ip >/dev/null 2>&1; then
  ip route | awk '/default/ {print $3; exit}' || true
elif command -v route >/dev/null 2>&1; then
  route -n get default 2>/dev/null | awk '/gateway/ {print $2; exit}' || true
else
  echo "Gateway detection unavailable."
fi
echo

echo "===== DNS CONFIGURATION ====="
if [ -f /etc/resolv.conf ]; then
  cat /etc/resolv.conf || true
else
  echo "/etc/resolv.conf not found."
fi
echo

echo "===== RESOLVECTL STATUS ====="
if command -v resolvectl >/dev/null 2>&1; then
  resolvectl status 2>/dev/null || true
else
  echo "resolvectl not available."
fi
echo

echo "===== LOOPBACK PING ====="
ping -c 4 127.0.0.1 || true
echo

echo "===== PUBLIC IP PING ====="
ping -c 4 1.1.1.1 || true
echo

echo "===== DNS RESOLUTION ====="
if command -v getent >/dev/null 2>&1; then
  getent hosts example.com || true
else
  echo "getent not available."
fi
echo

if command -v dig >/dev/null 2>&1; then
  dig example.com || true
else
  echo "dig not available."
fi
echo

if command -v nslookup >/dev/null 2>&1; then
  nslookup example.com || true
else
  echo "nslookup not available."
fi
echo

echo "===== HTTPS HEADERS ====="
if command -v curl >/dev/null 2>&1; then
  curl -I --max-time 10 https://example.com || true
else
  echo "curl not available."
fi
echo

echo "============================================================"
echo "END OF REPORT"
echo "============================================================"

} > "$REPORT_FILE"

echo "[OK] Report creato:"
echo "$REPORT_FILE"
echo ""
echo "[INFO] Anteprima:"
head -100 "$REPORT_FILE"
