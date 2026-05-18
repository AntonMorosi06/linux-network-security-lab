# Lab 010 — Docker Bridge Network and Container Diagnostics

## Objective

The objective of this lab is to build a local Docker networking experiment using a custom bridge network, a Python API container, and a diagnostic client container.

This lab teaches:

- Docker installation checks
- Docker image build
- Dockerfile basics
- custom bridge networks
- container-to-container communication
- host-to-container port publishing
- container DNS name resolution
- container logs
- container inspection
- network inspection
- cleanup of Docker resources

This lab is local and defensive. It does not scan external systems and does not attack services.

## Safety boundary

This lab creates local Docker resources:

```text
image:   linux-sec-lab010-api
network: lab010_bridge_net
server:  lab010_api_server
client:  lab010_api_client
```

The server container listens internally on:

```text
0.0.0.0:8500
```

The host maps it to:

```text
127.0.0.1:8500
```

The lab is safe because the service is published only on localhost.

## Why Docker after namespace labs?

In previous labs, Linux network namespaces were used directly. Docker uses Linux isolation primitives under the hood on Linux, but provides a higher-level workflow:

```text
image
-> container
-> network
-> port mapping
-> logs
-> inspect
-> cleanup
```

This is closer to how many real development, DevOps, monitoring and security labs are built.

## Topology

```text
Host machine
  |
  | localhost port mapping
  v
127.0.0.1:8500 -> lab010_api_server:8500

Docker bridge network: lab010_bridge_net

lab010_api_client ---> http://lab010_api_server:8500/status
```

The important idea is that the client container can reach the server container by name:

```text
lab010_api_server
```

That name is resolved by Docker's embedded network DNS inside the custom bridge network.

## Required tools

Check requirements:

```bash
./scripts/docker_lab010_check_requirements.sh
```

Expected output:

```text
[OK] docker command found
[OK] Docker daemon is reachable
```

If Docker is not running on macOS, open Docker Desktop and retry.

## Step 1 — Build the image

```bash
./scripts/docker_lab010_build_image.sh
```

Expected output:

```text
[OK] Docker image built: linux-sec-lab010-api
```

## Step 2 — Create the Docker network

```bash
./scripts/docker_lab010_create_network.sh
```

Expected output:

```text
[OK] Network ready: lab010_bridge_net
```

## Step 3 — Run the server container

```bash
./scripts/docker_lab010_run_server.sh
```

Expected output:

```text
[OK] Server container running: lab010_api_server
[INFO] Host URL: http://127.0.0.1:8500/status
```

## Step 4 — Test from host

```bash
./scripts/docker_lab010_test_from_host.sh
```

Expected output:

```json
{
  "service": "docker_lab010_api",
  "status": "ok",
  "context": "container",
  "port": 8500
}
```

## Step 5 — Test from another container

```bash
./scripts/docker_lab010_test_from_container.sh
```

Expected output:

```text
[CLIENT] Testing container DNS name: lab010_api_server
[CLIENT] HTTP status: 200
[CLIENT] Response body:
{
  "service": "docker_lab010_api",
  "status": "ok",
  "context": "container",
  "port": 8500
}
```

## Step 6 — Inspect Docker resources

```bash
./scripts/docker_lab010_inspect.sh
```

This shows:

- Docker version
- running containers
- lab network details
- server container details
- port mapping
- IP address inside Docker network

## Step 7 — Read logs

```bash
./scripts/docker_lab010_logs.sh
```

Expected output example:

```text
[API] Docker Lab 010 server listening on 0.0.0.0:8500
```

## Step 8 — Cleanup

```bash
./scripts/docker_lab010_cleanup.sh
```

Expected output:

```text
[OK] Removed container: lab010_api_server
[OK] Removed network: lab010_bridge_net
```

## Manual command summary

Build image:

```bash
docker build -t linux-sec-lab010-api docker/lab010
```

Create network:

```bash
docker network create lab010_bridge_net
```

Run server:

```bash
docker run -d \
  --name lab010_api_server \
  --network lab010_bridge_net \
  -p 127.0.0.1:8500:8500 \
  linux-sec-lab010-api
```

Test from host:

```bash
curl http://127.0.0.1:8500/status
```

Test from container:

```bash
docker run --rm \
  --name lab010_api_client \
  --network lab010_bridge_net \
  linux-sec-lab010-api \
  python3 /app/client_check.py http://lab010_api_server:8500/status
```

Inspect network:

```bash
docker network inspect lab010_bridge_net
```

Logs:

```bash
docker logs lab010_api_server
```

Cleanup:

```bash
docker rm -f lab010_api_server
docker network rm lab010_bridge_net
```

## Diagnostic interpretation

If the host can reach `127.0.0.1:8500`, the port mapping works.

If the client container can reach `http://lab010_api_server:8500/status`, the custom bridge network and Docker DNS are working.

If the host test works but the container test fails, inspect the Docker network.

If the container test works but the host test fails, inspect the port publishing.

## Common issues

### Docker daemon not running

On macOS, open Docker Desktop.

On Linux, check:

```bash
systemctl status docker
```

### Permission denied on Linux

Your user may not be in the `docker` group. Either use `sudo docker` or configure Docker permissions safely for your system.

### Port already allocated

If port `8500` is busy:

```bash
lsof -i :8500 -P -n
```

Stop the conflicting process or change the host port.

### Container name already exists

Clean up:

```bash
./scripts/docker_lab010_cleanup.sh
```

### Network already exists

The create script safely reuses the network if it already exists.

## Defensive value

Docker networking matters for defensive security and operations because real systems often run as services, containers and microservices.

This lab helps understand:

```text
service isolation
port exposure
container DNS
bridge networks
logs
inspect output
cleanup
local service diagnostics
```

It also prepares later labs on Docker Compose, reverse proxies, metrics, CI and deployable local security labs.

## Final conclusion

This lab introduces a local containerized network service and shows how to diagnose it from both host and container perspectives.

The core chain is:

```text
Dockerfile
-> image
-> bridge network
-> server container
-> host port mapping
-> client container test
-> logs and inspect
-> cleanup
```

This is a strong foundation for building a more professional local security lab and future MicroBot-style telemetry services.
