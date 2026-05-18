# Lab 003 Report — Ports, Processes, Logs and Local Diagnostics

## Date

YYYY-MM-DD

## Machine

Hostname:

Operating system:

Kernel:

User:

## Objective

The objective of this lab is to connect ports, processes, services, and logs into a defensive troubleshooting workflow.

## Commands executed

```bash
./scripts/diagnose_ports_processes.sh
./scripts/generate_local_log_events.sh
./scripts/create_ports_logs_report.sh
```

## Expected results

The diagnostic script should show:

- local system identity
- network interfaces
- listening ports
- network-related processes
- top CPU processes
- top memory processes
- failed systemd services, if systemd is available
- recent warning and error logs, if journalctl is available

## Observed listening ports

Paste output here.

## Observed processes

Paste output here.

## Observed failed services

Paste output here.

## Observed warning/error logs

Paste output here.

## Controlled log events

Expected controlled event prefix:

```text
LINUX_LAB_003
```

Observed events:

```text
Paste log events here.
```

## Interpretation

Explain whether the system has unexpected listening ports, failed services, relevant warnings, or suspicious error patterns.

## Problems encountered

Possible issues:

- `ss` not available
- `journalctl` not available
- `systemctl` not available
- process details require sudo
- too many logs to inspect manually

## Cleanup

No cleanup is required unless temporary reports were generated.

Generated reports are stored under:

```text
~/linux_lab/reports/
```

## Security note

This lab is local and defensive. It inspects the current machine and does not interact with unauthorized systems.
