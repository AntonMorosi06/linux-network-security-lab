# Lab 007 Report — Traffic Shaping, Latency, Packet Loss and Bandwidth Limits

## Date

YYYY-MM-DD

## Machine

Hostname:

Linux distribution:

Kernel:

User:

## Objective

The objective of this lab is to simulate degraded network conditions inside a local namespace topology using Linux `tc`, `netem`, and `tbf`.

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
./scripts/namespace_tc_show_qdisc.sh
./scripts/namespace_tc_test_ping_latency.sh
./scripts/namespace_tc_add_latency.sh
./scripts/namespace_tc_add_packet_loss.sh
./scripts/namespace_tc_add_latency_loss.sh
./scripts/namespace_tc_add_bandwidth_limit.sh
./scripts/namespace_tc_test_http_timing.sh
./scripts/namespace_tc_clear.sh
```

## Baseline qdisc state

Paste output:

```bash
./scripts/namespace_tc_show_qdisc.sh
```

## Baseline ping

Paste output:

```bash
./scripts/namespace_tc_test_ping_latency.sh
```

## Latency test

Applied command:

```bash
./scripts/namespace_tc_add_latency.sh
```

Observed ping:

```text
PASTE_OUTPUT_HERE
```

Interpretation:

```text
Explain how latency changed.
```

## Packet loss test

Applied command:

```bash
./scripts/namespace_tc_add_packet_loss.sh
```

Observed ping:

```text
PASTE_OUTPUT_HERE
```

Interpretation:

```text
Explain packet loss percentage and effect.
```

## Latency + packet loss test

Applied command:

```bash
./scripts/namespace_tc_add_latency_loss.sh
```

Observed ping:

```text
PASTE_OUTPUT_HERE
```

## Bandwidth limit test

Applied command:

```bash
./scripts/namespace_tc_add_bandwidth_limit.sh
```

HTTP timing output:

```text
PASTE_OUTPUT_HERE
```

## Cleanup

Command:

```bash
./scripts/namespace_tc_clear.sh
```

Final qdisc state:

```text
PASTE_OUTPUT_HERE
```

## Problems encountered

Possible issues:

- missing `tc`
- namespace missing
- qdisc already exists
- HTTP server not running
- ping blocked
- no visible bandwidth effect because the file is too small

## Security note

The qdisc changes were applied only inside the namespace lab and did not affect the real host network interface.
