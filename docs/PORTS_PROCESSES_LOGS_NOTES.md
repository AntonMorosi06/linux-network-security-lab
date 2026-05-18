# Ports, Processes and Logs Notes

## Process

A process is a running instance of a program. Every process has a process ID, usually called PID.

Useful command:

```bash
ps aux
```

## Port

A port is a numeric endpoint used by TCP or UDP services. A service listening on a port is waiting for incoming connections or datagrams.

Useful command:

```bash
ss -tulpen
```

## Socket

A socket connects an address, a port, and a protocol to a process.

Example:

```text
127.0.0.1:8080
```

This means local IPv4 loopback address on TCP or UDP port 8080, depending on the context.

## LISTEN state

A TCP socket in `LISTEN` state is waiting for incoming connections.

Example:

```text
LISTEN 0 5 127.0.0.1:8080
```

## ESTABLISHED state

A TCP socket in `ESTABLISHED` state is part of an active connection.

Useful command:

```bash
ss -tan state established
```

## Mapping a port to a process

Useful commands:

```bash
ss -ltnp | grep 8080
sudo lsof -i :8080 -P -n
```

This helps answer:

```text
Which program is using this port?
```

## systemd

On many Linux distributions, systemd manages services.

Useful commands:

```bash
systemctl --failed
systemctl status SERVICE_NAME --no-pager
journalctl -u SERVICE_NAME -n 100 --no-pager
```

## journalctl

`journalctl` reads systemd journal logs.

Useful commands:

```bash
journalctl -n 50 --no-pager
journalctl -p warning -n 50 --no-pager
journalctl -p err -n 50 --no-pager
journalctl -b -p err --no-pager
```

## logger

`logger` writes a controlled message to the system log.

Example:

```bash
logger "LINUX_LAB_003: normal diagnostic event"
```

This is useful for safe log pipeline testing.

## Diagnostic logic

A practical diagnostic sequence is:

```text
1. Is the process running?
2. Is the port listening?
3. Is it bound to the correct address?
4. Is the service manager reporting errors?
5. Do logs show warnings or failures?
6. Can the issue be reproduced?
7. Can a report be generated?
```

## Defensive value

Ports, processes and logs are core to defensive cybersecurity because they help identify:

- unexpected services
- misconfigured applications
- failed daemons
- local exposure
- repeated errors
- authentication problems
- suspicious activity patterns
