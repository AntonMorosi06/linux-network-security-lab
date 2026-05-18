#!/usr/bin/env bash
set -euo pipefail

print_section() {
  echo ""
  echo "============================================================"
  echo "$1"
  echo "============================================================"
}

run_command_if_available() {
  local command_name="$1"
  shift

  if command -v "$command_name" >/dev/null 2>&1; then
    "$@" || true
  else
    echo "[INFO] Command not available: $command_name"
  fi
}

ping_count_flag() {
  # Linux and macOS both support -c for ping count.
  echo "-c"
}

print_section "DNS, ROUTING AND CONNECTIVITY DIAGNOSTIC"
echo "Date: $(date)"
echo "Host: $(hostname 2>/dev/null || echo unknown)"
echo "User: $(whoami 2>/dev/null || echo unknown)"
echo "System:"
uname -a || true

print_section "NETWORK INTERFACES"
if command -v ip >/dev/null 2>&1; then
  ip -br addr || true
elif command -v ifconfig >/dev/null 2>&1; then
  ifconfig || true
else
  echo "[WARN] No ip or ifconfig command available."
fi

print_section "ROUTING TABLE"
if command -v ip >/dev/null 2>&1; then
  ip route || true
  echo ""
  echo "[INFO] Route used for 1.1.1.1:"
  ip route get 1.1.1.1 2>/dev/null || true
elif command -v netstat >/dev/null 2>&1; then
  netstat -rn || true
else
  echo "[WARN] No routing command available."
fi

print_section "DEFAULT GATEWAY DETECTION"
GATEWAY=""

if command -v ip >/dev/null 2>&1; then
  GATEWAY="$(ip route | awk '/default/ {print $3; exit}' || true)"
elif command -v route >/dev/null 2>&1; then
  GATEWAY="$(route -n get default 2>/dev/null | awk '/gateway/ {print $2; exit}' || true)"
fi

if [ -n "$GATEWAY" ]; then
  echo "[OK] Default gateway detected: $GATEWAY"
else
  echo "[WARN] Could not detect default gateway automatically."
fi

print_section "DNS CONFIGURATION"
if [ -f /etc/resolv.conf ]; then
  cat /etc/resolv.conf || true
else
  echo "[WARN] /etc/resolv.conf not found."
fi

echo ""
if command -v resolvectl >/dev/null 2>&1; then
  echo "[INFO] resolvectl status:"
  resolvectl status 2>/dev/null || true
else
  echo "[INFO] resolvectl not available."
fi

print_section "LOOPBACK CONNECTIVITY TEST"
ping -c 4 127.0.0.1 || true

print_section "GATEWAY CONNECTIVITY TEST"
if [ -n "$GATEWAY" ]; then
  ping -c 4 "$GATEWAY" || true
else
  echo "[SKIP] Gateway not detected."
fi

print_section "PUBLIC IP CONNECTIVITY TEST"
ping -c 4 1.1.1.1 || true

print_section "DNS RESOLUTION TESTS"
if command -v getent >/dev/null 2>&1; then
  echo "[INFO] getent hosts example.com"
  getent hosts example.com || true
else
  echo "[INFO] getent not available."
fi

echo ""
if command -v dig >/dev/null 2>&1; then
  echo "[INFO] dig example.com"
  dig example.com || true
else
  echo "[INFO] dig not available."
fi

echo ""
if command -v nslookup >/dev/null 2>&1; then
  echo "[INFO] nslookup example.com"
  nslookup example.com || true
else
  echo "[INFO] nslookup not available."
fi

print_section "APPLICATION-LEVEL HTTPS TEST"
if command -v curl >/dev/null 2>&1; then
  curl -I --max-time 10 https://example.com || true
else
  echo "[INFO] curl not available."
fi

print_section "DIAGNOSTIC INTERPRETATION HINTS"
cat <<'HINTS'
1. If ping 127.0.0.1 fails, check local loopback/network stack.
2. If gateway ping fails, check local network, Wi-Fi/Ethernet, router, or interface state.
3. If ping 1.1.1.1 fails but gateway works, check upstream connectivity.
4. If ping 1.1.1.1 works but example.com resolution fails, check DNS.
5. If DNS works but curl HTTPS fails, check TLS, proxy, firewall, or application-level issues.
HINTS

print_section "END OF DNS, ROUTING AND CONNECTIVITY DIAGNOSTIC"
