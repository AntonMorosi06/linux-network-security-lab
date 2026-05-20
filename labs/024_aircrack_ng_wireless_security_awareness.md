# Lab 024 — Aircrack-ng Wireless Security Awareness

## Objective

The objective of this lab is to introduce Aircrack-ng as a wireless security awareness topic while maintaining a strict legal, ethical and defensive boundary.

This lab does not attack Wi-Fi networks. It does not capture live wireless traffic. It does not perform deauthentication. It does not collect handshakes. It does not crack passwords.

The lab only checks whether Aircrack-ng tools are installed, records safe help/version output, explains tool roles at a high level and creates a defensive report.

## Safety boundary

Allowed:

```text
checking whether Aircrack-ng tools are installed
printing local help/version output
reading the safe usage policy
writing defensive wireless hardening notes
documenting authorization requirements
```

Not allowed:

```text
testing third-party Wi-Fi networks
capturing live wireless traffic
performing deauthentication
collecting handshakes
cracking passwords
publishing real SSIDs/BSSIDs/MAC addresses
publishing real wireless captures
```

## Files

This lab adds:

```text
docs/tools/AIRCRACK_NG_TOOL_OVERVIEW.md
docs/tools/WIRELESS_SECURITY_DEFENSIVE_HARDENING.md
scripts/aircrack_lab024_check_requirements.sh
scripts/aircrack_lab024_help_inventory.sh
scripts/aircrack_lab024_create_report.sh
examples/lab_024_expected_outputs.txt
reports/templates/lab_024_aircrack_ng_wireless_security_awareness_report_template.md
```

## Step 1 — Read the policy

Before running any command, read:

```text
docs/tools/AIRCRACK_NG_SAFE_USAGE_POLICY.md
docs/tools/AIRCRACK_NG_TOOL_OVERVIEW.md
docs/tools/WIRELESS_SECURITY_DEFENSIVE_HARDENING.md
```

## Step 2 — Check requirements

```bash
./scripts/aircrack_lab024_check_requirements.sh
```

Expected output may include:

```text
[OK] aircrack-ng found
```

or:

```text
[WARN] aircrack-ng not found
```

Missing Aircrack-ng is not a lab failure. This lab is awareness-first.

## Step 3 — Generate help inventory

```bash
./scripts/aircrack_lab024_help_inventory.sh
```

This script only runs help/version-style commands when tools are available.

It does not target any network.

## Step 4 — Create report

```bash
./scripts/aircrack_lab024_create_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/lab024_aircrack_ng_wireless_security_awareness_YYYYMMDD_HHMMSS.txt
```

## Safe commands

The only tool commands used by this lab are:

```bash
aircrack-ng --help
airmon-ng --help
airodump-ng --help
```

These commands print help text only.

## What this lab does not do

This lab does not:

```text
scan Wi-Fi networks
capture packets
monitor neighbors
deauthenticate clients
collect handshakes
run cracking workflows
recover passwords
publish wireless identifiers
```

## Defensive interpretation

The correct conclusion is:

```text
Aircrack-ng is a dual-use wireless auditing suite. It should be studied only in owned or explicitly authorized labs. This repository documents tool awareness and defensive Wi-Fi hardening, not unauthorized wireless attacks.
```

## Defensive hardening summary

A safe Wi-Fi hardening summary should mention:

```text
use WPA2/WPA3
use long random passphrases
disable WPS if not needed
update router firmware
separate guest/IoT networks
change default admin credentials
document authorization before testing
avoid publishing real SSIDs or captures
```

## Final conclusion

A good security learner knows that tool knowledge and authorization must go together.

This lab is complete when the learner can explain what Aircrack-ng is, why it is sensitive, what is allowed in this repository, what is not allowed, and how to produce defensive wireless recommendations.
