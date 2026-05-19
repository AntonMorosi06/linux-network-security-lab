# Networking Basics

This file explains Linux networking basics in depth. Networking is one of the most important parts of the Linux Network Security Lab because many labs depend on understanding interfaces, IP addresses, loopback, routing, DNS, ports, sockets, HTTP testing, containers and local-only exposure.

The goal is not to memorize a few commands, but to understand how Linux represents network state and how to diagnose problems safely. A good Linux networking workflow starts with local context, then interfaces, then routes, then name resolution, then ports, then application-level tests.


## 1. Networking mental model

A Linux network path can be understood as application, socket, port, IP address, route, interface and physical or virtual network. When something fails, the problem belongs to one or more of these layers.


## 2. Loopback

Loopback is the local network interface. The address `127.0.0.1` refers to the local machine. Services bound to loopback are normally reachable only from the same host.


## 3. localhost

`localhost` is a name that normally resolves to loopback addresses such as `127.0.0.1` and sometimes `::1` for IPv6. Local labs often use localhost to avoid exposing services.


## 4. 0.0.0.0

`0.0.0.0` means all IPv4 interfaces when used as a listening address. A service listening on `0.0.0.0:PORT` may be reachable through multiple interfaces depending on firewall and network.


## 5. IP address

An IP address identifies an interface on a network. IPv4 addresses look like `192.168.1.50`; IPv6 addresses are longer and use hexadecimal notation.


## 6. Subnet

A subnet defines a range of IP addresses. In CIDR notation, `/24` means 24 network bits. For example, `192.168.1.50/24` belongs to the `192.168.1.0` network.


## 7. Interface

A network interface is an endpoint for network communication. Examples include `lo`, `eth0`, `wlan0`, `docker0`, bridge interfaces and virtual Ethernet pairs.


## 8. ip addr

`ip addr` shows network interfaces, addresses and state. It is the main Linux command for inspecting interface addresses.


## 9. ip route

`ip route` shows the routing table. The default route decides where traffic goes when no more specific route exists.


## 10. Gateway

A gateway is a device or route target used to reach other networks. In home networks, the router is usually the default gateway.


## 11. DNS

DNS converts names into IP addresses. If IP connectivity works but names fail, DNS may be the issue.


## 12. ping

`ping` tests ICMP reachability. It is useful, but not every host responds to ICMP. A failed ping does not always mean the service is down.


## 13. curl

`curl` tests application-layer HTTP behavior. For local APIs, `curl -i` is often more useful than ping because it shows HTTP status codes and headers.


## 14. Ports

A port identifies an application endpoint on a host. HTTP often uses 80, HTTPS 443, Prometheus 9090, Grafana 3000/3001 in local labs, and development servers often use 8080 or similar.


## 15. Sockets

A socket combines protocol, address and port. A listening socket waits for incoming connections. `ss` and `lsof` can show sockets.


## 16. TCP

TCP is connection-oriented. It is common for HTTP, SSH, databases and many APIs. TCP includes connection establishment and reliable byte streams.


## 17. UDP

UDP is connectionless. It is common for DNS, streaming and some telemetry. UDP does not establish connections like TCP.


## 18. ss

`ss -tulpen` shows listening TCP/UDP sockets with process information on Linux. It is one of the main commands for exposure review.


## 19. lsof

`lsof -i -P -n` shows processes using network sockets and is useful on both macOS and Linux.


## 20. Routing diagnosis

Routing diagnosis asks whether the system knows where to send packets. `ip route` is the first command to inspect this on Linux.


## 21. DNS diagnosis

DNS diagnosis asks whether names resolve. `dig` and `nslookup` help separate name-resolution problems from route problems.


## 22. HTTP diagnosis

HTTP diagnosis asks whether the application responds correctly. `curl -i` shows status code, headers and body.


## 23. Local-only safety

Local-only services should bind to `127.0.0.1` when possible. This reduces unintended exposure during labs.


## 24. Container networking

Docker creates virtual networks and bridges. Containers may communicate internally while only selected ports are published to the host.


## 25. Network namespaces

Linux network namespaces isolate network stacks. They are useful for labs because they allow client-router-server topologies on one machine.


## 26. Firewall connection

A firewall can allow, drop, reject or translate traffic. Network checks should be interpreted together with firewall rules when relevant.


## 27. Packet capture

Packet capture tools such as tcpdump observe traffic. They are powerful and should be used only on local or authorized traffic.


## 28. Network report writing

A network report should describe interface state, route state, DNS behavior, port exposure and application response. Raw command output is not enough.


## Command card 1: `ip addr`

### Purpose

Show interfaces and IP addresses.

### Example

```bash
ip addr
```

### Expected output

```text
Interfaces such as lo, eth0, docker0 with addresses.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Safe read-only Linux command.


## Command card 2: `ip route`

### Purpose

Show routing table.

### Example

```bash
ip route
```

### Expected output

```text
Default route and network routes.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Safe read-only Linux command.


## Command card 3: `ping`

### Purpose

Test ICMP reachability.

### Example

```bash
ping -c 4 127.0.0.1
```

### Expected output

```text
Replies and packet loss statistics.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Use authorized targets only.


## Command card 4: `curl -i`

### Purpose

Test HTTP response with headers.

### Example

```bash
curl -i http://127.0.0.1:8080
```

### Expected output

```text
HTTP status, headers and body.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Safe for local services.


## Command card 5: `ss -tulpen`

### Purpose

Show listening sockets and processes.

### Example

```bash
ss -tulpen
```

### Expected output

```text
Protocol, address, port and process.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Safe read-only Linux command.


## Command card 6: `lsof -i -P -n`

### Purpose

Show network-related open files.

### Example

```bash
lsof -i -P -n
```

### Expected output

```text
Processes using sockets.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Safe and useful on macOS/Linux.


## Command card 7: `dig`

### Purpose

Query DNS records.

### Example

```bash
dig example.com
```

### Expected output

```text
DNS answer and metadata.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Safe; use reasonable targets.


## Command card 8: `nslookup`

### Purpose

Resolve a name.

### Example

```bash
nslookup example.com
```

### Expected output

```text
DNS server and answer.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Safe; common diagnostic.


## Command card 9: `traceroute`

### Purpose

Show network path hops.

### Example

```bash
traceroute example.com
```

### Expected output

```text
Hop list.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Use responsibly; not always installed.


## Command card 10: `tcpdump`

### Purpose

Capture packets.

### Example

```bash
sudo tcpdump -i lo port 8080
```

### Expected output

```text
Packet lines.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

High caution; local/authorized only.


## Command card 11: `hostname -I`

### Purpose

Show host IP addresses on some Linux systems.

### Example

```bash
hostname -I
```

### Expected output

```text
IP address list.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Linux-specific; safe.


## Command card 12: `ifconfig`

### Purpose

Show interface config on older systems/macOS.

### Example

```bash
ifconfig
```

### Expected output

```text
Interface details.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Alternative when ip is unavailable.


## Command card 13: `netstat`

### Purpose

Legacy network inspection.

### Example

```bash
netstat -an
```

### Expected output

```text
Connections and listening sockets.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Older replacement for ss in some environments.


## Command card 14: `docker network ls`

### Purpose

List Docker networks.

### Example

```bash
docker network ls
```

### Expected output

```text
Docker network list.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Safe Docker diagnostic.


## Command card 15: `docker network inspect`

### Purpose

Inspect Docker network details.

### Example

```bash
docker network inspect bridge
```

### Expected output

```text
JSON network metadata.
```

### Interpretation

This command helps inspect a specific layer of networking. A strong interpretation should identify whether the command checks interface state, routing, DNS, port exposure, application response or packet-level behavior.

### Safety note

Safe but large output.


## Networking reference tables

| Layer | Question | Command |
|---|---|---|
| Local context | Am I on the right host? | `hostname`, `uname -a` |
| Interface | What addresses exist? | `ip addr` |
| Route | Where does traffic go? | `ip route` |
| DNS | Do names resolve? | `dig`, `nslookup` |
| Port | What is listening? | `ss`, `lsof` |
| Application | Does HTTP respond? | `curl -i` |
| Container | What Docker networks exist? | `docker network ls` |
| Packet | Is traffic visible? | `tcpdump` |

| Address | Meaning |
|---|---|
| `127.0.0.1` | IPv4 loopback/local machine |
| `localhost` | Name for local machine |
| `0.0.0.0` | all IPv4 interfaces when listening |
| `::1` | IPv6 loopback |


## Networking study card 1: Layered diagnosis

### Concept

Start with local context, then interfaces, routes, DNS, ports and application response.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 2: Loopback safety

### Concept

Localhost is the safest target for labs.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 3: Binding address

### Concept

Listening on 127.0.0.1 is different from listening on 0.0.0.0.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 4: Interface state

### Concept

Interfaces can be up, down, virtual, physical or container-created.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 5: Route state

### Concept

The default route explains where unknown destinations go.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 6: DNS separation

### Concept

DNS failure is different from network failure.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 7: HTTP status

### Concept

HTTP status codes reveal application-level behavior.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 8: Port ownership

### Concept

A port belongs to a process or container.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 9: Docker bridge

### Concept

Docker bridge networks allow container communication.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 10: Namespaces

### Concept

Network namespaces isolate network stacks.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 11: Firewall interaction

### Concept

Firewall rules can change reachability.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 12: Packet capture caution

### Concept

Packet capture can expose sensitive traffic.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 13: Report clarity

### Concept

Network reports should explain the layer tested.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 14: macOS difference

### Concept

macOS may use ifconfig, netstat and lsof instead of ip and ss.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 15: Safe targets

### Concept

Use localhost or explicitly authorized lab targets.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 16: Layered diagnosis

### Concept

Start with local context, then interfaces, routes, DNS, ports and application response.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 17: Loopback safety

### Concept

Localhost is the safest target for labs.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 18: Binding address

### Concept

Listening on 127.0.0.1 is different from listening on 0.0.0.0.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 19: Interface state

### Concept

Interfaces can be up, down, virtual, physical or container-created.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 20: Route state

### Concept

The default route explains where unknown destinations go.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 21: DNS separation

### Concept

DNS failure is different from network failure.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 22: HTTP status

### Concept

HTTP status codes reveal application-level behavior.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 23: Port ownership

### Concept

A port belongs to a process or container.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 24: Docker bridge

### Concept

Docker bridge networks allow container communication.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 25: Namespaces

### Concept

Network namespaces isolate network stacks.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 26: Firewall interaction

### Concept

Firewall rules can change reachability.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 27: Packet capture caution

### Concept

Packet capture can expose sensitive traffic.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 28: Report clarity

### Concept

Network reports should explain the layer tested.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 29: macOS difference

### Concept

macOS may use ifconfig, netstat and lsof instead of ip and ss.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 30: Safe targets

### Concept

Use localhost or explicitly authorized lab targets.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 31: Layered diagnosis

### Concept

Start with local context, then interfaces, routes, DNS, ports and application response.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 32: Loopback safety

### Concept

Localhost is the safest target for labs.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 33: Binding address

### Concept

Listening on 127.0.0.1 is different from listening on 0.0.0.0.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 34: Interface state

### Concept

Interfaces can be up, down, virtual, physical or container-created.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 35: Route state

### Concept

The default route explains where unknown destinations go.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 36: DNS separation

### Concept

DNS failure is different from network failure.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 37: HTTP status

### Concept

HTTP status codes reveal application-level behavior.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 38: Port ownership

### Concept

A port belongs to a process or container.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 39: Docker bridge

### Concept

Docker bridge networks allow container communication.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 40: Namespaces

### Concept

Network namespaces isolate network stacks.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 41: Firewall interaction

### Concept

Firewall rules can change reachability.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 42: Packet capture caution

### Concept

Packet capture can expose sensitive traffic.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 43: Report clarity

### Concept

Network reports should explain the layer tested.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 44: macOS difference

### Concept

macOS may use ifconfig, netstat and lsof instead of ip and ss.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 45: Safe targets

### Concept

Use localhost or explicitly authorized lab targets.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 46: Layered diagnosis

### Concept

Start with local context, then interfaces, routes, DNS, ports and application response.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 47: Loopback safety

### Concept

Localhost is the safest target for labs.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 48: Binding address

### Concept

Listening on 127.0.0.1 is different from listening on 0.0.0.0.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 49: Interface state

### Concept

Interfaces can be up, down, virtual, physical or container-created.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 50: Route state

### Concept

The default route explains where unknown destinations go.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 51: DNS separation

### Concept

DNS failure is different from network failure.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 52: HTTP status

### Concept

HTTP status codes reveal application-level behavior.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 53: Port ownership

### Concept

A port belongs to a process or container.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 54: Docker bridge

### Concept

Docker bridge networks allow container communication.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 55: Namespaces

### Concept

Network namespaces isolate network stacks.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 56: Firewall interaction

### Concept

Firewall rules can change reachability.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 57: Packet capture caution

### Concept

Packet capture can expose sensitive traffic.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 58: Report clarity

### Concept

Network reports should explain the layer tested.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 59: macOS difference

### Concept

macOS may use ifconfig, netstat and lsof instead of ip and ss.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 60: Safe targets

### Concept

Use localhost or explicitly authorized lab targets.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 61: Layered diagnosis

### Concept

Start with local context, then interfaces, routes, DNS, ports and application response.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 62: Loopback safety

### Concept

Localhost is the safest target for labs.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 63: Binding address

### Concept

Listening on 127.0.0.1 is different from listening on 0.0.0.0.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 64: Interface state

### Concept

Interfaces can be up, down, virtual, physical or container-created.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 65: Route state

### Concept

The default route explains where unknown destinations go.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 66: DNS separation

### Concept

DNS failure is different from network failure.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 67: HTTP status

### Concept

HTTP status codes reveal application-level behavior.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 68: Port ownership

### Concept

A port belongs to a process or container.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.


## Networking study card 69: Docker bridge

### Concept

Docker bridge networks allow container communication.

### Practical check

```bash
hostname
ip addr
ip route
ss -tulpen
curl -i http://127.0.0.1:8080
```

These commands inspect host identity, interface addresses, routing, listening sockets and application response. On macOS, use `ifconfig`, `netstat` or `lsof -i -P -n` where Linux-specific commands are unavailable.

### Interpretation pattern

A good interpretation should identify the layer being tested and whether the result matches the expected local lab condition. For example, a service bound to `127.0.0.1` supports local-only exposure.

### Repository connection

This concept appears in local HTTP, ports/processes, DNS/routing, namespace, firewall, Docker, Prometheus, Grafana and capstone labs.

### Safety note

Do not test or scan systems without permission. Prefer localhost and repository-controlled services.
