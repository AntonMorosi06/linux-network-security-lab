# Lab 011 — Docker Compose API, Reverse Proxy and Local Logs

## Objective

The objective of this lab is to build a small local service stack using Docker Compose.

The stack contains:

```text
reverse_proxy -> api
```

The reverse proxy is an Nginx container. The API is a Python container. Both services run on a dedicated Docker bridge network created by Docker Compose.

This lab teaches:

- Docker Compose basics
- multi-container local stack
- service-to-service communication
- Nginx reverse proxy configuration
- local-only host port publishing
- container logs
- health endpoints
- request headers through a proxy
- service inspection
- controlled cleanup

## Safety boundary

This lab publishes the reverse proxy only on:

```text
127.0.0.1:8600
```

The API container is not directly published to the host. It is reachable only from the Compose network.

The lab is local and defensive. It does not scan external systems and does not expose a public service.

## Why Docker Compose?

Lab 010 used Docker commands manually:

```text
docker build
docker network create
docker run
docker inspect
docker logs
```

Lab 011 moves to a more professional workflow:

```text
compose.yaml
-> api service
-> reverse proxy service
-> dedicated network
-> one command up/down
```

This is closer to real local development, DevOps, monitoring and security lab workflows.

## Architecture

```text
Host
  |
  | http://127.0.0.1:8600
  v
reverse_proxy container
  |
  | http://api:8601
  v
api container
```

The host does not call the API container directly. The host calls Nginx, and Nginx forwards the request to the API service by Docker Compose service name:

```text
api
```

## Files

```text
docker/lab011/
  compose.yaml
  api/
    Dockerfile
    api_server.py
  nginx/
    nginx.conf
```

## Step 1 — Check requirements

```bash
./scripts/compose_lab011_check_requirements.sh
```

Expected output:

```text
[OK] docker command found
[OK] Docker daemon is reachable
[OK] docker compose is available
```

## Step 2 — Start the stack

```bash
./scripts/compose_lab011_up.sh
```

Expected output:

```text
[OK] Compose stack is running.
[INFO] Proxy URL: http://127.0.0.1:8600/status
```

## Step 3 — Test the stack

```bash
./scripts/compose_lab011_test.sh
```

Expected output example:

```json
{
  "service": "compose_lab011_api",
  "status": "ok",
  "served_by": "api",
  "port": 8601
}
```

The script also tests:

```text
/status
/health
/headers
/proxy-status
/unknown
```

## Step 4 — Inspect the stack

```bash
./scripts/compose_lab011_inspect.sh
```

This shows:

- Compose services
- running containers
- Docker networks
- container states
- port mapping
- network settings

## Step 5 — Read logs

```bash
./scripts/compose_lab011_logs.sh
```

Expected output includes logs from:

```text
api
reverse_proxy
```

## Step 6 — Stop and remove the stack

```bash
./scripts/compose_lab011_down.sh
```

Expected output:

```text
[OK] Compose stack stopped and removed.
```

## Manual command summary

Start:

```bash
docker compose -f docker/lab011/compose.yaml up -d --build
```

Test:

```bash
curl http://127.0.0.1:8600/status
curl http://127.0.0.1:8600/health
curl http://127.0.0.1:8600/headers
```

Logs:

```bash
docker compose -f docker/lab011/compose.yaml logs
```

Inspect:

```bash
docker compose -f docker/lab011/compose.yaml ps
docker network ls | grep lab011
docker inspect lab011_reverse_proxy
docker inspect lab011_api
```

Stop:

```bash
docker compose -f docker/lab011/compose.yaml down
```

## Reverse proxy behavior

Nginx listens inside the container on port `8600`.

The host maps:

```text
127.0.0.1:8600 -> reverse_proxy:8600
```

Nginx forwards traffic to:

```text
http://api:8601
```

The API sees proxy headers such as:

```text
X-Forwarded-For
X-Forwarded-Proto
X-Proxy-Lab
```

## Diagnostic interpretation

If the host cannot reach `127.0.0.1:8600`, check whether the reverse proxy container is running and whether the port is published.

If the reverse proxy is running but returns `502 Bad Gateway`, the API service may be down or unreachable.

If the API works but logs are missing, check container logs with Docker Compose.

If `api` cannot be resolved by Nginx, check the Compose network and service names.

## Common issues

### Docker Desktop not running

On macOS, open Docker Desktop and retry.

### Port 8600 already in use

Check:

```bash
lsof -i :8600 -P -n
```

Then stop the conflicting process or change the host port in `compose.yaml`.

### 502 Bad Gateway

Check API logs:

```bash
docker compose -f docker/lab011/compose.yaml logs api
```

### Compose command not found

Use a recent Docker installation with:

```bash
docker compose version
```

Old systems may use `docker-compose`, but this lab uses the modern `docker compose` plugin.

## Defensive value

Reverse proxies are common in real systems. They are used for:

- routing requests
- exposing only selected services
- adding headers
- centralizing access logs
- TLS termination
- authentication layers
- rate limiting
- service isolation

This lab prepares future work on:

- API gateways
- local monitoring
- Prometheus/Grafana
- secure dashboards
- MicroBot controller API
- telemetry gateways
- DevOps deployment patterns

## Final conclusion

This lab turns a single container into a small local stack.

The core chain is:

```text
Docker Compose
-> API container
-> Nginx reverse proxy
-> local-only port publishing
-> host tests
-> logs
-> inspect
-> cleanup
```

This is a strong step toward a professional local security and observability lab.
