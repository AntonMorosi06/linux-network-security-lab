# Lab 005 Report — Network Namespace Client-Router-Server Topology

## Date

YYYY-MM-DD

## Machine

Hostname:

Linux distribution:

Kernel:

User:

## Objective

The objective of this lab is to create a local isolated network topology with three Linux network namespaces: client, router, and server.

## Topology

```text
lab_client 10.10.1.2/24
    |
    | veth
    |
lab_router 10.10.1.1/24 + 10.10.2.1/24
    |
    | veth
    |
lab_server 10.10.2.2/24
```

## Commands executed

```bash
./scripts/setup_namespace_client_router_server.sh
./scripts/test_namespace_client_router_server.sh
./scripts/start_namespace_http_server.sh
./scripts/capture_namespace_http_traffic.sh
./scripts/cleanup_namespace_client_router_server.sh
```

## Namespace list

Paste output:

```bash
ip netns list
```

## Address configuration

Paste output:

```bash
sudo ip netns exec lab_client ip -br addr
sudo ip netns exec lab_router ip -br addr
sudo ip netns exec lab_server ip -br addr
```

## Routing configuration

Paste output:

```bash
sudo ip netns exec lab_client ip route
sudo ip netns exec lab_router ip route
sudo ip netns exec lab_server ip route
```

## IP forwarding

Paste output:

```bash
sudo ip netns exec lab_router sysctl net.ipv4.ip_forward
```

Expected:

```text
net.ipv4.ip_forward = 1
```

## Ping tests

Client to router:

```text
PASS / FAIL
```

Server to router:

```text
PASS / FAIL
```

Client to server:

```text
PASS / FAIL
```

Server to client:

```text
PASS / FAIL
```

## HTTP test

Command:

```bash
sudo ip netns exec lab_client curl http://10.10.2.2:8080
```

Expected output:

```text
HTTP server inside lab_server namespace
```

Observed output:

```text
PASTE_OUTPUT_HERE
```

## Packet capture

Paste relevant tcpdump output:

```text
PASTE_TCPDUMP_OUTPUT_HERE
```

## Interpretation

Explain whether the topology was correctly created and whether routing through the router namespace worked.

## Problems encountered

Possible issues:

- missing iproute2
- missing tcpdump
- sudo permissions
- namespace already exists
- IP forwarding disabled
- HTTP server not running
- route missing
- wrong interface state

## Cleanup

Cleanup command:

```bash
./scripts/cleanup_namespace_client_router_server.sh
```

Final namespace check:

```bash
ip netns list
```

Expected final state:

```text
No lab_client, lab_router, or lab_server namespaces remain.
```

## Security note

This lab is local and isolated. It does not touch external systems or unauthorized networks.
