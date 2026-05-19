#!/usr/bin/env bash
set -euo pipefail

OUT_FILE="docs/MASTER_LAB_INDEX.md"

{
echo "# Master Lab Index"
echo
echo "Generated on: $(date)"
echo
echo "## Overview"
echo
echo "This document indexes the complete Linux Network Security Lab baseline."
echo
echo "## Labs"
echo
find labs -maxdepth 1 -type f -name '[0-9][0-9][0-9]_*.md' | sort | while read -r file; do
  title="$(head -1 "$file" | sed 's/^# //')"
  echo "- [$title](../$file)"
done
echo
echo "## Counts"
echo
echo '```text'
echo "Labs: $(find labs -maxdepth 1 -type f -name '[0-9][0-9][0-9]_*.md' | wc -l | tr -d ' ')"
echo "Scripts: $(find scripts -type f | wc -l | tr -d ' ')"
echo "Docs: $(find docs -type f | wc -l | tr -d ' ')"
echo "Security docs: $(find security -type f | wc -l | tr -d ' ')"
echo "Docker files: $(find docker -type f 2>/dev/null | wc -l | tr -d ' ')"
echo "Data files: $(find data -type f 2>/dev/null | wc -l | tr -d ' ')"
echo '```'
echo
echo "## Recommended review path"
echo
echo '```text'
echo "README.md"
echo "docs/FINAL_PROJECT_SUMMARY.md"
echo "docs/PROOF_OF_WORK.md"
echo "docs/PORTFOLIO_SUMMARY.md"
echo "security/THREAT_MODEL.md"
echo "labs/015_final_capstone_secure_local_service.md"
echo "labs/018_local_siem_log_pipeline_detection_rules.md"
echo "labs/019_incident_response_case_file_evidence_bundle.md"
echo "labs/020_final_master_index_proof_of_work_release_candidate.md"
echo '```'
} > "$OUT_FILE"

echo "[OK] Master lab index generated:"
echo "$OUT_FILE"
