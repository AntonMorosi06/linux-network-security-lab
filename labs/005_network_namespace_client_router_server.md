# Lab 005 — Network Namespace Client-Router-Server Topology

## Objective

The objective of this lab is to build a fully isolated local network topology using Linux network namespaces.

The topology contains three isolated network environments:

```text
lab_client  ->  lab_router  ->  lab_server
```

The client and server are not directly connected. They communicate through the router namespace.

This lab teaches:

- Linux network namespaces
- virtual Ethernet pairs
- isolated interfaces
- IP addressing
- routing
- default gateways
- IP forwarding
- client-server communication across routed networks
- local HTTP testing
- packet capture in a virtual network
- cleanup of lab resources

## Safety boundary

This lab is local and isolated. It creates virtual network namespaces on the local Linux machine. It does not scan external systems and does not interact with unauthorized networks.

The lab requires Linux. It will not run natively on macOS because macOS does not provide Linux `ip netns`.

Allowed environments:

- Linux VM
- WSL2 with suitable networking support
- local Linux machine
- disposable Linux lab host

## Topology

The lab creates two virtual Ethernet links.

```text
                10.10.1.0/24                  10.10.2.0/24

 lab_client ---------------- lab_router ---------------- lab_server
 10.10.1.2       10.10.1.1     10.10.2.1       10.10.2.2
```

Interfaces:

```text
lab_client:
  veth_client = 10.10.1.2/24

lab_router:
  veth_router_client = 10.10.1.1/24
  veth_router_server = 10.10.2.1/24

lab_server:
  veth_server = 10.10.2.2/24
```

Routes:

```text
lab_client default gateway -> 10.10.1.1
lab_server default gateway -> 10.10.2.1
```

The router has IPv4 forwarding enabled.

## Step 1 — Setup topology

Run:

```bash
./scripts/setup_namespace_client_router_server.sh
```

### Expected output

```text
[OK] Created namespace: lab_client
[OK] Created namespace: lab_router
[OK] Created namespace: lab_server
[OK] Created veth pairs
[OK] Assigned IP addresses
[OK] Enabled IPv4 forwarding inside lab_router
[OK] Namespace topology ready
```

## Step 2 — Inspect namespaces

```bash
ip netns list
```

### Expected output

```text
lab_server
lab_router
lab_client
```

## Step 3 — Inspect addresses

```bash
sudo ip netns exec lab_client ip -br addr
sudo ip netns exec lab_router ip -br addr
sudo ip netns exec lab_server ip -br addr
```

### Expected output example

```text
lo             UNKNOWN        127.0.0.1/8 ::1/128
veth_client    UP             10.10.1.2/24
```

```text
lo                    UNKNOWN        127.0.0.1/8 ::1/128
veth_router_client    UP             10.10.1.1/24
veth_router_server    UP             10.10.2.1/24
```

```text
lo             UNKNOWN        127.0.0.1/8 ::1/128
veth_server    UP             10.10.2.2/24
```

## Step 4 — Test direct connectivity to router interfaces

```bash
sudo ip netns exec lab_client ping -c 3 10.10.1.1
sudo ip netns exec lab_server ping -c 3 10.10.2.1
```

### Expected output

```text
3 packets transmitted, 3 received, 0% packet loss
```

## Step 5 — Test routed connectivity between client and server

```bash
sudo ip netns exec lab_client ping -c 3 10.10.2.2
sudo ip netns exec lab_server ping -c 3 10.10.1.2
```

### Expected output

```text
3 packets transmitted, 3 received, 0% packet loss
```

### Interpretation

If this works, packets are moving through the router namespace. The client and server are on different subnets, so routing and IP forwarding are working.

## Step 6 — Start HTTP server in lab_server

In terminal 1:

```bash
./scripts/start_namespace_http_server.sh
```

### Expected output

```text
[INFO] Starting HTTP server inside lab_server
[INFO] URL from lab_client: http://10.10.2.2:8080
Serving HTTP on 10.10.2.2 port 8080 ...
```

This command remains active. Stop it with:

```text
CTRL + C
```

## Step 7 — Test HTTP from lab_client

In terminal 2:

```bash
sudo ip netns exec lab_client curl http://10.10.2.2:8080
```

### Expected output

```text
HTTP server inside lab_server namespace
```

## Step 8 — Capture HTTP traffic in the router

In terminal 3:

```bash
./scripts/capture_namespace_http_traffic.sh
```

In terminal 2, generate traffic again:

```bash
sudo ip netns exec lab_client curl http://10.10.2.2:8080
```

### Expected tcpdump output

```text
IP 10.10.1.2.54321 > 10.10.2.2.8080: Flags [S]
IP 10.10.2.2.8080 > 10.10.1.2.54321: Flags [S.]
IP 10.10.1.2.54321 > 10.10.2.2.8080: Flags [.]
IP 10.10.1.2.54321 > 10.10.2.2.8080: Flags [P.]
```

### Interpretation

The router sees HTTP traffic passing between the client and server. This demonstrates that the namespace router is forwarding traffic.

## Step 9 — Run the automated test script

```bash
./scripts/test_namespace_client_router_server.sh
```

This script checks:

- namespace existence
- interface addresses
- routes
- IP forwarding
- ping client to router
- ping server to router
- ping client to server
- ping server to client

## Step 10 — Cleanup

When finished:

```bash
./scripts/cleanup_namespace_client_router_server.sh
```

### Expected output

```text
[OK] Deleted namespace: lab_client
[OK] Deleted namespace: lab_router
[OK] Deleted namespace: lab_server
[OK] Cleanup complete
```

Check:

```bash
ip netns list
```

If nothing is printed, the lab namespaces were removed.

## Common issues

### ip netns command not found

Install `iproute2` on Linux.

On Debian/Ubuntu:

```bash
sudo apt update
sudo apt install iproute2 -y
```

### Operation not permitted

Network namespace operations require privileges. Use `sudo`.

### Ping between client and server fails

Check:

```bash
sudo ip netns exec lab_router sysctl net.ipv4.ip_forward
sudo ip netns exec lab_client ip route
sudo ip netns exec lab_server ip route
```

The router should have:

```text
net.ipv4.ip_forward = 1
```

### HTTP test fails

Check whether the server is running:

```bash
sudo ip netns exec lab_server ss -ltnp | grep 8080
```

Then test:

```bash
sudo ip netns exec lab_client curl http://10.10.2.2:8080
```

### tcpdump missing

Install tcpdump:

```bash
sudo apt install tcpdump -y
```

## Defensive value

This lab is extremely useful for defensive learning because it allows safe simulation of:

- segmented networks
- routed traffic
- client-server communication
- traffic inspection at an intermediate node
- service verification
- network troubleshooting

It is a local version of real network reasoning without touching external systems.

## Final conclusion

This lab moves from simple local diagnostics to a controlled multi-node network simulation.

The core chain is:

```text
namespace isolation
-> veth links
-> IP addressing
-> routing
-> IP forwarding
-> client-server test
-> packet capture
-> cleanup
```

This is a strong foundation for later labs on firewalling, NAT, DNS inside lab networks, traffic shaping, and defensive monitoring.
