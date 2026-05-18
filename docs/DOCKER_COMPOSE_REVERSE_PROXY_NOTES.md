# Docker Compose Reverse Proxy Notes

## Docker Compose

Docker Compose describes multi-container applications in a YAML file.

In this lab:

```text
docker/lab011/compose.yaml
```

defines two services:

```text
api
reverse_proxy
```

## Service name DNS

In a Compose network, services can reach each other by service name.

Nginx can proxy to:

```text
http://api:8601
```

because `api` is the Compose service name.

## Reverse proxy

A reverse proxy receives client requests and forwards them to a backend service.

In this lab:

```text
host -> reverse_proxy -> api
```

## Why not publish the API directly?

The API container uses `expose`, not `ports`.

This means the API is available to other containers on the Compose network but is not published directly to the host.

Only the reverse proxy is published to the host:

```yaml
ports:
  - "127.0.0.1:8600:8600"
```

## Local-only publishing

Binding to `127.0.0.1` makes the proxy reachable only from the local machine.

This is safer than:

```text
0.0.0.0:8600:8600
```

which would listen on all interfaces.

## Proxy headers

The reverse proxy adds or forwards headers:

```text
Host
X-Real-IP
X-Forwarded-For
X-Forwarded-Proto
X-Proxy-Lab
```

The API can read these headers to understand that the request passed through a proxy.

## Logs

Compose logs show both services:

```bash
docker compose -f docker/lab011/compose.yaml logs
```

This is useful for diagnosing:

- API startup
- Nginx startup
- proxy requests
- 404 responses
- 502 gateway errors

## Common diagnostic logic

If host request fails:

```text
check reverse proxy container
check port publishing
check Docker Desktop / daemon
```

If reverse proxy returns 502:

```text
check API container
check service name api
check Compose network
check Nginx upstream config
```

If API works but headers are missing:

```text
check nginx.conf proxy_set_header lines
```

## Defensive value

Reverse proxy patterns are important for:

- API gateway design
- service isolation
- secure dashboards
- access logging
- TLS termination
- request routing
- monitoring
- MicroBot controller architecture
