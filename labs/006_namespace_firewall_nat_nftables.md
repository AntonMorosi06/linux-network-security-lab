# Lab 006 — Firewall and NAT inside a Network Namespace Router

## Objective

The objective of this lab is to extend the client-router-server topology from Lab 005 by adding firewall and NAT behavior inside the `lab_router` namespace.

This lab teaches:

- nftables basics
- firewall tables and chains
- forward chain filtering
- default drop policy
- stateful firewall rules
- connection tracking state
- rule counters
- blocking and allowing HTTP traffic
- SNAT inside a namespace router
- how NAT changes what the server sees as the source address
- cleanup and reset of firewall rules

## Required previous lab

Before running this lab, create the namespace topology from Lab 005:

```bash
./scripts/setup_namespace_client_router_server.sh
```

Then verify it:

```bash
./scripts/test_namespace_client_router_server.sh
```

The expected topology is:

```text
lab_client 10.10.1.2/24
    |
lab_router 10.10.1.1/24 + 10.10.2.1/24
    |
lab_server 10.10.2.2/24
```

## Safety boundary

This lab is local and isolated. It applies nftables rules only inside the `lab_router` namespace. It does not modify the host firewall and does not touch unauthorized networks.

The lab requires Linux with:

- `iproute2`
- `nftables`
- `tcpdump` for observation
- `curl` for HTTP testing
- Python 3 for the local HTTP server

## Theory

A router forwards packets between networks. A firewall decides which packets are allowed or blocked. NAT modifies packet addresses.

In this lab, the router namespace can be used in three different ways:

```text
routing only
routing + firewall filtering
routing + NAT
```

The firewall operates on forwarded traffic because packets pass through the router namespace from client to server.

For routed traffic, the important nftables hook is:

```text
forward
```

For source NAT, the important hook is:

```text
postrouting
```

## Part A — Allow HTTP with a stateful firewall

First start with a clean ruleset:

```bash
./scripts/namespace_firewall_flush_rules.sh
```

Then apply stateful allow rules:

```bash
./scripts/namespace_firewall_stateful_rules.sh
```

Show the rules:

```bash
./scripts/namespace_firewall_show_rules.sh
```

Expected ruleset excerpt:

```text
table inet lab_fw {
  chain forward {
    type filter hook forward priority filter; policy drop;
    ct state established,related counter accept
    ip protocol icmp counter accept
    ip saddr 10.10.1.2 ip daddr 10.10.2.2 tcp dport 8080 ct state new counter accept
    counter drop
  }
}
```

### Interpretation

The policy is `drop`, so forwarded traffic is blocked by default.

The firewall allows:

- established and related traffic
- ICMP
- new TCP connections from client to server on port 8080

Everything else is dropped.

## Part B — Start the HTTP server

In terminal 1:

```bash
./scripts/start_namespace_http_server.sh
```

Expected output:

```text
Serving HTTP on 10.10.2.2 port 8080 ...
```

## Part C — Test allowed HTTP

In terminal 2:

```bash
sudo ip netns exec lab_client curl --max-time 3 http://10.10.2.2:8080
```

Expected output:

```text
HTTP server inside lab_server namespace
```

### Interpretation

The firewall allows the HTTP request because it matches:

```text
source: 10.10.1.2
destination: 10.10.2.2
tcp dport: 8080
state: new
```

The response is allowed by:

```text
ct state established,related accept
```

## Part D — Block HTTP

Apply a block rule:

```bash
./scripts/namespace_firewall_block_http.sh
```

Then test:

```bash
sudo ip netns exec lab_client curl --max-time 3 http://10.10.2.2:8080
```

Expected output:

```text
curl: (28) Connection timed out after 3000 milliseconds
```

### Interpretation

The HTTP server may still be running, but the router firewall drops traffic to TCP port 8080.

This demonstrates an important diagnostic distinction:

```text
service exists
network exists
route exists
firewall blocks traffic
```

## Part E — Allow HTTP again

```bash
./scripts/namespace_firewall_allow_http.sh
```

Then test:

```bash
sudo ip netns exec lab_client curl --max-time 3 http://10.10.2.2:8080
```

Expected output:

```text
HTTP server inside lab_server namespace
```

## Part F — Read firewall counters

```bash
./scripts/namespace_firewall_show_rules.sh
```

Expected output example:

```text
ct state established,related counter packets 8 bytes 1024 accept
ip protocol icmp counter packets 6 bytes 504 accept
ip saddr 10.10.1.2 ip daddr 10.10.2.2 tcp dport 8080 ct state new counter packets 2 bytes 120 accept
counter packets 3 bytes 180 drop
```

### Interpretation

Counters show how many packets matched each rule. This is useful for validating whether a firewall rule is being used.

## Part G — Enable SNAT

Flush previous firewall rules:

```bash
./scripts/namespace_firewall_flush_rules.sh
```

Enable SNAT:

```bash
./scripts/namespace_nat_enable_snat.sh
```

The rule changes traffic from:

```text
10.10.1.2 -> 10.10.2.2
```

to appear as:

```text
10.10.2.1 -> 10.10.2.2
```

from the server-side view.

## Part H — Test SNAT with tcpdump

In terminal 1, start HTTP server:

```bash
./scripts/start_namespace_http_server.sh
```

In terminal 2, observe on server side:

```bash
sudo ip netns exec lab_server tcpdump -i veth_server port 8080 -c 10
```

In terminal 3, generate client traffic:

```bash
sudo ip netns exec lab_client curl http://10.10.2.2:8080
```

Expected tcpdump output with SNAT:

```text
IP 10.10.2.1.54321 > 10.10.2.2.8080: Flags [S]
IP 10.10.2.2.8080 > 10.10.2.1.54321: Flags [S.]
```

### Interpretation

The original client is `10.10.1.2`, but the server sees the router-side address `10.10.2.1`.

This proves that SNAT is active.

## Part I — Automated SNAT test helper

Run:

```bash
./scripts/namespace_nat_test_snat.sh
```

The script prints:

- current nftables rules
- route state
- instructions for server/tcpdump/curl test
- interpretation hints

## Cleanup

To remove nftables rules inside the router namespace:

```bash
./scripts/namespace_firewall_flush_rules.sh
```

To remove the whole namespace topology:

```bash
./scripts/cleanup_namespace_client_router_server.sh
```

## Common issues

### nft command not found

Install nftables:

```bash
sudo apt update
sudo apt install nftables -y
```

### Namespace missing

Run Lab 005 setup:

```bash
./scripts/setup_namespace_client_router_server.sh
```

### HTTP server not running

Start it:

```bash
./scripts/start_namespace_http_server.sh
```

### Connection timed out

This may be expected if the firewall is dropping traffic.

Check rules:

```bash
./scripts/namespace_firewall_show_rules.sh
```

### Connection refused

This usually means the server is not listening on the target port.

Check:

```bash
sudo ip netns exec lab_server ss -ltnp | grep 8080
```

## Defensive value

This lab is important because it reproduces realistic defensive networking logic in a safe local environment.

It teaches how to distinguish:

```text
routing problem
service problem
firewall problem
NAT behavior
visibility problem
```

## Final conclusion

This lab moves from namespace routing to controlled firewalling and NAT.

The core chain is:

```text
client
-> router namespace
-> nftables forward filtering
-> optional SNAT postrouting
-> server
-> packet capture
-> interpretation
```

This is a strong foundation for later labs on traffic shaping, DNS inside isolated networks, monitoring, mini-SOC pipelines, and defensive incident analysis.
