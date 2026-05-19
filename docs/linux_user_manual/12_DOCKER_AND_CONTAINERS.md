# Docker and Containers

This file explains Docker and containers in depth for the Linux User Manual. Docker is central to the Linux Network Security Lab because several labs use containerized APIs, reverse proxies, Prometheus, Grafana and local service stacks. Containers make lab environments more reproducible, but they also introduce networking, filesystem, logging and security concepts that must be understood carefully.

The purpose of this file is to explain containers as practical runtime units: what images are, what containers are, how Docker networks work, how port publishing works, how logs are collected, how Compose manages multi-service stacks, and how to review Docker labs safely before publishing or presenting the repository.


## 1. Container concept

A container is a process or group of processes running with isolation features provided by the operating system. It is not the same as a full virtual machine, but it can package an application and its dependencies in a reproducible environment.


## 2. Image concept

An image is a filesystem template used to create containers. Images are built from Dockerfiles or pulled from registries. A container is a running instance of an image.


## 3. Dockerfile

A Dockerfile defines how an image is built. It may specify a base image, installed packages, copied files, environment variables, exposed ports and the command to run.


## 4. Container runtime

Docker starts containers by creating isolated processes with filesystem layers, namespaces, cgroups and network configuration. The exact implementation details vary, but the operational model is consistent for lab work.


## 5. Containers versus virtual machines

A virtual machine runs a full guest operating system with its own kernel. A container usually shares the host kernel but isolates user-space processes. Containers are lighter but not a perfect security boundary.


## 6. Docker Desktop

On macOS, Docker is commonly used through Docker Desktop. Docker Desktop runs a Linux environment behind the scenes, because Linux containers require Linux kernel features.


## 7. docker ps

`docker ps` lists running containers. The PORTS column is critical because it shows host-to-container port mappings.


## 8. docker image ls

`docker image ls` shows locally available images. Images can consume disk space and should be reviewed if the system becomes large.


## 9. docker logs

`docker logs` prints stdout and stderr from a container. It is often the first diagnostic command when a containerized API or service fails.


## 10. docker inspect

`docker inspect` shows detailed JSON metadata. It can reveal networks, mounts, environment variables and port bindings. Review before sharing.


## 11. Docker networks

Docker networks allow containers to communicate. The default bridge network is common, while Compose usually creates project-specific networks.


## 12. Bridge network

A bridge network connects containers to each other and optionally to the host through published ports. Internal container communication may not require host port exposure.


## 13. Port publishing

Port publishing maps a host address and port to a container port. For local labs, prefer mappings such as `127.0.0.1:8800:8800` rather than broad bindings.


## 14. Container port versus host port

The container port exists inside the container network namespace. The host port is what the host machine exposes. They can be the same or different.


## 15. Local-only Docker binding

A Docker mapping with `127.0.0.1:PORT:PORT` restricts host access to loopback. This is safer for local labs than binding to all interfaces.


## 16. 0.0.0.0 Docker binding

A Docker mapping without an explicit host address may bind broadly depending on Docker and platform behavior. Review exposure carefully.


## 17. Volumes

Volumes and bind mounts connect host storage to containers. They are useful for persistence and development, but can expose host files to container processes.


## 18. Bind mounts

A bind mount maps a specific host path into a container. It should be reviewed carefully because the container can access that path according to mount mode.


## 19. Environment variables

Containers often receive configuration through environment variables. These can contain secrets and may appear in inspect output.


## 20. Docker Compose

Docker Compose defines multi-service stacks in YAML. It is useful for local labs with API, proxy, Prometheus, Grafana and other services.


## 21. Compose services

A Compose service defines image/build, command, ports, networks, volumes, environment and dependencies for one service.


## 22. Compose up

`docker compose up -d` starts services in detached mode. It may build images, create networks and start containers.


## 23. Compose down

`docker compose down` stops and removes the Compose stack's containers and networks. It is the standard cleanup command.


## 24. Compose logs

`docker compose logs` aggregates logs across services, which is useful for multi-service debugging.


## 25. Compose ps

`docker compose ps` shows service state and published ports. It is a safe first check after startup.


## 26. Health checks

Some containers define health checks. Health status helps distinguish running containers from healthy services.


## 27. Reverse proxy in Docker

A reverse proxy container can receive host traffic and forward it to an internal API service. This pattern appears in local service stacks.


## 28. Prometheus in Docker

Prometheus can run as a container and scrape metrics endpoints. Its configuration must point to reachable targets.


## 29. Grafana in Docker

Grafana can run as a container and load provisioned dashboards and datasources. Logs help diagnose provisioning errors.


## 30. Docker logs and evidence

Container logs are useful evidence but can contain sensitive information. Review logs before committing or publishing.


## 31. Docker security boundary

Containers are not a complete security boundary. Docker access itself can be powerful. Treat Docker control as security-relevant.


## 32. Image trust

Images should come from trusted sources or be built from known Dockerfiles. Pulling random images introduces supply-chain risk.


## 33. Cleanup

After testing, stop stacks with `docker compose down`. This reduces leftover listeners, resource use and confusion.


## 34. Disk usage

Images, containers, volumes and build cache can consume disk. Use Docker disk commands carefully and avoid destructive prune commands unless intended.


## 35. Repository connection

This repository uses Docker in labs related to bridge networks, Compose, Prometheus, Grafana, capstone services and monitoring.


## Command card 1: `docker --version`

### Purpose

Check Docker client version.

### Example

```bash
docker --version
```

### Expected output

```text
Docker version string.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Safe availability check.


## Command card 2: `docker info`

### Purpose

Show Docker daemon information.

### Example

```bash
docker info
```

### Expected output

```text
Docker system details.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Safe but may reveal local details.


## Command card 3: `docker ps`

### Purpose

List running containers.

### Example

```bash
docker ps
```

### Expected output

```text
Container ID, image, status, ports, names.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Safe first diagnostic.


## Command card 4: `docker ps -a`

### Purpose

List all containers, including stopped.

### Example

```bash
docker ps -a
```

### Expected output

```text
All containers.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Safe diagnostic.


## Command card 5: `docker image ls`

### Purpose

List local images.

### Example

```bash
docker image ls
```

### Expected output

```text
Image names, tags, IDs, sizes.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Safe diagnostic.


## Command card 6: `docker logs`

### Purpose

Read container logs.

### Example

```bash
docker logs container
```

### Expected output

```text
Container stdout/stderr.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Review before sharing.


## Command card 7: `docker inspect`

### Purpose

Inspect container/image metadata.

### Example

```bash
docker inspect container
```

### Expected output

```text
JSON metadata.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

May reveal environment values.


## Command card 8: `docker network ls`

### Purpose

List Docker networks.

### Example

```bash
docker network ls
```

### Expected output

```text
Network IDs, names, drivers.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Safe diagnostic.


## Command card 9: `docker network inspect`

### Purpose

Inspect a Docker network.

### Example

```bash
docker network inspect bridge
```

### Expected output

```text
JSON network metadata.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Safe but verbose.


## Command card 10: `docker volume ls`

### Purpose

List Docker volumes.

### Example

```bash
docker volume ls
```

### Expected output

```text
Volume names.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Safe diagnostic.


## Command card 11: `docker compose up -d`

### Purpose

Start Compose stack detached.

### Example

```bash
docker compose up -d
```

### Expected output

```text
Build/start output.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

State-changing.


## Command card 12: `docker compose down`

### Purpose

Stop and remove stack resources.

### Example

```bash
docker compose down
```

### Expected output

```text
Removal output.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

State-changing cleanup.


## Command card 13: `docker compose ps`

### Purpose

Show Compose service state.

### Example

```bash
docker compose ps
```

### Expected output

```text
Service state and ports.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Safe diagnostic.


## Command card 14: `docker compose logs`

### Purpose

Show Compose service logs.

### Example

```bash
docker compose logs
```

### Expected output

```text
Aggregated logs.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Review before sharing.


## Command card 15: `docker compose config`

### Purpose

Render/validate Compose config.

### Example

```bash
docker compose config
```

### Expected output

```text
Expanded Compose YAML.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Safe validation.


## Command card 16: `curl local Docker service`

### Purpose

Test published service.

### Example

```bash
curl -i http://127.0.0.1:8800/status
```

### Expected output

```text
HTTP response.
```

### Interpretation

This command helps inspect Docker runtime state, images, containers, networks, logs, port mappings or Compose configuration. A strong interpretation should state which service or container was checked, whether it was expected, and whether exposure is local-only.

### Safety note

Safe for local service.


## Docker and containers reference tables

| Docker concept | Meaning |
|---|---|
| Image | template used to create containers |
| Container | running instance of an image |
| Dockerfile | build instructions for an image |
| Compose file | multi-service stack definition |
| Network | communication layer for containers |
| Volume | persistent Docker-managed storage |
| Bind mount | host path mounted into a container |
| Published port | host port mapped to container port |
| Health check | command that reports service health |

| Review question | Command |
|---|---|
| Is Docker available? | `docker --version`, `docker info` |
| What containers run? | `docker ps` |
| What ports are published? | `docker ps`, `docker compose ps` |
| What logs exist? | `docker logs`, `docker compose logs` |
| What networks exist? | `docker network ls` |
| Is Compose config valid? | `docker compose config` |
| Is service reachable? | `curl -i http://127.0.0.1:PORT` |


## Docker and containers study card 1: Image versus container

### Concept

An image is the template; a container is the running instance.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 2: Port mapping

### Concept

Docker host port mappings define external reachability.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 3: Local binding

### Concept

Use 127.0.0.1 host bindings for local labs.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 4: Compose stack

### Concept

Compose manages multiple related services.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 5: Container logs

### Concept

Logs reveal service startup and runtime errors.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 6: Inspect caution

### Concept

docker inspect may reveal environment variables.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 7: Network review

### Concept

Docker networks explain container communication.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 8: Volume review

### Concept

Volumes and bind mounts can expose host files.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 9: Cleanup

### Concept

docker compose down reduces leftover services.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 10: Docker Desktop

### Concept

On macOS Docker Desktop provides Linux container runtime support.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 11: Image trust

### Concept

Only use images from trusted or reviewed sources.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 12: Health check

### Concept

Running does not always mean healthy.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 13: Prometheus container

### Concept

Prometheus needs reachable scrape targets.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 14: Grafana container

### Concept

Grafana provisioning errors appear in logs.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 15: Security boundary

### Concept

Containers are isolation tools, not perfect security boundaries.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 16: Image versus container

### Concept

An image is the template; a container is the running instance.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 17: Port mapping

### Concept

Docker host port mappings define external reachability.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 18: Local binding

### Concept

Use 127.0.0.1 host bindings for local labs.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 19: Compose stack

### Concept

Compose manages multiple related services.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 20: Container logs

### Concept

Logs reveal service startup and runtime errors.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 21: Inspect caution

### Concept

docker inspect may reveal environment variables.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 22: Network review

### Concept

Docker networks explain container communication.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 23: Volume review

### Concept

Volumes and bind mounts can expose host files.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 24: Cleanup

### Concept

docker compose down reduces leftover services.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 25: Docker Desktop

### Concept

On macOS Docker Desktop provides Linux container runtime support.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 26: Image trust

### Concept

Only use images from trusted or reviewed sources.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 27: Health check

### Concept

Running does not always mean healthy.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 28: Prometheus container

### Concept

Prometheus needs reachable scrape targets.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 29: Grafana container

### Concept

Grafana provisioning errors appear in logs.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 30: Security boundary

### Concept

Containers are isolation tools, not perfect security boundaries.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 31: Image versus container

### Concept

An image is the template; a container is the running instance.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 32: Port mapping

### Concept

Docker host port mappings define external reachability.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 33: Local binding

### Concept

Use 127.0.0.1 host bindings for local labs.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 34: Compose stack

### Concept

Compose manages multiple related services.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 35: Container logs

### Concept

Logs reveal service startup and runtime errors.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 36: Inspect caution

### Concept

docker inspect may reveal environment variables.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 37: Network review

### Concept

Docker networks explain container communication.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 38: Volume review

### Concept

Volumes and bind mounts can expose host files.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 39: Cleanup

### Concept

docker compose down reduces leftover services.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 40: Docker Desktop

### Concept

On macOS Docker Desktop provides Linux container runtime support.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 41: Image trust

### Concept

Only use images from trusted or reviewed sources.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 42: Health check

### Concept

Running does not always mean healthy.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 43: Prometheus container

### Concept

Prometheus needs reachable scrape targets.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 44: Grafana container

### Concept

Grafana provisioning errors appear in logs.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 45: Security boundary

### Concept

Containers are isolation tools, not perfect security boundaries.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 46: Image versus container

### Concept

An image is the template; a container is the running instance.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 47: Port mapping

### Concept

Docker host port mappings define external reachability.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 48: Local binding

### Concept

Use 127.0.0.1 host bindings for local labs.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 49: Compose stack

### Concept

Compose manages multiple related services.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 50: Container logs

### Concept

Logs reveal service startup and runtime errors.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 51: Inspect caution

### Concept

docker inspect may reveal environment variables.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 52: Network review

### Concept

Docker networks explain container communication.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 53: Volume review

### Concept

Volumes and bind mounts can expose host files.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 54: Cleanup

### Concept

docker compose down reduces leftover services.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 55: Docker Desktop

### Concept

On macOS Docker Desktop provides Linux container runtime support.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 56: Image trust

### Concept

Only use images from trusted or reviewed sources.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 57: Health check

### Concept

Running does not always mean healthy.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 58: Prometheus container

### Concept

Prometheus needs reachable scrape targets.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 59: Grafana container

### Concept

Grafana provisioning errors appear in logs.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 60: Security boundary

### Concept

Containers are isolation tools, not perfect security boundaries.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 61: Image versus container

### Concept

An image is the template; a container is the running instance.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 62: Port mapping

### Concept

Docker host port mappings define external reachability.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 63: Local binding

### Concept

Use 127.0.0.1 host bindings for local labs.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 64: Compose stack

### Concept

Compose manages multiple related services.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 65: Container logs

### Concept

Logs reveal service startup and runtime errors.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 66: Inspect caution

### Concept

docker inspect may reveal environment variables.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 67: Network review

### Concept

Docker networks explain container communication.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 68: Volume review

### Concept

Volumes and bind mounts can expose host files.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.


## Docker and containers study card 69: Cleanup

### Concept

docker compose down reduces leftover services.

### Practical check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

These commands inspect running containers, Compose service state, logs and Docker networks. They are safe diagnostic commands, but logs and inspect output should be reviewed before publication.

### Interpretation pattern

A good interpretation should identify service state, published ports, network context, logs and whether the container behavior matches the expected lab design.

### Repository connection

This concept appears in Docker bridge network, Docker Compose reverse proxy, Prometheus metrics, Grafana dashboards and the secure local capstone service.

### Safety note

Stop unused stacks with `docker compose down` and review port bindings before presenting or publishing a lab.
