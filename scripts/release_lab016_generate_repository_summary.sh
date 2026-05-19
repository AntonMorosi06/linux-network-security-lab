#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "REPOSITORY SUMMARY"
echo "Date: $(date)"
echo "============================================================"

echo "Repository: $(basename "$(pwd)")"
echo "Branch: $(git branch --show-current 2>/dev/null || echo unknown)"
echo "Version: $(cat VERSION 2>/dev/null || echo unknown)"

echo ""
echo "===== COUNTS ====="
echo "Labs: $(find labs -maxdepth 1 -type f -name '[0-9][0-9][0-9]_*.md' | wc -l | tr -d ' ')"
echo "Scripts: $(find scripts -type f | wc -l | tr -d ' ')"
echo "Docs: $(find docs -type f | wc -l | tr -d ' ')"
echo "Security docs: $(find security -type f | wc -l | tr -d ' ')"
echo "Docker files: $(find docker -type f 2>/dev/null | wc -l | tr -d ' ')"
echo "Report templates: $(find reports/templates -type f | wc -l | tr -d ' ')"
echo "Examples: $(find examples -type f | wc -l | tr -d ' ')"

echo ""
echo "===== LAB INDEX ====="
find labs -maxdepth 1 -type f -name '[0-9][0-9][0-9]_*.md' | sort

echo ""
echo "===== CI STATUS FILES ====="
if [ -f .github/workflows/ci.yml ]; then
  echo "[OK] .github/workflows/ci.yml"
else
  echo "[WARN] Missing CI workflow"
fi

echo ""
echo "===== GIT STATUS ====="
git status --short
