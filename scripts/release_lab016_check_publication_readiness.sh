#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "RELEASE LAB 016 PUBLICATION READINESS CHECK"
echo "Date: $(date)"
echo "============================================================"

required_files=(
  README.md
  VERSION
  CHANGELOG.md
  RELEASE_NOTES_v0.1.0.md
  docs/CURRENT_STATUS.md
  docs/ROADMAP.md
  docs/PORTFOLIO_SUMMARY.md
  docs/REPOSITORY_AUDIT.md
  docs/PUBLICATION_CHECKLIST.md
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
  reports/templates
  examples
  .github/ISSUE_TEMPLATE
)

failed=0

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
if [ "$lab_count" -lt 16 ]; then
  echo "[ERROR] Expected at least 16 labs."
  failed=1
else
  echo "[OK] Lab count is 16 or higher."
fi

echo ""
echo "===== GIT STATUS ====="
git status --short

echo ""
echo "===== SECRET-LIKE FILE CHECK ====="
secret_hits="$(find . -type f \( -name '.env' -o -name '*.pem' -o -name '*.key' -o -name '*.p12' \) -not -path './.git/*' | sort || true)"
if [ -n "$secret_hits" ]; then
  echo "[WARN] Potential secret-like files found:"
  echo "$secret_hits"
  echo "[WARN] Review before release."
else
  echo "[OK] No common secret-like files found."
fi

echo ""
echo "===== LOCAL CI ====="
if [ -x scripts/ci_local_validate.sh ]; then
  echo "[INFO] Local CI script exists. Run manually before release:"
  echo "  ./scripts/ci_local_validate.sh"
else
  echo "[WARN] Local CI script missing or not executable."
fi

if [ "$failed" -ne 0 ]; then
  echo ""
  echo "[FAIL] Publication readiness check failed."
  exit 1
fi

echo ""
echo "[OK] Publication readiness check passed."
