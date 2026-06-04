# Lab Index

This file provides a reviewer-friendly index of the laboratory sequence in `linux-network-security-lab`.

The repository is organized as a local, defensive Linux, networking and cybersecurity lab. The labs are designed to be executed only on localhost, personal machines, virtual machines, containers, Linux network namespaces or explicitly authorized environments.

## Lab Status Legend

| Status | Meaning |
|---|---|
| `complete-baseline` | Part of the v1.0 baseline and ready for review. |
| `v1.1-expansion` | Part of the safe Linux security tools expansion. |
| `evidence-needed` | Requires sanitized output or report indexing before final release. |
| `review-required` | Requires privacy/safety review before public evidence publication. |

## Labs 001-020 — v1.0 Defensive Linux and Networking Baseline

| Lab | Title | Main skill | Status |
|---:|---|---|---|
| 001 | Local System and Network Baseline | System identity, interfaces, routing, basic diagnostics | `complete-baseline` |
| 002 | Local HTTP Server, curl, ss and tcpdump | Local service testing, sockets, packet capture basics | `complete-baseline` |
| 003 | Ports, Processes, Logs and Local Diagnostics | Process inspection, open ports, local logs | `complete-baseline` |
| 004 | DNS, Routing and Connectivity Diagnostics | DNS lookup, routing table, connectivity analysis | `complete-baseline` |
| 005 | Network Namespace Client-Router-Server Topology | Linux namespaces, isolated topology, local routing | `complete-baseline` |
| 006 | Firewall and NAT inside a Network Namespace Router | NAT concepts, firewall logic, namespace router | `complete-baseline` |
| 007 | Traffic Shaping, Latency, Packet Loss and Bandwidth Limits | Network impairment, latency, loss, bandwidth simulation | `complete-baseline` |
| 008 | Local JSON API, Structured Logs and Mini Detector | Local API, structured logs, simple defensive detection | `complete-baseline` |
| 009 | Local API Security Controls | Local application security controls and defensive checks | `complete-baseline` |
| 010 | Docker Bridge Network and Container Diagnostics | Docker networking, bridge inspection, container diagnostics | `complete-baseline` |
| 011 | Docker Compose API, Reverse Proxy and Local Logs | Compose services, reverse proxy, local service logs | `complete-baseline` |
| 012 | Prometheus-style Metrics and Local Monitoring | Metrics format, local monitoring concepts | `complete-baseline` |
| 013 | GitHub Actions CI and Local Validation | Repository validation, CI mindset, reproducibility | `complete-baseline` |
| 014 | Threat Modeling and Hardening Checklist | Threat thinking, defensive checklist design | `complete-baseline` |
| 015 | Final Capstone Secure Local Service | Combined local secure-service capstone | `complete-baseline` |
| 016 | Release Engineering, Repository Audit and Publication Readiness | Release discipline, audit, public-readiness review | `complete-baseline` |
| 017 | Grafana Dashboard and Prometheus Alert Rules | Dashboard planning, alert rules, monitoring design | `complete-baseline` |
| 018 | Local SIEM-style Log Pipeline and Detection Rules | Log pipeline, detection logic, SIEM-style reasoning | `complete-baseline` |
| 019 | Incident Response Case File and Evidence Bundle | Incident report structure, evidence bundle practice | `complete-baseline` |
| 020 | Final Master Index, Proof-of-Work Bundle and Release Candidate Review | Portfolio proof-of-work packaging | `complete-baseline` |

## Labs 021-030 — v1.1 Safe Linux Security Tools Expansion

| Lab | Title | Main skill | Safety boundary | Status |
|---:|---|---|---|---|
| 021 | Linux Security Tools Overview | Tool inventory, safe usage boundaries, version/help inspection | No offensive workflow; inventory and awareness only | `v1.1-expansion` |
| 022 | Wireshark and TShark Packet Analysis | Synthetic PCAP analysis, display filters, field extraction | Synthetic/local PCAP only; no private traffic capture | `v1.1-expansion` |
| 023 | Nmap Localhost and Authorized Service Scanning | Localhost service inventory and scan interpretation | Localhost only; no external or unauthorized targets | `v1.1-expansion` |
| 024 | Aircrack-ng Wireless Security Awareness | Wireless security awareness, legal/ethical boundaries, hardening report | No live capture, no deauth, no handshake collection, no cracking | `v1.1-expansion` / `review-required` |
| 025 | tcpdump Advanced Capture Filters | Loopback capture filters and local HTTP traffic capture | Loopback traffic only; no Wi-Fi/private browsing capture | `v1.1-expansion` |
| 026 | Defensive Firewall Rules with nftables, iptables and ufw | Firewall rule design and defensive dry-run examples | Read-only/dry-run; no automatic system firewall modification | `v1.1-expansion` |
| 027 | SSH Hardening and Key-Based Access | SSH hardening planning, key permissions, safe config examples | Dry-run examples; do not publish private keys | `v1.1-expansion` |
| 028 | auditd and Linux Event Auditing | Audit concepts, synthetic audit-like events, dry-run rules | No real user activity collection; synthetic events only | `v1.1-expansion` |
| 029 | Lynis Local Security Audit | Local audit awareness and sanitized finding format | Raw Lynis output private until reviewed | `v1.1-expansion` / `review-required` |
| 030 | Fail2ban Local Log-Based Protection | Synthetic failed-login detection and dry-run jail/filter examples | Synthetic logs only; no real bans or service modification | `v1.1-expansion` |

## Recommended Reviewer Path

For a fast technical review, read the repository in this order:

1. `README.md`
2. `CURRENT_STATUS.md`
3. `KNOWN_LIMITATIONS.md`
4. `LAB_INDEX.md`
5. `docs/releases/LINUX_NETWORK_SECURITY_LAB_v1_0_RELEASE_NOTES.md`
6. `docs/ALL_CODES_TOGETHER_FULL.md`
7. `reports/evidence/LATEST_V1_1_SAFE_RUN.md`, if present

## Portfolio Interpretation

The lab sequence demonstrates practical competence across Linux, networking and defensive cybersecurity. It is not intended to prove offensive capability. Its value is in structured local experimentation, command interpretation, safe evidence handling, documentation quality and technical discipline.

## Next Lab-Level Actions

| Priority | Action |
|---:|---|
| 1 | Confirm that Labs 021-030 all have safe execution instructions. |
| 2 | Confirm that raw local outputs are not committed. |
| 3 | Add or update sanitized evidence pointers. |
| 4 | Create a v1.1 release checklist. |
| 5 | Add GitHub issues for final review tasks. |
