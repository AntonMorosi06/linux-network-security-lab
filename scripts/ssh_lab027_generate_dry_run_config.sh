#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="generated/lab027"
mkdir -p "$OUT_DIR"

CLIENT_FILE="$OUT_DIR/ssh_client_config_example"
SSHD_FILE="$OUT_DIR/sshd_config_hardening_example.conf"
AUTH_KEYS_POLICY="$OUT_DIR/authorized_keys_policy_example.md"

cat > "$CLIENT_FILE" <<'EOF_CLIENT'
# Lab 027 SSH client config example
# DO NOT COPY BLINDLY.
# Review paths, usernames and ports before use.

Host lab-vm
  HostName 127.0.0.1
  Port 2222
  User labuser
  IdentityFile ~/.ssh/lab_ed25519
  IdentitiesOnly yes
  ServerAliveInterval 60
  ServerAliveCountMax 3
EOF_CLIENT

cat > "$SSHD_FILE" <<'EOF_SSHD'
# Lab 027 sshd_config hardening example
# DO NOT APPLY AUTOMATICALLY.
# Test in a lab VM first.
# Keep a fallback session open before changing real remote access.

Protocol 2
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
KbdInteractiveAuthentication no
PermitEmptyPasswords no
X11Forwarding no
AllowTcpForwarding no
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2

# Example only. Replace with a real reviewed local user in a lab.
AllowUsers labuser
EOF_SSHD

cat > "$AUTH_KEYS_POLICY" <<'EOF_POLICY'
# authorized_keys Policy Example

## Purpose

This file describes how to review `authorized_keys` safely.

## Recommended checks

```text
one key per expected user/device
remove unknown keys
review comments at the end of keys
avoid sharing private keys
rotate old keys
use passphrases for private keys
restrict keys where appropriate
```

## Do not publish

```text
private keys
real usernames if sensitive
hostnames
internal comments
keys from production systems
```

## Example public key line format

```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA... labuser@example-lab
```

This is a format example only, not a real key.
EOF_POLICY

echo "[OK] Generated: $CLIENT_FILE"
echo "[OK] Generated: $SSHD_FILE"
echo "[OK] Generated: $AUTH_KEYS_POLICY"
echo "[INFO] These files are examples only. They were not applied."
