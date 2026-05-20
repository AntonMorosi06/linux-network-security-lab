# Lab 029 — Lynis Local Security Audit

## Objective

The objective of this lab is to introduce Lynis as a local defensive security auditing tool.

This lab checks whether Lynis is installed, creates synthetic findings for GitHub-safe practice, and provides an optional gated script to run a real local audit on a machine you own or administer.

The patch does not run a real Lynis audit automatically.

## Safety boundary

Allowed:

```text
checking whether Lynis is installed
printing version/help output
creating synthetic findings
running an audit only on your own machine or VM
saving raw output locally
publishing only sanitized summaries
```

Not allowed:

```text
running Lynis on machines you do not own/administer
publishing raw Lynis reports without review
publishing private hostnames, usernames or local paths
treating Lynis as a complete security certification
```

## Files

This lab adds:

```text
docs/tools/LYNIS_LOCAL_SECURITY_AUDIT.md
scripts/lynis_lab029_check_requirements.sh
scripts/lynis_lab029_create_synthetic_findings.py
scripts/lynis_lab029_run_local_audit.sh
scripts/lynis_lab029_create_report.sh
data/lab029/synthetic_lynis_findings.jsonl
examples/lab_029_expected_outputs.txt
reports/templates/lab_029_lynis_local_security_audit_report_template.md
```

## Step 1 — Check requirements

```bash
./scripts/lynis_lab029_check_requirements.sh
```

Expected output may include:

```text
[OK] found: lynis
```

or:

```text
[INFO] optional tool not found: lynis
```

Missing Lynis is not a lab failure.

## Step 2 — Create synthetic findings

```bash
./scripts/lynis_lab029_create_synthetic_findings.py
```

Expected output:

```text
[OK] Synthetic Lynis-style findings created: data/lab029/synthetic_lynis_findings.jsonl
```

These findings are fake and safe to use in examples.

## Step 3 — Optional real local audit

The real audit is gated. It will not run unless you explicitly set:

```bash
RUN_LYNIS_LOCAL_AUDIT=yes ./scripts/lynis_lab029_run_local_audit.sh
```

This should only be used on your own machine, VM or explicitly authorized system.

Raw output is saved locally under:

```text
~/linux_lab/private_outputs/lab029/
```

Do not publish raw output without review.

## Step 4 — Create report

```bash
./scripts/lynis_lab029_create_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/lab029_lynis_local_security_audit_YYYYMMDD_HHMMSS.txt
```

## Defensive interpretation

Lynis findings should be treated as:

```text
recommendations
hardening prompts
evidence for follow-up
not final proof of security
not final proof of compromise
```

## What this lab does not do

This lab does not:

```text
audit third-party machines
publish raw system audit output
apply hardening automatically
modify system configuration
install packages
claim certification
```

## Common issues

### Lynis is missing

On macOS with Homebrew:

```bash
brew install lynis
```

On Debian/Ubuntu:

```bash
sudo apt install lynis
```

### Permission differences

Some Lynis checks may report more detail when run with elevated privileges. This lab does not force sudo.

### Sensitive output

Raw audit output may include hostnames, paths, users, services, packages or configuration details. Keep it private until sanitized.

## Final conclusion

The safe chain is:

```text
check tool
generate synthetic findings
optionally run local audit with confirmation
sanitize
summarize
write defensive report
```
