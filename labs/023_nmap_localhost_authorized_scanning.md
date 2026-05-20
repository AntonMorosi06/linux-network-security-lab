# Lab 023 — Nmap Localhost and Authorized Service Scanning

## Objective

The objective of this lab is to use Nmap safely for local service inventory.

This lab starts a small local HTTP service bound to `127.0.0.1`, scans only localhost, records expected output and creates a defensive report.

This lab does not scan external hosts, public networks, third-party machines or unauthorized targets.

## Safety boundary

Allowed:

```text
127.0.0.1
localhost
local service started by this lab
personal VM
personal container
explicitly authorized lab target
```

Not allowed:

```text
third-party hosts
public IP ranges
school/company networks without authorization
stealth/evasion scanning
exploit execution
brute force
credential collection
```

## Files

This lab adds:

```text
docs/tools/NMAP_AUTHORIZED_SCANNING_NOTES.md
scripts/nmap_lab023_check_requirements.sh
scripts/nmap_lab023_start_local_service.py
scripts/nmap_lab023_scan_localhost.sh
scripts/nmap_lab023_create_report.sh
examples/lab_023_expected_outputs.txt
reports/templates/lab_023_nmap_localhost_authorized_scanning_report_template.md
```

## Step 1 — Check requirements

```bash
./scripts/nmap_lab023_check_requirements.sh
```

Expected output may include:

```text
[OK] python3 found
[OK] nmap found
```

If Nmap is missing, the script explains how to install it.

## Step 2 — Start the local service

Open a terminal and run:

```bash
./scripts/nmap_lab023_start_local_service.py
```

Expected output:

```text
[INFO] Lab 023 local HTTP service
[INFO] Listening on http://127.0.0.1:8088
```

Keep this terminal open while scanning. Stop it later with `CTRL + C`.

## Step 3 — Scan localhost

Open another terminal and run:

```bash
./scripts/nmap_lab023_scan_localhost.sh
```

Expected output contains a local scan of port `8088` on `127.0.0.1`.

## Step 4 — Create report

```bash
./scripts/nmap_lab023_create_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/lab023_nmap_localhost_authorized_scanning_YYYYMMDD_HHMMSS.txt
```

## Safe commands

```bash
nmap 127.0.0.1
nmap -p 8088 127.0.0.1
nmap -sV -p 8088 127.0.0.1
```

These commands scan only localhost.

## Defensive interpretation

A local Nmap result should be interpreted as service inventory.

Example:

```text
Port 8088/tcp is open because the lab started a local HTTP service.
The service is expected.
The service is bound to 127.0.0.1.
No third-party target was scanned.
```

## What this lab does not do

This lab does not:

```text
scan external IPs
scan public networks
scan Wi-Fi networks
perform stealth or evasion
exploit services
brute force credentials
collect sensitive banners from third-party systems
```

## Common issues

### Nmap not found

On macOS:

```bash
brew install nmap
```

On Debian/Ubuntu:

```bash
sudo apt install nmap
```

### Port 8088 appears closed

Make sure the local service is running in another terminal:

```bash
./scripts/nmap_lab023_start_local_service.py
```

### Address already in use

Another process is using port 8088. Stop it or change the port in the scripts.

## Final conclusion

The core chain is:

```text
local service
-> localhost scan
-> expected open port
-> local report
-> defensive service inventory
```

A good analyst does not scan random targets. A good analyst defines scope first.
