#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "CI CHECK: REPOSITORY STRUCTURE"
echo "Date: $(date)"
echo "============================================================"

required_dirs=(
  "docs"
  "labs"
  "scripts"
  "reports/templates"
  "examples"
  "security"
  ".github/workflows"
)

required_files=(
  "README.md"
  ".gitignore"
  "security/SAFE_USE_POLICY.md"
  ".github/workflows/ci.yml"
)

failed=0

echo "[1] Checking required directories"
for dir in "${required_dirs[@]}"; do
  if [ -d "$dir" ]; then
    echo "[OK] Directory exists: $dir"
  else
    echo "[ERROR] Missing directory: $dir"
    failed=1
  fi
done

echo ""
echo "[2] Checking required files"
for file in "${required_files[@]}"; do
  if [ -f "$file" ]; then
    echo "[OK] File exists: $file"
  else
    echo "[ERROR] Missing file: $file"
    failed=1
  fi
done

echo ""
echo "[3] Checking lab count"
lab_count="$(find labs -maxdepth 1 -type f -name '[0-9][0-9][0-9]_*.md' | wc -l | tr -d ' ')"
echo "[INFO] Lab files found: $lab_count"

if [ "$lab_count" -lt 13 ]; then
  echo "[ERROR] Expected at least 13 lab files."
  failed=1
else
  echo "[OK] Lab count is valid."
fi

echo ""
echo "[4] Checking README index"
if grep -q "Lab 013" README.md; then
  echo "[OK] README includes Lab 013."
else
  echo "[ERROR] README does not include Lab 013."
  failed=1
fi

if [ "$failed" -ne 0 ]; then
  echo "[FAIL] Repository structure check failed."
  exit 1
fi

echo "[OK] Repository structure check passed."
