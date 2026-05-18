# Lab 004 Report — DNS, Routing and Connectivity Diagnostics

## Date

YYYY-MM-DD

## Machine

Hostname:

Operating system:

Kernel:

User:

## Objective

The objective of this report is to document local network configuration, routing, gateway reachability, public IP connectivity, DNS resolution, and application-level HTTPS connectivity.

## Commands executed

```bash
./scripts/diagnose_dns_routing_connectivity.sh
./scripts/test_dns_resolution_examples.sh example.com
./scripts/create_dns_routing_report.sh
```

## Interface summary

Paste relevant output from:

```bash
ip -br addr
```

or equivalent.

## Routing summary

Paste relevant output from:

```bash
ip route
ip route get 1.1.1.1
```

## Default gateway

Detected gateway:

```text
PASTE_GATEWAY_HERE
```

## DNS configuration

Paste relevant output from:

```bash
cat /etc/resolv.conf
resolvectl status
```

## Connectivity test results

Loopback:

```text
PASS / FAIL
```

Gateway:

```text
PASS / FAIL / NOT TESTED
```

Public IP:

```text
PASS / FAIL
```

DNS resolution:

```text
PASS / FAIL
```

HTTPS application-level test:

```text
PASS / FAIL
```

## Interpretation

Explain whether the issue, if any, appears to be related to:

- local interface configuration
- routing
- default gateway
- upstream connectivity
- DNS resolution
- HTTPS/TLS/application layer

## Problems encountered

Possible issues:

- `ip` command not available
- `dig` not available
- `nslookup` not available
- `resolvectl` not available
- ICMP blocked by network
- DNS server not responding
- HTTPS blocked or TLS error

## Security note

This lab is defensive and diagnostic. It does not scan unauthorized systems. It uses basic connectivity checks toward local addresses, the configured gateway, and standard diagnostic/documentation targets.
