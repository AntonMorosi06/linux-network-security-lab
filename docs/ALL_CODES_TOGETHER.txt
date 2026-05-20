# All Codes Together — Linux Network Security Lab

This document collects the main copy-paste commands for the full Linux Network Security Lab sequence from setup/lab 000 through Lab 030.

It is designed as an execution companion. It does not replace the individual lab documents. Before running a lab, read its Markdown file in `labs/`.

## Safety rule

Run these commands only on:

```text
localhost
your own machine
your own virtual machine
your own container
Linux network namespaces created for the lab
explicitly authorized lab environments
```

Do not scan, test, probe, capture, monitor or audit third-party systems.

Do not publish raw outputs before checking privacy.

## Lab 000 — Repository setup and safety check

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

git status
git pull --ff-only origin main

mkdir -p "$HOME/linux_lab/reports"
mkdir -p "$HOME/linux_lab/private_outputs"
mkdir -p "$HOME/linux_lab/backups"

python3 --version
git --version

find labs -maxdepth 1 -type f | sort
find scripts -maxdepth 1 -type f | sort
```

## Lab 000B — Show all available lab commands

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
./scripts/list_lab_commands.sh
```

## Lab 000C — Safe discovery for any lab number

Use this when you do not remember the exact script names.

Replace `021` with the lab number you want.

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

LAB="021"

echo "=== Lab markdown ==="
find labs -maxdepth 1 -type f -iname "*${LAB}*" -print | sort

echo "=== Scripts ==="
find scripts -maxdepth 1 -type f -iname "*${LAB}*" -print | sort

echo "=== Examples / reports / data / generated ==="
find examples reports/templates data generated -maxdepth 3 -type f -iname "*${LAB}*" -print 2>/dev/null | sort
```

## Labs 001–020 — Safe discovery and execution model

The first twenty labs already exist as the v1.0 defensive Linux/network/security baseline. Because their exact script names may vary, use discovery commands first.

### Lab 001 — Local System and Network Baseline

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*001*" -print | sort
find scripts -maxdepth 1 -type f -iname "*001*" -print | sort
```

### Lab 002 — Local HTTP Server, curl, ss and tcpdump

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*002*" -print | sort
find scripts -maxdepth 1 -type f -iname "*002*" -print | sort
```

### Lab 003 — Ports, Processes, Logs and Local Diagnostics

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*003*" -print | sort
find scripts -maxdepth 1 -type f -iname "*003*" -print | sort
```

### Lab 004 — DNS, Routing and Connectivity Diagnostics

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*004*" -print | sort
find scripts -maxdepth 1 -type f -iname "*004*" -print | sort
```

### Lab 005 — Network Namespace Client-Router-Server Topology

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*005*" -print | sort
find scripts -maxdepth 1 -type f -iname "*005*" -print | sort
```

### Lab 006 — Firewall and NAT inside a Network Namespace Router

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*006*" -print | sort
find scripts -maxdepth 1 -type f -iname "*006*" -print | sort
```

### Lab 007 — Traffic Shaping, Latency, Packet Loss and Bandwidth Limits

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*007*" -print | sort
find scripts -maxdepth 1 -type f -iname "*007*" -print | sort
```

### Lab 008 — Local JSON API, Structured Logs and Mini Detector

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*008*" -print | sort
find scripts -maxdepth 1 -type f -iname "*008*" -print | sort
```

### Lab 009 — Local API Security Controls

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*009*" -print | sort
find scripts -maxdepth 1 -type f -iname "*009*" -print | sort
```

### Lab 010 — Docker Bridge Network and Container Diagnostics

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*010*" -print | sort
find scripts -maxdepth 1 -type f -iname "*010*" -print | sort
```

### Lab 011 — Docker Compose API, Reverse Proxy and Local Logs

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*011*" -print | sort
find scripts -maxdepth 1 -type f -iname "*011*" -print | sort
```

### Lab 012 — Prometheus-style Metrics and Local Monitoring

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*012*" -print | sort
find scripts -maxdepth 1 -type f -iname "*012*" -print | sort
```

### Lab 013 — GitHub Actions CI and Local Validation

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*013*" -print | sort
find scripts -maxdepth 1 -type f -iname "*013*" -print | sort
```

### Lab 014 — Threat Modeling and Hardening Checklist

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*014*" -print | sort
find scripts -maxdepth 1 -type f -iname "*014*" -print | sort
```

### Lab 015 — Final Capstone Secure Local Service

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*015*" -print | sort
find scripts -maxdepth 1 -type f -iname "*015*" -print | sort
```

### Lab 016 — Release Engineering, Repository Audit and Publication Readiness

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*016*" -print | sort
find scripts -maxdepth 1 -type f -iname "*016*" -print | sort
```

### Lab 017 — Grafana Dashboard and Prometheus Alert Rules

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*017*" -print | sort
find scripts -maxdepth 1 -type f -iname "*017*" -print | sort
```

### Lab 018 — Local SIEM-style Log Pipeline and Detection Rules

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*018*" -print | sort
find scripts -maxdepth 1 -type f -iname "*018*" -print | sort
```

### Lab 019 — Incident Response Case File and Evidence Bundle

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*019*" -print | sort
find scripts -maxdepth 1 -type f -iname "*019*" -print | sort
```

### Lab 020 — Final Master Index, Proof-of-Work Bundle and Release Candidate Review

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
find labs -maxdepth 1 -type f -iname "*020*" -print | sort
find scripts -maxdepth 1 -type f -iname "*020*" -print | sort
```

## Labs 021–030 — Exact commands

These are the exact commands for the v1.1 Linux Security Tools Expansion.

## Lab 021 — Linux Security Tools Overview

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

./scripts/tools_lab021_inventory.sh
./scripts/tools_lab021_create_report.sh
```

## Lab 022 — Wireshark and TShark Packet Analysis

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

./scripts/tshark_lab022_check_requirements.sh
./scripts/tshark_lab022_generate_sample_pcap.py
./scripts/tshark_lab022_analyze_sample_pcap.sh
./scripts/tshark_lab022_create_report.sh
```

## Lab 023 — Nmap Localhost and Authorized Service Scanning

Terminal 1:

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

./scripts/nmap_lab023_check_requirements.sh
./scripts/nmap_lab023_start_local_service.py
```

Terminal 2:

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

./scripts/nmap_lab023_scan_localhost.sh
./scripts/nmap_lab023_create_report.sh
```

Stop Terminal 1 with:

```bash
CTRL+C
```

## Lab 024 — Aircrack-ng Wireless Security Awareness

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

./scripts/aircrack_lab024_check_requirements.sh
./scripts/aircrack_lab024_help_inventory.sh
./scripts/aircrack_lab024_create_report.sh
```

Safety reminder:

```text
This lab does not scan Wi-Fi networks.
This lab does not capture wireless traffic.
This lab does not deauthenticate clients.
This lab does not collect handshakes.
This lab does not crack passwords.
```

## Lab 025 — tcpdump Advanced Capture Filters

Normal attempt:

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

./scripts/tcpdump_lab025_check_requirements.sh
./scripts/tcpdump_lab025_capture_loopback.sh
./scripts/tcpdump_lab025_create_report.sh
```

If packet capture requires elevated privileges on your own machine:

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

sudo ./scripts/tcpdump_lab025_capture_loopback.sh
./scripts/tcpdump_lab025_create_report.sh
```

Safety reminder:

```text
The capture is restricted to loopback traffic for 127.0.0.1:8090.
Do not capture third-party, Wi-Fi or private browsing traffic.
```

## Lab 026 — Defensive Firewall Rules with nftables, iptables and ufw

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

./scripts/firewall_lab026_check_requirements.sh
./scripts/firewall_lab026_inspect_readonly.sh
./scripts/firewall_lab026_generate_dry_run_rules.sh
./scripts/firewall_lab026_create_report.sh
```

Safety reminder:

```text
This lab does not apply firewall rules.
This lab does not flush firewall rules.
This lab does not block ports.
This lab does not modify system firewall state.
```

## Lab 027 — SSH Hardening and Key-Based Access

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

./scripts/ssh_lab027_check_requirements.sh
./scripts/ssh_lab027_inspect_readonly.sh
./scripts/ssh_lab027_generate_dry_run_config.sh
./scripts/ssh_lab027_create_report.sh
```

Safety reminder:

```text
Do not publish private keys.
Do not paste private key contents into reports.
This lab does not modify sshd_config.
This lab does not restart sshd.
This lab does not disable password login.
```

## Lab 028 — auditd and Linux Event Auditing

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

./scripts/auditd_lab028_check_requirements.sh
./scripts/auditd_lab028_inspect_readonly.sh
./scripts/auditd_lab028_generate_dry_run_rules.sh
./scripts/auditd_lab028_create_synthetic_events.py
./scripts/auditd_lab028_create_report.sh
```

Safety reminder:

```text
This lab does not install auditd.
This lab does not start or restart auditd.
This lab does not load audit rules.
This lab does not collect real user activity.
```

## Lab 029 — Lynis Local Security Audit

Default safe workflow:

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

./scripts/lynis_lab029_check_requirements.sh
./scripts/lynis_lab029_create_synthetic_findings.py
./scripts/lynis_lab029_create_report.sh
```

Optional real local audit on your own/administered machine only:

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

RUN_LYNIS_LOCAL_AUDIT=yes ./scripts/lynis_lab029_run_local_audit.sh
```

Safety reminder:

```text
Raw Lynis output can contain sensitive local details.
Do not publish raw output without review and sanitization.
```

## Lab 030 — Fail2ban Local Log-Based Protection

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

./scripts/fail2ban_lab030_check_requirements.sh
./scripts/fail2ban_lab030_generate_synthetic_auth_log.py
./scripts/fail2ban_lab030_analyze_synthetic_auth_log.py
./scripts/fail2ban_lab030_generate_dry_run_config.sh
./scripts/fail2ban_lab030_create_report.sh
```

Safety reminder:

```text
This lab uses synthetic logs.
It does not install Fail2ban.
It does not restart services.
It does not modify /etc/fail2ban.
It does not ban real IPs.
```

## Run all safe v1.1 labs from 021 to 030

This sequence avoids optional real/gated audit commands and avoids forcing sudo. It may still report missing optional tools, which is fine.

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

./scripts/tools_lab021_inventory.sh
./scripts/tools_lab021_create_report.sh

./scripts/tshark_lab022_check_requirements.sh
./scripts/tshark_lab022_generate_sample_pcap.py
./scripts/tshark_lab022_analyze_sample_pcap.sh
./scripts/tshark_lab022_create_report.sh

./scripts/nmap_lab023_check_requirements.sh
python3 scripts/nmap_lab023_start_local_service.py &
LAB023_PID=$!
sleep 1
./scripts/nmap_lab023_scan_localhost.sh
./scripts/nmap_lab023_create_report.sh
kill "$LAB023_PID" 2>/dev/null || true

./scripts/aircrack_lab024_check_requirements.sh
./scripts/aircrack_lab024_help_inventory.sh
./scripts/aircrack_lab024_create_report.sh

./scripts/tcpdump_lab025_check_requirements.sh
./scripts/tcpdump_lab025_capture_loopback.sh || true
./scripts/tcpdump_lab025_create_report.sh

./scripts/firewall_lab026_check_requirements.sh
./scripts/firewall_lab026_inspect_readonly.sh
./scripts/firewall_lab026_generate_dry_run_rules.sh
./scripts/firewall_lab026_create_report.sh

./scripts/ssh_lab027_check_requirements.sh
./scripts/ssh_lab027_inspect_readonly.sh
./scripts/ssh_lab027_generate_dry_run_config.sh
./scripts/ssh_lab027_create_report.sh

./scripts/auditd_lab028_check_requirements.sh
./scripts/auditd_lab028_inspect_readonly.sh
./scripts/auditd_lab028_generate_dry_run_rules.sh
./scripts/auditd_lab028_create_synthetic_events.py
./scripts/auditd_lab028_create_report.sh

./scripts/lynis_lab029_check_requirements.sh
./scripts/lynis_lab029_create_synthetic_findings.py
./scripts/lynis_lab029_create_report.sh

./scripts/fail2ban_lab030_check_requirements.sh
./scripts/fail2ban_lab030_generate_synthetic_auth_log.py
./scripts/fail2ban_lab030_analyze_synthetic_auth_log.py
./scripts/fail2ban_lab030_generate_dry_run_config.sh
./scripts/fail2ban_lab030_create_report.sh

echo "[OK] Safe v1.1 command sequence completed."
```

## Check generated reports

```bash
ls -lah "$HOME/linux_lab/reports"
find "$HOME/linux_lab/reports" -type f | sort | tail -n 30
```

## Check generated lab data

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

find data -maxdepth 3 -type f | sort
find generated -maxdepth 3 -type f | sort
```

## Git status after running labs

Most runtime outputs should stay local or ignored. Before committing anything new:

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

git status --short
git diff --stat
```

Do not commit private raw outputs. Review before publication.

## Clean local runtime outputs carefully

This removes generated runtime data from selected v1.1 labs. Use only if you want to reset local lab artifacts.

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

rm -f data/lab022/local_http_dns_sample.pcap
rm -f data/lab025/lab025_loopback_http.pcap
rm -f data/lab025/lab025_tcpdump_output.txt
rm -f data/lab025/lab025_local_service.log
rm -f data/lab030/synthetic_auth.log

echo "[OK] Selected local runtime artifacts removed."
```

## Final safety checklist

Before pushing or publishing outputs:

```text
No private keys.
No real auth logs.
No real Wi-Fi captures.
No third-party scan output.
No private hostnames.
No private IP maps.
No tokens.
No credentials.
No screenshots with private information.
No raw Lynis output without sanitization.
No packet captures from real user traffic.
```

## Final repository check

```bash
cd "/Users/antonmorosi/linux-network-security-lab"

git pull --ff-only origin main
git status
find labs -maxdepth 1 -type f | sort | wc -l
find scripts -maxdepth 1 -type f | sort | wc -l
./scripts/list_lab_commands.sh
```
