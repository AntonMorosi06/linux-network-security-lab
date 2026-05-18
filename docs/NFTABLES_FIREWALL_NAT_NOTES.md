# nftables Firewall and NAT Notes

## What is nftables?

nftables is a Linux packet filtering framework. It can be used for firewalling, NAT, packet classification, and traffic control integrations.

In this repository, nftables is used only inside an isolated network namespace router.

## Main concepts

### Table

A table groups chains.

Example:

```bash
nft add table inet lab_fw
```

### Chain

A chain contains rules. A chain can be attached to a packet processing hook.

Example:

```bash
nft add chain inet lab_fw forward '{ type filter hook forward priority 0 ; policy drop ; }'
```

### Rule

A rule matches packet conditions and applies an action.

Example:

```bash
nft add rule inet lab_fw forward ip saddr 10.10.1.2 ip daddr 10.10.2.2 tcp dport 8080 accept
```

## forward hook

The forward hook is used for packets routed through the machine.

In the namespace lab:

```text
lab_client -> lab_router -> lab_server
```

Packets from client to server pass through the router's forward path.

## postrouting hook

The postrouting hook is used after routing decisions. It is commonly used for source NAT.

Example:

```bash
nft add chain ip lab_nat postrouting '{ type nat hook postrouting priority 100 ; }'
```

## Stateful firewalling

Stateful rules use connection tracking.

Important states:

```text
new
established
related
invalid
```

A common rule is:

```bash
ct state established,related accept
```

This allows response traffic for connections that were already accepted.

## Default drop policy

A defensive firewall often uses:

```text
policy drop
```

This means traffic is blocked unless explicitly allowed.

Example:

```bash
nft add chain inet lab_fw forward '{ type filter hook forward priority 0 ; policy drop ; }'
```

## Rule counters

Counters count packets and bytes matching a rule.

Example:

```bash
nft add rule inet lab_fw forward ip protocol icmp counter accept
```

Reading the ruleset later may show:

```text
counter packets 6 bytes 504 accept
```

This helps verify whether traffic matched a rule.

## SNAT

SNAT means Source Network Address Translation.

In this lab:

```text
original source: 10.10.1.2
translated source: 10.10.2.1
destination: 10.10.2.2
```

Rule:

```bash
nft add rule ip lab_nat postrouting ip saddr 10.10.1.2 ip daddr 10.10.2.2 snat to 10.10.2.1
```

The server sees the router-side address instead of the original client address.

## Diagnostic distinction

If HTTP fails, possible causes include:

```text
server not running
wrong port
wrong route
IP forwarding disabled
firewall drop
NAT issue
DNS issue
```

This lab focuses specifically on firewall and NAT behavior.

## Defensive value

Firewall and NAT knowledge is important for:

- network segmentation
- service exposure control
- incident response
- log interpretation
- traffic path analysis
- router/firewall troubleshooting
- secure system design
