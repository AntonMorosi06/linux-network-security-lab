#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
REPORT_FILE="$REPORT_DIR/threat_model_report_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$REPORT_DIR"

{
echo "============================================================"
echo "THREAT MODEL AND HARDENING REPORT"
echo "Date: $(date)"
echo "Repository: $(basename "$(pwd)")"
echo "Host: $(hostname 2>/dev/null || echo unknown)"
echo "User: $(whoami 2>/dev/null || echo unknown)"
echo "============================================================"
echo

echo "===== SYSTEM ====="
uname -a 2>/dev/null || true
echo

echo "===== GIT STATE ====="
git status --short || true
echo

echo "===== SECURITY DOCUMENT STATUS ====="
for file in security/SAFE_USE_POLICY.md security/ASSET_INVENTORY.md security/TRUST_BOUNDARIES.md security/THREAT_MODEL.md security/HARDENING_CHECKLIST.md security/RISK_REGISTER.md
do
  if [ -f "$file" ]; then
    echo "[OK] $file"
  else
    echo "[MISSING] $file"
  fi
done
echo

echo "===== LOCAL LISTENING PORTS ====="
if command -v ss >/dev/null 2>&1; then
  ss -tulpen || true
elif command -v lsof >/dev/null 2>&1; then
  lsof -i -P -n || true
else
  echo "No ss/lsof available."
fi
echo

echo "===== DOCKER STATE ====="
if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
  docker ps || true
  echo
  docker network ls || true
else
  echo "Docker unavailable or daemon not running."
fi
echo

echo "===== RISK REGISTER SUMMARY ====="
if [ -f security/RISK_REGISTER.md ]; then
  grep -E '^\| R-' security/RISK_REGISTER.md || true
else
  echo "Risk register missing."
fi
echo

echo "===== RECOMMENDED NEXT ACTIONS ====="
echo "1. Review listening ports before demos."
echo "2. Keep lab services bound to 127.0.0.1 where possible."
echo "3. Run ./scripts/ci_local_validate.sh before push."
echo "4. Review reports before committing them."
echo "5. Do not commit real secrets, tokens, private logs or private packet captures."
echo "6. Clean up Docker containers and namespace labs after use."
echo
echo "============================================================"
echo "END OF REPORT"
echo "============================================================"
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
echo ""
echo "[INFO] Preview:"
head -140 "$REPORT_FILE"
