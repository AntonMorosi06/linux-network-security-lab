# Users, Groups and Permissions

Linux permissions control who can read, write or execute files.

## Identity commands

```bash
whoami
id
groups
```

## Permission model

A typical file listing looks like:

```text
-rwxr-xr-- 1 anton staff 1200 May 20 script.sh
```

The first field means:

```text
-       regular file
rwx     owner can read/write/execute
r-x     group can read/execute
r--     others can read
```

## Permission table

| Symbol | Meaning |
|---|---|
| `r` | read |
| `w` | write |
| `x` | execute |
| `-` | permission absent |

## Common commands

```bash
chmod +x script.sh
chmod 644 file.txt
chmod 755 script.sh
chown user:group file
ls -la
```

## Numeric permissions

| Number | Meaning |
|---:|---|
| 7 | read + write + execute |
| 6 | read + write |
| 5 | read + execute |
| 4 | read only |
| 0 | no permissions |

## Safety

Changing permissions can make files inaccessible or too exposed. Avoid using `chmod 777` as a habit.
