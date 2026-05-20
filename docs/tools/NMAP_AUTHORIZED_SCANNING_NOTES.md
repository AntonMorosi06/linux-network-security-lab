# Nmap Authorized Scanning Notes

## Purpose

This document explains how this repository discusses Nmap safely.

Nmap is a network discovery and service enumeration tool. It is useful for defensive inventory, local service verification and authorized assessment. Because it can actively probe systems, this repository restricts Nmap usage to localhost, personal machines, containers, VMs and explicitly authorized lab networks.

## Allowed scope

Allowed targets:

```text
127.0.0.1
localhost
personal VM
personal container
Linux network namespace
lab service started by this repository
explicitly authorized lab host
```

Allowed scan style in this repository:

```text
basic localhost scan
specific-port scan against localhost
service/version detection against localhost
output saving for local report
defensive interpretation
```

## Disallowed scope

This repository must not include:

```text
scanning third-party systems
scanning public IP ranges
scanning school/company networks without written authorization
stealth/evasion workflows
bypass techniques
brute force
exploit execution
credential collection
```

## Safe commands

Safe examples:

```bash
nmap 127.0.0.1
nmap -p 8088 127.0.0.1
nmap -sV -p 8088 127.0.0.1
nmap -oN reports/nmap_localhost.txt -p 8088 127.0.0.1
```

These commands target only localhost.

## Defensive questions

A local Nmap scan should answer:

```text
Which ports are open on my own machine?
Which service appears to be listening?
Is the service expected?
Is it bound only to localhost?
Should it be stopped, firewalled or documented?
```

## Publication warning

Before publishing scan output, check that it does not contain:

```text
public IP addresses
private hostnames
company/school systems
real device names
unauthorized targets
service banners containing sensitive data
```

## Correct wording

Correct:

```text
This lab scans only localhost and a local test service started by the repository. It demonstrates defensive service inventory and report writing.
```

Incorrect:

```text
This lab scans networks to find vulnerable targets.
```

## Final rule

When using Nmap, the target must be local, owned or explicitly authorized.
