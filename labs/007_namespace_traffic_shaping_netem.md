# Lab 007 — Traffic Shaping, Latency, Packet Loss and Bandwidth Limits

## Objective

The objective of this lab is to simulate degraded network conditions inside the isolated namespace topology created in Lab 005.

This lab teaches:

- Linux traffic control with `tc`
- queueing disciplines, also called qdisc
- `netem` for latency and packet loss simulation
- `tbf` for bandwidth limiting
- latency measurement with `ping`
- HTTP timing measurement with `curl`
- cleanup of qdisc state
- defensive interpretation of degraded telemetry or service performance

## Required previous lab

Before running this lab, create the namespace topology from Lab 005:

```bash
./scripts/setup_namespace_client_router_server.sh
```

Then verify it:

```bash
./scripts/test_namespace_client_router_server.sh
```

Expected topology:

```text
lab_client 10.10.1.2/24
    |
lab_router 10.10.1.1/24 + 10.10.2.1/24
    |
lab_server 10.10.2.2/24
```

## Safety boundary

This lab is local and isolated. Traffic shaping is applied only to virtual interfaces inside Linux network namespaces.

It does not modify the real Wi-Fi/Ethernet interface and does not affect external networks.

## Theory

Linux `tc` controls traffic behavior through queueing disciplines.

A queueing discipline, or `qdisc`, determines how packets leave an interface.

In this lab, traffic shaping is applied to:

```text
lab_client / veth_client
```

This means the client-side outbound traffic can be artificially delayed, dropped, or rate-limited.

The main tools used are:

```text
netem  -> latency, jitter, loss, corruption, reordering simulation
tbf    -> bandwidth limiting using token bucket filter
```

## Part A — Show current qdisc state

```bash
./scripts/namespace_tc_show_qdisc.sh
```

Expected output example:

```text
qdisc noqueue 0: dev lo root refcnt 2
qdisc noqueue 0: dev veth_client root refcnt 2
```

or:

```text
qdisc netem 8001: dev veth_client root refcnt 2 delay 200ms
```

## Part B — Baseline ping latency

Before adding artificial delay, test the baseline:

```bash
./scripts/namespace_tc_test_ping_latency.sh
```

Expected output example:

```text
3 packets transmitted, 3 received, 0% packet loss
rtt min/avg/max/mdev = 0.050/0.080/0.120/0.030 ms
```

### Interpretation

Inside a local namespace topology, latency is usually extremely low because everything runs inside the same machine.

## Part C — Add latency

Apply 200 ms outbound latency on the client interface:

```bash
./scripts/namespace_tc_add_latency.sh
```

Then test:

```bash
./scripts/namespace_tc_test_ping_latency.sh
```

Expected output example:

```text
64 bytes from 10.10.2.2: icmp_seq=1 ttl=63 time=400 ms
64 bytes from 10.10.2.2: icmp_seq=2 ttl=63 time=400 ms
```

### Interpretation

The apparent round-trip time may be around 400 ms because delay can affect the outbound path and the reply path depending on where the qdisc is applied and how packets traverse the topology.

## Part D — Add packet loss

First clear previous qdisc state:

```bash
./scripts/namespace_tc_clear.sh
```

Then apply packet loss:

```bash
./scripts/namespace_tc_add_packet_loss.sh
```

Then test:

```bash
./scripts/namespace_tc_test_ping_latency.sh
```

Expected output example:

```text
10 packets transmitted, 7 received, 30% packet loss
```

### Interpretation

Packet loss simulates unreliable links. This is useful for understanding telemetry gaps, retry behavior, heartbeat failures, and monitoring alerts.

## Part E — Add latency and packet loss together

```bash
./scripts/namespace_tc_clear.sh
./scripts/namespace_tc_add_latency_loss.sh
./scripts/namespace_tc_test_ping_latency.sh
```

Expected behavior:

```text
Higher latency and visible packet loss
```

### Interpretation

Real networks often degrade in multiple ways at once. A system may need to handle both delay and loss.

## Part F — Add bandwidth limit

```bash
./scripts/namespace_tc_clear.sh
./scripts/namespace_tc_add_bandwidth_limit.sh
```

Then start the HTTP server in terminal 1:

```bash
./scripts/start_namespace_http_server.sh
```

Then test HTTP timing in terminal 2:

```bash
./scripts/namespace_tc_test_http_timing.sh
```

Expected output example:

```text
DNS lookup: 0.000000
Connect: 0.001234
Start transfer: 0.003210
Total: 0.015678
Speed download: 12345 bytes/s
HTTP code: 200
```

### Interpretation

Bandwidth limiting affects transfer speed. With very small files, the effect may be limited. Larger payloads show bandwidth limits more clearly.

## Part G — Cleanup

Always clear qdisc state when finished:

```bash
./scripts/namespace_tc_clear.sh
```

Then verify:

```bash
./scripts/namespace_tc_show_qdisc.sh
```

Finally, remove the namespace topology if finished:

```bash
./scripts/cleanup_namespace_client_router_server.sh
```

## Common issues

### tc command not found

Install iproute2:

```bash
sudo apt update
sudo apt install iproute2 -y
```

### Namespace missing

Run Lab 005 setup:

```bash
./scripts/setup_namespace_client_router_server.sh
```

### RTNETLINK answers: File exists

This usually means a qdisc is already configured. Clear it first:

```bash
./scripts/namespace_tc_clear.sh
```

### Cannot delete qdisc

If no qdisc exists, deletion may print an error. The cleanup script handles this safely.

### HTTP timing test fails

Start the namespace HTTP server:

```bash
./scripts/start_namespace_http_server.sh
```

Then run the timing test from another terminal:

```bash
./scripts/namespace_tc_test_http_timing.sh
```

## Defensive value

Traffic shaping is useful for defensive learning because real incidents often involve degraded communication rather than complete outages.

This lab helps reason about:

- slow services
- unstable telemetry
- heartbeat gaps
- timeout behavior
- retry logic
- packet loss
- reduced throughput
- performance reports
- monitoring thresholds

## Final conclusion

This lab adds network degradation to the isolated client-router-server topology.

The core chain is:

```text
namespace topology
-> qdisc on virtual interface
-> latency / packet loss / bandwidth limit
-> ping and curl measurements
-> interpretation
-> cleanup
```

This is directly useful for testing dashboards, telemetry systems, distributed services, MicroBot-style node communication, and defensive network troubleshooting.
