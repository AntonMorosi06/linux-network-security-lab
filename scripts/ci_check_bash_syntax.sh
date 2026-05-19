#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "CI CHECK: BASH SYNTAX"
echo "Date: $(date)"
echo "============================================================"

mapfile -t bash_files < <(find scripts -type f -name "*.sh" | sort)

if [ "${#bash_files[@]}" -eq 0 ]; then
  echo "[WARN] No Bash scripts found."
  exit 0
fi

failed=0
for file in "${bash_files[@]}"; do
  echo "[CHECK] bash -n $file"
  if bash -n "$file"; then
    echo "[OK] $file"
  else
    echo "[ERROR] Bash syntax failed: $file"
    failed=1
  fi
done

if [ "$failed" -ne 0 ]; then
  echo "[FAIL] Bash syntax check failed."
  exit 1
fi

echo "[OK] Bash syntax check passed."
