# tcpdump Advanced Capture Filters

## Purpose

This document introduces `tcpdump` from a defensive and privacy-safe perspective.

`tcpdump` is a command-line packet capture tool. It can be extremely useful for troubleshooting and defensive analysis, but it can also capture sensitive traffic. For this repository, `tcpdump` must be used only on local lab traffic, synthetic traffic, loopback traffic, personal machines, containers, VMs or explicitly authorized lab networks.

## Safety boundary

Allowed:

```text
loopback capture
localhost service traffic
container or VM lab traffic
short packet-count captures
controlled protocol filtering
writing local reports
```

Not allowed:

```text
capturing third-party traffic
capturing Wi-Fi traffic from real users
publishing private captures
capturing credentials
monitoring networks without permission
collecting private browsing activity
```

## Why capture filters matter

Capture filters reduce risk and noise. Instead of capturing everything, the analyst defines a narrow scope.

Examples:

```text
host 127.0.0.1
tcp port 8090
tcp and host 127.0.0.1
tcp port 8090 and host 127.0.0.1
```

The narrower the filter, the safer and more useful the capture.

## Common safe options

| Option | Meaning |
|---|---|
| `-i lo` / `-i lo0` | capture on loopback interface |
| `-nn` | do not resolve names or ports |
| `-c 10` | stop after 10 packets |
| `-w file.pcap` | write capture to a PCAP file |
| `-r file.pcap` | read from a PCAP file |
| `tcp port 8090` | capture TCP traffic for port 8090 |
| `host 127.0.0.1` | limit capture to localhost |

## Safe commands

Linux:

```bash
sudo tcpdump -i lo -nn -c 10 'tcp port 8090 and host 127.0.0.1'
```

macOS:

```bash
sudo tcpdump -i lo0 -nn -c 10 'tcp port 8090 and host 127.0.0.1'
```

Read a local capture:

```bash
tcpdump -nn -r data/lab025/lab025_loopback_http.pcap
```

## Defensive interpretation

A safe tcpdump report should answer:

```text
What interface was used?
What filter was used?
Was the target local or authorized?
How many packets were captured?
Which protocol and port appeared?
Did the capture match expected service traffic?
Was any private traffic included?
```

## Publication warning

Before publishing a capture or output, verify that it contains no:

```text
real third-party IP addresses
private DNS queries
cookies
tokens
credentials
session identifiers
personal browsing traffic
neighbor Wi-Fi traffic
```

## Final rule

Capture the smallest amount of traffic needed to answer the defensive question.
