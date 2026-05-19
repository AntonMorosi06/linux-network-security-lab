#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
REPORT_FILE="$REPORT_DIR/release_readiness_report_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$REPORT_DIR"

{
echo "============================================================"
echo "RELEASE READINESS REPORT"
echo "Date: $(date)"
echo "Repository: $(basename "$(pwd)")"
echo "Version: $(cat VERSION 2>/dev/null || echo unknown)"
echo "Host: $(hostname 2>/dev/null || echo unknown)"
echo "User: $(whoami 2>/dev/null || echo unknown)"
echo "============================================================"
echo

echo "===== REPOSITORY SUMMARY ====="
./scripts/release_lab016_generate_repository_summary.sh || true
echo

echo "===== PUBLICATION READINESS ====="
./scripts/release_lab016_check_publication_readiness.sh || true
echo

echo "===== RECENT GIT LOG ====="
git log --oneline -10 || true
echo

echo "===== RELEASE NOTES PREVIEW ====="
head -120 RELEASE_NOTES_v0.1.0.md || true
echo

echo "===== PUBLICATION CHECKLIST ====="
cat docs/PUBLICATION_CHECKLIST.md || true
echo

echo "===== FINAL RECOMMENDATION ====="
echo "Before creating a GitHub release:"
echo "1. Run ./scripts/ci_local_validate.sh"
echo "2. Check GitHub Actions"
echo "3. Review generated reports"
echo "4. Review screenshots and private local paths"
echo "5. Create tag manually only after review"
echo
echo "Manual tag command after review:"
echo "git tag -a v0.1.0 -m \"Linux Network Security Lab v0.1.0\""
echo "git push origin v0.1.0"
echo
echo "============================================================"
echo "END OF RELEASE READINESS REPORT"
echo "============================================================"
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
echo ""
echo "[INFO] Preview:"
head -180 "$REPORT_FILE"
