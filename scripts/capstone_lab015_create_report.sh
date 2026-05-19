#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="$HOME/linux_lab/reports"
REPORT_FILE="$REPORT_DIR/capstone_lab015_report_$(date +%Y%m%d_%H%M%S).txt"

mkdir -p "$REPORT_DIR"

{
echo "============================================================"
echo "CAPSTONE LAB 015 FINAL REPORT"
echo "Date: $(date)"
echo "Repository: $(basename "$(pwd)")"
echo "Host: $(hostname 2>/dev/null || echo unknown)"
echo "User: $(whoami 2>/dev/null || echo unknown)"
echo "============================================================"
echo

echo "===== GIT STATE ====="
git status --short || true
echo

echo "===== COMPOSE STATE ====="
docker compose -f docker/lab015/compose.yaml ps || true
echo

echo "===== ENDPOINT TEST ====="
./scripts/capstone_lab015_test.sh || true
echo

echo "===== PROMETHEUS QUERIES ====="
./scripts/capstone_lab015_query_metrics.sh || true
echo

echo "===== RECENT LOGS ====="
./scripts/capstone_lab015_logs.sh 80 || true
echo

echo "===== SECURITY INTERPRETATION ====="
echo "- Reverse proxy is published to 127.0.0.1:8800."
echo "- Prometheus is published to 127.0.0.1:9095."
echo "- API is not directly published to the host."
echo "- Protected endpoints require X-API-Key."
echo "- Metrics are exposed for local observability."
echo "- Logs are available through Docker Compose."
echo "- CI and threat modeling already exist in the repository."
echo

echo "===== RECOMMENDED NEXT ACTIONS ====="
echo "1. Review report before committing or publishing."
echo "2. Run ./scripts/ci_local_validate.sh."
echo "3. Check GitHub Actions after push."
echo "4. Create a v0.1.0 release after final review."
echo "5. Add screenshots to screenshots/ if useful."
echo

echo "============================================================"
echo "END OF CAPSTONE REPORT"
echo "============================================================"
} > "$REPORT_FILE"

echo "[OK] Report created:"
echo "$REPORT_FILE"
echo ""
echo "[INFO] Preview:"
head -160 "$REPORT_FILE"
