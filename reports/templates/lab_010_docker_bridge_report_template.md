# Lab 010 Report — Docker Bridge Network and Container Diagnostics

## Date

YYYY-MM-DD

## Machine

Hostname:

Operating system:

Docker version:

User:

## Objective

The objective of this lab is to build a Docker image, create a custom bridge network, run a local API container, test it from the host, test it from another container and inspect Docker networking.

## Commands executed

```bash
./scripts/docker_lab010_check_requirements.sh
./scripts/docker_lab010_build_image.sh
./scripts/docker_lab010_create_network.sh
./scripts/docker_lab010_run_server.sh
./scripts/docker_lab010_test_from_host.sh
./scripts/docker_lab010_test_from_container.sh
./scripts/docker_lab010_inspect.sh
./scripts/docker_lab010_logs.sh
./scripts/docker_lab010_cleanup.sh
```

## Docker resources

Image:

```text
linux-sec-lab010-api
```

Network:

```text
lab010_bridge_net
```

Server container:

```text
lab010_api_server
```

Client container:

```text
lab010_api_client
```

## Host test

Command:

```bash
curl http://127.0.0.1:8500/status
```

Observed output:

```json
PASTE_OUTPUT_HERE
```

## Container test

Command:

```bash
./scripts/docker_lab010_test_from_container.sh
```

Observed output:

```text
PASTE_OUTPUT_HERE
```

## Network inspection

Paste relevant output from:

```bash
docker network inspect lab010_bridge_net
```

## Container inspection

Paste relevant output from:

```bash
docker inspect lab010_api_server
```

## Logs

Paste output from:

```bash
docker logs lab010_api_server
```

## Interpretation

Explain:

- whether the image built correctly
- whether the server container started
- whether host-to-container access worked
- whether container-to-container DNS worked
- whether the port was safely bound to localhost
- whether cleanup removed all resources

## Problems encountered

Possible issues:

- Docker daemon not running
- Docker Desktop not open
- port 8500 already used
- container name already exists
- network already exists
- image missing
- host test works but container DNS fails
- container test works but host port mapping fails

## Cleanup

Command:

```bash
./scripts/docker_lab010_cleanup.sh
```

Expected result:

```text
No lab010 container or network remains.
```

## Security note

The service was published only on `127.0.0.1:8500`, not on all network interfaces.
