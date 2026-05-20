#!/usr/bin/env bash
# Lab 026 ufw dry-run example
# DO NOT RUN WITHOUT REVIEW.
# This file is generated for documentation only.

echo "DRY RUN ONLY — these commands are not executed automatically."

cat <<'COMMANDS'
ufw default deny incoming
ufw default allow outgoing
ufw allow from 192.0.2.10 to any port 22 proto tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw status verbose
COMMANDS
