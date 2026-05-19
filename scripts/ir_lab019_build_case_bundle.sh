#!/usr/bin/env bash
set -euo pipefail

EVENTS_FILE="${1:-data/lab019/ir_case_events.jsonl}"
BASE_DIR="$HOME/linux_lab/lab019_ir_case"
BUNDLE_DIR="$BASE_DIR/bundles/ir_case_bundle_$(date +%Y%m%d_%H%M%S)"

if [ ! -f "$EVENTS_FILE" ]; then
  echo "[ERROR] Events file not found: $EVENTS_FILE"
  exit 1
fi

mkdir -p "$BUNDLE_DIR"/{evidence,analysis,docs}

cp "$EVENTS_FILE" "$BUNDLE_DIR/evidence/ir_case_events.jsonl"
cp data/lab019/ir_case_metadata.json "$BUNDLE_DIR/evidence/ir_case_metadata.json" 2>/dev/null || true
cp incident_response/lab019/*.md "$BUNDLE_DIR/docs/"

./scripts/ir_lab019_analyze_case.py "$EVENTS_FILE" > "$BUNDLE_DIR/analysis/case_analysis.txt"

cat > "$BUNDLE_DIR/README.txt" <<EOF_INNER
Incident Response Case Bundle - Lab 019

Created: $(date)
Repository: $(basename "$(pwd)")
Events file: $EVENTS_FILE

Contents:
- evidence/ir_case_events.jsonl
- evidence/ir_case_metadata.json
- docs/*.md
- analysis/case_analysis.txt

Safety:
This bundle contains synthetic local lab data only.
Review before publishing.
EOF_INNER

echo "[OK] Evidence bundle created:"
echo "$BUNDLE_DIR"
