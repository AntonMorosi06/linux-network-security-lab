#!/usr/bin/env bash

echo "============================================================"
echo "LINUX LOCAL HEALTH CHECK"
echo "Date: $(date)"
echo "Host: $(hostname)"
echo "User: $(whoami)"
echo "============================================================"
echo

echo "[1] System"
uname -a
echo

echo "[2] Distribution"
cat /etc/os-release 2>/dev/null || true
echo

echo "[3] User identity"
id
echo

echo "[4] Network interfaces"
ip -br addr
echo

echo "[5] Routing table"
ip route
echo

echo "[6] DNS configuration"
cat /etc/resolv.conf
echo

echo "[7] Listening ports"
ss -tulpen
echo

echo "[8] Failed systemd services"
systemctl --failed 2>/dev/null || true
echo

echo "[9] Recent warning logs"
journalctl -p warning -n 30 --no-pager 2>/dev/null || true
echo

echo "============================================================"
echo "END OF HEALTH CHECK"
echo "============================================================"
