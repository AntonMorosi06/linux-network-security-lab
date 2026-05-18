# Lab 006 Report — Firewall and NAT inside a Namespace Router

## Date

YYYY-MM-DD

## Machine

Hostname:

Linux distribution:

Kernel:

User:

## Objective

The objective of this lab is to apply firewall and NAT rules inside the `lab_router` namespace and observe how traffic between `lab_client` and `lab_server` changes.

## Required topology

The Lab 005 topology must exist:

```text
lab_client 10.10.1.2
lab_router 10.10.1.1 + 10.10.2.1
lab_server 10.10.2.2
```

## Commands executed

```bash
./scripts/setup_namespace_client_router_server.sh
./scripts/namespace_firewall_stateful_rules.sh
./scripts/namespace_firewall_show_rules.sh
./scripts/start_namespace_http_server.sh
./scripts/namespace_firewall_block_http.sh
./scripts/namespace_firewall_allow_http.sh
./scripts/namespace_nat_enable_snat.sh
./scripts/namespace_nat_test_snat.sh
./scripts/namespace_firewall_flush_rules.sh
```

## Stateful firewall ruleset

Paste output from:

```bash
./scripts/namespace_firewall_show_rules.sh
```

## HTTP allowed test

Command:

```bash
sudo ip netns exec lab_client curl --max-time 3 http://10.10.2.2:8080
```

Expected:

```text
HTTP server inside lab_server namespace
```

Observed:

```text
PASTE_OUTPUT_HERE
```

## HTTP blocked test

Command:

```bash
./scripts/namespace_firewall_block_http.sh
sudo ip netns exec lab_client curl --max-time 3 http://10.10.2.2:8080
```

Expected:

```text
curl timeout or no response
```

Observed:

```text
PASTE_OUTPUT_HERE
```

## Firewall counters

Paste ruleset with counters:

```text
PASTE_COUNTERS_HERE
```

Interpretation:

```text
Explain which rules were matched.
```

## SNAT test

SNAT rule enabled with:

```bash
./scripts/namespace_nat_enable_snat.sh
```

Server-side tcpdump command:

```bash
sudo ip netns exec lab_server tcpdump -i veth_server port 8080 -c 10
```

Client request:

```bash
sudo ip netns exec lab_client curl http://10.10.2.2:8080
```

Expected tcpdump source:

```text
10.10.2.1 -> 10.10.2.2:8080
```

Observed tcpdump:

```text
PASTE_OUTPUT_HERE
```

## Interpretation

Explain:

- whether firewall allow rules worked
- whether firewall block rules worked
- whether counters increased
- whether SNAT changed the visible source address
- whether routing remained functional

## Problems encountered

Possible issues:

- missing nftables
- namespace missing
- HTTP server not running
- IP forwarding disabled
- tcpdump missing
- curl timeout due to firewall drop
- connection refused due to server not listening

## Cleanup

Flush router namespace rules:

```bash
./scripts/namespace_firewall_flush_rules.sh
```

Remove topology if done:

```bash
./scripts/cleanup_namespace_client_router_server.sh
```

## Security note

All firewall and NAT rules are applied only inside the isolated `lab_router` namespace.
