# Linux Command Reference Matrix

## Purpose

This file is the expanded command reference matrix for the Linux User Manual. It is designed to be more than a short cheatsheet. It explains what commands do, why they matter, what output to expect, how risky they are, how to interpret them and which repository labs they support.

The matrix is intentionally defensive and local-first. Commands should be used only on owned or explicitly authorized systems. Commands that inspect state are safer than commands that modify state. Commands that change permissions, services, firewall rules, traffic shaping, containers or Git history require extra care.

## How to read the matrix

Each command should be read through these fields:

```text
Area -> technical domain
Command -> command or command pattern
Purpose -> why the command exists
Example -> safe or typical usage
Expected output -> what normal output looks like
Risk level -> safety category
Lab connection -> where the command appears in the repository
Interpretation -> how to explain the output in a report
```

## Risk levels

| Risk level | Meaning |
|---|---|
| Safe | Read-only or low-impact inspection command. |
| Safe/Medium | Usually safe, but context can make it sensitive. |
| Medium | Changes local state or can stop/start services. |
| High | Can affect networking, permissions, packet visibility, firewall state or important resources. |

## Main command matrix

| Area | Command | Purpose | Example | Expected output | Risk | Lab connection | Notes |
|---|---|---|---|---|---|---|---|
| Identity | `whoami` | Show the current effective username. | `whoami` | The current username, for example anton. | Safe | Lab 001 | Useful as the first identity check in any report. |
| Identity | `id` | Show UID, GID and group membership. | `id` | A line containing uid, gid and groups. | Safe | Lab 001 | Useful for permission troubleshooting. |
| Identity | `groups` | List groups for the current user. | `groups` | A list of group names. | Safe | Lab 001 | Good for checking docker or sudo-related access. |
| System | `hostname` | Show the machine hostname. | `hostname` | The local host name. | Safe | Lab 001 | Useful in evidence and reports. |
| System | `uname -a` | Show kernel, architecture and system information. | `uname -a` | Kernel name, version, architecture and platform details. | Safe | Lab 001 | Important compatibility check. |
| System | `date` | Print current date and time. | `date` | Current system date/time. | Safe | All labs | Useful for report timestamps. |
| Filesystem | `pwd` | Print the current working directory. | `pwd` | An absolute path. | Safe | All labs | Prevents running commands in the wrong folder. |
| Filesystem | `ls -la` | List files with hidden files and metadata. | `ls -la` | Permissions, owner, group, size, date and filename. | Safe | Lab 001 | Core filesystem inspection command. |
| Filesystem | `tree -L 2` | Display a directory tree with limited depth. | `tree -L 2` | Hierarchical folder/file view. | Safe | Lab 016 and Lab 020 | May need installation. |
| Filesystem | `find . -name '*.md'` | Search for Markdown files. | `find . -name '*.md'` | Matching file paths. | Safe | Lab 013 and Lab 020 | Useful in CI and audits. |
| Filesystem | `du -sh .` | Show total size of the current directory. | `du -sh .` | A human-readable size. | Safe | Release review | Useful before packaging or publishing. |
| Filesystem | `df -h` | Show filesystem disk usage. | `df -h` | Mounted filesystems and free space. | Safe | Lab 001 | General system health check. |
| Text | `cat file` | Print a file to stdout. | `cat README.md` | The file content. | Safe | All labs | Best for short files. |
| Text | `less file` | Open a file in a pager. | `less README.md` | Interactive view; press q to quit. | Safe | All labs | Better for long files. |
| Text | `head -20 file` | Print the first 20 lines. | `head -20 README.md` | First 20 lines. | Safe | Reports and logs | Good for previews. |
| Text | `tail -50 file` | Print the last 50 lines. | `tail -50 app.log` | Last 50 lines. | Safe | Lab 003 and logs | Good for recent log entries. |
| Text | `tail -f file` | Follow a file as it changes. | `tail -f app.log` | Live appended log lines. | Safe | Logs and monitoring | Stop with Ctrl+C. |
| Text | `grep 'ERROR' file` | Search for matching text. | `grep 'ERROR' app.log` | Lines containing ERROR. | Safe | Lab 003, Lab 018 | Core analysis command. |
| Text | `awk '{print $1}' file` | Extract fields from text. | `awk '{print $1}' access.log` | First whitespace-separated field. | Safe | Log analysis | More advanced text processing. |
| Permissions | `chmod +x script.sh` | Make a script executable. | `chmod +x scripts/test.sh` | No output if successful. | Medium | All script labs | Changes file mode. |
| Permissions | `chmod 644 file` | Set read/write for owner and read for others. | `chmod 644 README.md` | No output if successful. | Medium | Filesystem/security | Common documentation file mode. |
| Permissions | `chmod 755 script.sh` | Set executable mode for owner/group/others. | `chmod 755 scripts/run.sh` | No output if successful. | Medium | Script labs | Common script mode. |
| Permissions | `chown user:group file` | Change file owner and group. | `sudo chown anton:staff file` | No output if successful. | High | Admin concepts | Requires care and often sudo. |
| Processes | `ps aux` | List running processes. | `ps aux` | Process table. | Safe | Lab 003 | Broad process snapshot. |
| Processes | `top` | Interactive process monitor. | `top` | Live CPU/memory/process display. | Safe | Lab 003 | Press q to quit. |
| Processes | `pgrep -fl python` | Find processes by name and show command lines. | `pgrep -fl python` | PIDs and command names. | Safe | Lab 003 and API labs | Good before stopping a local API. |
| Processes | `kill PID` | Send a termination signal. | `kill 12345` | No output if successful. | Medium | Service cleanup | Can stop important processes. |
| Services | `systemctl status service` | Show systemd service status. | `systemctl status ssh` | Service state and recent logs. | Safe | Linux service diagnostics | Linux/systemd only. |
| Services | `journalctl -u service` | Read logs for a systemd service. | `journalctl -u ssh` | Service log entries. | Safe | Lab 003 | Linux/systemd only. |
| Network | `ip addr` | Show network interfaces and IP addresses. | `ip addr` | Interface list with addresses. | Safe | Lab 004 | Linux-specific. |
| Network | `ip route` | Show routing table. | `ip route` | Default route and network routes. | Safe | Lab 004 | Linux-specific. |
| Network | `ping -c 4 127.0.0.1` | Test basic IP reachability. | `ping -c 4 127.0.0.1` | ICMP replies and packet loss statistics. | Safe | Lab 004 | Use authorized targets only. |
| Network | `curl -i URL` | Make an HTTP request and show headers. | `curl -i http://127.0.0.1:8800/status` | HTTP status line, headers and body. | Safe | Lab 002 onward | Excellent API diagnostic tool. |
| Ports | `ss -tulpen` | Show listening TCP/UDP sockets and processes. | `ss -tulpen` | Listening sockets with addresses, ports and process info. | Safe | Lab 003 | Linux-specific. |
| Ports | `lsof -i -P -n` | Show processes using network sockets. | `lsof -i -P -n` | Process names, PIDs, addresses and ports. | Safe | Lab 003 | Useful on macOS and Linux. |
| DNS | `nslookup domain` | Resolve a domain name. | `nslookup example.com` | DNS server and resolved addresses. | Safe | Lab 004 | Common DNS diagnostic. |
| DNS | `dig domain` | Query DNS records with detailed output. | `dig example.com` | DNS answer, authority and timing details. | Safe | Lab 004 | May need installation. |
| Capture | `tcpdump` | Capture or display packets. | `sudo tcpdump -i lo port 8080` | Packet lines for matching traffic. | High | Lab 002 | Use only on local or authorized traffic. |
| Firewall | `nft list ruleset` | List nftables firewall rules. | `sudo nft list ruleset` | Firewall tables, chains and rules. | Medium | Lab 006 | Listing is safer than modifying. |
| Traffic Control | `tc qdisc show` | Show traffic control queue disciplines. | `tc qdisc show` | qdisc configuration per interface. | Safe/Medium | Lab 007 | Changing qdisc can affect networking. |
| Docker | `docker ps` | List running containers. | `docker ps` | Container ID, image, status, ports and names. | Safe | Lab 010 onward | First Docker diagnostic command. |
| Docker | `docker logs name` | Show logs for a container. | `docker logs lab015_api` | Container stdout/stderr logs. | Safe | Docker labs | Logs may contain sensitive info. |
| Docker | `docker inspect name` | Show detailed container metadata. | `docker inspect lab015_api` | Large JSON metadata. | Safe | Docker diagnostics | Large output. |
| Docker | `docker network ls` | List Docker networks. | `docker network ls` | Network IDs, names and drivers. | Safe | Lab 010 onward | Important for Compose stacks. |
| Compose | `docker compose up -d` | Start a Compose stack in detached mode. | `docker compose -f docker/lab015/compose.yaml up -d --build` | Build and startup output. | Medium | Lab 011 onward | Starts containers and networks. |
| Compose | `docker compose ps` | Show Compose service state. | `docker compose -f docker/lab015/compose.yaml ps` | Service names, state and ports. | Safe | Compose labs | Good after startup. |
| Compose | `docker compose logs` | Show logs from a Compose stack. | `docker compose -f docker/lab015/compose.yaml logs` | Logs from all services. | Safe | Compose labs | Review before publishing. |
| Compose | `docker compose down` | Stop and remove a Compose stack. | `docker compose -f docker/lab015/compose.yaml down` | Containers and networks removed. | Medium | Compose labs | Cleanup command. |
| Git | `git status` | Show working tree and branch state. | `git status` | Branch, staged, modified and untracked files. | Safe | All labs | Run before and after patches. |
| Git | `git add` | Stage files for commit. | `git add docs/linux_user_manual` | No output if successful. | Medium | All repo workflows | Review staged changes. |
| Git | `git commit -m` | Create a commit. | `git commit -m 'Expand Linux manual command matrix'` | Commit hash and summary. | Medium | All repo workflows | Creates local history. |
| Git | `git push origin main` | Push commits to GitHub. | `git push origin main` | Upload progress and remote update. | Medium | All repo workflows | Publishes changes. |
| Validation | `bash -n script.sh` | Check Bash syntax without running the script. | `bash -n scripts/example.sh` | No output if syntax is valid. | Safe | Lab 013 | CI-friendly. |
| Validation | `python3 -m py_compile file.py` | Check Python syntax by compiling a file. | `python3 -m py_compile scripts/analyze.py` | No output if valid. | Safe | Lab 013 | CI-friendly. |
| Monitoring | `curl /metrics` | Fetch Prometheus-style metrics. | `curl http://127.0.0.1:8701/metrics` | Prometheus text exposition format. | Safe | Lab 012 and Lab 017 | Local metrics endpoint. |
| Monitoring | `Prometheus query API` | Query Prometheus over HTTP. | `curl --get http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=up'` | JSON query result. | Safe | Lab 012 and Lab 017 | Useful in scripts. |
| IR | `JSONL analysis script` | Analyze local synthetic security events. | `./scripts/siem_lab018_analyze_events.py` | Event counts and findings. | Safe | Lab 018 | Synthetic local data only. |

## Detailed command cards

### Command card 1: `whoami`

**Area:** Identity

**Purpose:** Show the current effective username.

**Example:**

```bash
whoami
```

**Expected output:**

```text
The current username, for example anton.
```

**Risk level:** Safe

**Lab connection:** Lab 001

**Technical interpretation:** If the output is the expected user, the command confirms the user context for the session. If the output is root, extra caution is needed because later commands may have elevated impact.

**Report sentence template:**

```text
The command `whoami` was used to inspect identity state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 2: `id`

**Area:** Identity

**Purpose:** Show UID, GID and group membership.

**Example:**

```bash
id
```

**Expected output:**

```text
A line containing uid, gid and groups.
```

**Risk level:** Safe

**Lab connection:** Lab 001

**Technical interpretation:** The important fields are uid, gid and group list. Group membership can explain why a user can access Docker, logs or protected files.

**Report sentence template:**

```text
The command `id` was used to inspect identity state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 3: `groups`

**Area:** Identity

**Purpose:** List groups for the current user.

**Example:**

```bash
groups
```

**Expected output:**

```text
A list of group names.
```

**Risk level:** Safe

**Lab connection:** Lab 001

**Technical interpretation:** If the user belongs to a service-related group, that may explain permission to control that subsystem.

**Report sentence template:**

```text
The command `groups` was used to inspect identity state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 4: `hostname`

**Area:** System

**Purpose:** Show the machine hostname.

**Example:**

```bash
hostname
```

**Expected output:**

```text
The local host name.
```

**Risk level:** Safe

**Lab connection:** Lab 001

**Technical interpretation:** The hostname identifies where the evidence was collected. In a report, it helps separate local machines, containers and virtual machines.

**Report sentence template:**

```text
The command `hostname` was used to inspect system state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 5: `uname -a`

**Area:** System

**Purpose:** Show kernel, architecture and system information.

**Example:**

```bash
uname -a
```

**Expected output:**

```text
Kernel name, version, architecture and platform details.
```

**Risk level:** Safe

**Lab connection:** Lab 001

**Technical interpretation:** The output helps identify whether the user is on Linux, macOS, ARM, x86 or another environment. This matters because some labs require Linux-specific tools.

**Report sentence template:**

```text
The command `uname -a` was used to inspect system state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 6: `date`

**Area:** System

**Purpose:** Print current date and time.

**Example:**

```bash
date
```

**Expected output:**

```text
Current system date/time.
```

**Risk level:** Safe

**Lab connection:** All labs

**Technical interpretation:** The date provides temporal context for a command output or report. It is useful for evidence ordering.

**Report sentence template:**

```text
The command `date` was used to inspect system state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 7: `pwd`

**Area:** Filesystem

**Purpose:** Print the current working directory.

**Example:**

```bash
pwd
```

**Expected output:**

```text
An absolute path.
```

**Risk level:** Safe

**Lab connection:** All labs

**Technical interpretation:** If the path is the repository root, the user can safely run repo-relative scripts. If not, change directory first.

**Report sentence template:**

```text
The command `pwd` was used to inspect filesystem state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 8: `ls -la`

**Area:** Filesystem

**Purpose:** List files with hidden files and metadata.

**Example:**

```bash
ls -la
```

**Expected output:**

```text
Permissions, owner, group, size, date and filename.
```

**Risk level:** Safe

**Lab connection:** Lab 001

**Technical interpretation:** The permission column explains readability, writability and executability. The owner/group fields explain access context.

**Report sentence template:**

```text
The command `ls -la` was used to inspect filesystem state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 9: `tree -L 2`

**Area:** Filesystem

**Purpose:** Display a directory tree with limited depth.

**Example:**

```bash
tree -L 2
```

**Expected output:**

```text
Hierarchical folder/file view.
```

**Risk level:** Safe

**Lab connection:** Lab 016 and Lab 020

**Technical interpretation:** The tree view helps verify repository structure without opening every directory.

**Report sentence template:**

```text
The command `tree -L 2` was used to inspect filesystem state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 10: `find . -name '*.md'`

**Area:** Filesystem

**Purpose:** Search for Markdown files.

**Example:**

```bash
find . -name '*.md'
```

**Expected output:**

```text
Matching file paths.
```

**Risk level:** Safe

**Lab connection:** Lab 013 and Lab 020

**Technical interpretation:** The output shows whether expected documentation files exist and where they are located.

**Report sentence template:**

```text
The command `find . -name '*.md'` was used to inspect filesystem state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 11: `du -sh .`

**Area:** Filesystem

**Purpose:** Show total size of the current directory.

**Example:**

```bash
du -sh .
```

**Expected output:**

```text
A human-readable size.
```

**Risk level:** Safe

**Lab connection:** Release review

**Technical interpretation:** Large size may indicate generated artifacts, logs, pcaps or dependencies that should be reviewed before publishing.

**Report sentence template:**

```text
The command `du -sh .` was used to inspect filesystem state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 12: `df -h`

**Area:** Filesystem

**Purpose:** Show filesystem disk usage.

**Example:**

```bash
df -h
```

**Expected output:**

```text
Mounted filesystems and free space.
```

**Risk level:** Safe

**Lab connection:** Lab 001

**Technical interpretation:** Low free disk space can explain failures during Docker builds, logging or package installation.

**Report sentence template:**

```text
The command `df -h` was used to inspect filesystem state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 13: `cat file`

**Area:** Text

**Purpose:** Print a file to stdout.

**Example:**

```bash
cat README.md
```

**Expected output:**

```text
The file content.
```

**Risk level:** Safe

**Lab connection:** All labs

**Technical interpretation:** Useful for quick inspection, but not ideal for long files because it floods the terminal.

**Report sentence template:**

```text
The command `cat README.md` was used to inspect text state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 14: `less file`

**Area:** Text

**Purpose:** Open a file in a pager.

**Example:**

```bash
less README.md
```

**Expected output:**

```text
Interactive view; press q to quit.
```

**Risk level:** Safe

**Lab connection:** All labs

**Technical interpretation:** Allows controlled reading without changing the file.

**Report sentence template:**

```text
The command `less README.md` was used to inspect text state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 15: `head -20 file`

**Area:** Text

**Purpose:** Print the first 20 lines.

**Example:**

```bash
head -20 README.md
```

**Expected output:**

```text
First 20 lines.
```

**Risk level:** Safe

**Lab connection:** Reports and logs

**Technical interpretation:** Useful to confirm file identity and header without reading the whole file.

**Report sentence template:**

```text
The command `head -20 README.md` was used to inspect text state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 16: `tail -50 file`

**Area:** Text

**Purpose:** Print the last 50 lines.

**Example:**

```bash
tail -50 app.log
```

**Expected output:**

```text
Last 50 lines.
```

**Risk level:** Safe

**Lab connection:** Lab 003 and logs

**Technical interpretation:** Recent lines often contain the latest error or service status.

**Report sentence template:**

```text
The command `tail -50 app.log` was used to inspect text state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 17: `tail -f file`

**Area:** Text

**Purpose:** Follow a file as it changes.

**Example:**

```bash
tail -f app.log
```

**Expected output:**

```text
Live appended log lines.
```

**Risk level:** Safe

**Lab connection:** Logs and monitoring

**Technical interpretation:** Useful for observing a service while generating test traffic.

**Report sentence template:**

```text
The command `tail -f app.log` was used to inspect text state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 18: `grep 'ERROR' file`

**Area:** Text

**Purpose:** Search for matching text.

**Example:**

```bash
grep 'ERROR' app.log
```

**Expected output:**

```text
Lines containing ERROR.
```

**Risk level:** Safe

**Lab connection:** Lab 003, Lab 018

**Technical interpretation:** The result isolates relevant evidence from a larger file.

**Report sentence template:**

```text
The command `grep 'ERROR' app.log` was used to inspect text state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 19: `awk '{print $1}' file`

**Area:** Text

**Purpose:** Extract fields from text.

**Example:**

```bash
awk '{print $1}' access.log
```

**Expected output:**

```text
First whitespace-separated field.
```

**Risk level:** Safe

**Lab connection:** Log analysis

**Technical interpretation:** Useful for extracting repeated fields such as IPs, timestamps or statuses.

**Report sentence template:**

```text
The command `awk '{print $1}' access.log` was used to inspect text state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 20: `chmod +x script.sh`

**Area:** Permissions

**Purpose:** Make a script executable.

**Example:**

```bash
chmod +x scripts/test.sh
```

**Expected output:**

```text
No output if successful.
```

**Risk level:** Medium

**Lab connection:** All script labs

**Technical interpretation:** After this command, the file can be run as `./script.sh` if the shebang is correct.

**Report sentence template:**

```text
The command `chmod +x scripts/test.sh` was used to inspect permissions state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 21: `chmod 644 file`

**Area:** Permissions

**Purpose:** Set read/write for owner and read for others.

**Example:**

```bash
chmod 644 README.md
```

**Expected output:**

```text
No output if successful.
```

**Risk level:** Medium

**Lab connection:** Filesystem/security

**Technical interpretation:** The file remains readable but not executable.

**Report sentence template:**

```text
The command `chmod 644 README.md` was used to inspect permissions state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 22: `chmod 755 script.sh`

**Area:** Permissions

**Purpose:** Set executable mode for owner/group/others.

**Example:**

```bash
chmod 755 scripts/run.sh
```

**Expected output:**

```text
No output if successful.
```

**Risk level:** Medium

**Lab connection:** Script labs

**Technical interpretation:** The file becomes executable and readable by users with access to the directory.

**Report sentence template:**

```text
The command `chmod 755 scripts/run.sh` was used to inspect permissions state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 23: `chown user:group file`

**Area:** Permissions

**Purpose:** Change file owner and group.

**Example:**

```bash
sudo chown anton:staff file
```

**Expected output:**

```text
No output if successful.
```

**Risk level:** High

**Lab connection:** Admin concepts

**Technical interpretation:** Ownership changes can fix or break access. Use only when the target and effect are clear.

**Report sentence template:**

```text
The command `sudo chown anton:staff file` was used to inspect permissions state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 24: `ps aux`

**Area:** Processes

**Purpose:** List running processes.

**Example:**

```bash
ps aux
```

**Expected output:**

```text
Process table.
```

**Risk level:** Safe

**Lab connection:** Lab 003

**Technical interpretation:** Useful for identifying running services, Python scripts, Docker helpers or unexpected processes.

**Report sentence template:**

```text
The command `ps aux` was used to inspect processes state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 25: `top`

**Area:** Processes

**Purpose:** Interactive process monitor.

**Example:**

```bash
top
```

**Expected output:**

```text
Live CPU/memory/process display.
```

**Risk level:** Safe

**Lab connection:** Lab 003

**Technical interpretation:** Useful for checking whether a process is consuming CPU or memory unexpectedly.

**Report sentence template:**

```text
The command `top` was used to inspect processes state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 26: `pgrep -fl python`

**Area:** Processes

**Purpose:** Find processes by name and show command lines.

**Example:**

```bash
pgrep -fl python
```

**Expected output:**

```text
PIDs and command names.
```

**Risk level:** Safe

**Lab connection:** Lab 003 and API labs

**Technical interpretation:** The output identifies whether a Python API, server or script is still running.

**Report sentence template:**

```text
The command `pgrep -fl python` was used to inspect processes state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 27: `kill PID`

**Area:** Processes

**Purpose:** Send a termination signal.

**Example:**

```bash
kill 12345
```

**Expected output:**

```text
No output if successful.
```

**Risk level:** Medium

**Lab connection:** Service cleanup

**Technical interpretation:** Use only after confirming the PID belongs to the intended process.

**Report sentence template:**

```text
The command `kill 12345` was used to inspect processes state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 28: `systemctl status service`

**Area:** Services

**Purpose:** Show systemd service status.

**Example:**

```bash
systemctl status ssh
```

**Expected output:**

```text
Service state and recent logs.
```

**Risk level:** Safe

**Lab connection:** Linux service diagnostics

**Technical interpretation:** The active state and recent logs help diagnose whether a service is running correctly.

**Report sentence template:**

```text
The command `systemctl status ssh` was used to inspect services state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 29: `journalctl -u service`

**Area:** Services

**Purpose:** Read logs for a systemd service.

**Example:**

```bash
journalctl -u ssh
```

**Expected output:**

```text
Service log entries.
```

**Risk level:** Safe

**Lab connection:** Lab 003

**Technical interpretation:** Useful for service-specific timeline reconstruction.

**Report sentence template:**

```text
The command `journalctl -u ssh` was used to inspect services state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 30: `ip addr`

**Area:** Network

**Purpose:** Show network interfaces and IP addresses.

**Example:**

```bash
ip addr
```

**Expected output:**

```text
Interface list with addresses.
```

**Risk level:** Safe

**Lab connection:** Lab 004

**Technical interpretation:** The output identifies loopback, Ethernet, Wi-Fi, Docker and virtual interfaces.

**Report sentence template:**

```text
The command `ip addr` was used to inspect network state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 31: `ip route`

**Area:** Network

**Purpose:** Show routing table.

**Example:**

```bash
ip route
```

**Expected output:**

```text
Default route and network routes.
```

**Risk level:** Safe

**Lab connection:** Lab 004

**Technical interpretation:** The default route shows where traffic goes when no more specific route exists.

**Report sentence template:**

```text
The command `ip route` was used to inspect network state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 32: `ping -c 4 127.0.0.1`

**Area:** Network

**Purpose:** Test basic IP reachability.

**Example:**

```bash
ping -c 4 127.0.0.1
```

**Expected output:**

```text
ICMP replies and packet loss statistics.
```

**Risk level:** Safe

**Lab connection:** Lab 004

**Technical interpretation:** Loopback ping confirms the local network stack is responding.

**Report sentence template:**

```text
The command `ping -c 4 127.0.0.1` was used to inspect network state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 33: `curl -i URL`

**Area:** Network

**Purpose:** Make an HTTP request and show headers.

**Example:**

```bash
curl -i http://127.0.0.1:8800/status
```

**Expected output:**

```text
HTTP status line, headers and body.
```

**Risk level:** Safe

**Lab connection:** Lab 002 onward

**Technical interpretation:** Status codes such as 200, 401, 404 and 500 indicate application behavior.

**Report sentence template:**

```text
The command `curl -i http://127.0.0.1:8800/status` was used to inspect network state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 34: `ss -tulpen`

**Area:** Ports

**Purpose:** Show listening TCP/UDP sockets and processes.

**Example:**

```bash
ss -tulpen
```

**Expected output:**

```text
Listening sockets with addresses, ports and process info.
```

**Risk level:** Safe

**Lab connection:** Lab 003

**Technical interpretation:** A listener on 127.0.0.1 is local-only. A listener on 0.0.0.0 may be exposed on all interfaces.

**Report sentence template:**

```text
The command `ss -tulpen` was used to inspect ports state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 35: `lsof -i -P -n`

**Area:** Ports

**Purpose:** Show processes using network sockets.

**Example:**

```bash
lsof -i -P -n
```

**Expected output:**

```text
Process names, PIDs, addresses and ports.
```

**Risk level:** Safe

**Lab connection:** Lab 003

**Technical interpretation:** A good fallback when `ss` is unavailable.

**Report sentence template:**

```text
The command `lsof -i -P -n` was used to inspect ports state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 36: `nslookup domain`

**Area:** DNS

**Purpose:** Resolve a domain name.

**Example:**

```bash
nslookup example.com
```

**Expected output:**

```text
DNS server and resolved addresses.
```

**Risk level:** Safe

**Lab connection:** Lab 004

**Technical interpretation:** If DNS fails while IP connectivity works, the problem may be name resolution.

**Report sentence template:**

```text
The command `nslookup example.com` was used to inspect dns state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 37: `dig domain`

**Area:** DNS

**Purpose:** Query DNS records with detailed output.

**Example:**

```bash
dig example.com
```

**Expected output:**

```text
DNS answer, authority and timing details.
```

**Risk level:** Safe

**Lab connection:** Lab 004

**Technical interpretation:** Useful for precise DNS debugging and response timing.

**Report sentence template:**

```text
The command `dig example.com` was used to inspect dns state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 38: `tcpdump`

**Area:** Capture

**Purpose:** Capture or display packets.

**Example:**

```bash
sudo tcpdump -i lo port 8080
```

**Expected output:**

```text
Packet lines for matching traffic.
```

**Risk level:** High

**Lab connection:** Lab 002

**Technical interpretation:** Packet capture confirms whether traffic actually reaches an interface.

**Report sentence template:**

```text
The command `sudo tcpdump -i lo port 8080` was used to inspect capture state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 39: `nft list ruleset`

**Area:** Firewall

**Purpose:** List nftables firewall rules.

**Example:**

```bash
sudo nft list ruleset
```

**Expected output:**

```text
Firewall tables, chains and rules.
```

**Risk level:** Medium

**Lab connection:** Lab 006

**Technical interpretation:** The ruleset explains what traffic is accepted, dropped, forwarded or NATed.

**Report sentence template:**

```text
The command `sudo nft list ruleset` was used to inspect firewall state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 40: `tc qdisc show`

**Area:** Traffic Control

**Purpose:** Show traffic control queue disciplines.

**Example:**

```bash
tc qdisc show
```

**Expected output:**

```text
qdisc configuration per interface.
```

**Risk level:** Safe/Medium

**Lab connection:** Lab 007

**Technical interpretation:** Useful for verifying latency, loss or shaping configuration.

**Report sentence template:**

```text
The command `tc qdisc show` was used to inspect traffic control state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 41: `docker ps`

**Area:** Docker

**Purpose:** List running containers.

**Example:**

```bash
docker ps
```

**Expected output:**

```text
Container ID, image, status, ports and names.
```

**Risk level:** Safe

**Lab connection:** Lab 010 onward

**Technical interpretation:** The PORTS column is critical for checking local-only vs broad exposure.

**Report sentence template:**

```text
The command `docker ps` was used to inspect docker state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 42: `docker logs name`

**Area:** Docker

**Purpose:** Show logs for a container.

**Example:**

```bash
docker logs lab015_api
```

**Expected output:**

```text
Container stdout/stderr logs.
```

**Risk level:** Safe

**Lab connection:** Docker labs

**Technical interpretation:** Useful for understanding API startup, requests, errors and shutdown events.

**Report sentence template:**

```text
The command `docker logs lab015_api` was used to inspect docker state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 43: `docker inspect name`

**Area:** Docker

**Purpose:** Show detailed container metadata.

**Example:**

```bash
docker inspect lab015_api
```

**Expected output:**

```text
Large JSON metadata.
```

**Risk level:** Safe

**Lab connection:** Docker diagnostics

**Technical interpretation:** Useful for networks, mounts, environment variables and port mappings.

**Report sentence template:**

```text
The command `docker inspect lab015_api` was used to inspect docker state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 44: `docker network ls`

**Area:** Docker

**Purpose:** List Docker networks.

**Example:**

```bash
docker network ls
```

**Expected output:**

```text
Network IDs, names and drivers.
```

**Risk level:** Safe

**Lab connection:** Lab 010 onward

**Technical interpretation:** Shows whether custom bridge networks exist after lab startup.

**Report sentence template:**

```text
The command `docker network ls` was used to inspect docker state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 45: `docker compose up -d`

**Area:** Compose

**Purpose:** Start a Compose stack in detached mode.

**Example:**

```bash
docker compose -f docker/lab015/compose.yaml up -d --build
```

**Expected output:**

```text
Build and startup output.
```

**Risk level:** Medium

**Lab connection:** Lab 011 onward

**Technical interpretation:** Use when starting a multi-service local lab such as API plus proxy plus Prometheus.

**Report sentence template:**

```text
The command `docker compose -f docker/lab015/compose.yaml up -d --build` was used to inspect compose state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 46: `docker compose ps`

**Area:** Compose

**Purpose:** Show Compose service state.

**Example:**

```bash
docker compose -f docker/lab015/compose.yaml ps
```

**Expected output:**

```text
Service names, state and ports.
```

**Risk level:** Safe

**Lab connection:** Compose labs

**Technical interpretation:** Confirms whether services are running and which ports are published.

**Report sentence template:**

```text
The command `docker compose -f docker/lab015/compose.yaml ps` was used to inspect compose state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 47: `docker compose logs`

**Area:** Compose

**Purpose:** Show logs from a Compose stack.

**Example:**

```bash
docker compose -f docker/lab015/compose.yaml logs
```

**Expected output:**

```text
Logs from all services.
```

**Risk level:** Safe

**Lab connection:** Compose labs

**Technical interpretation:** Useful for correlating API, proxy, Prometheus and Grafana behavior.

**Report sentence template:**

```text
The command `docker compose -f docker/lab015/compose.yaml logs` was used to inspect compose state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 48: `docker compose down`

**Area:** Compose

**Purpose:** Stop and remove a Compose stack.

**Example:**

```bash
docker compose -f docker/lab015/compose.yaml down
```

**Expected output:**

```text
Containers and networks removed.
```

**Risk level:** Medium

**Lab connection:** Compose labs

**Technical interpretation:** Stops local lab services and reduces leftover exposure.

**Report sentence template:**

```text
The command `docker compose -f docker/lab015/compose.yaml down` was used to inspect compose state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 49: `git status`

**Area:** Git

**Purpose:** Show working tree and branch state.

**Example:**

```bash
git status
```

**Expected output:**

```text
Branch, staged, modified and untracked files.
```

**Risk level:** Safe

**Lab connection:** All labs

**Technical interpretation:** A clean tree means no uncommitted changes. Modified files must be reviewed before commit.

**Report sentence template:**

```text
The command `git status` was used to inspect git state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 50: `git add`

**Area:** Git

**Purpose:** Stage files for commit.

**Example:**

```bash
git add docs/linux_user_manual
```

**Expected output:**

```text
No output if successful.
```

**Risk level:** Medium

**Lab connection:** All repo workflows

**Technical interpretation:** Staging selects what will be included in the next commit.

**Report sentence template:**

```text
The command `git add docs/linux_user_manual` was used to inspect git state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 51: `git commit -m`

**Area:** Git

**Purpose:** Create a commit.

**Example:**

```bash
git commit -m 'Expand Linux manual command matrix'
```

**Expected output:**

```text
Commit hash and summary.
```

**Risk level:** Medium

**Lab connection:** All repo workflows

**Technical interpretation:** The commit should represent one coherent change.

**Report sentence template:**

```text
The command `git commit -m 'Expand Linux manual command matrix'` was used to inspect git state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 52: `git push origin main`

**Area:** Git

**Purpose:** Push commits to GitHub.

**Example:**

```bash
git push origin main
```

**Expected output:**

```text
Upload progress and remote update.
```

**Risk level:** Medium

**Lab connection:** All repo workflows

**Technical interpretation:** After push, files become visible on GitHub and should have been reviewed.

**Report sentence template:**

```text
The command `git push origin main` was used to inspect git state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 53: `bash -n script.sh`

**Area:** Validation

**Purpose:** Check Bash syntax without running the script.

**Example:**

```bash
bash -n scripts/example.sh
```

**Expected output:**

```text
No output if syntax is valid.
```

**Risk level:** Safe

**Lab connection:** Lab 013

**Technical interpretation:** A passing syntax check does not prove runtime behavior, but catches syntax errors early.

**Report sentence template:**

```text
The command `bash -n scripts/example.sh` was used to inspect validation state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 54: `python3 -m py_compile file.py`

**Area:** Validation

**Purpose:** Check Python syntax by compiling a file.

**Example:**

```bash
python3 -m py_compile scripts/analyze.py
```

**Expected output:**

```text
No output if valid.
```

**Risk level:** Safe

**Lab connection:** Lab 013

**Technical interpretation:** Valid syntax does not prove logic, but prevents broken Python files from being committed.

**Report sentence template:**

```text
The command `python3 -m py_compile scripts/analyze.py` was used to inspect validation state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 55: `curl /metrics`

**Area:** Monitoring

**Purpose:** Fetch Prometheus-style metrics.

**Example:**

```bash
curl http://127.0.0.1:8701/metrics
```

**Expected output:**

```text
Prometheus text exposition format.
```

**Risk level:** Safe

**Lab connection:** Lab 012 and Lab 017

**Technical interpretation:** Counters and gauges show service behavior over time.

**Report sentence template:**

```text
The command `curl http://127.0.0.1:8701/metrics` was used to inspect monitoring state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 56: `Prometheus query API`

**Area:** Monitoring

**Purpose:** Query Prometheus over HTTP.

**Example:**

```bash
curl --get http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=up'
```

**Expected output:**

```text
JSON query result.
```

**Risk level:** Safe

**Lab connection:** Lab 012 and Lab 017

**Technical interpretation:** `up == 1` means Prometheus can scrape the target.

**Report sentence template:**

```text
The command `curl --get http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=up'` was used to inspect monitoring state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

### Command card 57: `JSONL analysis script`

**Area:** IR

**Purpose:** Analyze local synthetic security events.

**Example:**

```bash
./scripts/siem_lab018_analyze_events.py
```

**Expected output:**

```text
Event counts and findings.
```

**Risk level:** Safe

**Lab connection:** Lab 018

**Technical interpretation:** Findings are signals that require analyst interpretation.

**Report sentence template:**

```text
The command `./scripts/siem_lab018_analyze_events.py` was used to inspect ir state. The relevant output was interpreted to confirm the expected local lab condition and to document the result safely.
```

**Safety note:** Always confirm the command target and context before execution. If the command modifies state, review the expected change before running it.

## Cross-reference by lab

- **Admin concepts:** `chown user:group file`
- **All labs:** `date`, `pwd`, `cat file`, `less file`, `git status`
- **All repo workflows:** `git add`, `git commit -m`, `git push origin main`
- **All script labs:** `chmod +x script.sh`
- **Compose labs:** `docker compose ps`, `docker compose logs`, `docker compose down`
- **Docker diagnostics:** `docker inspect name`
- **Docker labs:** `docker logs name`
- **Filesystem/security:** `chmod 644 file`
- **Lab 001:** `whoami`, `id`, `groups`, `hostname`, `uname -a`, `ls -la`, `df -h`
- **Lab 002:** `tcpdump`
- **Lab 002 onward:** `curl -i URL`
- **Lab 003:** `ps aux`, `top`, `journalctl -u service`, `ss -tulpen`, `lsof -i -P -n`
- **Lab 003 and API labs:** `pgrep -fl python`
- **Lab 003 and logs:** `tail -50 file`
- **Lab 003, Lab 018:** `grep 'ERROR' file`
- **Lab 004:** `ip addr`, `ip route`, `ping -c 4 127.0.0.1`, `nslookup domain`, `dig domain`
- **Lab 006:** `nft list ruleset`
- **Lab 007:** `tc qdisc show`
- **Lab 010 onward:** `docker ps`, `docker network ls`
- **Lab 011 onward:** `docker compose up -d`
- **Lab 012 and Lab 017:** `curl /metrics`, `Prometheus query API`
- **Lab 013:** `bash -n script.sh`, `python3 -m py_compile file.py`
- **Lab 013 and Lab 020:** `find . -name '*.md'`
- **Lab 016 and Lab 020:** `tree -L 2`
- **Lab 018:** `JSONL analysis script`
- **Linux service diagnostics:** `systemctl status service`
- **Log analysis:** `awk '{print $1}' file`
- **Logs and monitoring:** `tail -f file`
- **Release review:** `du -sh .`
- **Reports and logs:** `head -20 file`
- **Script labs:** `chmod 755 script.sh`
- **Service cleanup:** `kill PID`

## Practical diagnostic sequences

### Baseline before any lab

```bash
pwd
git status
whoami
hostname
date
```

Interpretation: this sequence groups commands that answer one operational question. The output should be summarized in a report rather than pasted blindly.

### Local service check

```bash
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:PORT/status
```

Interpretation: this sequence groups commands that answer one operational question. The output should be summarized in a report rather than pasted blindly.

### Docker stack check

```bash
docker ps
docker compose ps
docker compose logs
docker network ls
```

Interpretation: this sequence groups commands that answer one operational question. The output should be summarized in a report rather than pasted blindly.

### Repository publication check

```bash
git status
find . -name '.env' -o -name '*.pem' -o -name '*.key'
./scripts/ci_local_validate.sh
```

Interpretation: this sequence groups commands that answer one operational question. The output should be summarized in a report rather than pasted blindly.

### Incident response synthetic case check

```bash
./scripts/siem_lab018_analyze_events.py
./scripts/ir_lab019_analyze_case.py
./scripts/ir_lab019_create_final_report.sh
```

Interpretation: this sequence groups commands that answer one operational question. The output should be summarized in a report rather than pasted blindly.
