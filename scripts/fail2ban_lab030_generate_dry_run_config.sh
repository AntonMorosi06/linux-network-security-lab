#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="generated/lab030"
mkdir -p "$OUT_DIR"

FILTER_FILE="$OUT_DIR/fail2ban_filter_lab_auth.conf"
JAIL_FILE="$OUT_DIR/fail2ban_jail_lab_auth.local"
NOTES_FILE="$OUT_DIR/fail2ban_dry_run_notes.md"

cat > "$FILTER_FILE" <<'FILTER'
# Lab 030 Fail2ban filter dry-run example
# DO NOT COPY INTO /etc/fail2ban WITHOUT REVIEW.
# This filter is designed for the synthetic lab log format.

[Definition]
failregex = ^.*sshd\[\d+\]: Failed password .* from <HOST> port \d+ ssh2$
ignoreregex =
FILTER

cat > "$JAIL_FILE" <<'JAIL'
# Lab 030 Fail2ban jail dry-run example
# DO NOT COPY INTO /etc/fail2ban WITHOUT REVIEW.
# This is documentation-only.

[lab-auth-synthetic]
enabled = false
filter = lab-auth
logpath = /path/to/linux-network-security-lab/data/lab030/synthetic_auth.log
maxretry = 3
findtime = 600
bantime = 300
action = %(action_)s
JAIL

cat > "$NOTES_FILE" <<'NOTES'
# Lab 030 Fail2ban Dry-Run Notes

## Safety

These files are examples only.

They were not installed into `/etc/fail2ban`.
No service was restarted.
No IP address was banned.

## Defensive model

```text
synthetic auth log
-> failregex
-> count failed attempts
-> compare with maxretry
-> report finding
```

## Before real deployment

Document:

```text
system owner
service being protected
log path
filter regex
jail settings
rollback plan
false positive risk
admin access plan
```

## Privacy warning

Do not publish real authentication logs without sanitization.
NOTES

echo "[OK] Generated: $FILTER_FILE"
echo "[OK] Generated: $JAIL_FILE"
echo "[OK] Generated: $NOTES_FILE"
echo "[INFO] These files were not applied."
