# Troubleshooting Case Examples

## Case 1: command not found

```text
zsh: command not found: ss
```

Layer: operating system/tool availability.

Safe checks:

```bash
command -v ss
uname -a
```

Interpretation: `ss` is Linux-oriented and is usually unavailable on macOS. Use `lsof -i -P -n` locally or run the lab in Linux.

## Case 2: port already in use

```text
OSError: [Errno 48] Address already in use
```

Safe check:

```bash
lsof -i :8080 -P -n
```

Interpretation: another process already owns the target port. Confirm PID and command before stopping it.
