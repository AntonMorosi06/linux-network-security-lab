# Lab 030 — Fail2ban Local Log-Based Protection

## Objective

The objective of this lab is to understand Fail2ban-style log-based protection using synthetic authentication logs.

This lab generates fake SSH authentication log lines, analyzes repeated failed-login patterns, creates dry-run Fail2ban filter/jail examples and writes a defensive report.

It does not install Fail2ban. It does not start or restart Fail2ban. It does not modify `/etc/fail2ban`. It does not ban any real IP address.

## Safety boundary

Allowed:

```text
checking whether fail2ban-client exists
generating synthetic logs
analyzing synthetic failed-login patterns
generating dry-run configuration examples
writing a local report
```

Not allowed:

```text
modifying /etc/fail2ban
starting/restarting fail2ban
banning real IP addresses
testing against real login services
brute forcing SSH
publishing real authentication logs
```

## Files

This lab adds:

```text
docs/tools/FAIL2BAN_LOCAL_LOG_BASED_PROTECTION.md
scripts/fail2ban_lab030_check_requirements.sh
scripts/fail2ban_lab030_generate_synthetic_auth_log.py
scripts/fail2ban_lab030_analyze_synthetic_auth_log.py
scripts/fail2ban_lab030_generate_dry_run_config.sh
scripts/fail2ban_lab030_create_report.sh
data/lab030/synthetic_auth.log
data/lab030/synthetic_fail2ban_findings.jsonl
generated/lab030/fail2ban_filter_lab_auth.conf
generated/lab030/fail2ban_jail_lab_auth.local
generated/lab030/fail2ban_dry_run_notes.md
examples/lab_030_expected_outputs.txt
reports/templates/lab_030_fail2ban_local_log_based_protection_report_template.md
```

## Step 1 — Check requirements

```bash
./scripts/fail2ban_lab030_check_requirements.sh
```

Expected output may include:

```text
[OK] found: fail2ban-client
```

or:

```text
[INFO] optional tool not found: fail2ban-client
```

Missing Fail2ban is not a lab failure because this lab uses synthetic logs and dry-run examples.

## Step 2 — Generate synthetic authentication log

```bash
./scripts/fail2ban_lab030_generate_synthetic_auth_log.py
```

Expected output:

```text
[OK] Synthetic auth log created: data/lab030/synthetic_auth.log
```

## Step 3 — Analyze synthetic log

```bash
./scripts/fail2ban_lab030_analyze_synthetic_auth_log.py
```

Expected output:

```text
[OK] Synthetic findings created: data/lab030/synthetic_fail2ban_findings.jsonl
```

## Step 4 — Generate dry-run Fail2ban config

```bash
./scripts/fail2ban_lab030_generate_dry_run_config.sh
```

This creates:

```text
generated/lab030/fail2ban_filter_lab_auth.conf
generated/lab030/fail2ban_jail_lab_auth.local
generated/lab030/fail2ban_dry_run_notes.md
```

These files are examples only. They are not copied into `/etc/fail2ban`.

## Step 5 — Create report

```bash
./scripts/fail2ban_lab030_create_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/lab030_fail2ban_local_log_based_protection_YYYYMMDD_HHMMSS.txt
```

## Detection model

The synthetic model is:

```text
failed login line
-> extract source IP
-> count failures by IP
-> compare with threshold
-> create finding
-> recommend defensive review
```

## What this lab does not do

This lab does not:

```text
run brute force
touch SSH service
ban real IPs
modify Fail2ban service
publish real logs
collect real credentials
```

## Common issues

### Fail2ban is missing

That is fine. The lab still works with synthetic logs.

### Real logs are tempting to use

Do not commit real authentication logs. Use synthetic examples in GitHub.

### Dry-run config looks real

It is intentionally realistic for learning, but it is not applied automatically.

## Final conclusion

The safe chain is:

```text
synthetic log
-> pattern analysis
-> dry-run filter/jail
-> local report
-> privacy review
```

Fail2ban is a defensive tool, but real deployment must be tested carefully on systems you own or administer.
