# Aircrack-ng Safe Usage Policy

## Purpose

This document defines the repository policy for discussing Aircrack-ng.

Aircrack-ng is a wireless security auditing suite. Because wireless auditing tools are dual-use, this repository documents them only from a safe, legal, defensive and authorized perspective.

## Allowed scope

Allowed content:

```text
what Aircrack-ng is
what the major tools are used for conceptually
version and help inspection
authorized lab setup notes
sample PCAP-only discussion
Wi-Fi security awareness
defensive configuration recommendations
ethics and legal boundary
report templates
```

Allowed commands in this repository:

```bash
aircrack-ng --help
airmon-ng --help
airodump-ng --help
```

These commands inspect local help text only. They do not target a network.

## Disallowed scope

This repository must not include:

```text
instructions for attacking third-party Wi-Fi networks
instructions for unauthorized access
live capture against neighbors or public networks
deauthentication workflow against real clients
password cracking walkthroughs against real networks
collection or publication of real handshakes
collection or publication of real user traffic
bypass or evasion instructions
credential recovery against systems not owned by the learner
```

## Authorized lab boundary

Aircrack-ng may only be discussed in relation to:

```text
owned wireless lab hardware
explicitly authorized lab network
offline sample PCAP files
synthetic or training captures
conceptual defensive education
```

## Safe report wording

Correct wording:

```text
This lab studies wireless security tooling from a defensive and authorized perspective. No third-party networks were targeted. No real user traffic was captured. The lab is limited to help/version inspection and conceptual PCAP-based analysis.
```

Incorrect wording:

```text
This lab demonstrates how to break into Wi-Fi networks.
```

## Defensive recommendations

A safe wireless security awareness lab should end with defensive advice:

```text
use WPA2/WPA3
use long random passphrases
disable WPS when not needed
update router firmware
separate guest networks
monitor unknown devices
avoid publishing SSIDs or captures from real environments
document authorization before testing
```

## Final policy

Aircrack-ng can be referenced in this repository only when the content remains educational, defensive, local or explicitly authorized. When in doubt, do not include the command or workflow.
