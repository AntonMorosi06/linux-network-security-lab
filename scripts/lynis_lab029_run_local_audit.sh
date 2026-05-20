#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="$HOME/linux_lab/private_outputs/lab029"
mkdir -p "$OUT_DIR"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT_FILE="$OUT_DIR/lynis_local_audit_${STAMP}.txt"

echo "[INFO] Lab 029 optional local Lynis audit"
echo "[INFO] Raw output path: $OUT_FILE"
echo ""

if ! command -v lynis >/dev/null 2>&1; then
  echo "[WARN] lynis not found"
  echo "[INFO] Install only if needed:"
  echo "  brew install lynis"
  echo "  sudo apt install lynis"
  exit 0
fi

if [ "${RUN_LYNIS_LOCAL_AUDIT:-no}" != "yes" ]; then
  echo "[WARN] Real local Lynis audit not started."
  echo "[INFO] This guard prevents accidental collection of sensitive local details."
  echo "[INFO] To run explicitly on your own machine or VM:"
  echo "  RUN_LYNIS_LOCAL_AUDIT=yes ./scripts/lynis_lab029_run_local_audit.sh"
  exit 0
fi

echo "[INFO] Starting Lynis local audit."
echo "[INFO] Run only on a system you own/administer."
echo "[INFO] Review and sanitize output before publication."
echo ""

{
  echo "Lab 029 Lynis local audit"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo "Scope: local machine only"
  echo "Privacy: raw output must be reviewed before publication"
  echo "------------------------------------------------------------"
  lynis audit system --quick --no-colors 2>&1 || true
} > "$OUT_FILE"

echo "[OK] Local audit completed or exited."
echo "[INFO] Raw output saved to:"
echo "$OUT_FILE"
echo "[WARN] Do not publish raw output without review."
