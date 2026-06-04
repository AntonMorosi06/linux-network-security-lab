# Evidence Review — v1.1 macOS Rerun

Evidence bundle:

```text
reports/evidence/v1_1_mac_rerun_20260520_152216
```

Review date: 2026-06-04

Review type: repository-level evidence metadata and safety review

## Review Summary

This evidence bundle is suitable as the current v1.1 evidence pointer for `linux-network-security-lab`, with one important limitation: this review verifies the bundle metadata, declared scope, safety notes and manifest structure. It does not replace a full manual line-by-line review of every sanitized output file.

The bundle is acceptable for the current release checklist stage because it clearly states that it contains sanitized evidence from a macOS rerun of Labs 021-030, that raw local reports remain outside the repository, and that common identifiers and sensitive details were redacted.

## Files Reviewed

| File | Review result |
|---|---|
| `README.md` | Confirms this is a sanitized macOS rerun evidence folder and points to `RUN_SUMMARY.md` and `EVIDENCE_MANIFEST.json`. |
| `RUN_SUMMARY.md` | Confirms date, script used, platform, safety notes, sanitization policy and raw-output policy. |
| `EVIDENCE_MANIFEST.json` | Confirms generated timestamp, raw output policy, sanitized file list and target directory. |

## Scope Verification

| Requirement | Result | Evidence |
|---|---|---|
| Evidence states environment/platform | Verified | `RUN_SUMMARY.md` states that the run was performed on macOS. |
| Evidence states run command | Verified | `RUN_SUMMARY.md` lists `./scripts/run_safe_v11_labs_021_030.sh`. |
| Evidence states local report location | Verified | `RUN_SUMMARY.md` states reports were produced under `~/linux_lab/reports/`. |
| Evidence states sanitized copies only | Verified | `RUN_SUMMARY.md` and manifest state that raw reports remain outside the repository. |
| Evidence covers Labs 021-030 | Verified | `RUN_SUMMARY.md` and manifest describe v1.1 Labs 021-030 evidence. |

## Safety Verification

| Safety statement | Result |
|---|---|
| No third-party hosts were scanned. | Declared in `RUN_SUMMARY.md`. |
| No Wi-Fi network was attacked. | Declared in `RUN_SUMMARY.md`. |
| No wireless traffic was captured. | Declared in `RUN_SUMMARY.md`. |
| No firewall rules were applied. | Declared in `RUN_SUMMARY.md`. |
| No SSH configuration was modified. | Declared in `RUN_SUMMARY.md`. |
| No auditd rules were loaded. | Declared in `RUN_SUMMARY.md`. |
| No real Fail2ban configuration was modified. | Declared in `RUN_SUMMARY.md`. |
| No raw private outputs were committed. | Declared in `RUN_SUMMARY.md` and `EVIDENCE_MANIFEST.json`. |

## Sanitization Verification

| Sanitization point | Result |
|---|---|
| Common local identifiers replaced | Declared in `RUN_SUMMARY.md` and manifest notes. |
| Long Nmap fingerprint blocks removed | Declared in `RUN_SUMMARY.md` and manifest notes. |
| Detailed local process listings redacted | Declared in manifest notes. |
| Raw reports kept outside repository | Declared in README, run summary and manifest. |
| Raw outputs committed | Manifest states `raw_outputs_committed: false`. |

## Manifest Coverage

The manifest lists sanitized outputs for:

- Lab 021 — Linux Security Tools Overview
- Lab 022 — TShark Packet Analysis
- Lab 023 — Nmap Localhost / Authorized Scanning
- Lab 024 — Aircrack-ng Wireless Security Awareness
- Lab 025 — tcpdump Advanced Capture Filters
- Lab 026 — Defensive Firewall Rules
- Lab 027 — SSH Hardening and Key-Based Access
- Lab 028 — auditd Linux Event Auditing
- Lab 029 — Lynis Local Security Audit
- Lab 030 — Fail2ban Local Log-Based Protection
- macOS rerun tool check

## Sensitive Pattern Check

A repository-level search was performed for common sensitive terms around this evidence bundle, including private keys, passwords, secrets, tokens, credentials and AWS-style key prefixes. No matching results were returned by the GitHub search connector during this review.

This does not prove that the bundle is mathematically free of every possible sensitive string, but it supports the current release checklist step together with the manifest and sanitization notes.

## Release Checklist Recommendation

The following evidence checklist items can be marked as complete:

- `reports/evidence/LATEST_V1_1_SAFE_RUN.md` exists or is created.
- Evidence states environment and scope.
- Evidence states that only local/synthetic/authorized activity was used.
- Evidence explains what the run proves.

The following items should remain under review until a full file-by-file evidence pass is completed:

- Evidence contains no secrets.
- Evidence contains no private keys.
- Evidence contains no raw authentication logs.
- Evidence contains no private screenshots.

## Final Review Decision

Current decision:

```text
Evidence pointer and bundle metadata are verified. Bundle is acceptable as the current v1.1 evidence pointer, but a deeper file-by-file review is still recommended before final release tagging.
```
