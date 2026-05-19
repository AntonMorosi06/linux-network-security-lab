# DNS, Routing and Connectivity

This file explains DNS, routing and connectivity in depth. It continues the networking section of the Linux User Manual and focuses on how a Linux system decides where traffic goes, how names become IP addresses, how to test reachability safely, and how to separate DNS failures from routing failures and application failures.

In real troubleshooting, many people jump immediately to the wrong conclusion. If a website or local service does not respond, the problem may be DNS, routing, firewall, service binding, port conflict, proxy behavior, container networking, application error, or simple wrong URL. This file teaches a layered diagnostic method.


## 1. Connectivity model

Connectivity should be diagnosed layer by layer: local host, interface, route, DNS, port, protocol and application. Skipping layers often causes confusion.


## 2. Local host check

Before testing remote systems, confirm local context with `hostname`, `uname -a`, `pwd` and repository state. This prevents debugging the wrong machine or wrong environment.


## 3. Interface check

The interface layer answers whether the system has network interfaces and addresses. On Linux, `ip addr` is the primary command.


## 4. Route check

Routing answers where packets go. `ip route` shows the routing table and default route. If there is no valid route, DNS may work but traffic may still fail.


## 5. Default route

The default route is used when no more specific route matches a destination. It usually points to a gateway such as a home router or container bridge.


## 6. Gateway

A gateway forwards traffic to another network. If the gateway is wrong or unreachable, external connectivity fails even if the interface has an IP address.


## 7. DNS concept

DNS converts names such as `example.com` into IP addresses. It does not itself guarantee that the destination is reachable.


## 8. Resolver

A resolver is the system component or configured server used to perform DNS lookups. Linux resolver configuration often involves `/etc/resolv.conf` or systemd-resolved.


## 9. /etc/resolv.conf

`/etc/resolv.conf` often shows DNS nameserver configuration. On modern systems it may be generated or managed by another service.


## 10. systemd-resolved

Some Linux systems use systemd-resolved for DNS resolution. Commands such as `resolvectl status` may show resolver state.


## 11. dig

`dig` is a detailed DNS query tool. It shows answers, query time and DNS server information. It is preferred for precise DNS diagnostics.


## 12. nslookup

`nslookup` is a common DNS query tool. It is easy to use and widely recognized, although `dig` is often more detailed.


## 13. ping by IP

Pinging an IP tests basic reachability without DNS. If ping by IP works but ping by name fails, DNS may be the issue.


## 14. ping by name

Pinging a name tests both DNS and ICMP reachability. If it fails, the failure could be DNS resolution or blocked ICMP.


## 15. ICMP limitation

Ping uses ICMP. Some systems block ICMP while still serving HTTP. A failed ping does not prove a web service is down.


## 16. curl as application test

`curl -i` tests HTTP-level behavior. It can show 200, 301, 401, 403, 404, 500 or other status codes.


## 17. Traceroute

`traceroute` shows path hops toward a destination. It can be useful, but some networks block or modify traceroute behavior.


## 18. Local service connectivity

For local labs, test `127.0.0.1:PORT` first. If localhost works but external access fails, binding or firewall may be involved.


## 19. Container connectivity

Docker containers may communicate through internal networks while host access depends on published ports. Compose networks are not the same as host interfaces.


## 20. DNS inside containers

Containers often have their own resolver behavior. Docker provides internal DNS for service names inside Compose networks.


## 21. Route inside namespaces

Network namespaces have their own interfaces and routes. A namespace can fail connectivity even when the host works.


## 22. Firewall interaction

Firewall rules can block or allow traffic after routing decisions. Connectivity diagnosis should consider firewall rules when listeners exist but traffic fails.


## 23. Proxy interaction

Reverse proxies can make connectivity appear successful while backend services fail. A proxy may return 502 or 504 when upstream services are unavailable.


## 24. HTTP redirects

HTTP 301 or 302 means connectivity worked and the application redirected the client. It is not a network failure.


## 25. HTTP 401 and 403

401 and 403 indicate application-level authorization or authentication issues. They are not DNS or routing failures.


## 26. HTTP 404

404 means the server responded but the path was not found. Network connectivity worked.


## 27. HTTP 500

500 indicates server-side application failure. DNS and routing may be fine.


## 28. Connectivity report

A good connectivity report states which layer was tested, which command was used, what output mattered and what conclusion follows.


## 29. Safe targets

Use localhost or explicitly authorized targets. Avoid aggressive testing of systems that are not yours.


## Command card 1: `ip addr`

### Purpose

Inspect network interfaces and IP addresses.

### Example

```bash
ip addr
```

### Expected output

```text
Interface list with addresses.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Safe Linux read-only command.


## Command card 2: `ip route`

### Purpose

Inspect routing table.

### Example

```bash
ip route
```

### Expected output

```text
Default route and network routes.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Safe Linux read-only command.


## Command card 3: `cat /etc/resolv.conf`

### Purpose

Inspect resolver configuration.

### Example

```bash
cat /etc/resolv.conf
```

### Expected output

```text
nameserver entries or managed config.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Safe but may reveal local config.


## Command card 4: `resolvectl status`

### Purpose

Inspect systemd-resolved DNS status.

### Example

```bash
resolvectl status
```

### Expected output

```text
Resolver links and DNS servers.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Linux/systemd-specific.


## Command card 5: `dig`

### Purpose

Query DNS records.

### Example

```bash
dig example.com
```

### Expected output

```text
DNS answer, server and timing.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Safe; use reasonable targets.


## Command card 6: `nslookup`

### Purpose

Resolve domain names.

### Example

```bash
nslookup example.com
```

### Expected output

```text
DNS server and resolved address.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Safe common diagnostic.


## Command card 7: `ping IP`

### Purpose

Test ICMP reachability by IP.

### Example

```bash
ping -c 4 127.0.0.1
```

### Expected output

```text
Replies and packet loss statistics.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Use authorized targets.


## Command card 8: `ping name`

### Purpose

Test DNS plus ICMP path.

### Example

```bash
ping -c 4 example.com
```

### Expected output

```text
DNS resolution then replies or failure.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Failure can mean DNS or ICMP issue.


## Command card 9: `curl -i`

### Purpose

Test HTTP-level connectivity.

### Example

```bash
curl -i http://127.0.0.1:8080/status
```

### Expected output

```text
HTTP status, headers and body.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Safe for local services.


## Command card 10: `traceroute`

### Purpose

Show path hops.

### Example

```bash
traceroute example.com
```

### Expected output

```text
Hop list.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Use responsibly.


## Command card 11: `ss -tulpen`

### Purpose

Check local listeners.

### Example

```bash
ss -tulpen
```

### Expected output

```text
Listening sockets.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Safe Linux read-only command.


## Command card 12: `lsof -i`

### Purpose

Check socket/process ownership.

### Example

```bash
lsof -i -P -n
```

### Expected output

```text
Processes and sockets.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Safe; macOS/Linux.


## Command card 13: `docker compose ps`

### Purpose

Check Compose service state and ports.

### Example

```bash
docker compose ps
```

### Expected output

```text
Services and published ports.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Safe Docker inspection.


## Command card 14: `docker network inspect`

### Purpose

Inspect Docker network metadata.

### Example

```bash
docker network inspect bridge
```

### Expected output

```text
JSON network details.
```

### Interpretation

This command helps isolate a connectivity layer. A strong interpretation should state whether the command tests interface state, routing, DNS resolution, ICMP reachability, HTTP application response, container networking or port exposure.

### Safety note

Safe but verbose.


## DNS, routing and connectivity reference tables

| Symptom | Likely layer | First command | Interpretation |
|---|---|---|---|
| IP works, name fails | DNS | `dig name` | resolver/name issue likely |
| name resolves, HTTP fails | app/port/firewall | `curl -i URL` | inspect status or connection error |
| localhost works, external fails | binding/firewall | `ss -tulpen` | check 127.0.0.1 vs 0.0.0.0 |
| container service works internally only | Docker publishing | `docker compose ps` | check host port mapping |
| ping fails, HTTP works | ICMP blocked | `curl -i URL` | not necessarily network down |
| 404 returned | application route | `curl -i URL` | server reachable, path missing |
| 401/403 returned | auth/access control | `curl -i URL` | network worked, access denied |
| 500 returned | application/server | logs | server error |

| Layer | Question | Command |
|---|---|---|
| Interface | Do I have addresses? | `ip addr` |
| Route | Where does traffic go? | `ip route` |
| DNS | Does name resolve? | `dig`, `nslookup` |
| ICMP | Does ping reply? | `ping` |
| Port | Is service listening? | `ss`, `lsof` |
| HTTP | Does app respond? | `curl -i` |
| Container | Is port published? | `docker compose ps` |


## DNS/routing/connectivity study card 1: Layered troubleshooting

### Concept

Do not jump directly to DNS or firewall; test layers in order.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 2: Interface first

### Concept

No address or down interface can break everything above it.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 3: Route second

### Concept

Without a route, packets do not know where to go.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 4: DNS third

### Concept

DNS turns names into addresses but does not prove reachability.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 5: Ping limitation

### Concept

Ping can fail because ICMP is blocked even if HTTP works.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 6: Curl value

### Concept

Curl tests the actual application protocol.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 7: HTTP status

### Concept

HTTP status codes distinguish network success from application behavior.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 8: Localhost testing

### Concept

Localhost is the safest first target for repository labs.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 9: Container DNS

### Concept

Compose service names may resolve inside Docker networks but not on the host.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 10: Namespace routes

### Concept

Namespaces have separate routes and interfaces.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 11: Firewall distinction

### Concept

A service can listen and still be blocked by firewall.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 12: Proxy distinction

### Concept

A proxy can be reachable while its upstream backend fails.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 13: DNS config

### Concept

Resolver config may be managed by system services.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 14: Safe targets

### Concept

Use owned or authorized systems only.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 15: Report clarity

### Concept

Write which layer each command tested.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 16: Layered troubleshooting

### Concept

Do not jump directly to DNS or firewall; test layers in order.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 17: Interface first

### Concept

No address or down interface can break everything above it.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 18: Route second

### Concept

Without a route, packets do not know where to go.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 19: DNS third

### Concept

DNS turns names into addresses but does not prove reachability.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 20: Ping limitation

### Concept

Ping can fail because ICMP is blocked even if HTTP works.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 21: Curl value

### Concept

Curl tests the actual application protocol.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 22: HTTP status

### Concept

HTTP status codes distinguish network success from application behavior.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 23: Localhost testing

### Concept

Localhost is the safest first target for repository labs.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 24: Container DNS

### Concept

Compose service names may resolve inside Docker networks but not on the host.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 25: Namespace routes

### Concept

Namespaces have separate routes and interfaces.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 26: Firewall distinction

### Concept

A service can listen and still be blocked by firewall.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 27: Proxy distinction

### Concept

A proxy can be reachable while its upstream backend fails.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 28: DNS config

### Concept

Resolver config may be managed by system services.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 29: Safe targets

### Concept

Use owned or authorized systems only.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 30: Report clarity

### Concept

Write which layer each command tested.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 31: Layered troubleshooting

### Concept

Do not jump directly to DNS or firewall; test layers in order.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 32: Interface first

### Concept

No address or down interface can break everything above it.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 33: Route second

### Concept

Without a route, packets do not know where to go.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 34: DNS third

### Concept

DNS turns names into addresses but does not prove reachability.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 35: Ping limitation

### Concept

Ping can fail because ICMP is blocked even if HTTP works.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 36: Curl value

### Concept

Curl tests the actual application protocol.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 37: HTTP status

### Concept

HTTP status codes distinguish network success from application behavior.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 38: Localhost testing

### Concept

Localhost is the safest first target for repository labs.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 39: Container DNS

### Concept

Compose service names may resolve inside Docker networks but not on the host.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 40: Namespace routes

### Concept

Namespaces have separate routes and interfaces.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 41: Firewall distinction

### Concept

A service can listen and still be blocked by firewall.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 42: Proxy distinction

### Concept

A proxy can be reachable while its upstream backend fails.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 43: DNS config

### Concept

Resolver config may be managed by system services.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 44: Safe targets

### Concept

Use owned or authorized systems only.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 45: Report clarity

### Concept

Write which layer each command tested.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 46: Layered troubleshooting

### Concept

Do not jump directly to DNS or firewall; test layers in order.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 47: Interface first

### Concept

No address or down interface can break everything above it.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 48: Route second

### Concept

Without a route, packets do not know where to go.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 49: DNS third

### Concept

DNS turns names into addresses but does not prove reachability.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 50: Ping limitation

### Concept

Ping can fail because ICMP is blocked even if HTTP works.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 51: Curl value

### Concept

Curl tests the actual application protocol.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 52: HTTP status

### Concept

HTTP status codes distinguish network success from application behavior.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 53: Localhost testing

### Concept

Localhost is the safest first target for repository labs.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 54: Container DNS

### Concept

Compose service names may resolve inside Docker networks but not on the host.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 55: Namespace routes

### Concept

Namespaces have separate routes and interfaces.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 56: Firewall distinction

### Concept

A service can listen and still be blocked by firewall.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 57: Proxy distinction

### Concept

A proxy can be reachable while its upstream backend fails.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 58: DNS config

### Concept

Resolver config may be managed by system services.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 59: Safe targets

### Concept

Use owned or authorized systems only.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 60: Report clarity

### Concept

Write which layer each command tested.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 61: Layered troubleshooting

### Concept

Do not jump directly to DNS or firewall; test layers in order.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 62: Interface first

### Concept

No address or down interface can break everything above it.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 63: Route second

### Concept

Without a route, packets do not know where to go.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 64: DNS third

### Concept

DNS turns names into addresses but does not prove reachability.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 65: Ping limitation

### Concept

Ping can fail because ICMP is blocked even if HTTP works.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 66: Curl value

### Concept

Curl tests the actual application protocol.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 67: HTTP status

### Concept

HTTP status codes distinguish network success from application behavior.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 68: Localhost testing

### Concept

Localhost is the safest first target for repository labs.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.


## DNS/routing/connectivity study card 69: Container DNS

### Concept

Compose service names may resolve inside Docker networks but not on the host.

### Practical check

```bash
ip addr
ip route
dig example.com
curl -i http://127.0.0.1:8080
```

These commands test interface state, route state, DNS behavior and HTTP response. In local labs, replace external domains with localhost endpoints whenever possible.

### Interpretation pattern

A good interpretation should identify the tested layer and the conclusion. For example: DNS resolution succeeded, but HTTP returned 404, so the network path worked and the application route was missing.

### Repository connection

This concept appears in DNS/routing labs, local HTTP labs, API security labs, Docker Compose labs, monitoring labs and incident response analysis.

### Safety note

Connectivity testing should stay local or explicitly authorized. Avoid aggressive or repeated testing of systems you do not own.
