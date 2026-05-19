# Processes and Services

A process is a running program. A service is usually a long-running background process managed by the operating system.

## Process commands

```bash
ps aux
top
pgrep -fl python
kill PID
```

## Service commands on systemd Linux

```bash
systemctl status ssh
systemctl list-units --type=service
journalctl -u ssh
journalctl -xe
```

These commands are Linux/systemd specific and may not exist on macOS.

## Expected output

```bash
pgrep -fl python
```

```text
12345 python3 scripts/local_json_api_server_8300.py
```

## Safety

`ps`, `top`, `pgrep` and `systemctl status` are read-only.

`kill`, `systemctl stop`, `systemctl restart` and `systemctl disable` modify runtime state and should be used carefully.
