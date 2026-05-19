# Ports, Sockets and Connections

This file explains Linux ports, sockets and connections in depth. It builds directly on the networking basics file and focuses on the practical question that appears constantly in local labs: which service is listening, on which address, on which port, through which protocol, and which process owns it.

Understanding ports and sockets is essential for debugging local APIs, Docker Compose stacks, reverse proxies, Prometheus, Grafana, incident response evidence and hardening reviews. A service can be running but unreachable. A port can be busy because an old process is still active. A service can be safe when bound to `127.0.0.1` but more exposed when bound to `0.0.0.0`. This file teaches how to reason about those cases.


## 1. What a port is

A port is a numeric endpoint used by transport protocols to deliver traffic to the correct application on a host. An IP address identifies the host or interface, while the port identifies the service endpoint.


## 2. Port ranges

Ports range from 0 to 65535. Well-known ports are traditionally 0-1023, registered ports are 1024-49151, and dynamic or ephemeral ports are 49152-65535. The exact ephemeral range can vary.


## 3. Well-known ports

Common examples include 22 for SSH, 53 for DNS, 80 for HTTP, 443 for HTTPS, 5432 for PostgreSQL, 6379 for Redis, 9090 for Prometheus and 3000 or 3001 for development dashboards.


## 4. Local development ports

Development tools often use ports such as 3000, 5000, 8000, 8080, 8500, 8800, 9090 and 9095. These ports are not automatically safe; safety depends on binding address and firewall.


## 5. Socket definition

A socket combines protocol, local address, local port, remote address, remote port and state. For a listening service, the remote side may be wildcarded because the service is waiting for incoming connections.


## 6. Listening socket

A listening socket is waiting for incoming connections. In `ss` output, TCP listeners usually appear with state `LISTEN`. A local API must have a listening socket before curl can reach it.


## 7. Established connection

An established connection represents active communication between two endpoints. TCP connections can have states such as ESTABLISHED, TIME-WAIT, SYN-SENT or LISTEN.


## 8. TCP socket

TCP is connection-oriented and reliable. It is used by HTTP, HTTPS, SSH, many APIs, databases and reverse proxies. TCP states are useful for debugging connection behavior.


## 9. UDP socket

UDP is connectionless. It is used by DNS, telemetry and some streaming protocols. UDP does not have TCP-style connection states.


## 10. Binding address

A service binds to an address and port. Binding to `127.0.0.1` means local-only for IPv4 loopback. Binding to `0.0.0.0` means all IPv4 interfaces.


## 11. 127.0.0.1 binding

A listener on `127.0.0.1:PORT` is normally reachable only from the same machine. This is preferred for local labs and defensive learning environments.


## 12. 0.0.0.0 binding

A listener on `0.0.0.0:PORT` may be reachable through external interfaces depending on network and firewall. It should be reviewed carefully.


## 13. IPv6 listeners

IPv6 loopback is `::1`. Some services listen on IPv6 wildcard addresses such as `::`. This can create exposure that is missed if only IPv4 is checked.


## 14. Port conflict

A port conflict occurs when a process tries to bind to a port already in use. The fix is to stop the old process or change the port.


## 15. Process ownership

A listening port is owned by a process. Tools such as `ss -tulpen` and `lsof -i -P -n` help connect port to PID, process name and user.


## 16. ss command

`ss` is the modern Linux socket inspection command. `ss -tulpen` shows TCP/UDP listeners, numeric ports, process information and extended details.


## 17. lsof command

`lsof -i -P -n` lists open network files and is useful on macOS and Linux. It is often the best fallback when `ss` is unavailable.


## 18. netstat command

`netstat` is older but still common in some environments. It can show listeners and connections, although `ss` is generally preferred on modern Linux.


## 19. curl and ports

`curl` tests application-layer behavior. A port can be listening but still return 404, 401 or 500 depending on the application.


## 20. HTTP status and port diagnosis

A successful TCP connection does not guarantee application success. HTTP status codes explain application behavior after the network connection works.


## 21. Docker port publishing

Docker can map container ports to host ports. A mapping like `127.0.0.1:8800:8800` is local-only. A mapping like `0.0.0.0:8800:8800` is broader.


## 22. Docker Compose ports

Compose files define published ports. Reviewing Compose YAML is part of exposure review because it shows how services become reachable.


## 23. Reverse proxy

A reverse proxy listens on one port and forwards traffic to another service. In labs, Nginx may listen locally and proxy to an internal API container.


## 24. Prometheus and Grafana ports

Prometheus often uses 9090 internally; local labs may publish it as 9095 or 9096. Grafana often uses 3000 internally and may be published as 3001.


## 25. Metrics endpoints

A metrics endpoint is usually accessed over HTTP on a port. It may reveal operational information and should be protected or local-only when appropriate.


## 26. Firewall relation

A service can listen on a port but still be unreachable because of firewall rules. Port inspection and firewall inspection answer different questions.


## 27. TIME_WAIT

TIME_WAIT is a normal TCP state after connection close. Many TIME_WAIT entries do not necessarily mean a service is broken.


## 28. Ephemeral ports

Clients often use temporary high-numbered ports when connecting to services. These ephemeral ports appear in connection lists and should not be confused with server listeners.


## 29. Safe exposure review

A safe exposure review asks: what is listening, where is it bound, which process owns it, which user runs it, is it expected, and is it local-only.


## 30. Incident response relevance

Unexpected listeners can be important evidence. A report should include address, port, protocol, PID, process name, user and interpretation.


## Command card 1: `ss -tulpen`

### Purpose

Show listening TCP/UDP sockets with process information.

### Example

```bash
ss -tulpen
```

### Expected output

```text
Netid, state, local address, port and process.
```

### Interpretation

This command helps connect network exposure to processes, containers or application behavior. A strong interpretation should state protocol, address, port, process/PID when available, and whether the listener is expected and local-only.

### Safety note

Safe read-only Linux command.


## Command card 2: `ss -tunap`

### Purpose

Show TCP/UDP sockets including active connections.

### Example

```bash
ss -tunap
```

### Expected output

```text
Listening and established sockets.
```

### Interpretation

This command helps connect network exposure to processes, containers or application behavior. A strong interpretation should state protocol, address, port, process/PID when available, and whether the listener is expected and local-only.

### Safety note

Safe but may require privileges for process info.


## Command card 3: `lsof -i -P -n`

### Purpose

Show processes using network sockets.

### Example

```bash
lsof -i -P -n
```

### Expected output

```text
Command, PID, user, address and port.
```

### Interpretation

This command helps connect network exposure to processes, containers or application behavior. A strong interpretation should state protocol, address, port, process/PID when available, and whether the listener is expected and local-only.

### Safety note

Safe and useful on macOS/Linux.


## Command card 4: `lsof -i :PORT -P -n`

### Purpose

Find process using a specific port.

### Example

```bash
lsof -i :8080 -P -n
```

### Expected output

```text
Process using port 8080.
```

### Interpretation

This command helps connect network exposure to processes, containers or application behavior. A strong interpretation should state protocol, address, port, process/PID when available, and whether the listener is expected and local-only.

### Safety note

Safe and useful for port conflicts.


## Command card 5: `netstat -an`

### Purpose

Show network sockets using legacy tool.

### Example

```bash
netstat -an
```

### Expected output

```text
Listeners and connections.
```

### Interpretation

This command helps connect network exposure to processes, containers or application behavior. A strong interpretation should state protocol, address, port, process/PID when available, and whether the listener is expected and local-only.

### Safety note

Safe but older output format.


## Command card 6: `curl -i`

### Purpose

Test HTTP service on a port.

### Example

```bash
curl -i http://127.0.0.1:8080
```

### Expected output

```text
HTTP status, headers and body.
```

### Interpretation

This command helps connect network exposure to processes, containers or application behavior. A strong interpretation should state protocol, address, port, process/PID when available, and whether the listener is expected and local-only.

### Safety note

Safe for local/authorized services.


## Command card 7: `docker ps`

### Purpose

Show container port publishing.

### Example

```bash
docker ps
```

### Expected output

```text
PORTS column with mappings.
```

### Interpretation

This command helps connect network exposure to processes, containers or application behavior. A strong interpretation should state protocol, address, port, process/PID when available, and whether the listener is expected and local-only.

### Safety note

Safe Docker inspection.


## Command card 8: `docker compose ps`

### Purpose

Show Compose service ports.

### Example

```bash
docker compose ps
```

### Expected output

```text
Service state and published ports.
```

### Interpretation

This command helps connect network exposure to processes, containers or application behavior. A strong interpretation should state protocol, address, port, process/PID when available, and whether the listener is expected and local-only.

### Safety note

Safe Compose inspection.


## Command card 9: `docker inspect`

### Purpose

Inspect detailed container networking.

### Example

```bash
docker inspect container
```

### Expected output

```text
JSON metadata.
```

### Interpretation

This command helps connect network exposure to processes, containers or application behavior. A strong interpretation should state protocol, address, port, process/PID when available, and whether the listener is expected and local-only.

### Safety note

Safe but may reveal environment values.


## Command card 10: `grep port in compose`

### Purpose

Search Compose files for port definitions.

### Example

```bash
grep -R "ports:" docker/
```

### Expected output

```text
Matching YAML lines.
```

### Interpretation

This command helps connect network exposure to processes, containers or application behavior. A strong interpretation should state protocol, address, port, process/PID when available, and whether the listener is expected and local-only.

### Safety note

Safe repository inspection.


## Command card 11: `kill PID`

### Purpose

Stop process after confirming port ownership.

### Example

```bash
kill 12345
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command helps connect network exposure to processes, containers or application behavior. A strong interpretation should state protocol, address, port, process/PID when available, and whether the listener is expected and local-only.

### Safety note

Medium risk; confirm PID.


## Ports, sockets and exposure reference tables

| Binding | Meaning | Security interpretation |
|---|---|---|
| `127.0.0.1:PORT` | IPv4 loopback only | preferred for local labs |
| `localhost:PORT` | local name, often loopback | usually local, verify resolution |
| `0.0.0.0:PORT` | all IPv4 interfaces | review exposure carefully |
| `::1:PORT` | IPv6 loopback | local IPv6 |
| `:::PORT` or `[::]:PORT` | all IPv6 interfaces | review exposure carefully |

| Port | Common service |
|---:|---|
| 22 | SSH |
| 53 | DNS |
| 80 | HTTP |
| 443 | HTTPS |
| 3000 | Grafana/development apps |
| 3001 | local Grafana lab mapping |
| 8080 | local HTTP development |
| 8800 | capstone local proxy in this repo |
| 9090 | Prometheus internal/default |
| 9095/9096 | local Prometheus lab mappings |


## Ports and sockets study card 1: Listener identification

### Concept

A listener is a service waiting for incoming connections.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 2: Binding review

### Concept

Binding address determines whether a service is local-only or broadly exposed.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 3: Process mapping

### Concept

Every listener should map to an expected process or container.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 4: Port conflict

### Concept

A busy port usually means a previous process is still running.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 5: Docker port mapping

### Concept

Docker host mappings can expose container services.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 6: Reverse proxy path

### Concept

A proxy listener may forward to an internal service port.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 7: HTTP status

### Concept

HTTP status explains application behavior after connection.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 8: TCP state

### Concept

TCP states help diagnose connection lifecycle.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 9: UDP difference

### Concept

UDP does not have TCP-style connection state.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 10: Ephemeral client port

### Concept

Client-side high ports are normal and temporary.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 11: IPv6 review

### Concept

IPv6 listeners can be missed if only IPv4 is checked.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 12: Firewall distinction

### Concept

Listening does not guarantee reachability through firewall.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 13: Prometheus port

### Concept

Metrics systems often expose HTTP endpoints.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 14: Grafana port

### Concept

Dashboards often run on development-style ports.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 15: IR evidence

### Concept

Unexpected listeners should be documented in incident response.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 16: Listener identification

### Concept

A listener is a service waiting for incoming connections.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 17: Binding review

### Concept

Binding address determines whether a service is local-only or broadly exposed.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 18: Process mapping

### Concept

Every listener should map to an expected process or container.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 19: Port conflict

### Concept

A busy port usually means a previous process is still running.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 20: Docker port mapping

### Concept

Docker host mappings can expose container services.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 21: Reverse proxy path

### Concept

A proxy listener may forward to an internal service port.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 22: HTTP status

### Concept

HTTP status explains application behavior after connection.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 23: TCP state

### Concept

TCP states help diagnose connection lifecycle.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 24: UDP difference

### Concept

UDP does not have TCP-style connection state.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 25: Ephemeral client port

### Concept

Client-side high ports are normal and temporary.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 26: IPv6 review

### Concept

IPv6 listeners can be missed if only IPv4 is checked.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 27: Firewall distinction

### Concept

Listening does not guarantee reachability through firewall.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 28: Prometheus port

### Concept

Metrics systems often expose HTTP endpoints.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 29: Grafana port

### Concept

Dashboards often run on development-style ports.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 30: IR evidence

### Concept

Unexpected listeners should be documented in incident response.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 31: Listener identification

### Concept

A listener is a service waiting for incoming connections.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 32: Binding review

### Concept

Binding address determines whether a service is local-only or broadly exposed.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 33: Process mapping

### Concept

Every listener should map to an expected process or container.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 34: Port conflict

### Concept

A busy port usually means a previous process is still running.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 35: Docker port mapping

### Concept

Docker host mappings can expose container services.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 36: Reverse proxy path

### Concept

A proxy listener may forward to an internal service port.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 37: HTTP status

### Concept

HTTP status explains application behavior after connection.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 38: TCP state

### Concept

TCP states help diagnose connection lifecycle.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 39: UDP difference

### Concept

UDP does not have TCP-style connection state.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 40: Ephemeral client port

### Concept

Client-side high ports are normal and temporary.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 41: IPv6 review

### Concept

IPv6 listeners can be missed if only IPv4 is checked.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 42: Firewall distinction

### Concept

Listening does not guarantee reachability through firewall.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 43: Prometheus port

### Concept

Metrics systems often expose HTTP endpoints.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 44: Grafana port

### Concept

Dashboards often run on development-style ports.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 45: IR evidence

### Concept

Unexpected listeners should be documented in incident response.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 46: Listener identification

### Concept

A listener is a service waiting for incoming connections.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 47: Binding review

### Concept

Binding address determines whether a service is local-only or broadly exposed.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 48: Process mapping

### Concept

Every listener should map to an expected process or container.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 49: Port conflict

### Concept

A busy port usually means a previous process is still running.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 50: Docker port mapping

### Concept

Docker host mappings can expose container services.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 51: Reverse proxy path

### Concept

A proxy listener may forward to an internal service port.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 52: HTTP status

### Concept

HTTP status explains application behavior after connection.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 53: TCP state

### Concept

TCP states help diagnose connection lifecycle.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 54: UDP difference

### Concept

UDP does not have TCP-style connection state.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 55: Ephemeral client port

### Concept

Client-side high ports are normal and temporary.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 56: IPv6 review

### Concept

IPv6 listeners can be missed if only IPv4 is checked.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 57: Firewall distinction

### Concept

Listening does not guarantee reachability through firewall.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 58: Prometheus port

### Concept

Metrics systems often expose HTTP endpoints.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 59: Grafana port

### Concept

Dashboards often run on development-style ports.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 60: IR evidence

### Concept

Unexpected listeners should be documented in incident response.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 61: Listener identification

### Concept

A listener is a service waiting for incoming connections.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 62: Binding review

### Concept

Binding address determines whether a service is local-only or broadly exposed.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 63: Process mapping

### Concept

Every listener should map to an expected process or container.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 64: Port conflict

### Concept

A busy port usually means a previous process is still running.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 65: Docker port mapping

### Concept

Docker host mappings can expose container services.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 66: Reverse proxy path

### Concept

A proxy listener may forward to an internal service port.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 67: HTTP status

### Concept

HTTP status explains application behavior after connection.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 68: TCP state

### Concept

TCP states help diagnose connection lifecycle.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.


## Ports and sockets study card 69: UDP difference

### Concept

UDP does not have TCP-style connection state.

### Practical check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
docker ps
```

These commands inspect listeners, process ownership, application behavior and Docker port publishing. On macOS, `lsof` is often the most useful port inspection command.

### Interpretation pattern

A good interpretation should answer: what is listening, on which address, on which port, owned by which process, and whether this is expected for the lab.

### Repository connection

This concept appears in local HTTP labs, API security labs, Docker Compose labs, Prometheus/Grafana labs, capstone service, hardening review and incident response evidence.

### Safety note

Inspecting ports is safe. Stopping processes or changing service bindings is state-changing and should be done only after confirming the target.
