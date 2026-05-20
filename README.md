# Linux Network Security Lab

This repository contains a local and defensive Linux laboratory focused on system diagnostics, networking, service monitoring, firewall inspection, packet capture, logging, automation, and basic security analysis.

The purpose of this project is to document practical Linux, networking, and cybersecurity exercises in a safe environment using localhost, local services, virtual network namespaces, containers, and controlled scripts.

## Scope

This repository is designed for defensive learning and local experimentation only. The exercises are intended to be executed on a personal machine, virtual machine, container, local namespace lab, or explicitly authorized environment.

The project includes:

- Linux system inspection
- Network interface analysis
- Routing and gateway diagnostics
- DNS troubleshooting
- Local HTTP servers
- TCP and UDP local testing
- Socket and port inspection
- Process and service monitoring
- systemd and journalctl usage
- Firewall inspection with UFW, nftables, and iptables
- Packet capture with tcpdump
- Local network namespaces
- Basic NAT and routing laboratories
- Local JSON API experiments
- Structured logs
- Health-check scripts
- Defensive mini-SOC style reports
- Documentation with commands, expected outputs, and interpretation

## Repository structure

linux-network-security-lab/
  README.md
  docs/
  labs/
  scripts/
  reports/
  pcaps/
  screenshots/
  notes/
  security/
  examples/

## Safety rule

All commands and exercises in this repository must be used only on:

- localhost
- personal machines
- virtual machines
- containers
- Linux network namespaces
- explicitly authorized labs

Do not scan, test, probe, or monitor systems that you do not own or do not have permission to assess.

## Status

The repository has evolved from an initial public baseline into a complete local defensive Linux, networking and cybersecurity lab. It now includes 20 documented labs, a full Linux User Manual, visual reference assets, synthetic examples, monitoring/incident-response documentation and portfolio-oriented project structure.


## Labs

- Lab 001 — Local System and Network Baseline
- Lab 002 — Local HTTP Server, curl, ss and tcpdump
- Lab 003 — Ports, Processes, Logs and Local Diagnostics
- Lab 004 — DNS, Routing and Connectivity Diagnostics
- Lab 005 — Network Namespace Client-Router-Server Topology
- Lab 006 — Firewall and NAT inside a Network Namespace Router
- Lab 007 — Traffic Shaping, Latency, Packet Loss and Bandwidth Limits
- Lab 008 — Local JSON API, Structured Logs and Mini Detector
- Lab 009 — Local API Security Controls
- Lab 010 — Docker Bridge Network and Container Diagnostics
- Lab 011 — Docker Compose API, Reverse Proxy and Local Logs
- Lab 012 — Prometheus-style Metrics and Local Monitoring
- Lab 013 — GitHub Actions CI and Local Validation
- Lab 014 — Threat Modeling and Hardening Checklist
- Lab 015 — Final Capstone Secure Local Service
- Lab 016 — Release Engineering, Repository Audit and Publication Readiness
- Lab 017 — Grafana Dashboard and Prometheus Alert Rules
- Lab 018 — Local SIEM-style Log Pipeline and Detection Rules
- Lab 019 — Incident Response Case File and Evidence Bundle
- Lab 020 — Final Master Index, Proof-of-Work Bundle and Release Candidate Review


## Linux User Manual

This repository includes a complete practical Linux handbook:

```text
docs/linux_user_manual/
```

The manual is structured as a portfolio-grade technical document connected to the lab sequence. It covers Linux fundamentals, filesystem usage, terminal and shell behavior, users and permissions, processes and services, networking, ports and sockets, DNS and routing, logs, package management, hardening, Docker, monitoring, incident response, troubleshooting and cybersecurity analyst workflows.

Recommended entry points:

```text
docs/linux_user_manual/PORTFOLIO_OVERVIEW.md
docs/linux_user_manual/README.md
docs/linux_user_manual/00_LINUX_COMMAND_REFERENCE_MATRIX.md
docs/linux_user_manual/VISUAL_ASSETS_INDEX.md
```

The manual also includes:

```text
docs/linux_user_manual/tables/
docs/linux_user_manual/images/
docs/linux_user_manual/examples/
```

These folders provide learning maps, risk matrices, troubleshooting decision tables, SVG diagrams, expected outputs and synthetic report examples.

## Portfolio status

The main Linux User Manual sequence from `README.md` and `00` through `17` is complete. The visual asset layer has also been added with Markdown tables, SVG diagrams, synthetic command output examples, an asset index and a manifest.

This repository can now be presented as a defensive Linux, networking and cybersecurity proof-of-work project.

## Release notes

The current portfolio-grade baseline is documented here:

```text
docs/releases/LINUX_NETWORK_SECURITY_LAB_v1_0_RELEASE_NOTES.md
```

This release note summarizes the 20-lab sequence, the complete Linux User Manual, the visual asset layer, the safety model and the skills demonstrated by the repository.

## Phase v1.1 — Linux Security Tools Expansion

The repository now starts a second track focused on safe Linux security tool awareness.

Initial v1.1 files:

```text
docs/TOOLS_EXPANSION_PLAN_v1_1.md
docs/tools/LINUX_SECURITY_TOOLS_MATRIX.md
docs/tools/AIRCRACK_NG_SAFE_USAGE_POLICY.md
labs/021_linux_security_tools_overview.md
scripts/tools_lab021_inventory.sh
scripts/tools_lab021_create_report.sh
```

This expansion remains local, defensive and authorized. It introduces common tools such as `tcpdump`, `tshark`, `nmap`, Aircrack-ng, firewall tools, audit tools, cryptography tools, Zeek and Suricata through safe inventory, help/version inspection, sample-PCAP planning and defensive reporting.

Aircrack-ng is included only as wireless security awareness material. The repository does not provide unauthorized Wi-Fi testing or cracking workflows.

