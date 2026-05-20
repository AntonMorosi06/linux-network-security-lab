# Lab 030 Report — Fail2ban Local Log-Based Protection

## Analyst

```text
Name:
Date:
Machine:
OS:
Repository commit:
```

## Scope

```text
Synthetic logs:
Dry-run config:
Real Fail2ban modified: No
Real IPs banned: No
```

## Tool information

| Tool | Present | Notes |
|---|---|---|
| fail2ban-client |  |  |
| python3 |  |  |

## Synthetic findings summary

| Source IP | Failed attempts | Threshold exceeded | Recommendation |
|---|---:|---|---|
|  |  |  |  |

## Generated files

```text
data/lab030/synthetic_auth.log
data/lab030/synthetic_fail2ban_findings.jsonl
generated/lab030/fail2ban_filter_lab_auth.conf
generated/lab030/fail2ban_jail_lab_auth.local
generated/lab030/fail2ban_dry_run_notes.md
```

## Safety review

```text
Were real authentication logs used? No.
Was Fail2ban modified? No.
Was any service restarted? No.
Were any IPs banned? No.
Was brute force performed? No.
```

## Defensive interpretation

```text
This lab demonstrates Fail2ban-style detection logic using synthetic authentication logs.
```

## Publication review

Before publishing any real future output, remove usernames, IP addresses, hostnames, timestamps and infrastructure details if sensitive.
