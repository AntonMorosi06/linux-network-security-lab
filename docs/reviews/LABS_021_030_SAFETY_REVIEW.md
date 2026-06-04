# Labs 021-030 Safety Review

Review date: 2026-06-04

Repository: `linux-network-security-lab`

Issue: #2 — Review Labs 021-030 safety notes

## Review Summary

Labs 021-030 were reviewed for local scope, defensive framing, authorization boundaries, privacy handling and explicit limitations.

Result:

```text
PASS
```

Each lab includes a clear safety boundary and a section describing what the lab does not do. The v1.1 lab sequence is consistent with the repository's public positioning as a local, defensive and authorized Linux/networking/security learning lab.

## Reviewed Files

| Lab | File | Result |
|---:|---|---|
| 021 | `labs/021_linux_security_tools_overview.md` | Pass |
| 022 | `labs/022_wireshark_tshark_packet_analysis.md` | Pass |
| 023 | `labs/023_nmap_localhost_authorized_scanning.md` | Pass |
| 024 | `labs/024_aircrack_ng_wireless_security_awareness.md` | Pass with cautionary framing preserved |
| 025 | `labs/025_tcpdump_advanced_capture_filters.md` | Pass |
| 026 | `labs/026_defensive_firewall_rules_nftables_iptables_ufw.md` | Pass |
| 027 | `labs/027_ssh_hardening_key_based_access.md` | Pass |
| 028 | `labs/028_auditd_linux_event_auditing.md` | Pass |
| 029 | `labs/029_lynis_local_security_audit.md` | Pass |
| 030 | `labs/030_fail2ban_local_log_based_protection.md` | Pass |

## Review Criteria

Each lab was checked for the following:

| Criterion | Result |
|---|---|
| Clear objective | Pass |
| Local, controlled or synthetic scope | Pass |
| Explicit safety boundary | Pass |
| Explicit list of disallowed actions | Pass |
| Raw/private data caution where needed | Pass |
| No instruction to test third-party systems | Pass |
| No claim of production security capability | Pass |
| Defensive interpretation included or implied | Pass |

## Lab-Level Notes

### Lab 021

Lab 021 introduces tool awareness and explicitly limits activity to installed-tool checks, local version/help output, documentation and local report creation. It excludes third-party scanning, third-party traffic capture, credential collection, private logs and real network identifiers.

### Lab 022

Lab 022 uses a synthetic PCAP generated locally. It states that the lab does not capture live traffic, inspect third-party networks or publish private traffic.

### Lab 023

Lab 023 is scoped to localhost service inventory. It explicitly allows localhost, local services, personal VMs/containers and authorized lab targets, while excluding third-party hosts, public IP ranges, unauthorized networks, evasion, exploitation and credential collection.

### Lab 024

Lab 024 is the most sensitive topic in the v1.1 sequence. The file handles this correctly by framing the topic as awareness-only. It states that it does not perform live testing, packet capture, client disruption, credential recovery or publication of real wireless identifiers. The cautionary framing should remain in place.

### Lab 025

Lab 025 uses a narrow loopback capture filter for a local service. It explicitly excludes third-party traffic, wireless traffic, private browsing capture, credential capture and public network monitoring.

### Lab 026

Lab 026 is read-only and dry-run. It states that firewall rules are not applied, existing rules are not flushed, ports are not blocked and the machine firewall is not modified.

### Lab 027

Lab 027 performs read-only SSH inspection and dry-run config generation. It states that private key contents are not printed, real SSH configuration is not modified and services are not restarted.

### Lab 028

Lab 028 uses read-only inspection, dry-run audit examples and synthetic events. It excludes real user activity collection, real audit log publication and automatic configuration changes.

### Lab 029

Lab 029 uses synthetic findings by default and gates any real local audit behind explicit confirmation. It states that raw output must remain private until sanitized.

### Lab 030

Lab 030 uses synthetic authentication logs and dry-run configuration examples. It states that no real service is modified, no real IP is banned and real authentication logs must not be committed.

## Required Changes

No required lab-file changes were identified during this review.

## Recommended Follow-Up

Before final release tagging, complete the next issue:

```text
#3 — Verify command indexes for Labs 001-030
```

The lab files themselves are safety-ready, but the generated command indexes should still be checked to confirm that they match the current lab sequence.

## Final Decision

```text
Labs 021-030 pass the safety-note review. Issue #2 can be closed as completed.
```
