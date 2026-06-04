# Portfolio Summary

`linux-network-security-lab` is a defensive Linux, networking and cybersecurity laboratory designed to document practical technical learning through safe, local and reproducible exercises.

This repository is intended as a proof-of-work project for Linux fundamentals, network diagnostics, system inspection, local service monitoring, packet analysis, firewall concepts, structured logging and basic security analyst workflows.

## One-Sentence Summary

A local defensive cybersecurity lab that demonstrates Linux, networking, logs, monitoring and security-tool awareness through documented, authorized and reproducible exercises.

## What This Project Shows

This repository demonstrates the ability to:

- inspect Linux systems from the terminal;
- understand interfaces, routes, sockets, ports and local services;
- use common diagnostic tools with care;
- reason about DNS, routing and local connectivity;
- create controlled local lab environments;
- interpret logs and structured outputs;
- document expected command behavior;
- build defensive checklists and reports;
- handle evidence safely;
- define clear safety boundaries around cybersecurity tooling.

## Technical Areas Covered

| Area | Examples |
|---|---|
| Linux fundamentals | filesystem, terminal, users, permissions, processes, services |
| Networking | interfaces, routes, DNS, localhost services, ports, sockets |
| Diagnostics | `ip`, `ss`, `curl`, `journalctl`, logs, service inspection |
| Packet analysis | `tcpdump`, TShark/Wireshark-style analysis, synthetic PCAPs |
| Firewall concepts | UFW, nftables, iptables, dry-run rule planning |
| Containers and namespaces | Docker bridge diagnostics and Linux namespace topologies |
| Monitoring | Prometheus-style metrics, Grafana-style dashboards, alert rules |
| Detection and response | SIEM-style logs, detection rules, incident response case files |
| Security tools | Local and authorized awareness of Nmap, auditd, Lynis, Fail2ban and Aircrack-ng boundaries |

## Why It Is Portfolio-Relevant

This project is portfolio-relevant because it is practical, reproducible and grounded in defensive workflows. It does not rely on vague cybersecurity claims. It shows concrete command-line work, documentation discipline and safe technical reasoning.

For a reviewer, the repository can provide evidence of:

1. Linux command-line literacy.
2. Networking fundamentals.
3. Safe cybersecurity mindset.
4. Structured documentation.
5. Ability to build labs and explain results.
6. Awareness of privacy and evidence handling.
7. Progression from basic diagnostics to monitoring and incident-response-style reporting.

## Current Maturity

| Dimension | Status |
|---|---|
| Documentation | Strong baseline |
| Lab sequence | Labs 001-020 complete baseline; Labs 021-030 v1.1 expansion |
| Safety model | Strong local/defensive boundary |
| Evidence model | Sanitized evidence only |
| Public readiness | High after final review |
| Best label | `portfolio-ready candidate` |

## Recommended Reading Path

For a fast review, use this order:

1. `README.md`
2. `CURRENT_STATUS.md`
3. `LAB_INDEX.md`
4. `KNOWN_LIMITATIONS.md`
5. `docs/releases/LINUX_NETWORK_SECURITY_LAB_v1_0_RELEASE_NOTES.md`
6. `docs/ALL_CODES_TOGETHER_FULL.md`
7. `reports/evidence/LATEST_V1_1_SAFE_RUN.md`, if available

## Safe Claim for CV or Portfolio

The following description can be used safely in a CV or portfolio:

> Built a defensive Linux and network security laboratory with 30 staged local labs covering system diagnostics, networking, logs, services, firewall concepts, packet analysis, monitoring, incident-response documentation and safe security-tool awareness. The project uses localhost, containers, namespaces and sanitized evidence to keep all exercises controlled, reproducible and authorized.

## Claims to Avoid

Do not present this repository as:

- a penetration testing toolkit;
- an offensive hacking framework;
- a production SOC;
- a Wi-Fi cracking project;
- an enterprise security product;
- a guarantee of system security.

## Next Portfolio Polish Tasks

| Priority | Task |
|---:|---|
| 1 | Confirm evidence pointers and sanitized output policy. |
| 2 | Add v1.1 release checklist. |
| 3 | Create GitHub issues for final documentation polish. |
| 4 | Add screenshots or terminal-output examples if they are sanitized. |
| 5 | Add this repository to the main portfolio site and GitHub profile once final review is complete. |
