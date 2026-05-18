#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
REPORT_FILE="$REPORT_DIR/ports_logs_report_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$REPORT_DIR"

{
echo "============================================================"
echo "PORTS, PROCESSES AND LOGS REPORT"
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
else
  echo "ip command not available"
fi
echo

echo "===== ROUTING ====="
if command -v ip >/dev/null 2>&1; then
  ip route || true
else
  echo "ip command not available"
fi
echo

echo "===== LISTENING PORTS ====="
if command -v ss >/dev/null 2>&1; then
  ss -tulpen || true
else
  echo "ss command not available"
fi
echo

echo "===== LSOF NETWORK VIEW ====="
if command -v lsof >/dev/null 2>&1; then
  lsof -i -P -n 2>/dev/null | head -100 || true
else
  echo "lsof command not available"
fi
echo

echo "===== TOP CPU PROCESSES ====="
ps aux | sort -nrk 3 | head -15 || true
echo

echo "===== TOP MEMORY PROCESSES ====="
ps aux | sort -nrk 4 | head -15 || true
echo

echo "===== FAILED SYSTEMD SERVICES ====="
if command -v systemctl >/dev/null 2>&1; then
  systemctl --failed 2>/dev/null || true
else
  echo "systemctl not available"
fi
echo

echo "===== RECENT WARNING LOGS ====="
if command -v journalctl >/dev/null 2>&1; then
  journalctl -p warning -n 50 --no-pager 2>/dev/null || true
else
  echo "journalctl not available"
fi
echo

echo "===== RECENT ERROR LOGS ====="
if command -v journalctl >/dev/null 2>&1; then
  journalctl -p err -n 50 --no-pager 2>/dev/null || true
else
  echo "journalctl not available"
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
head -80 "$REPORT_FILE"
