#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="generated/lab028"
mkdir -p "$OUT_DIR"

RULES_FILE="$OUT_DIR/auditd_dry_run_rules.rules"
EXPLANATION_FILE="$OUT_DIR/auditd_rules_explanation.md"

cat > "$RULES_FILE" <<'RULES'
# Lab 028 auditd dry-run rules
# DO NOT LOAD AUTOMATICALLY.
# These rules are examples for documentation and lab review only.

# Watch identity-related files for writes/attribute changes.
-w /etc/passwd -p wa -k identity_changes
-w /etc/group -p wa -k identity_changes

# Watch credential storage files for writes/attribute changes.
-w /etc/shadow -p wa -k credential_store_changes
-w /etc/gshadow -p wa -k credential_store_changes

# Watch sudo policy.
-w /etc/sudoers -p wa -k privilege_policy_changes
-w /etc/sudoers.d/ -p wa -k privilege_policy_changes

# Watch SSH server configuration.
-w /etc/ssh/sshd_config -p wa -k ssh_config_changes

# Example command execution syscall rule.
# This can be noisy and privacy-sensitive. Test only in a lab.
-a always,exit -F arch=b64 -S execve -k command_execution
RULES

cat > "$EXPLANATION_FILE" <<'EOF_EXPLAIN'
# Lab 028 auditd Dry-Run Rules Explanation

## Important safety note

These rules are not applied by the repository.

Do not load them on a real system without review. Audit rules can generate sensitive logs and large event volumes.

## Rule explanations

| Rule key | Purpose |
|---|---|
| `identity_changes` | detects changes to files related to local users/groups |
| `credential_store_changes` | detects changes to sensitive credential database files |
| `privilege_policy_changes` | detects changes to sudo policy |
| `ssh_config_changes` | detects SSH daemon configuration changes |
| `command_execution` | detects command execution events; can be noisy and privacy-sensitive |

## Privacy warning

Real audit data may include usernames, commands, process arguments, paths, hostnames and authentication details. Do not publish raw logs without review.

## Example search concepts

```text
ausearch -k identity_changes
ausearch -k ssh_config_changes
aureport -x
```

These are conceptual examples. This repository does not run them against real logs automatically.
EOF_EXPLAIN

echo "[OK] Generated: $RULES_FILE"
echo "[OK] Generated: $EXPLANATION_FILE"
echo "[INFO] These rules were not loaded."
