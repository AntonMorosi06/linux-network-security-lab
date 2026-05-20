# Lab 027 — SSH Hardening and Key-Based Access

## Objective

The objective of this lab is to understand SSH hardening and key-based access without modifying real SSH server configuration.

This lab performs read-only inspection and generates dry-run SSH configuration examples.

It does not edit `/etc/ssh/sshd_config`. It does not restart SSH. It does not disable password authentication. It does not delete keys.

## Safety boundary

Allowed:

```text
checking SSH tool availability
printing SSH client version
read-only inspection of ~/.ssh file names and permissions
generating example client config
generating example sshd_config hardening file
creating a local report
```

Not allowed:

```text
modifying real sshd_config automatically
restarting sshd automatically
disabling password login automatically
deleting keys
publishing private keys
brute forcing SSH
testing third-party hosts
```

## Files

This lab adds:

```text
docs/tools/SSH_HARDENING_KEY_BASED_ACCESS.md
scripts/ssh_lab027_check_requirements.sh
scripts/ssh_lab027_inspect_readonly.sh
scripts/ssh_lab027_generate_dry_run_config.sh
scripts/ssh_lab027_create_report.sh
generated/lab027/ssh_client_config_example
generated/lab027/sshd_config_hardening_example.conf
generated/lab027/authorized_keys_policy_example.md
examples/lab_027_expected_outputs.txt
reports/templates/lab_027_ssh_hardening_key_based_access_report_template.md
```

## Step 1 — Check requirements

```bash
./scripts/ssh_lab027_check_requirements.sh
```

Expected output:

```text
[OK] found: ssh
[OK] found: ssh-keygen
```

On some systems, `sshd` may not be installed or enabled. That is not a lab failure.

## Step 2 — Read-only inspection

```bash
./scripts/ssh_lab027_inspect_readonly.sh
```

This script inspects local SSH-related files without printing private key contents.

It intentionally avoids:

```text
cat ~/.ssh/id_*
printing private keys
modifying permissions
editing config
```

## Step 3 — Generate dry-run config examples

```bash
./scripts/ssh_lab027_generate_dry_run_config.sh
```

This creates examples under:

```text
generated/lab027/
```

These files are examples only. They are not applied.

## Step 4 — Create report

```bash
./scripts/ssh_lab027_create_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/lab027_ssh_hardening_key_based_access_YYYYMMDD_HHMMSS.txt
```

## Defensive hardening ideas

Common SSH hardening ideas include:

```text
use key-based authentication
protect private keys with passphrases
disable root login
disable password authentication only after key login is tested
limit allowed users
reduce max authentication attempts
avoid unnecessary forwarding
keep fallback access during changes
```

## What this lab does not do

This lab does not:

```text
change real server settings
disable password login
restart sshd
open remote access
scan hosts
attack SSH
collect credentials
publish private keys
```

## Common issues

### No sshd installed

Many macOS or desktop systems have an SSH client but no active SSH server. That is normal.

### Private keys exist

Do not publish them. Do not paste them into reports. Only document filenames and permissions if safe.

### PasswordAuthentication no is dangerous remotely

If you disable password auth before testing key login, you can lock yourself out. Always test in a lab first.

## Final conclusion

The safe SSH hardening chain is:

```text
inspect
generate examples
review
test in lab
document
apply manually only with recovery plan
```

A learning repo should not automatically modify SSH access.
