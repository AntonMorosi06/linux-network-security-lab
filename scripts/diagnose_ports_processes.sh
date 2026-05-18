#!/usr/bin/env bash
set -euo pipefail

print_section() {
  echo ""
  echo "============================================================"
  echo "$1"
  echo "============================================================"
}

run_if_available() {
  local command_name="$1"
  shift

  if command -v "$command_name" >/dev/null 2>&1; then
    "$@" || true
  else
    echo "[INFO] Command not available: $command_name"
  fi
}

print_section "LOCAL PORTS AND PROCESSES DIAGNOSTIC"
echo "Date: $(date)"
echo "Host: $(hostname 2>/dev/null || echo unknown)"
echo "User: $(whoami 2>/dev/null || echo unknown)"
echo "Kernel/System:"
uname -a || true

print_section "NETWORK INTERFACES"
if command -v ip >/dev/null 2>&1; then
  ip -br addr || true
else
  echo "[INFO] ip command not available. Trying ifconfig."
  run_if_available ifconfig ifconfig
fi

print_section "LISTENING PORTS WITH SS"
if command -v ss >/dev/null 2>&1; then
  ss -tulpen || true
else
  echo "[INFO] ss not available."
  echo "[INFO] On Linux, install iproute2. On macOS, use lsof or netstat."
fi

print_section "LISTENING PORTS WITH LSOF"
if command -v lsof >/dev/null 2>&1; then
  lsof -i -P -n 2>/dev/null | head -80 || true
else
  echo "[INFO] lsof not available."
fi

print_section "PROCESS LIST"
ps aux | head -30 || true

print_section "TOP CPU PROCESSES"
ps aux | sort -nrk 3 | head -15 || true

print_section "TOP MEMORY PROCESSES"
ps aux | sort -nrk 4 | head -15 || true

print_section "FAILED SYSTEMD SERVICES"
if command -v systemctl >/dev/null 2>&1; then
  systemctl --failed 2>/dev/null || true
else
  echo "[INFO] systemctl not available on this system."
fi

print_section "RECENT WARNING LOGS"
if command -v journalctl >/dev/null 2>&1; then
  journalctl -p warning -n 40 --no-pager 2>/dev/null || true
else
  echo "[INFO] journalctl not available on this system."
fi

print_section "RECENT ERROR LOGS"
if command -v journalctl >/dev/null 2>&1; then
  journalctl -p err -n 40 --no-pager 2>/dev/null || true
else
  echo "[INFO] journalctl not available on this system."
fi

print_section "DIAGNOSTIC COMPLETE"
