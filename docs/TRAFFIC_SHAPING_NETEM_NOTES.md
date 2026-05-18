# Traffic Shaping and netem Notes

## What is tc?

`tc` stands for traffic control. It is a Linux tool used to configure packet scheduling, shaping, delay, loss, and other network behavior.

## What is a qdisc?

A qdisc is a queueing discipline. It controls how packets are queued and transmitted by an interface.

Show qdisc state:

```bash
tc qdisc show
```

Show qdisc for one interface:

```bash
tc qdisc show dev veth_client
```

## What is netem?

`netem` is a Linux network emulator. It can simulate degraded network behavior such as:

- delay
- packet loss
- jitter
- duplication
- corruption
- reordering

Example:

```bash
tc qdisc add dev veth_client root netem delay 200ms
```

## What is packet loss?

Packet loss means some packets do not reach their destination.

Example:

```bash
tc qdisc add dev veth_client root netem loss 30%
```

This is useful for testing retry logic, monitoring gaps, and telemetry robustness.

## What is TBF?

TBF means Token Bucket Filter. It can limit bandwidth.

Example:

```bash
tc qdisc add dev veth_client root tbf rate 512kbit burst 32kbit latency 400ms
```

## Why use namespaces?

Applying traffic shaping to real interfaces can disrupt real connectivity. Applying it inside a namespace lab is safer because it affects only virtual interfaces created for the experiment.

## Defensive value

Traffic shaping helps simulate realistic problems:

```text
slow network
unstable network
packet loss
high latency
low throughput
```

These conditions matter for:

- telemetry systems
- dashboards
- distributed services
- robotics controllers
- MicroBot-style node communication
- monitoring and incident response

## Diagnostic interpretation

If ping latency increases after applying netem delay, the qdisc is active.

If packet loss appears after applying netem loss, the qdisc is active.

If HTTP transfers slow down after applying TBF, bandwidth limiting is active.

If nothing changes, check:

```bash
tc qdisc show dev veth_client
ip netns list
ip netns exec lab_client ip -br addr
```

## Cleanup

Always clear qdisc state when finished:

```bash
./scripts/namespace_tc_clear.sh
```
