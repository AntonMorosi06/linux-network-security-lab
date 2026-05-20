# Lab 021 — Linux Security Tools Overview

## Objective

The objective of this lab is to start Phase v1.1 by building a safe inventory of common Linux security tools.

This lab does not perform scanning, exploitation, wireless capture, password attacks or third-party monitoring. It only checks whether tools are installed, records safe version/help information, explains what each tool is used for, and prepares a report structure for future defensive labs.

## Safety boundary

Allowed:

```text
checking whether a command exists
printing local version/help output
documenting tool purpose
creating a local report
running on a personal machine, VM or container
```

Not allowed:

```text
scanning third-party systems
capturing third-party traffic
testing Wi-Fi networks without authorization
collecting credentials
publishing private logs
publishing real network identifiers
```

## Tools covered

| Group | Tools |
|---|---|
| Packet capture and analysis | `tcpdump`, `tshark`, Wireshark |
| Network diagnostics | `ip`, `ss`, `curl`, `dig`, `nmap` |
| Wireless security awareness | Aircrack-ng suite |
| Firewall inspection | `nft`, `iptables`, `ufw` |
| Host auditing | auditd, Lynis |
| Log-based defense | Fail2ban |
| Cryptography and integrity | OpenSSL, GPG, SHA-256 |
| Network security monitoring | Zeek, Suricata |

## Step 1 — Run tool inventory

```bash
./scripts/tools_lab021_inventory.sh
```

Expected output:

```text
[INFO] Lab 021 Linux security tools inventory
[OK] found: git
[OK] found: python3
[INFO] optional tool not found: tshark
[INFO] optional tool not found: aircrack-ng
[OK] Inventory completed.
```

The exact result depends on the local machine. Missing optional tools are not errors.

## Step 2 — Create report

```bash
./scripts/tools_lab021_create_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/lab021_linux_security_tools_overview_YYYYMMDD_HHMMSS.txt
```

## Safe command examples

These commands are safe because they inspect local version/help text only:

```bash
tcpdump --version
tshark --version
nmap --version
aircrack-ng --help
openssl version
gpg --version
```

If a command is not installed, the inventory script reports it as optional.

## What this lab does not do

This lab does not:

```text
scan external hosts
attack Wi-Fi networks
capture real user traffic
run password attacks
run exploit tools
publish real logs
publish private host data
```

## Defensive conclusion

This lab adds a tool-awareness layer to the repository. It prepares future labs on packet analysis, authorized scanning, firewall inspection, host auditing, log-based defense, cryptographic integrity and sample-PCAP monitoring.

A good security analyst knows not only how to run tools, but also when not to run them.
