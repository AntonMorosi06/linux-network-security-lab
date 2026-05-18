# Lab 003 — Ports, Processes, Logs and Local Diagnostics

## Objective

The objective of this lab is to understand how to connect four core Linux administration concepts:

1. Listening ports
2. Running processes
3. System services
4. Local logs

This lab teaches how to answer practical troubleshooting questions such as:

- Which process is using a port?
- Is a service running?
- Are there failed services?
- Are there warning or error logs?
- Is a local endpoint failing because the process is down, the port is closed, or the service has errors?

This is a defensive and local-only diagnostic lab.

## Safety boundary

This lab is designed for local diagnostics only. It does not scan external hosts, does not attack services, and does not attempt exploitation. It only inspects local processes, local sockets, local logs, and local service state.

Allowed environments:

- Local Linux machine
- Linux VM
- WSL
- Container
- Lab server owned by the user
- Explicitly authorized environment

## Theory

A Linux network service normally involves several layers:

```text
program
-> process
-> socket
-> port
-> protocol
-> logs
-> service manager
```

A web server, for example, is not just "a website". It is a process that opens a socket and listens on a TCP port. If something fails, the problem may be caused by:

- the process not running
- the port not listening
- the wrong address binding
- a permission problem
- a firewall rule
- a service manager failure
- an application error visible in logs

## Step 1 — Inspect listening ports

```bash
ss -tulpen
```

If process details require elevated privileges:

```bash
sudo ss -tulpen
```

### Command description

`ss` inspects sockets.

`-t` shows TCP sockets.

`-u` shows UDP sockets.

`-l` shows listening sockets.

`-p` shows process information.

`-e` shows extended information.

`-n` keeps numeric addresses and ports.

### Expected output example

```text
Netid State  Recv-Q Send-Q Local Address:Port  Peer Address:Port Process
tcp   LISTEN 0      5      127.0.0.1:8080     0.0.0.0:*     users:(("python3",pid=12345,fd=3))
```

### Interpretation

The output shows that a process named `python3` is listening on local TCP port `8080`.

The address `127.0.0.1:8080` means that the service is bound only to loopback and is local-only.

## Step 2 — Inspect one specific port

```bash
ss -ltnp | grep 8080
```

Alternative with `lsof`:

```bash
sudo lsof -i :8080 -P -n
```

### Expected output example

```text
python3 12345 anton 3u IPv4 123456 0t0 TCP 127.0.0.1:8080 (LISTEN)
```

### Interpretation

This maps a port to a concrete process ID. This is useful when a port is busy or when a service is not behaving as expected.

## Step 3 — Inspect running processes

```bash
ps aux
```

Top CPU processes:

```bash
ps aux | sort -nrk 3 | head -15
```

Top memory processes:

```bash
ps aux | sort -nrk 4 | head -15
```

### Expected output example

```text
USER       PID  %CPU %MEM COMMAND
anton    12345   0.1  0.3 python3 -m http.server 8080 --bind 127.0.0.1
```

### Interpretation

The process list helps identify what is running, who started it, how much CPU and memory it uses, and the command line used to launch it.

## Step 4 — Inspect failed services

```bash
systemctl --failed
```

### Expected output if there are no failed services

```text
0 loaded units listed.
```

### Interpretation

Failed services may explain why a port is not listening or why an application is unavailable.

If a service is failed, inspect it with:

```bash
systemctl status SERVICE_NAME --no-pager
journalctl -u SERVICE_NAME -n 100 --no-pager
```

## Step 5 — Inspect warning and error logs

Recent warnings:

```bash
journalctl -p warning -n 50 --no-pager
```

Recent errors:

```bash
journalctl -p err -n 50 --no-pager
```

Current boot errors:

```bash
journalctl -b -p err --no-pager
```

### Expected output example

```text
May 18 12:30:00 anton-linux systemd[1]: example.service: Failed with result 'exit-code'.
```

### Interpretation

Logs explain what the system observed. A good diagnostic workflow always checks logs after checking process and port state.

## Step 6 — Generate controlled local log events

```bash
logger "LINUX_LAB_003: normal diagnostic event"
logger -p user.warning "LINUX_LAB_003: controlled warning event"
logger -p user.err "LINUX_LAB_003: controlled error event"
```

Read the events:

```bash
journalctl -n 50 --no-pager | grep LINUX_LAB_003
```

### Expected output example

```text
May 18 12:35:00 anton-linux anton: LINUX_LAB_003: normal diagnostic event
May 18 12:35:01 anton-linux anton: LINUX_LAB_003: controlled warning event
May 18 12:35:02 anton-linux anton: LINUX_LAB_003: controlled error event
```

### Interpretation

`logger` writes controlled messages to the system log. This is useful for learning log pipelines safely.

## Step 7 — Create a local report

Run:

```bash
./scripts/create_ports_logs_report.sh
```

### Expected output example

```text
[OK] Report creato:
~/linux_lab/reports/ports_logs_report_20260518_123500.txt
```

### Interpretation

The script collects system identity, listening ports, process list, failed services, and recent logs into a timestamped report.

## Common issues

### ss command not found

Install the package that provides `ss`, often `iproute2` on Linux distributions.

### journalctl not available

Some systems do not use systemd. In that case, inspect traditional log files such as `/var/log/syslog`, `/var/log/messages`, or `/var/log/system.log`, depending on the system.

### Permission denied with lsof or ss

Use `sudo` when process details are hidden.

### No failed services

This is normal and usually good.

### Many warning logs

Not every warning is critical. Warnings must be interpreted with context.

## Diagnostic method

A strong local diagnostic sequence is:

```text
1. Check whether the process exists.
2. Check whether the port is listening.
3. Check which address the port is bound to.
4. Check whether systemd reports failed services.
5. Check warning and error logs.
6. Generate controlled events if testing log collection.
7. Save a report.
```

## Final conclusion

This lab connects ports, processes, services, and logs into one troubleshooting method. It is a foundational defensive skill for Linux administration, network diagnostics, cybersecurity analysis, backend services, and future MicroBot telemetry/control systems.
