# Tools Expansion Plan v1.1

## Purpose

This document starts Phase v1.1 of the `linux-network-security-lab` repository.

The v1.0 line created a complete local defensive Linux, networking and cybersecurity baseline with 20 labs, a Linux User Manual, monitoring, SIEM-style synthetic analysis, incident response documentation and release notes.

Phase v1.1 extends the project with a curated Linux security tools track. The goal is not to turn the repository into an offensive toolkit. The goal is to show that common Linux security tools can be studied, installed, inspected, documented and used safely in local, authorized and defensive contexts.

## Safety boundary

Allowed environments:

```text
localhost
personal machine
virtual machine
container
Linux network namespace
sample PCAP file
explicitly authorized lab network
```

Not allowed:

```text
third-party scanning
third-party packet capture
unauthorized Wi-Fi testing
credential collection
real user traffic collection
deauthentication against real clients
publication of private logs
publication of captured credentials
```

## Phase v1.1 lab plan

| Lab | Title | Status |
|---:|---|---|
| 021 | Linux Security Tools Overview | created in this patch |
| 022 | Wireshark and TShark Packet Analysis | created |
| 023 | Nmap Localhost and Authorized Service Scanning | created |
| 024 | Aircrack-ng Wireless Security Awareness | created |
| 025 | tcpdump Advanced Capture Filters | planned |
| 026 | nftables / iptables Defensive Firewall Rules | planned |
| 027 | SSH Hardening and Key-Based Access | planned |
| 028 | auditd and Linux Event Auditing | planned |
| 029 | Lynis Local Security Audit | planned |
| 030 | Fail2ban Local Log-Based Protection | planned |
| 031 | OpenSSL, Certificates and TLS Inspection | planned |
| 032 | GPG, File Integrity and Signing | planned |
| 033 | Zeek Network Security Monitoring from Sample PCAP | planned |
| 034 | Suricata IDS from Sample PCAP | planned |
| 035 | Linux Hardening Final Report | planned |

## Tool categories

| Category | Tools |
|---|---|
| Packet capture and analysis | `tcpdump`, `tshark`, Wireshark |
| Local network diagnostics | `ip`, `ss`, `curl`, `dig`, `traceroute`, `nmap` |
| Wireless security awareness | Aircrack-ng suite, authorized lab notes, sample PCAP concepts |
| Firewall and packet filtering | `nft`, `iptables`, `ufw` |
| Host audit and hardening | Lynis, auditd, systemd, journalctl |
| Log-based defense | Fail2ban, local service logs |
| Cryptography and integrity | OpenSSL, GPG, SHA-256 |
| Network security monitoring | Zeek, Suricata, sample PCAP workflows |

## Documentation standard

Each lab must include:

```text
objective
safety boundary
tool overview
safe commands
expected output
interpretation
common issues
report template
what this lab does not do
defensive conclusion
```

## Aircrack-ng boundary

Aircrack-ng is included only as wireless security awareness material.

Allowed:

```text
tool overview
help/version inspection
conceptual explanation
authorized lab notes
sample PCAP-only discussion
defensive recommendations
Wi-Fi hardening advice
```

Not allowed:

```text
instructions to attack third-party Wi-Fi
instructions to obtain unauthorized access
deauthentication workflow against real clients
password cracking workflow against real networks
publication of captured handshakes from real networks
collection of real user traffic
```

## Final rule

If a tool can be used offensively, this repository must document it from the defensive, local, authorized and educational side only.
