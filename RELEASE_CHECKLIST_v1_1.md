# Release Checklist — v1.1 Safe Linux Security Tools Expansion

This checklist defines the remaining work required before marking `linux-network-security-lab` v1.1 as a polished portfolio-ready release.

## Release Goal

The goal of v1.1 is to extend the v1.0 defensive Linux/networking baseline with safe security-tool awareness labs.

The release must remain:

- local;
- defensive;
- authorized;
- reproducible;
- documented;
- privacy-aware;
- safe for public portfolio presentation.

## v1.1 Scope

| Lab | Topic | Release requirement |
|---:|---|---|
| 021 | Linux Security Tools Overview | Tool inventory is safe and does not run offensive workflows. |
| 022 | Wireshark and TShark Packet Analysis | Uses synthetic/local PCAPs only. |
| 023 | Nmap Localhost and Authorized Service Scanning | Scans only localhost or explicit lab targets. |
| 024 | Aircrack-ng Wireless Security Awareness | Awareness-only; no capture, deauth, handshake collection or cracking. |
| 025 | tcpdump Advanced Capture Filters | Captures only loopback or controlled lab traffic. |
| 026 | Defensive Firewall Rules | Read-only or dry-run examples only unless explicitly controlled. |
| 027 | SSH Hardening | No private keys or real access disruption. |
| 028 | auditd and Linux Event Auditing | Synthetic or dry-run audit examples only. |
| 029 | Lynis Local Security Audit | Raw outputs treated as private until sanitized. |
| 030 | Fail2ban Local Log-Based Protection | Synthetic logs and dry-run examples only. |

## Documentation Checklist

| Done | Requirement |
|---|---|
| [x] | `CURRENT_STATUS.md` exists. |
| [x] | `KNOWN_LIMITATIONS.md` exists. |
| [x] | `LAB_INDEX.md` exists. |
| [x] | `PORTFOLIO_SUMMARY.md` exists. |
| [x] | `EVIDENCE.md` exists. |
| [x] | README links to the new portfolio/status files. |
| [ ] | v1.1 release notes exist or are updated. |
| [ ] | Labs 021-030 each have clear safety notes. |
| [ ] | All command indexes point to current labs. |
| [x] | Evidence pointer is verified. |

## Evidence Pointer Verification

The latest v1.1 safe-run evidence pointer has been verified.

```text
reports/evidence/LATEST_V1_1_SAFE_RUN.md
```

Current pointer target:

```text
reports/evidence/v1_1_mac_rerun_20260520_152216
```

Generated at:

```text
20260520_152216
```

The pointer states that it is updated whenever a new sanitized safe-run evidence bundle is uploaded.

## Evidence Bundle Review

A metadata-level evidence bundle review has been added here:

```text
reports/evidence/v1_1_mac_rerun_20260520_152216/EVIDENCE_REVIEW.md
```

The review verifies the bundle README, run summary, manifest, declared scope, macOS platform, safety notes and raw-output policy. It confirms that the bundle is acceptable as the current v1.1 evidence pointer.

Important limitation: this is not a full manual line-by-line review of every sanitized output file. A deeper file-by-file pass is still recommended before final release tagging.

## Safety Checklist

| Done | Requirement |
|---|---|
| [ ] | No external scanning examples are included. |
| [ ] | Nmap examples are localhost or explicitly authorized only. |
| [ ] | Aircrack-ng material is awareness-only. |
| [ ] | No Wi-Fi cracking workflow is present. |
| [ ] | No deauthentication workflow is present. |
| [ ] | No handshake capture workflow is present. |
| [ ] | tcpdump/TShark examples avoid private traffic. |
| [ ] | Firewall labs do not unexpectedly modify real system state. |
| [ ] | auditd/Lynis/Fail2ban outputs are synthetic or sanitized. |
| [x] | Raw outputs remain outside the repository. |

## Evidence Checklist

| Done | Requirement |
|---|---|
| [x] | `reports/evidence/LATEST_V1_1_SAFE_RUN.md` exists or is created. |
| [x] | Evidence states environment and scope. |
| [x] | Evidence states that only local/synthetic/authorized activity was used. |
| [ ] | Evidence contains no secrets. |
| [ ] | Evidence contains no private keys. |
| [ ] | Evidence contains no raw authentication logs. |
| [ ] | Evidence contains no private screenshots. |
| [x] | Evidence explains what the run proves. |

## Portfolio Checklist

| Done | Requirement |
|---|---|
| [ ] | Repository can be described in one sentence. |
| [x] | README entry points are clear. |
| [x] | `PORTFOLIO_SUMMARY.md` is linked from README. |
| [x] | Current status is clear. |
| [x] | Limitations are clear. |
| [x] | Evidence is clear. |
| [x] | v1.1 scope is clear. |
| [ ] | Repository is ready to be pinned or linked from portfolio. |

## Suggested Release Tag

```text
v1.1.0-safe-tools-expansion
```

## Suggested Release Title

```text
Linux Network Security Lab v1.1 — Safe Security Tools Expansion
```

## Suggested Release Description

```text
This release expands the local defensive Linux and networking lab with safe security-tool awareness labs covering TShark/Wireshark analysis, localhost-only Nmap scanning, Aircrack-ng awareness boundaries, tcpdump filters, defensive firewall rules, SSH hardening, auditd-style event auditing, Lynis-style audit reporting and Fail2ban-style synthetic log protection.

All labs remain local, defensive and authorized. Raw outputs are kept private until sanitized, and public evidence is designed to demonstrate controlled learning rather than offensive activity.
```

## Final Release Decision

v1.1 should be released only after the documentation, safety and evidence checklists are complete.
