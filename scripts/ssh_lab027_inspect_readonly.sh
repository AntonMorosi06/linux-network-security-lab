#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Lab 027 read-only SSH inspection"
echo "[INFO] No files will be modified."
echo "[INFO] Private key contents will not be printed."
echo ""

SSH_DIR="$HOME/.ssh"

if [ -d "$SSH_DIR" ]; then
  echo "[INFO] SSH directory exists: $SSH_DIR"
  echo "[INFO] Listing filenames and permissions only."
  echo ""

  if command -v stat >/dev/null 2>&1; then
    for f in "$SSH_DIR"/*; do
      [ -e "$f" ] || continue
      base="$(basename "$f")"
      case "$base" in
        id_*|*.pem|*.key)
          if [[ "$base" == *.pub ]]; then
            sensitive="public-key-review-comments"
          else
            sensitive="private-key-do-not-publish"
          fi
          ;;
        known_hosts)
          sensitive="known-hosts-review-before-publish"
          ;;
        config)
          sensitive="ssh-config-review-before-publish"
          ;;
        authorized_keys)
          sensitive="authorized-keys-review-before-publish"
          ;;
        *)
          sensitive="review"
          ;;
      esac

      if [ "$(uname -s)" = "Darwin" ]; then
        perm="$(stat -f "%Sp" "$f" 2>/dev/null || echo unknown)"
      else
        perm="$(stat -c "%A" "$f" 2>/dev/null || echo unknown)"
      fi
      echo "$perm  $(basename "$f")  [$sensitive]"
    done
  else
    ls -la "$SSH_DIR"
  fi
else
  echo "[INFO] No ~/.ssh directory found."
fi

echo ""
echo "[INFO] System SSH server config paths, existence only:"
for f in /etc/ssh/sshd_config /etc/ssh/ssh_config; do
  if [ -f "$f" ]; then
    echo "[INFO] exists: $f"
  else
    echo "[INFO] not found: $f"
  fi
done

echo ""
echo "[OK] Read-only SSH inspection completed."
