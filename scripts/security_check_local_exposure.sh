#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "SECURITY CHECK: LOCAL EXPOSURE"
echo "Date: $(date)"
echo "Repository: $(basename "$(pwd)")"
echo "============================================================"

echo ""
echo "===== SYSTEM IDENTITY ====="
hostname 2>/dev/null || true
whoami 2>/dev/null || true
uname -a 2>/dev/null || true

echo ""
echo "===== LISTENING PORTS ====="
if command -v ss >/dev/null 2>&1; then
  ss -tulpen || true
elif command -v lsof >/dev/null 2>&1; then
  lsof -i -P -n || true
else
  echo "[WARN] Neither ss nor lsof available."
fi

echo ""
echo "===== DOCKER STATE ====="
if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
  docker ps || true
  docker network ls || true
else
  echo "[INFO] Docker unavailable or daemon not running."
fi

echo ""
echo "===== GIT STATE ====="
git status --short || true

echo ""
echo "===== SECURITY DOCUMENTS ====="
for file in security/SAFE_USE_POLICY.md security/ASSET_INVENTORY.md security/TRUST_BOUNDARIES.md security/THREAT_MODEL.md security/HARDENING_CHECKLIST.md security/RISK_REGISTER.md
do
  if [ -f "$file" ]; then
    echo "[OK] Security document exists: $file"
  else
    echo "[WARN] Missing security document: $file"
  fi
done

echo ""
echo "===== CI WORKFLOW ====="
if [ -f ".github/workflows/ci.yml" ]; then
  echo "[OK] Workflow exists: .github/workflows/ci.yml"
else
  echo "[WARN] Missing workflow: .github/workflows/ci.yml"
fi

echo ""
echo "[OK] Local exposure check completed."
