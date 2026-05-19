#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "LOCAL CI VALIDATION"
echo "Date: $(date)"
echo "Repository: $(basename "$(pwd)")"
echo "============================================================"

./scripts/ci_check_repository_structure.sh
echo ""
./scripts/ci_check_bash_syntax.sh
echo ""
./scripts/ci_check_python_syntax.sh
echo ""
./scripts/ci_check_compose_files.sh
echo ""

echo "============================================================"
echo "[OK] Local CI validation completed."
echo "============================================================"
