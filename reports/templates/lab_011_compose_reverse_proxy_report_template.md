# Lab 011 Report — Docker Compose API, Reverse Proxy and Local Logs

## Date

YYYY-MM-DD

## Machine

Hostname:

Operating system:

Docker version:

Docker Compose version:

User:

## Objective

The objective of this lab is to run a local Docker Compose stack with an API container behind an Nginx reverse proxy.

## Stack

```text
host -> reverse_proxy -> api
```

## Commands executed

```bash
./scripts/compose_lab011_check_requirements.sh
./scripts/compose_lab011_up.sh
./scripts/compose_lab011_test.sh
./scripts/compose_lab011_inspect.sh
./scripts/compose_lab011_logs.sh
./scripts/compose_lab011_down.sh
```

## Expected services

```text
api
reverse_proxy
```

## Expected host endpoint

```text
http://127.0.0.1:8600/status
```

## Test output

Paste relevant output from:

```bash
./scripts/compose_lab011_test.sh
```

## Inspect output

Paste relevant output from:

```bash
./scripts/compose_lab011_inspect.sh
```

## Logs

Paste relevant output from:

```bash
./scripts/compose_lab011_logs.sh
```

## Interpretation

Explain:

- whether Docker Compose started the stack
- whether the reverse proxy was reachable from the host
- whether the API responded through the proxy
- whether proxy headers reached the API
- whether logs show both services
- whether cleanup removed the stack

## Problems encountered

Possible issues:

- Docker daemon not running
- Docker Compose unavailable
- port 8600 already in use
- Nginx 502 Bad Gateway
- API container not healthy
- Compose network issue
- wrong service name in Nginx upstream

## Cleanup

Command:

```bash
./scripts/compose_lab011_down.sh
```

Expected result:

```text
Compose containers and network removed.
```

## Security note

The reverse proxy is bound only to `127.0.0.1:8600`. The API container is not directly exposed to the host.
