#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
REPORT_FILE="$REPORT_DIR/final_release_candidate_report_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$REPORT_DIR"

{
echo "============================================================"
echo "FINAL RELEASE CANDIDATE REPORT"
echo "Date: $(date)"
echo "Repository: $(basename "$(pwd)")"
echo "Version: $(cat VERSION 2>/dev/null || echo unknown)"
echo "Host: $(hostname 2>/dev/null || echo unknown)"
echo "User: $(whoami 2>/dev/null || echo unknown)"
echo "============================================================"
echo

echo "===== FINAL VALIDATION ====="
./scripts/final_lab020_validate_all.sh || true
echo

echo "===== MASTER INDEX ====="
./scripts/final_lab020_generate_master_index.sh || true
cat docs/MASTER_LAB_INDEX.md || true
echo

echo "===== PROOF OF WORK ====="
cat docs/PROOF_OF_WORK.md || true
echo

echo "===== FINAL REVIEW CHECKLIST ====="
cat docs/FINAL_REVIEW_CHECKLIST.md || true
echo

echo "===== RECENT GIT LOG ====="
git log --oneline -15 || true
echo

echo "===== FINAL RECOMMENDATION ====="
echo "The repository is ready for manual review as a v0.1.0 release candidate."
echo "Do not create a public release until CI, README, secrets, screenshots and generated reports have been reviewed."
echo
echo "Optional manual release commands after review:"
echo "git tag -a v0.1.0 -m \"Linux Network Security Lab v0.1.0\""
echo "git push origin v0.1.0"
echo

echo "============================================================"
echo "END OF FINAL RELEASE CANDIDATE REPORT"
echo "============================================================"
} > "$REPORT_FILE"

echo "[OK] Release candidate report created:"
echo "$REPORT_FILE"
echo ""
echo "[INFO] Preview:"
head -220 "$REPORT_FILE"
