# Common Errors and Troubleshooting

This file explains common Linux, shell, Git, Docker, networking and repository errors in depth. Troubleshooting is the discipline of moving from symptom to cause through controlled checks. A good troubleshooting workflow does not guess randomly. It observes the error message, identifies the layer involved, runs the safest diagnostic command, interprets the output and applies the smallest reasonable fix.

The purpose of this file is to help the user recognize recurring failures in the Linux Network Security Lab repository: wrong directory, wrong shell, missing command, permission denied, port already in use, Docker daemon not running, Compose stack problems, missing Linux-specific commands on macOS, Git working tree confusion, CI validation failures, logs containing private data and scripts executed incorrectly.


## 1. Troubleshooting mindset

Troubleshooting should be structured. Start with the exact error, identify the layer, check context, run read-only diagnostics, then apply a minimal fix.


## 2. Read the exact error

The exact text matters. `command not found`, `permission denied`, `no such file or directory` and `address already in use` point to different layers.


## 3. Check current directory

Many repository errors happen because the command is run from the wrong folder. Use `pwd` and confirm the repository root.


## 4. Check repository state

`git status` shows whether files are modified, staged, untracked or clean. It prevents accidental commits and explains unexpected changes.


## 5. Command not found

`command not found` usually means the command is not installed or not in PATH. Use `command -v tool` and install the correct package only if needed.


## 6. Permission denied

`permission denied` can mean missing execute bit, insufficient file permission, protected path or missing privileges. Use `ls -la` and `id` before using sudo.


## 7. No such file or directory

This often means wrong path, wrong current directory, typo, deleted file or missing generated file. Use `ls`, `find` and `pwd`.


## 8. Syntax error

Shell syntax errors often come from pasting scripts into the wrong shell, broken heredocs, unclosed quotes or running Bash code in zsh.


## 9. Wrong shell

A script written for bash should be run with `bash file`, not pasted into zsh. This is especially important for scripts that write Markdown or use heredocs.


## 10. Backticks interpreted

Markdown backticks can be interpreted by the shell as command substitution if pasted into an unquoted heredoc or directly into the terminal. Use quoted heredocs in generated scripts.


## 11. File is not executable

If `./script.sh` fails, the file may not have execute permission. Use `chmod +x script.sh` or run it with `bash script.sh`.


## 12. Port already in use

A port conflict means another process is listening on the same port. Use `lsof -i :PORT -P -n` or `ss -tulpen` to identify it.


## 13. Connection refused

Connection refused means the target host is reachable but no service is listening on that port, or the service is not accepting connections.


## 14. Connection timed out

Timeouts can indicate routing problems, firewall filtering, service unreachability or wrong target. Diagnose interfaces, routes, ports and firewall.


## 15. HTTP 404

404 means the server responded but the path was not found. This is not a DNS or routing failure.


## 16. HTTP 401 or 403

401 and 403 are authentication/authorization issues. Connectivity worked, but access was denied or credentials were missing.


## 17. HTTP 500

500 indicates server-side application error. Check application logs, container logs and controlled error handling.


## 18. Docker daemon not running

Docker commands may fail if Docker Desktop or the Docker daemon is not running. Use `docker info` to check.


## 19. Docker permission problem

On Linux, Docker access may depend on group membership or daemon permissions. Use `id` and understand Docker group implications.


## 20. Docker port mapping problem

A container can be running but unreachable if the host port is not published correctly. Use `docker ps` and `docker compose ps`.


## 21. Compose file error

Compose YAML errors can break stack startup. Use `docker compose config` to validate rendered configuration.


## 22. Compose service unhealthy

A container can be running but unhealthy. Check `docker compose ps`, health checks and logs.


## 23. Missing Linux-specific command

Commands such as `ip`, `ss`, `journalctl`, `systemctl`, `nft` and `tc` may not exist on macOS. Use alternatives or a Linux VM.


## 24. Git pull failure

A pull can fail if local changes conflict with remote changes. Use `git status` first and avoid overwriting work blindly.


## 25. Nothing to commit

This message means Git sees no staged changes. It is not an error if no files changed.


## 26. Untracked files

Untracked files exist in the working tree but are not committed. Review them before adding.


## 27. CI failure

CI failures can come from Bash syntax errors, Python syntax errors, invalid config, missing files or broken paths.


## 28. Python module not found

Python import errors can mean missing package, wrong virtual environment, wrong working directory or wrong PYTHONPATH.


## 29. pip environment confusion

pip may install into a different Python environment than the one running the script. Use `python3 -m pip` and virtual environments.


## 30. Permission over-fixing

Using `chmod 777` to fix permission issues creates security problems. Diagnose first and apply minimal permissions.


## 31. Raw log publication

Logs may contain private data. Review before committing or sharing.


## 32. Generated file confusion

Generated reports may live outside the repository under `~/linux_lab`. They are not automatically committed unless copied or generated inside the repo.


## 33. Troubleshooting report

A troubleshooting report should include symptom, command, output summary, suspected layer, fix applied and verification result.


## Command card 1: `pwd`

### Purpose

Confirm current directory.

### Example

```bash
pwd
```

### Expected output

```text
Absolute path.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe first check.


## Command card 2: `git status`

### Purpose

Check repository state.

### Example

```bash
git status
```

### Expected output

```text
Branch and working tree state.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe first check.


## Command card 3: `command -v`

### Purpose

Check if a command exists.

### Example

```bash
command -v docker
```

### Expected output

```text
Path or no output.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe availability check.


## Command card 4: `ls -la`

### Purpose

Inspect files and permissions.

### Example

```bash
ls -la script.sh
```

### Expected output

```text
Mode, owner, group and path.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe read-only.


## Command card 5: `chmod +x`

### Purpose

Make script executable.

### Example

```bash
chmod +x script.sh
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

State-changing but common.


## Command card 6: `bash file`

### Purpose

Run script using bash.

### Example

```bash
bash script.txt
```

### Expected output

```text
Script output.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Preferred for downloaded patch scripts.


## Command card 7: `echo $?`

### Purpose

Show previous exit code.

### Example

```bash
echo $?
```

### Expected output

```text
0 or non-zero.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe diagnostic.


## Command card 8: `lsof -i :PORT`

### Purpose

Find process using a port.

### Example

```bash
lsof -i :8080 -P -n
```

### Expected output

```text
Process and PID.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe diagnostic.


## Command card 9: `ss -tulpen`

### Purpose

Show listeners on Linux.

### Example

```bash
ss -tulpen
```

### Expected output

```text
Sockets and process info.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe Linux diagnostic.


## Command card 10: `docker info`

### Purpose

Check Docker daemon.

### Example

```bash
docker info
```

### Expected output

```text
Docker system info or error.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe but may reveal details.


## Command card 11: `docker ps`

### Purpose

Check running containers.

### Example

```bash
docker ps
```

### Expected output

```text
Container list and ports.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe diagnostic.


## Command card 12: `docker compose ps`

### Purpose

Check Compose services.

### Example

```bash
docker compose ps
```

### Expected output

```text
Service states.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe diagnostic.


## Command card 13: `docker compose logs`

### Purpose

Read Compose logs.

### Example

```bash
docker compose logs
```

### Expected output

```text
Stack logs.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Review before sharing.


## Command card 14: `docker compose config`

### Purpose

Validate Compose YAML.

### Example

```bash
docker compose config
```

### Expected output

```text
Rendered config.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe validation.


## Command card 15: `python3 -m py_compile`

### Purpose

Check Python syntax.

### Example

```bash
python3 -m py_compile file.py
```

### Expected output

```text
No output if valid.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe validation.


## Command card 16: `bash -n`

### Purpose

Check Bash syntax.

### Example

```bash
bash -n script.sh
```

### Expected output

```text
No output if valid.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe validation.


## Command card 17: `find`

### Purpose

Locate files.

### Example

```bash
find . -name '*.md'
```

### Expected output

```text
Matching paths.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Safe unless destructive options used.


## Command card 18: `grep`

### Purpose

Search logs or code.

### Example

```bash
grep -Rni 'error' .
```

### Expected output

```text
Matching lines.
```

### Interpretation

This command supports troubleshooting by identifying context, availability, permissions, service state, syntax validity or runtime failure. A strong interpretation should connect the command output to the suspected layer.

### Safety note

Review output before sharing.


## Troubleshooting reference tables

| Error message | Likely layer | First check | Typical fix |
|---|---|---|---|
| `command not found` | PATH/package | `command -v tool` | install tool or fix PATH |
| `permission denied` | permissions | `ls -la`, `id` | chmod/chown only if justified |
| `no such file or directory` | path | `pwd`, `ls`, `find` | correct path or generate file |
| `address already in use` | port/process | `lsof -i :PORT` | stop old process or change port |
| `connection refused` | service/port | `ss`, `docker ps` | start service or fix port |
| `connection timed out` | route/firewall/target | `ip route`, `curl`, logs | inspect layer by layer |
| HTTP 404 | app route | `curl -i URL` | check path |
| HTTP 401/403 | auth/access | headers/token | provide expected credentials |
| HTTP 500 | application | logs | inspect server error |
| Docker daemon error | Docker runtime | `docker info` | start Docker Desktop/daemon |
| CI failed | validation | CI logs | reproduce locally |
| nothing to commit | Git state | `git status` | no action if expected |

| Safe order | Command |
|---|---|
| 1 | `pwd` |
| 2 | `git status` |
| 3 | `command -v tool` |
| 4 | `ls -la target` |
| 5 | `lsof -i :PORT -P -n` |
| 6 | `docker ps` |
| 7 | `docker compose logs` |


## Troubleshooting study card 1: Exact error

### Concept

Copy the exact error message before fixing.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 2: Layer thinking

### Concept

Identify whether the problem is shell, path, permission, port, Docker, Git or application.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 3: Wrong directory

### Concept

pwd prevents many relative-path errors.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 4: Missing command

### Concept

command -v confirms availability.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 5: Permission denied

### Concept

Inspect mode and owner before chmod.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 6: Port conflict

### Concept

Find the PID before killing anything.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 7: Docker daemon

### Concept

docker info reveals daemon availability.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 8: Compose config

### Concept

docker compose config catches YAML/config issues.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 9: HTTP status

### Concept

HTTP codes are application evidence.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 10: Git status

### Concept

git status should be checked before and after patches.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 11: CI validation

### Concept

Reproduce CI errors locally when possible.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 12: Logs

### Concept

Logs explain runtime failures.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 13: macOS limitation

### Concept

Linux-specific commands may need a VM.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 14: No blind sudo

### Concept

sudo should not be the first troubleshooting step.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 15: Report fix

### Concept

Document symptom, cause, fix and verification.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 16: Exact error

### Concept

Copy the exact error message before fixing.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 17: Layer thinking

### Concept

Identify whether the problem is shell, path, permission, port, Docker, Git or application.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 18: Wrong directory

### Concept

pwd prevents many relative-path errors.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 19: Missing command

### Concept

command -v confirms availability.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 20: Permission denied

### Concept

Inspect mode and owner before chmod.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 21: Port conflict

### Concept

Find the PID before killing anything.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 22: Docker daemon

### Concept

docker info reveals daemon availability.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 23: Compose config

### Concept

docker compose config catches YAML/config issues.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 24: HTTP status

### Concept

HTTP codes are application evidence.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 25: Git status

### Concept

git status should be checked before and after patches.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 26: CI validation

### Concept

Reproduce CI errors locally when possible.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 27: Logs

### Concept

Logs explain runtime failures.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 28: macOS limitation

### Concept

Linux-specific commands may need a VM.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 29: No blind sudo

### Concept

sudo should not be the first troubleshooting step.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 30: Report fix

### Concept

Document symptom, cause, fix and verification.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 31: Exact error

### Concept

Copy the exact error message before fixing.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 32: Layer thinking

### Concept

Identify whether the problem is shell, path, permission, port, Docker, Git or application.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 33: Wrong directory

### Concept

pwd prevents many relative-path errors.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 34: Missing command

### Concept

command -v confirms availability.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 35: Permission denied

### Concept

Inspect mode and owner before chmod.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 36: Port conflict

### Concept

Find the PID before killing anything.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 37: Docker daemon

### Concept

docker info reveals daemon availability.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 38: Compose config

### Concept

docker compose config catches YAML/config issues.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 39: HTTP status

### Concept

HTTP codes are application evidence.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 40: Git status

### Concept

git status should be checked before and after patches.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 41: CI validation

### Concept

Reproduce CI errors locally when possible.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 42: Logs

### Concept

Logs explain runtime failures.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 43: macOS limitation

### Concept

Linux-specific commands may need a VM.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 44: No blind sudo

### Concept

sudo should not be the first troubleshooting step.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 45: Report fix

### Concept

Document symptom, cause, fix and verification.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 46: Exact error

### Concept

Copy the exact error message before fixing.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 47: Layer thinking

### Concept

Identify whether the problem is shell, path, permission, port, Docker, Git or application.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 48: Wrong directory

### Concept

pwd prevents many relative-path errors.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 49: Missing command

### Concept

command -v confirms availability.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 50: Permission denied

### Concept

Inspect mode and owner before chmod.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 51: Port conflict

### Concept

Find the PID before killing anything.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 52: Docker daemon

### Concept

docker info reveals daemon availability.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 53: Compose config

### Concept

docker compose config catches YAML/config issues.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 54: HTTP status

### Concept

HTTP codes are application evidence.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 55: Git status

### Concept

git status should be checked before and after patches.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 56: CI validation

### Concept

Reproduce CI errors locally when possible.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 57: Logs

### Concept

Logs explain runtime failures.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 58: macOS limitation

### Concept

Linux-specific commands may need a VM.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 59: No blind sudo

### Concept

sudo should not be the first troubleshooting step.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 60: Report fix

### Concept

Document symptom, cause, fix and verification.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 61: Exact error

### Concept

Copy the exact error message before fixing.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 62: Layer thinking

### Concept

Identify whether the problem is shell, path, permission, port, Docker, Git or application.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 63: Wrong directory

### Concept

pwd prevents many relative-path errors.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 64: Missing command

### Concept

command -v confirms availability.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 65: Permission denied

### Concept

Inspect mode and owner before chmod.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 66: Port conflict

### Concept

Find the PID before killing anything.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 67: Docker daemon

### Concept

docker info reveals daemon availability.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 68: Compose config

### Concept

docker compose config catches YAML/config issues.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.


## Troubleshooting study card 69: HTTP status

### Concept

HTTP codes are application evidence.

### Practical check

```bash
pwd
git status
command -v bash
echo $?
```

These commands establish context, repository state, command availability and previous command success. They are safe first-line diagnostics.

### Interpretation pattern

A good interpretation should name the symptom, suspected layer, command used to test it, observed result and next action.

### Repository connection

This concept appears across all Linux Network Security Lab work because every generated script, Docker stack, local API and Git push can fail in repeatable ways.

### Safety note

Do not use destructive commands as a shortcut. Diagnose first, then apply the smallest necessary fix.
