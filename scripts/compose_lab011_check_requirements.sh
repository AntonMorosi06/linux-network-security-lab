#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "COMPOSE LAB 011 REQUIREMENTS CHECK"
echo "Date: $(date)"
echo "============================================================"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker command not found."
  echo "[INFO] Install Docker Desktop on macOS or Docker Engine on Linux."
  exit 1
fi

echo "[OK] docker command found"
docker --version

echo ""
echo "[INFO] Checking Docker daemon..."
if docker info >/dev/null 2>&1; then
  echo "[OK] Docker daemon is reachable."
else
  echo "[ERROR] Docker daemon is not reachable."
  echo "[INFO] On macOS, open Docker Desktop."
  echo "[INFO] On Linux, check Docker service or permissions."
  exit 1
fi

echo ""
echo "[INFO] Checking docker compose..."
if docker compose version >/dev/null 2>&1; then
  echo "[OK] docker compose is available."
  docker compose version
else
  echo "[ERROR] docker compose is not available."
  echo "[INFO] Install/update Docker Desktop or Docker Compose plugin."
  exit 1
fi

echo ""
echo "[OK] Requirements check complete."
