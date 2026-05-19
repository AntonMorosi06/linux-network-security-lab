#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "SIEM LAB 018 FULL LOCAL PIPELINE"
echo "Date: $(date)"
echo "============================================================"

./scripts/siem_lab018_validate_rules.py
echo ""

./scripts/siem_lab018_generate_sample_events.py
echo ""

GENERATED_EVENTS="$HOME/linux_lab/lab018_siem/events/generated_events.jsonl"

./scripts/siem_lab018_analyze_events.py "$GENERATED_EVENTS"
echo ""

./scripts/siem_lab018_create_timeline_report.sh "$GENERATED_EVENTS"

echo ""
echo "[OK] SIEM Lab 018 pipeline completed."
