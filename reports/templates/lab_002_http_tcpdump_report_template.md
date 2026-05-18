# Lab 002 Report — Local HTTP Server, curl, ss and tcpdump

## Date

YYYY-MM-DD

## Machine

Hostname:

Operating system:

Kernel:

## Objective

The objective of this lab is to start a local HTTP server, test it with curl, inspect the listening TCP port, and capture loopback packets.

## Commands executed

```bash
./scripts/start_local_http_server_8080.sh
./scripts/test_local_http_server_8080.sh
./scripts/capture_local_http_8080.sh
```

## Expected results

The HTTP server should listen on:

```text
127.0.0.1:8080
```

The HTTP test should return:

```text
HTTP/1.0 200 OK
```

The port inspection should show a Python process listening on port 8080.

The packet capture should show TCP packets between a local ephemeral port and local port 8080.

## Observed output

Paste relevant output here.

## Interpretation

The lab demonstrates that a local process can expose a TCP service on the loopback interface. The `curl` command acts as the HTTP client, `ss` maps the listening socket to the process, and `tcpdump` observes packets on the loopback interface.

## Problems encountered

Document errors such as:

- port already in use
- connection refused
- permission denied with tcpdump
- missing curl
- missing tcpdump

## Cleanup

The server was stopped with:

```text
CTRL + C
```

The final port check was:

```bash
ss -ltnp | grep 8080 || echo "Port 8080 is no longer listening"
```

## Security note

This lab is local-only and does not interact with unauthorized systems.
