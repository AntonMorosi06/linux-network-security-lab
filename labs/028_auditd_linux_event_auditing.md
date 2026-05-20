# Lab 028 — auditd and Linux Event Auditing

## Objective

The objective of this lab is to understand Linux event auditing with `auditd` without changing the machine audit configuration.

This lab performs read-only tool inspection, generates dry-run audit rules and creates synthetic audit-like events for report practice.

It does not install auditd. It does not start or restart auditd. It does not load audit rules. It does not modify `/etc/audit`.

## Safety boundary

Allowed:

```text
checking whether audit tools exist
read-only status inspection
dry-run audit rule generation
synthetic event generation
local report writing
```

Not allowed:

```text
modifying /etc/audit
loading audit rules automatically
restarting auditd
collecting private user activity
publishing real audit logs without review
monitoring users without authorization
```

## Files

This lab adds:

```text
docs/tools/AUDITD_LINUX_EVENT_AUDITING.md
scripts/auditd_lab028_check_requirements.sh
scripts/auditd_lab028_inspect_readonly.sh
scripts/auditd_lab028_generate_dry_run_rules.sh
scripts/auditd_lab028_create_synthetic_events.py
scripts/auditd_lab028_create_report.sh
generated/lab028/auditd_dry_run_rules.rules
generated/lab028/auditd_rules_explanation.md
examples/lab_028_expected_outputs.txt
reports/templates/lab_028_auditd_linux_event_auditing_report_template.md
```

## Step 1 — Check requirements

```bash
./scripts/auditd_lab028_check_requirements.sh
```

Expected output on Linux may include:

```text
[OK] found: auditctl
[OK] found: ausearch
[OK] found: aureport
```

On macOS, these tools may be missing. That is not a lab failure.

## Step 2 — Read-only inspection

```bash
./scripts/auditd_lab028_inspect_readonly.sh
```

The script attempts read-only inspection only. It does not load audit rules.

## Step 3 — Generate dry-run audit rules

```bash
./scripts/auditd_lab028_generate_dry_run_rules.sh
```

This creates:

```text
generated/lab028/auditd_dry_run_rules.rules
generated/lab028/auditd_rules_explanation.md
```

These files are examples only. They are not applied.

## Step 4 — Create synthetic events

```bash
./scripts/auditd_lab028_create_synthetic_events.py
```

This creates a synthetic JSONL event file under:

```text
data/lab028/synthetic_audit_events.jsonl
```

The events are fake and safe to use for learning.

## Step 5 — Create report

```bash
./scripts/auditd_lab028_create_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/lab028_auditd_linux_event_auditing_YYYYMMDD_HHMMSS.txt
```

## Defensive audit model

A basic audit workflow is:

```text
1. define sensitive asset
2. define event of interest
3. create narrow rule
4. label event with key
5. search by key
6. review findings
7. protect privacy
8. write report
```

## What this lab does not do

This lab does not:

```text
install auditd
enable auditd
load rules into the kernel
restart services
collect real user command history
publish real audit logs
```

## Common issues

### auditctl not found

On macOS this is normal. On Linux, audit tools may need installation in a VM.

### permission denied

Some audit inspection commands require elevated privileges. This lab does not force sudo.

### too much logging

Real audit rules can generate a lot of events. Always test in a lab VM before production use.

## Final conclusion

This lab teaches event auditing logic without changing audit configuration.

The safe chain is:

```text
inspect
generate dry-run rules
create synthetic events
write report
do not load rules automatically
```
