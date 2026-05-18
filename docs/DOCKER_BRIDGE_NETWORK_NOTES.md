# Docker Bridge Network Notes

## Docker image

A Docker image is a packaged filesystem and runtime definition used to create containers.

Build example:

```bash
docker build -t linux-sec-lab010-api docker/lab010
```

## Docker container

A container is a running instance of an image.

Run example:

```bash
docker run -d --name lab010_api_server linux-sec-lab010-api
```

## Docker bridge network

A bridge network allows containers connected to the same Docker network to communicate with each other.

Create example:

```bash
docker network create lab010_bridge_net
```

## Container DNS

On a custom bridge network, containers can resolve each other by container name.

Example:

```text
http://lab010_api_server:8500/status
```

This works from another container attached to the same Docker network.

## Port publishing

Port publishing maps a container port to a host port.

Safe local example:

```bash
-p 127.0.0.1:8500:8500
```

This means:

```text
host 127.0.0.1:8500 -> container port 8500
```

Binding to `127.0.0.1` is safer for local labs than binding to all interfaces.

## Inspect

Useful Docker inspection commands:

```bash
docker ps
docker image ls
docker network ls
docker network inspect lab010_bridge_net
docker inspect lab010_api_server
docker logs lab010_api_server
```

## Host-to-container vs container-to-container

Host-to-container test:

```bash
curl http://127.0.0.1:8500/status
```

Container-to-container test:

```bash
docker run --rm --network lab010_bridge_net linux-sec-lab010-api python3 /app/client_check.py http://lab010_api_server:8500/status
```

## Defensive value

Docker bridge networking is important for understanding:

- service isolation
- local service exposure
- port mapping
- container DNS
- logs
- microservice communication
- DevOps diagnostics
- safe local security labs

## Cleanup

Remove lab resources:

```bash
docker rm -f lab010_api_server
docker network rm lab010_bridge_net
```
