# Evidence Index

This document explains how evidence is handled in `linux-network-security-lab`.

The repository is designed as a local, defensive and authorized Linux/networking/cybersecurity lab. Evidence must therefore prove controlled learning and safe execution, not unauthorized activity.

## Evidence Policy

Only sanitized evidence should be committed to this repository.

Raw local outputs may contain private information such as usernames, hostnames, local paths, local IP addresses, package versions, service names, timestamps, network details or machine-specific findings. Raw outputs should remain outside the repository until reviewed.

Recommended private locations for raw outputs:

```text
~/linux_lab/reports/
~/linux_lab/private_outputs/
```

Recommended public location for sanitized evidence:

```text
reports/evidence/
```

## Evidence Types

| Evidence type | Public status | Notes |
|---|---|---|
| Sanitized command output | Allowed | Remove personal usernames, hostnames and sensitive paths. |
| Synthetic command output | Allowed | Must be clearly synthetic/example output. |
| Local lab report | Allowed after review | Commit only sanitized Markdown/text reports. |
| PCAP file | Review required | Use synthetic/local PCAPs only; document origin. |
| Screenshot | Review required | Remove private data and unrelated windows. |
| Raw terminal log | Private by default | Review and sanitize before committing. |
| Security tool raw output | Private by default | Tools like Lynis may reveal sensitive local system information. |
| Real authentication logs | Private by default | Use synthetic logs for public examples. |

## Current Evidence Pointers

| Path | Purpose | Status |
|---|---|---|
| `reports/evidence/` | Main sanitized evidence folder | Expected evidence location |
| `reports/evidence/LATEST_V1_1_SAFE_RUN.md` | Pointer to latest v1.1 safe-run evidence bundle | Referenced by README if present |
| `docs/ALL_CODES_TOGETHER.md` | Consolidated command collection | Documentation evidence |
| `docs/ALL_CODES_TOGETHER_FULL.md` | Generated full command/code index for Labs 001-030 | Documentation evidence |
| `docs/COMMAND_INDEX_001_030.md` | Command index for lab sequence | Documentation evidence |
| `scripts/run_safe_v11_labs_021_030.sh` | Safe v1.1 runner | Execution support evidence |

## What Evidence Should Prove

Evidence should prove that:

1. labs are structured and reproducible;
2. commands are local or authorized;
3. outputs are interpreted defensively;
4. raw sensitive data is not published;
5. v1.1 labs can be executed safely;
6. the project demonstrates Linux/network/security learning in a controlled environment.

Evidence should not imply:

1. unauthorized scanning;
2. offensive exploitation;
3. Wi-Fi cracking;
4. production incident response;
5. real third-party monitoring;
6. enterprise security validation.

## Sanitization Checklist

Before committing evidence, check:

| Done | Check |
|---|---|
| [ ] | No API keys, tokens, passwords or secrets. |
| [ ] | No private keys or SSH private material. |
| [ ] | No personal account information. |
| [ ] | No public IP scans unless explicitly authorized and documented. |
| [ ] | No private hostnames unless replaced or acceptable. |
| [ ] | No private usernames unless replaced or acceptable. |
| [ ] | No sensitive local paths. |
| [ ] | No raw Wi-Fi captures. |
| [ ] | No real authentication logs unless fully synthetic/redacted. |
| [ ] | No screenshots with private browser tabs, accounts, files or messages. |
| [ ] | Synthetic examples are clearly labeled as synthetic. |
| [ ] | Local-only evidence is clearly labeled as localhost/container/namespace/VM. |

## Recommended Evidence Bundle Structure

A clean evidence bundle should follow this structure:

```text
reports/evidence/YYYY-MM-DD_v1_1_safe_run/
  README.md
  command_summary.md
  sanitized_outputs.md
  generated_reports_index.md
  safety_notes.md
  limitations.md
```

## Example Evidence Summary Format

```text
Evidence bundle: v1.1 safe run
Date: YYYY-MM-DD
Environment: local machine / VM / container / namespace
Scope: localhost and synthetic data only
Labs covered: 021-030
Raw outputs location: private local folder, not committed
Sanitized outputs: committed under reports/evidence/
Safety notes: no external targets, no unauthorized scanning, no real Wi-Fi capture, no credential material
```

## Next Evidence Tasks

| Priority | Task | Acceptance criteria |
|---:|---|---|
| 1 | Confirm latest sanitized evidence pointer | `reports/evidence/LATEST_V1_1_SAFE_RUN.md` exists or is created. |
| 2 | Create v1.1 evidence bundle README | Bundle explains environment, scope, labs and safety boundaries. |
| 3 | Review all PCAP/log/report files | No private or raw sensitive data is committed. |
| 4 | Add portfolio-safe terminal examples | Examples are local, sanitized and clearly explained. |
| 5 | Link evidence from README | Reviewer can find evidence without digging through folders. |

## Final Evidence Statement

This repository should use evidence to demonstrate disciplined, local, defensive technical practice. Sanitized evidence is a strength. Raw unreviewed output is a risk and should remain private until inspected.
