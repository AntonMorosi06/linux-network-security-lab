#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "FINAL LAB 020 REVIEW WORKFLOW"
echo "Date: $(date)"
echo "============================================================"

./scripts/final_lab020_validate_all.sh
echo ""

./scripts/final_lab020_generate_master_index.sh
echo ""

./scripts/final_lab020_create_proof_of_work_bundle.sh
echo ""

./scripts/final_lab020_create_release_candidate_report.sh

echo ""
echo "[OK] Final Lab 020 review workflow completed."
