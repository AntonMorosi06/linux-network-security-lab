#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "CI CHECK: DOCKER COMPOSE FILES"
echo "Date: $(date)"
echo "============================================================"

mapfile -t compose_files < <(
  find docker -type f \( -name "compose.yaml" -o -name "compose.yml" -o -name "docker-compose.yml" \) | sort
)

if [ "${#compose_files[@]}" -eq 0 ]; then
  echo "[WARN] No Docker Compose files found."
  exit 0
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "[WARN] docker not found. Skipping Compose validation."
  exit 0
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "[WARN] docker compose not available. Skipping Compose validation."
  exit 0
fi

failed=0
for file in "${compose_files[@]}"; do
  echo "[CHECK] docker compose -f $file config"
  if docker compose -f "$file" config >/tmp/compose_config_check.txt; then
    echo "[OK] Compose config valid: $file"
  else
    echo "[ERROR] Compose config failed: $file"
    failed=1
  fi
done

rm -f /tmp/compose_config_check.txt

if [ "$failed" -ne 0 ]; then
  echo "[FAIL] Docker Compose config check failed."
  exit 1
fi

echo "[OK] Docker Compose config check completed."
