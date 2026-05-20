#!/usr/bin/env bash
set -euo pipefail

echo "Linux Network Security Lab — available lab files and scripts"
echo ""

for n in $(seq -w 1 30); do
  echo "============================================================"
  echo "LAB $n"
  echo "============================================================"

  echo "[Lab markdown]"
  find labs -maxdepth 1 -type f \( -name "${n}_*.md" -o -name "0${n}_*.md" -o -name "*${n}*.md" \) 2>/dev/null | sort | sed 's/^/  /' || true

  echo "[Scripts]"
  find scripts -maxdepth 1 -type f \( -name "*lab${n}*" -o -name "*lab0${n}*" -o -name "*${n}*" \) 2>/dev/null | sort | sed 's/^/  /' || true

  echo "[Examples/templates/data/generated]"
  find examples reports/templates data generated -maxdepth 3 -type f \( -name "*${n}*" -o -name "*0${n}*" \) 2>/dev/null | sort | sed 's/^/  /' || true

  echo ""
done

echo "Done."
