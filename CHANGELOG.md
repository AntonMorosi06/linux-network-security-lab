# Changelog

All notable changes to this repository are documented in this file.

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
