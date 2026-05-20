#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 021 Linux security tools inventory"
echo "[INFO] Date: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
echo "[INFO] Host: $(hostname 2>/dev/null || echo unknown)"
echo "[INFO] Kernel: $(uname -a 2>/dev/null || echo unknown)"
echo ""

CORE_TOOLS=(git python3 curl openssl)
OPTIONAL_TOOLS=(tcpdump tshark nmap aircrack-ng airmon-ng airodump-ng nft iptables ufw gpg lynis auditctl fail2ban-client zeek suricata)

echo "[SECTION] Core tools"
for tool in "${CORE_TOOLS[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "[OK] found: $tool -> $(command -v "$tool")"
  else
    echo "[WARN] core tool not found: $tool"
  fi
done

echo ""
echo "[SECTION] Optional security tools"
for tool in "${OPTIONAL_TOOLS[@]}"; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "[OK] found: $tool -> $(command -v "$tool")"
  else
    echo "[INFO] optional tool not found: $tool"
  fi
done

echo ""
echo "[SECTION] Safe version/help samples"

if command -v tcpdump >/dev/null 2>&1; then
  echo ""
  echo "[tcpdump --version]"
  tcpdump --version 2>&1 | head -n 5 || true
fi

if command -v tshark >/dev/null 2>&1; then
  echo ""
  echo "[tshark --version]"
  tshark --version 2>&1 | head -n 8 || true
fi

if command -v nmap >/dev/null 2>&1; then
  echo ""
  echo "[nmap --version]"
  nmap --version 2>&1 | head -n 8 || true
fi

if command -v aircrack-ng >/dev/null 2>&1; then
  echo ""
  echo "[aircrack-ng --help]"
  aircrack-ng --help 2>&1 | head -n 12 || true
  echo "[INFO] Aircrack-ng help output only. No wireless network was targeted."
fi

if command -v openssl >/dev/null 2>&1; then
  echo ""
  echo "[openssl version]"
  openssl version 2>&1 || true
fi

if command -v gpg >/dev/null 2>&1; then
  echo ""
  echo "[gpg --version]"
  gpg --version 2>&1 | head -n 8 || true
fi

echo ""
echo "[OK] Inventory completed."
echo "[INFO] Missing optional tools are not errors."
echo "[INFO] Do not run active scans, wireless tests or packet captures outside authorized labs."
