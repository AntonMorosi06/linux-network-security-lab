#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 028 read-only auditd inspection"
echo "[INFO] No audit rules will be loaded."
echo "[INFO] No service will be restarted."
echo ""

echo "============================================================"
echo "[auditctl status, read-only if available]"
echo "============================================================"
if command -v auditctl >/dev/null 2>&1; then
  auditctl -s 2>/dev/null || echo "[WARN] auditctl -s failed, possibly due to permissions."
else
  echo "[INFO] auditctl not found."
fi

echo ""
echo "============================================================"
echo "[auditctl listed rules, read-only if available]"
echo "============================================================"
if command -v auditctl >/dev/null 2>&1; then
  auditctl -l 2>/dev/null || echo "[WARN] auditctl -l failed, possibly due to permissions."
else
  echo "[INFO] auditctl not found."
fi

echo ""
echo "============================================================"
echo "[auditd service status, read-only if available]"
echo "============================================================"
if command -v systemctl >/dev/null 2>&1; then
  systemctl status auditd --no-pager 2>/dev/null | head -n 30 || echo "[INFO] auditd service status not available."
else
  echo "[INFO] systemctl not found."
fi

echo ""
echo "============================================================"
echo "[journalctl auditd recent logs, read-only if available]"
echo "============================================================"
if command -v journalctl >/dev/null 2>&1; then
  journalctl -u auditd --no-pager -n 10 2>/dev/null || echo "[INFO] auditd journal not available or permission denied."
else
  echo "[INFO] journalctl not found."
fi

echo ""
echo "[OK] Read-only auditd inspection completed."
