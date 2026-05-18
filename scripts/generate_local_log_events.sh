#!/usr/bin/env bash
set -euo pipefail

EVENT_PREFIX="LINUX_LAB_003"

echo "============================================================"
echo "GENERATE CONTROLLED LOCAL LOG EVENTS"
echo "Prefix: $EVENT_PREFIX"
echo "Date: $(date)"
echo "============================================================"
echo ""

if ! command -v logger >/dev/null 2>&1; then
  echo "[ERROR] logger command not available."
  exit 1
fi

logger "$EVENT_PREFIX: normal diagnostic event"
logger -p user.warning "$EVENT_PREFIX: controlled warning event"
logger -p user.err "$EVENT_PREFIX: controlled error event"

echo "[OK] Controlled log events generated."
echo ""

if command -v journalctl >/dev/null 2>&1; then
  echo "[INFO] Recent matching journalctl events:"
  journalctl -n 80 --no-pager 2>/dev/null | grep "$EVENT_PREFIX" || true
else
  echo "[INFO] journalctl not available. Events were sent through logger."
  echo "[INFO] Check your system log facility manually."
fi
