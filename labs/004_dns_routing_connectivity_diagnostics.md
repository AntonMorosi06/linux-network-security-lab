# Lab 004 — DNS, Routing and Connectivity Diagnostics

## Objective

The objective of this lab is to understand the diagnostic chain that connects local network configuration, routing, gateway reachability, DNS resolution, and application-level connectivity.

This lab answers practical questions such as:

- Does the machine have an IP address?
- Does the machine have a default gateway?
- Can the machine reach loopback?
- Can the machine reach the gateway?
- Can the machine reach a public IP address?
- Does DNS resolution work?
- Is the problem related to IP connectivity or name resolution?

This is a defensive and local diagnostic lab. It does not scan external systems. It only performs basic connectivity checks against local addresses, the configured gateway, and well-known public diagnostic targets.

## Safety boundary

This lab is safe when used for normal local diagnostics. It uses:

- loopback address: `127.0.0.1`
- local gateway discovered from the routing table
- public DNS/connectivity test IPs such as `1.1.1.1`
- documentation domain `example.com`

Do not use these methods to probe networks that you do not own or do not have permission to test.

## Theory

A network problem should be diagnosed in layers.

A useful order is:

```text
local host
-> interface
-> IP address
-> route
-> default gateway
-> IP connectivity
-> DNS resolution
-> application protocol
```

If `ping 1.1.1.1` works but `ping example.com` fails, the network path may be working while DNS resolution is broken.

If `ping 127.0.0.1` fails, the local TCP/IP stack or loopback configuration has a serious issue.

If the machine has no default route, it may not know where to send packets outside the local network.

## Step 1 — Identify local network interfaces

On Linux:

```bash
ip -br addr
```

Fallback on systems without `ip`:

```bash
ifconfig
```

### Expected output example

```text
lo      UNKNOWN 127.0.0.1/8 ::1/128
wlan0   UP      192.168.1.45/24
```

### Interpretation

`lo` is the loopback interface.

`wlan0` or similar is a physical or virtual network interface.

`192.168.1.45/24` is a private IPv4 address on a local network.

## Step 2 — Inspect the routing table

On Linux:

```bash
ip route
```

Fallback:

```bash
netstat -rn
```

### Expected output example

```text
default via 192.168.1.1 dev wlan0 proto dhcp metric 600
192.168.1.0/24 dev wlan0 proto kernel scope link src 192.168.1.45
```

### Interpretation

The `default` route indicates where packets go when the destination is not in a directly connected network.

In this example, the default gateway is:

```text
192.168.1.1
```

## Step 3 — Discover the default gateway

On Linux:

```bash
ip route | awk '/default/ {print $3; exit}'
```

Expected output:

```text
192.168.1.1
```

### Interpretation

The gateway is the router used to reach networks outside the local subnet.

## Step 4 — Test loopback

```bash
ping -c 4 127.0.0.1
```

### Expected output

```text
4 packets transmitted, 4 received, 0% packet loss
```

### Interpretation

The local TCP/IP stack and loopback interface are functioning.

## Step 5 — Test gateway reachability

```bash
GATEWAY=$(ip route | awk '/default/ {print $3; exit}')
echo "Gateway: $GATEWAY"
ping -c 4 "$GATEWAY"
```

### Expected output

```text
Gateway: 192.168.1.1
4 packets transmitted, 4 received, 0% packet loss
```

### Interpretation

The local machine can reach the default router.

If this fails, the issue may be local Wi-Fi/Ethernet, gateway reachability, VLAN, firewall, or local network configuration.

## Step 6 — Test public IP connectivity

```bash
ping -c 4 1.1.1.1
```

### Expected output

```text
4 packets transmitted, 4 received, 0% packet loss
```

### Interpretation

The machine can reach an external IP address. This tests IP connectivity without relying on DNS.

## Step 7 — Test DNS resolution

```bash
getent hosts example.com
```

Alternative tools:

```bash
dig example.com
nslookup example.com
```

### Expected output example

```text
93.184.216.34 example.com
```

### Interpretation

The machine can resolve a domain name into an IP address.

If public IP ping works but DNS resolution fails, the problem is likely DNS-related.

## Step 8 — Inspect DNS configuration

```bash
cat /etc/resolv.conf
```

If systemd-resolved is available:

```bash
resolvectl status
```

### Expected output example

```text
nameserver 127.0.0.53
options edns0 trust-ad
search home
```

### Interpretation

`/etc/resolv.conf` tells the system which resolver to use.

On many systemd-based Linux systems, `127.0.0.53` is the local stub resolver managed by `systemd-resolved`.

## Step 9 — Test application-level connectivity

```bash
curl -I https://example.com
```

### Expected output example

```text
HTTP/2 200
content-type: text/html
```

or:

```text
HTTP/1.1 200 OK
Content-Type: text/html
```

### Interpretation

If this works, DNS, TCP, TLS, and HTTP-level connectivity are functioning.

## Diagnostic scenarios

### Scenario A — Loopback fails

If `ping 127.0.0.1` fails, the local network stack or loopback interface is broken.

### Scenario B — Gateway fails

If loopback works but gateway ping fails, the issue is likely local network connection, interface state, Wi-Fi/Ethernet, or router reachability.

### Scenario C — Public IP fails

If gateway works but `ping 1.1.1.1` fails, the local network may be working but upstream connectivity is broken.

### Scenario D — Public IP works but DNS fails

If `ping 1.1.1.1` works but `getent hosts example.com` fails, DNS is likely broken.

### Scenario E — DNS works but HTTPS fails

If DNS resolution works but `curl https://example.com` fails, the problem may involve TCP connectivity, TLS, proxy settings, certificate validation, or application-level filtering.

## Commands summary

```bash
ip -br addr
ip route
ip route get 1.1.1.1
cat /etc/resolv.conf
ping -c 4 127.0.0.1
ping -c 4 1.1.1.1
getent hosts example.com
dig example.com
nslookup example.com
curl -I https://example.com
```

## Final conclusion

This lab provides a structured diagnostic method for separating network connectivity problems from DNS resolution problems and application-level problems.

The key idea is:

```text
If IP works but names do not work, check DNS.
If local gateway does not work, check local network.
If DNS works but HTTPS does not work, check application/TLS/proxy/firewall layers.
```
