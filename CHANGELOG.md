# Changelog

All notable changes to this repository are documented in this file.

## [1.1.0] — Safe Tools Expansion release candidate

Release status: release candidate

Release notes:

```text
docs/releases/LINUX_NETWORK_SECURITY_LAB_v1_1_RELEASE_NOTES.md
```

### Added

Added a v1.1 safe tools expansion track, extending the repository from the original defensive baseline into a 30-lab local learning sequence.

The v1.1 expansion includes:

```text
Lab 021 — Linux Security Tools Overview
Lab 022 — Wireshark and TShark Packet Analysis
Lab 023 — Nmap Localhost and Authorized Service Scanning
Lab 024 — Aircrack-ng Wireless Security Awareness
Lab 025 — tcpdump Advanced Capture Filters
Lab 026 — Defensive Firewall Rules with nftables, iptables and ufw
Lab 027 — SSH Hardening and Key-Based Access
Lab 028 — auditd and Linux Event Auditing
Lab 029 — Lynis Local Security Audit
Lab 030 — Fail2ban Local Log-Based Protection
```

### Documentation

Added or updated reviewer-facing and portfolio-facing documents:

```text
CURRENT_STATUS.md
KNOWN_LIMITATIONS.md
LAB_INDEX.md
PORTFOLIO_SUMMARY.md
EVIDENCE.md
RELEASE_CHECKLIST_v1_1.md
docs/releases/LINUX_NETWORK_SECURITY_LAB_v1_1_RELEASE_NOTES.md
```

### Evidence and review layer

Added release-candidate evidence and review documents:

```text
reports/evidence/LATEST_V1_1_SAFE_RUN.md
reports/evidence/v1_1_mac_rerun_20260520_152216/EVIDENCE_REVIEW.md
reports/evidence/v1_1_mac_rerun_20260520_152216/FILE_BY_FILE_SAFETY_REVIEW.md
docs/reviews/LABS_021_030_SAFETY_REVIEW.md
docs/reviews/COMMAND_INDEX_001_030_REVIEW.md
docs/reviews/V1_1_RELEASE_READINESS_REVIEW.md
docs/reviews/PORTFOLIO_PUBLICATION_REVIEW.md
```

### Portfolio readiness

The repository is now suitable to present as a portfolio-ready candidate for defensive Linux, networking and local security learning.

Recommended public description:

```text
Defensive Linux and network security lab with 30 local, documented labs covering system diagnostics, networking, logs, monitoring, evidence handling and safe security-tool awareness.
```

### Safety and limitations

The release remains:

```text
local
controlled
defensive
authorized
privacy-aware
evidence-reviewed
```

This release does not present the repository as an offensive toolkit, production security platform, enterprise monitoring system or guarantee of system security.

### Remaining decision

The repository is ready for a final release/tag decision after confirming whether to use:

```text
v1.1.0-safe-tools-expansion
```

## [0.1.0] — Public baseline candidate

### Added

Initial 16-lab defensive Linux, networking and local security baseline.

The baseline includes:

```text
Lab 001 — Local System and Network Baseline
Lab 002 — Local HTTP Server, curl, ss and tcpdump
Lab 003 — Ports, Processes, Logs and Local Diagnostics
Lab 004 — DNS, Routing and Connectivity Diagnostics
Lab 005 — Network Namespace Client-Router-Server Topology
Lab 006 — Firewall and NAT inside a Network Namespace Router
Lab 007 — Traffic Shaping, Latency, Packet Loss and Bandwidth Limits
Lab 008 — Local JSON API, Structured Logs and Mini Detector
Lab 009 — Local API Security Controls
Lab 010 — Docker Bridge Network and Container Diagnostics
Lab 011 — Docker Compose API, Reverse Proxy and Local Logs
Lab 012 — Prometheus-style Metrics and Local Monitoring
Lab 013 — GitHub Actions CI and Local Validation
Lab 014 — Threat Modeling and Hardening Checklist
Lab 015 — Final Capstone Secure Local Service
Lab 016 — Release Engineering, Repository Audit and Publication Readiness
```

### Security and safety

Added:

```text
security/SAFE_USE_POLICY.md
security/ASSET_INVENTORY.md
security/TRUST_BOUNDARIES.md
security/THREAT_MODEL.md
security/HARDENING_CHECKLIST.md
security/RISK_REGISTER.md
```

### Automation

Added:

```text
GitHub Actions CI
local CI validation scripts
repository structure checks
Bash syntax checks
Python syntax checks
Docker Compose config checks
```

### Docker and monitoring

Added Docker and Docker Compose labs for:

```text
single-container API
bridge networking
reverse proxy
Prometheus metrics
capstone stack
```

### Documentation

Added current status, roadmap, portfolio summary, repository audit, release notes and publication checklist.

## Notes

This repository is defensive and local-first. It is designed for safe learning and portfolio demonstration.
