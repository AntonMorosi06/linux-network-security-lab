#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "FINAL LAB 020 VALIDATE ALL"
echo "Date: $(date)"
echo "============================================================"

failed=0

required_files=(
  README.md
  VERSION
  CHANGELOG.md
  RELEASE_NOTES_v0.1.0.md
  docs/FINAL_PROJECT_SUMMARY.md
  docs/PROOF_OF_WORK.md
  docs/FINAL_REVIEW_CHECKLIST.md
  docs/V0_1_0_RELEASE_CANDIDATE_REVIEW.md
  docs/WHAT_TO_SHOW_RECRUITER_OR_PROFESSOR.md
  security/SAFE_USE_POLICY.md
  security/THREAT_MODEL.md
  security/HARDENING_CHECKLIST.md
  .github/workflows/ci.yml
)

required_dirs=(
  labs
  docs
  scripts
  security
  docker
  data
  incident_response
  reports/templates
  examples
)

echo ""
echo "===== REQUIRED FILES ====="
for file in "${required_files[@]}"; do
  if [ -f "$file" ]; then
    echo "[OK] File exists: $file"
  else
    echo "[ERROR] Missing file: $file"
    failed=1
  fi
done

echo ""
echo "===== REQUIRED DIRECTORIES ====="
for dir in "${required_dirs[@]}"; do
  if [ -d "$dir" ]; then
    echo "[OK] Directory exists: $dir"
  else
    echo "[ERROR] Missing directory: $dir"
    failed=1
  fi
done

echo ""
echo "===== LAB COUNT ====="
lab_count="$(find labs -maxdepth 1 -type f -name '[0-9][0-9][0-9]_*.md' | wc -l | tr -d ' ')"
echo "[INFO] Lab count: $lab_count"
if [ "$lab_count" -lt 20 ]; then
  echo "[ERROR] Expected at least 20 labs."
  failed=1
else
  echo "[OK] Lab count is 20 or higher."
fi

echo ""
echo "===== README FINAL LAB CHECK ====="
if grep -q "Lab 020" README.md; then
  echo "[OK] README includes Lab 020."
else
  echo "[WARN] README may not include Lab 020."
fi

echo ""
echo "===== GIT STATUS ====="
git status --short

if [ "$failed" -ne 0 ]; then
  echo ""
  echo "[FAIL] Final validation failed."
  exit 1
fi

echo ""
echo "[OK] Final validation passed."
