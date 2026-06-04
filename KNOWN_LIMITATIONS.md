# Known Limitations and Safety Scope

This document defines the limitations, safety boundaries and publication constraints of the `linux-network-security-lab` repository.

The goal is to keep the project technically honest and safe to present as a defensive cybersecurity learning laboratory.

## Main Limitation

This repository is a local defensive lab. It is not a production security platform, not an offensive toolkit and not a penetration-testing framework for third-party systems.

The exercises are intended for:

- localhost;
- personal machines;
- virtual machines;
- containers;
- Linux network namespaces;
- explicitly authorized lab environments.

The exercises are not intended for systems, networks, accounts or services that the user does not own or does not have explicit permission to assess.

## Scope Boundaries

| Area | Boundary |
|---|---|
| Network scanning | Localhost and authorized lab targets only. No third-party scanning. |
| Packet capture | Synthetic, loopback or lab-only traffic. No private browsing or third-party capture. |
| Wireless security | Awareness and defensive hardening only. No unauthorized capture, deauthentication, handshake collection or cracking. |
| Firewall work | Inspection, dry-run examples and controlled lab rules only. Avoid modifying real production firewall state. |
| Logs | Synthetic or sanitized logs only. Real logs may contain private data and must be reviewed before publication. |
| Monitoring | Local educational monitoring only, not a production SOC. |
| Incident response | Case-file practice and synthetic evidence only, not real incident handling unless explicitly authorized. |
| Security tools | Version/help inspection, local usage and defensive interpretation only. |

## What This Repository Demonstrates

This repository can demonstrate:

- Linux command-line competence;
- system inspection;
- users, permissions, processes and services awareness;
- local network diagnostics;
- socket and port inspection;
- DNS and routing troubleshooting;
- firewall concept understanding;
- packet analysis fundamentals;
- structured logging and local monitoring;
- safe cybersecurity reporting;
- basic incident-response documentation;
- careful safety boundaries around security tools.

## What This Repository Does Not Demonstrate

This repository does not claim to demonstrate:

- enterprise-grade SOC deployment;
- production incident response;
- offensive exploitation;
- unauthorized penetration testing;
- real-world Wi-Fi cracking;
- malware analysis or deployment;
- guaranteed host hardening;
- complete system security;
- professional certification by itself.

## Tool-Specific Limitations

| Tool / topic | Limitation |
|---|---|
| `nmap` | Use only against localhost or explicitly authorized lab services. Do not scan public IPs or third-party networks. |
| `tcpdump` | Use only controlled interfaces and filters. Raw captures may contain sensitive data. |
| `tshark` / Wireshark | Analyze synthetic or reviewed PCAPs only. Do not publish private captures. |
| Aircrack-ng | Awareness-only. No unauthorized wireless testing, deauthentication, handshake collection or cracking workflows. |
| `auditd` | Dry-run/synthetic examples unless used in a local authorized machine. Real audit logs can expose private activity. |
| Lynis | Raw audit outputs may contain sensitive host details. Publish only sanitized summaries. |
| Fail2ban | Synthetic log analysis and dry-run configuration only unless used intentionally in a local controlled environment. |
| Firewall tools | Avoid commands that flush, overwrite or break a real firewall configuration. |

## Privacy Limitations

Raw local outputs may expose:

- usernames;
- hostnames;
- local paths;
- local IP addresses;
- network configuration;
- installed services;
- open ports;
- timestamps;
- package versions;
- machine-specific security findings.

For this reason, raw outputs should remain outside the repository until reviewed.

Safe publication requires sanitized outputs, synthetic examples or redacted reports.

## Evidence Limitations

Evidence in this repository should prove that exercises were structured, locally executable and safely documented. It should not imply that the repository was tested against real external targets.

Acceptable evidence:

- sanitized terminal output;
- synthetic logs;
- local reports;
- localhost service checks;
- controlled namespace/container examples;
- screenshots without private data;
- generated Markdown summaries;
- safe command indexes.

Unacceptable evidence:

- raw private PCAPs;
- real third-party scan results;
- exposed public IP scans;
- passwords or hashes;
- private keys;
- sensitive system logs;
- screenshots with personal accounts or private windows.

## Public Presentation Rule

When presenting this repository publicly, describe it as:

> A defensive Linux, networking and cybersecurity lab focused on local diagnostics, safe tool awareness, logs, monitoring and documentation.

Do not describe it as:

> A hacking toolkit, offensive security framework or production-ready SOC system.

## Final Limitation Statement

This repository is valuable because it is controlled, documented and defensive. Its strength is not aggressive tooling. Its strength is careful technical practice, clear safety boundaries and reproducible local learning.
