# Docker and Containers

Docker packages applications into containers. Containers isolate processes and filesystem layers, but they are not magic security boundaries.

## Basic commands

```bash
docker --version
docker ps
docker image ls
docker logs container_name
docker inspect container_name
docker network ls
docker compose up -d
docker compose down
```

## Local-only port publishing

Prefer:

```text
127.0.0.1:PORT:PORT
```

Example:

```bash
docker run -p 127.0.0.1:8500:8500 image_name
```

This binds the service to localhost only.

## Repository connection

Docker appears in:

```text
Lab 010
Lab 011
Lab 012
Lab 015
Lab 017
```

## Safety

Review published ports and stop containers after testing.
