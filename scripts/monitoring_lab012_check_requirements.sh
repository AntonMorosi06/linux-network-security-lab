#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "MONITORING LAB 012 REQUIREMENTS CHECK"
echo "Date: $(date)"
echo "============================================================"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker command not found."
  exit 1
fi

echo "[OK] docker command found"
docker --version

if docker info >/dev/null 2>&1; then
  echo "[OK] Docker daemon is reachable."
else
  echo "[ERROR] Docker daemon is not reachable. On macOS, open Docker Desktop."
  exit 1
fi

if docker compose version >/dev/null 2>&1; then
  echo "[OK] docker compose is available."
  docker compose version
else
  echo "[ERROR] docker compose is not available."
  exit 1
fi

echo "[OK] Requirements check complete."
