# Aircrack-ng Tool Overview

## Purpose

This document gives a safe, defensive overview of the Aircrack-ng suite.

Aircrack-ng is a wireless security auditing suite. Because it is dual-use, this repository treats it only as a topic for wireless security awareness, authorized lab planning, help/version inspection and defensive hardening.

This document must not be expanded into an unauthorized Wi-Fi attack guide.

## Repository scope

Allowed:

```text
tool availability checks
version/help output
tool role descriptions
legal/ethical boundary
authorized lab planning
sample-PCAP-only conceptual notes
defensive Wi-Fi hardening recommendations
report writing
```

Not allowed:

```text
live attacks against third-party networks
deauthentication workflows
capturing handshakes from real networks
password cracking workflows
bypass or evasion instructions
credential collection
publishing real wireless captures
publishing nearby SSIDs/BSSIDs/MAC addresses
```

## Major tools, described safely

| Tool | Safe description |
|---|---|
| `aircrack-ng` | suite entry point commonly associated with wireless security auditing; in this repo it is limited to help/version awareness |
| `airmon-ng` | tool commonly associated with wireless interface mode management; in this repo it is limited to help/version awareness |
| `airodump-ng` | tool commonly associated with wireless packet capture; in this repo it is not used for live capture |
| `aireplay-ng` | dual-use traffic injection tool; this repo does not provide usage workflows |
| `airdecap-ng` | tool for capture file processing; this repo does not process private captures |
| `airbase-ng` | advanced wireless tool; this repo does not provide usage workflows |

## Safe commands

The only Aircrack-ng commands used by this repository are help/version style commands:

```bash
aircrack-ng --help
airmon-ng --help
airodump-ng --help
```

These commands print local help text. They do not target networks.

## What this overview teaches

This overview teaches that wireless tools require strict authorization. It also teaches that the defensive lesson is not “how to attack Wi-Fi,” but how to understand why wireless networks should be hardened.

## Defensive questions

A defensive wireless security review should ask:

```text
Is WPA2/WPA3 enabled?
Is the passphrase long and random?
Is WPS disabled if not needed?
Is router firmware updated?
Is a guest network separated from trusted devices?
Are unknown clients reviewed?
Are default router credentials changed?
Is testing documented and authorized?
```

## Safe final wording

Correct:

```text
This repository discusses Aircrack-ng only as a wireless security awareness topic. It does not provide unauthorized capture, deauthentication or cracking workflows.
```

Incorrect:

```text
This repository teaches how to break into Wi-Fi networks.
```
