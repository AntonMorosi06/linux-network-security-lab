#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME/linux_lab/final_review"
BUNDLE_DIR="$BASE_DIR/proof_of_work_bundle_$(date +%Y%m%d_%H%M%S)"

mkdir -p "$BUNDLE_DIR"/{docs,security,meta,lists}

copy_if_exists() {
  local src="$1"
  local dst="$2"
  if [ -f "$src" ]; then
    cp "$src" "$dst"
  fi
}

copy_if_exists README.md "$BUNDLE_DIR/meta/README.md"
copy_if_exists VERSION "$BUNDLE_DIR/meta/VERSION"
copy_if_exists CHANGELOG.md "$BUNDLE_DIR/meta/CHANGELOG.md"
copy_if_exists RELEASE_NOTES_v0.1.0.md "$BUNDLE_DIR/meta/RELEASE_NOTES_v0.1.0.md"

for file in \
  docs/MASTER_LAB_INDEX.md \
  docs/FINAL_PROJECT_SUMMARY.md \
  docs/PROOF_OF_WORK.md \
  docs/FINAL_REVIEW_CHECKLIST.md \
  docs/V0_1_0_RELEASE_CANDIDATE_REVIEW.md \
  docs/WHAT_TO_SHOW_RECRUITER_OR_PROFESSOR.md \
  docs/PORTFOLIO_SUMMARY.md \
  docs/ROADMAP.md \
  docs/CURRENT_STATUS.md
do
  copy_if_exists "$file" "$BUNDLE_DIR/docs/$(basename "$file")"
done

for file in security/*.md; do
  [ -f "$file" ] && cp "$file" "$BUNDLE_DIR/security/"
done

find labs -maxdepth 1 -type f -name '[0-9][0-9][0-9]_*.md' | sort > "$BUNDLE_DIR/lists/lab_files.txt"
find scripts -type f | sort > "$BUNDLE_DIR/lists/script_files.txt"
find docs -type f | sort > "$BUNDLE_DIR/lists/doc_files.txt"
find docker -type f 2>/dev/null | sort > "$BUNDLE_DIR/lists/docker_files.txt" || true
find data -type f 2>/dev/null | sort > "$BUNDLE_DIR/lists/data_files.txt" || true

cat > "$BUNDLE_DIR/README.txt" <<EOF_INNER
Linux Network Security Lab - Proof-of-Work Bundle

Created: $(date)
Repository: $(basename "$(pwd)")
Version: $(cat VERSION 2>/dev/null || echo unknown)

This bundle contains selected index and review documents for portfolio/review use.

Review before sharing publicly.
Generated reports may contain local paths if added separately.
EOF_INNER

echo "[OK] Proof-of-work bundle created:"
echo "$BUNDLE_DIR"
