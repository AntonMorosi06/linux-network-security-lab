# Ports, Sockets and Connections

A port identifies a service endpoint on a machine. A socket is the combination of protocol, address and port.

## Useful commands

```bash
ss -tulpen
ss -tunap
lsof -i -P -n
curl -i http://127.0.0.1:8080
```

## Common ports

| Port | Common use |
|---:|---|
| 22 | SSH |
| 53 | DNS |
| 80 | HTTP |
| 443 | HTTPS |
| 3000 | development web apps |
| 8080 | local HTTP testing |
| 9090 | Prometheus |
| 3001 | Grafana lab port |

## Expected `ss` output

```text
Netid State  Local Address:Port  Process
tcp   LISTEN 127.0.0.1:8080      users:(("python3",pid=1234,fd=3))
```

## Interpretation

If a service listens on `127.0.0.1`, it is local-only. If it listens on `0.0.0.0`, it may be reachable from other interfaces depending on firewall and network settings.
