#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "IR LAB 019 FULL WORKFLOW"
echo "Date: $(date)"
echo "============================================================"

./scripts/ir_lab019_generate_case_events.py
echo ""

GENERATED_EVENTS="$HOME/linux_lab/lab019_ir_case/events/ir_case_events.jsonl"

./scripts/ir_lab019_analyze_case.py "$GENERATED_EVENTS"
echo ""

./scripts/ir_lab019_build_case_bundle.sh "$GENERATED_EVENTS"
echo ""

./scripts/ir_lab019_create_final_report.sh "$GENERATED_EVENTS"

echo ""
echo "[OK] IR Lab 019 workflow completed."
