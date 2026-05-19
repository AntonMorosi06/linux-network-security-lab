#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "CI CHECK: PYTHON SYNTAX"
echo "Date: $(date)"
echo "============================================================"

if ! command -v python3 >/dev/null 2>&1; then
  echo "[ERROR] python3 not found."
  exit 1
fi

mapfile -t python_files < <(
  find . -type f -name "*.py" \
    -not -path "./.git/*" \
    -not -path "./.venv/*" \
    -not -path "./venv/*" \
    | sort
)

if [ "${#python_files[@]}" -eq 0 ]; then
  echo "[WARN] No Python files found."
  exit 0
fi

failed=0
for file in "${python_files[@]}"; do
  echo "[CHECK] python3 -m py_compile $file"
  if python3 -m py_compile "$file"; then
    echo "[OK] $file"
  else
    echo "[ERROR] Python syntax failed: $file"
    failed=1
  fi
done

if [ "$failed" -ne 0 ]; then
  echo "[FAIL] Python syntax check failed."
  exit 1
fi

echo "[OK] Python syntax check passed."
