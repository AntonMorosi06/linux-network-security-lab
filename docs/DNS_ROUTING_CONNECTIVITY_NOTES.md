# DNS, Routing and Connectivity Notes

## Diagnostic chain

A practical network diagnostic chain is:

```text
local host
-> interface
-> IP address
-> route
-> gateway
-> public IP connectivity
-> DNS resolution
-> application protocol
```

## Interface

A network interface can be physical, virtual, loopback, wireless, Ethernet, bridge, veth, or container-related.

Useful Linux command:

```bash
ip -br addr
```

## Loopback

Loopback is the local network interface used by a host to communicate with itself.

Common loopback address:

```text
127.0.0.1
```

Test:

```bash
ping -c 4 127.0.0.1
```

## Routing table

The routing table tells the operating system where to send packets.

Useful command:

```bash
ip route
```

## Default gateway

The default gateway is used when the destination is outside directly connected networks.

Useful command:

```bash
ip route | awk '/default/ {print $3; exit}'
```

## Route to a destination

Useful command:

```bash
ip route get 1.1.1.1
```

This shows the interface, gateway, and source address Linux would use to reach the target.

## DNS

DNS resolves names into IP addresses.

Useful commands:

```bash
cat /etc/resolv.conf
getent hosts example.com
dig example.com
nslookup example.com
```

## Public IP test

A public IP connectivity test avoids DNS.

Example:

```bash
ping -c 4 1.1.1.1
```

If this works but DNS fails, the network path may be functional while DNS is broken.

## Application-level test

HTTP/HTTPS tests validate more than raw connectivity.

Example:

```bash
curl -I https://example.com
```

This may involve:

- DNS
- TCP
- TLS
- HTTP
- proxy settings
- firewall rules
- certificate validation

## Common diagnostic conclusions

### Loopback works, gateway fails

Likely local network connection problem.

### Gateway works, public IP fails

Likely upstream routing or internet connectivity problem.

### Public IP works, DNS fails

Likely DNS resolver problem.

### DNS works, HTTPS fails

Likely application, TLS, proxy, firewall, or service-layer problem.

## Defensive value

DNS and routing diagnostics are essential for:

- troubleshooting Linux systems
- diagnosing service outages
- validating local network configuration
- understanding telemetry failures
- separating DNS problems from connectivity problems
- documenting network state during incidents
