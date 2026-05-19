# Processes and Services

This file explains Linux processes and services in depth. Processes are running programs. Services are usually long-running background programs that provide functionality such as SSH, HTTP APIs, databases, reverse proxies, metrics exporters or monitoring systems. Understanding processes and services is essential for debugging ports, logs, Docker containers, local APIs and incident response evidence.

The goal is to make the user able to answer practical questions: what is running, who started it, which PID owns it, how much CPU or memory it uses, whether it is listening on a port, where its logs are, how to stop it safely, and how to document the finding.


## 1. What a process is

A process is a running instance of a program. When a command such as `python3`, `curl`, `nginx`, `docker`, `bash` or `git` runs, the operating system represents it as a process with a PID, owner, state and resource usage.


## 2. PID

A PID is a process identifier. It uniquely identifies a running process at a point in time. PIDs are useful for inspection and signals, but they can be reused after a process exits.


## 3. Parent process

Processes are often launched by other processes. The parent process ID helps explain process trees. A shell may launch a script, which may launch Python, which may start an HTTP server.


## 4. Process owner

Every process runs as a user. The owner matters for permissions and security. A process running as root has more power than a process running as a normal user.


## 5. Process state

Processes can be running, sleeping, stopped, zombie or in other states depending on the system. State helps explain whether a process is active, waiting or stuck.


## 6. Foreground and background

A foreground process occupies the terminal until it exits. A background process runs while the shell accepts more commands. Services usually run in the background.


## 7. Signals

Signals are messages sent to processes. `kill PID` normally sends SIGTERM, asking a process to terminate. Stronger signals such as SIGKILL should be used carefully.


## 8. ps

`ps aux` shows a snapshot of processes. It includes user, PID, CPU, memory, start time and command. It is one of the safest first commands for process diagnosis.


## 9. top

`top` shows a live process view. It is useful for CPU and memory observation. It is interactive and can be exited with `q`.


## 10. pgrep

`pgrep -fl pattern` searches processes by name and prints matching PIDs and command lines. It is useful before stopping a local test server.


## 11. kill

`kill` sends a signal to a process. It should only be used after confirming the PID belongs to the intended process. Killing the wrong process can stop important work.


## 12. Service concept

A service is a long-running process or group of processes that provides functionality. Examples include SSH, web servers, APIs, reverse proxies, metrics exporters and database servers.


## 13. systemd

Many Linux systems use systemd to manage services. Commands such as `systemctl status service` and `journalctl -u service` help inspect service state and logs.


## 14. Service status

A service can be active, inactive, failed, restarting or degraded. Status alone is not enough; logs and port checks are often needed.


## 15. journalctl

`journalctl` reads systemd journal logs. It can show system events, service logs, boot logs and recent errors. It is Linux/systemd-specific.


## 16. Local API process

A local API started with Python is a process. If it keeps running, it may continue listening on a port until stopped. This explains port conflicts in labs.


## 17. Port ownership

A process can listen on a TCP or UDP port. Tools such as `ss -tulpen` and `lsof -i -P -n` connect ports to process names and PIDs.


## 18. CPU usage

High CPU usage can indicate heavy work, a loop, a runaway process or expected load. `top` and `ps` help identify CPU consumers.


## 19. Memory usage

Memory usage can explain slowdowns, container issues or service instability. `top`, `ps` and Docker stats can help inspect it.


## 20. Logs and processes

Processes often write logs to stdout, stderr, files or system journals. Logs are essential for understanding why a process failed or behaved unexpectedly.


## 21. Docker and processes

Containers run processes. `docker ps` shows containers, but inside each container there is still a process model. Container logs often come from process stdout/stderr.


## 22. Compose and services

Docker Compose defines services. Each Compose service usually runs one main process in one container. Compose commands provide service-level process management.


## 23. Process cleanup

After labs, cleanup matters. Servers, containers and background processes should be stopped when no longer needed to avoid port conflicts and resource usage.


## 24. Process evidence

In incident response, process listings can become evidence. A report should include command, relevant process name, PID, user, port if applicable and interpretation.


## 25. macOS differences

macOS has `ps`, `top`, `pgrep`, `kill` and `lsof`, but not systemd. Commands such as `systemctl` and `journalctl` are Linux-specific.


## 26. Safe process workflow

The safe workflow is: inspect with `ps` or `pgrep`, confirm target, inspect port/logs, stop only if necessary, verify it stopped, document the result.


## Command card 1: `ps aux`

### Purpose

Show a broad process snapshot.

### Example

```bash
ps aux
```

### Expected output

```text
Process table with users, PIDs and commands.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe read-only command.


## Command card 2: `ps -ef`

### Purpose

Show process table in another common format.

### Example

```bash
ps -ef
```

### Expected output

```text
UID, PID, PPID and command.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe and useful for parent process view.


## Command card 3: `top`

### Purpose

Show interactive live process resource usage.

### Example

```bash
top
```

### Expected output

```text
Live CPU/memory process display.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe; press q to quit.


## Command card 4: `pgrep -fl`

### Purpose

Search processes by pattern.

### Example

```bash
pgrep -fl python
```

### Expected output

```text
Matching PIDs and command lines.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe and useful before kill.


## Command card 5: `kill PID`

### Purpose

Send SIGTERM to a process.

### Example

```bash
kill 12345
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Medium risk; verify PID.


## Command card 6: `kill -9 PID`

### Purpose

Force kill a process with SIGKILL.

### Example

```bash
kill -9 12345
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Higher risk; last resort.


## Command card 7: `jobs`

### Purpose

Show background jobs in current shell.

### Example

```bash
jobs
```

### Expected output

```text
Job list.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe; shell-specific.


## Command card 8: `fg`

### Purpose

Bring a background job to foreground.

### Example

```bash
fg %1
```

### Expected output

```text
Job resumes in foreground.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Changes shell job state.


## Command card 9: `bg`

### Purpose

Resume a stopped job in background.

### Example

```bash
bg %1
```

### Expected output

```text
Job resumes in background.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Changes shell job state.


## Command card 10: `nohup`

### Purpose

Run command immune to hangup.

### Example

```bash
nohup command &
```

### Expected output

```text
Output usually in nohup.out.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Can leave processes running.


## Command card 11: `systemctl status`

### Purpose

Show service status.

### Example

```bash
systemctl status ssh
```

### Expected output

```text
Service state and recent logs.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe but Linux/systemd only.


## Command card 12: `systemctl stop`

### Purpose

Stop a service.

### Example

```bash
sudo systemctl stop service
```

### Expected output

```text
No output or status.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

State-changing; use carefully.


## Command card 13: `journalctl -u`

### Purpose

Read logs for a service.

### Example

```bash
journalctl -u ssh
```

### Expected output

```text
Service logs.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe but logs may contain sensitive data.


## Command card 14: `ss -tulpen`

### Purpose

Connect listeners to processes.

### Example

```bash
ss -tulpen
```

### Expected output

```text
Sockets and process info.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe, Linux-specific.


## Command card 15: `lsof -i -P -n`

### Purpose

Show network-related open files.

### Example

```bash
lsof -i -P -n
```

### Expected output

```text
Processes using ports.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe and useful on macOS/Linux.


## Command card 16: `docker ps`

### Purpose

Show running containers.

### Example

```bash
docker ps
```

### Expected output

```text
Containers, status and ports.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe Docker process-level view.


## Command card 17: `docker logs`

### Purpose

Show container logs.

### Example

```bash
docker logs container_name
```

### Expected output

```text
Container stdout/stderr.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe but review for secrets.


## Command card 18: `docker compose ps`

### Purpose

Show Compose services.

### Example

```bash
docker compose ps
```

### Expected output

```text
Service state and ports.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe.


## Command card 19: `docker compose logs`

### Purpose

Show Compose logs.

### Example

```bash
docker compose logs
```

### Expected output

```text
Logs from stack services.
```

### Interpretation

This command helps identify runtime state. The important fields are process name, PID, owner, status, resource usage, command line, associated port or service state.

### Safety note

Safe but review logs.


## Process and service reference tables

| Concept | Meaning |
|---|---|
| PID | Process identifier |
| PPID | Parent process identifier |
| UID/User | Identity running the process |
| CPU | CPU usage or scheduling information |
| MEM | Memory usage |
| COMMAND | Program and arguments |
| LISTEN | Socket waiting for connections |
| SIGTERM | Polite termination signal |
| SIGKILL | Forceful termination signal |

| Situation | First command | Follow-up |
|---|---|---|
| Port busy | `lsof -i :PORT -P -n` | confirm PID, then stop correct process |
| Unknown Python server | `pgrep -fl python` | inspect command line |
| Service failing | `systemctl status service` | `journalctl -u service` |
| Docker service issue | `docker compose ps` | `docker compose logs` |
| High CPU | `top` | inspect process and logs |


## Processes and services study card 1: PID discipline

### Concept

Never kill a process until the PID and command line are confirmed.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 2: Process owner

### Concept

The process owner explains what permissions the process likely has.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 3: Port conflicts

### Concept

A process listening on a port can block a new service from starting.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 4: Foreground server

### Concept

A Python HTTP server in the foreground stops with Ctrl+C.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 5: Background process

### Concept

A background process may continue after the shell prompt returns.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 6: Service manager

### Concept

systemd supervises services on many Linux systems.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 7: Journal logs

### Concept

Service logs often explain failures better than status alone.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 8: Docker process

### Concept

A container usually wraps a main process.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 9: Compose service

### Concept

Compose describes a service abstraction built on containers.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 10: Cleanup

### Concept

After labs, stop services that are no longer needed.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 11: Evidence

### Concept

Process listings can support a technical report.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 12: Resource usage

### Concept

CPU and memory fields help diagnose performance problems.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 13: Signals

### Concept

SIGTERM is safer than SIGKILL.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 14: macOS limitation

### Concept

systemctl and journalctl are not available on macOS.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 15: Security

### Concept

Unexpected processes or listeners require investigation.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 16: PID discipline

### Concept

Never kill a process until the PID and command line are confirmed.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 17: Process owner

### Concept

The process owner explains what permissions the process likely has.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 18: Port conflicts

### Concept

A process listening on a port can block a new service from starting.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 19: Foreground server

### Concept

A Python HTTP server in the foreground stops with Ctrl+C.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 20: Background process

### Concept

A background process may continue after the shell prompt returns.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 21: Service manager

### Concept

systemd supervises services on many Linux systems.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 22: Journal logs

### Concept

Service logs often explain failures better than status alone.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 23: Docker process

### Concept

A container usually wraps a main process.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 24: Compose service

### Concept

Compose describes a service abstraction built on containers.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 25: Cleanup

### Concept

After labs, stop services that are no longer needed.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 26: Evidence

### Concept

Process listings can support a technical report.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 27: Resource usage

### Concept

CPU and memory fields help diagnose performance problems.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 28: Signals

### Concept

SIGTERM is safer than SIGKILL.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 29: macOS limitation

### Concept

systemctl and journalctl are not available on macOS.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 30: Security

### Concept

Unexpected processes or listeners require investigation.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 31: PID discipline

### Concept

Never kill a process until the PID and command line are confirmed.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 32: Process owner

### Concept

The process owner explains what permissions the process likely has.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 33: Port conflicts

### Concept

A process listening on a port can block a new service from starting.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 34: Foreground server

### Concept

A Python HTTP server in the foreground stops with Ctrl+C.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 35: Background process

### Concept

A background process may continue after the shell prompt returns.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 36: Service manager

### Concept

systemd supervises services on many Linux systems.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 37: Journal logs

### Concept

Service logs often explain failures better than status alone.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 38: Docker process

### Concept

A container usually wraps a main process.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 39: Compose service

### Concept

Compose describes a service abstraction built on containers.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 40: Cleanup

### Concept

After labs, stop services that are no longer needed.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 41: Evidence

### Concept

Process listings can support a technical report.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 42: Resource usage

### Concept

CPU and memory fields help diagnose performance problems.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 43: Signals

### Concept

SIGTERM is safer than SIGKILL.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 44: macOS limitation

### Concept

systemctl and journalctl are not available on macOS.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 45: Security

### Concept

Unexpected processes or listeners require investigation.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 46: PID discipline

### Concept

Never kill a process until the PID and command line are confirmed.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 47: Process owner

### Concept

The process owner explains what permissions the process likely has.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 48: Port conflicts

### Concept

A process listening on a port can block a new service from starting.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 49: Foreground server

### Concept

A Python HTTP server in the foreground stops with Ctrl+C.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 50: Background process

### Concept

A background process may continue after the shell prompt returns.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 51: Service manager

### Concept

systemd supervises services on many Linux systems.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 52: Journal logs

### Concept

Service logs often explain failures better than status alone.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 53: Docker process

### Concept

A container usually wraps a main process.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 54: Compose service

### Concept

Compose describes a service abstraction built on containers.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 55: Cleanup

### Concept

After labs, stop services that are no longer needed.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 56: Evidence

### Concept

Process listings can support a technical report.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 57: Resource usage

### Concept

CPU and memory fields help diagnose performance problems.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 58: Signals

### Concept

SIGTERM is safer than SIGKILL.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 59: macOS limitation

### Concept

systemctl and journalctl are not available on macOS.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 60: Security

### Concept

Unexpected processes or listeners require investigation.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 61: PID discipline

### Concept

Never kill a process until the PID and command line are confirmed.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 62: Process owner

### Concept

The process owner explains what permissions the process likely has.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 63: Port conflicts

### Concept

A process listening on a port can block a new service from starting.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 64: Foreground server

### Concept

A Python HTTP server in the foreground stops with Ctrl+C.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 65: Background process

### Concept

A background process may continue after the shell prompt returns.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 66: Service manager

### Concept

systemd supervises services on many Linux systems.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 67: Journal logs

### Concept

Service logs often explain failures better than status alone.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 68: Docker process

### Concept

A container usually wraps a main process.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.


## Processes and services study card 69: Compose service

### Concept

Compose describes a service abstraction built on containers.

### Practical check

```bash
ps aux
pgrep -fl python
lsof -i -P -n
git status
```

These commands inspect running processes, candidate local servers, network listeners and repository state. They are safe read-only checks.

### Interpretation pattern

A good interpretation should identify the process, owner, PID, command line, port if relevant, and whether the process is expected for the current lab.

### Repository connection

This concept appears in local HTTP labs, API labs, Docker labs, Prometheus/Grafana labs and incident response reports.

### Safety note

Do not stop or kill processes blindly. Confirm the process identity and understand the consequence first.
