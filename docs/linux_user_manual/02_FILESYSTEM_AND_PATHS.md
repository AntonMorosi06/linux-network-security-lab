# Filesystem and Paths

This file explains the Linux filesystem and path model in depth. It is the foundation for safe command-line work because almost every Linux task depends on knowing where you are, which file you are touching, which path is absolute or relative, which directory has which purpose, and which commands can safely inspect the filesystem.

The main idea is simple: Linux presents storage as a single tree rooted at `/`. Every file, directory, device handle, configuration file, log file and virtual kernel entry appears somewhere in that tree. If the user does not understand paths, commands become dangerous because it becomes easy to modify, delete or commit the wrong file.


## 1. The root directory

The root directory `/` is the top of the Linux filesystem tree. Every absolute path starts from `/`. This is different from systems that expose separate drive letters. In Linux, additional filesystems are mounted somewhere inside the same tree.


## 2. Absolute paths

An absolute path starts from `/` and identifies a location independently from the current working directory. Examples include `/home/anton`, `/etc/hosts`, `/var/log`, `/tmp` and `/usr/bin/python3`. Absolute paths are useful in scripts because they reduce ambiguity.


## 3. Relative paths

A relative path is interpreted from the current working directory. Examples include `docs/linux_user_manual`, `./scripts/test.sh`, `../README.md` and `labs/001_baseline.md`. Relative paths are convenient but can be dangerous if the current directory is not what the user thinks it is.


## 4. Current working directory

`pwd` prints the current working directory. This should be one of the first commands before running repository scripts. Many errors happen because the user is inside the home directory, a subfolder or another repository while trying to run a relative path.


## 5. Home directory

The home directory is the normal workspace for a user. It is often `/home/user` on Linux and `/Users/user` on macOS. The tilde `~` expands to the current user's home directory.


## 6. Important top-level directories

Common top-level directories include `/home`, `/etc`, `/var`, `/tmp`, `/usr`, `/bin`, `/sbin`, `/opt`, `/proc`, `/dev` and `/run`. Each has a different role in the system.


## 7. /home

`/home` contains user home directories on many Linux systems. Personal files, project folders and local workspaces often live here. On macOS, the equivalent user home structure is under `/Users`.


## 8. /etc

`/etc` contains system configuration files. These files can affect services, networking, users, package sources and system behavior. Editing `/etc` usually requires caution and often elevated privileges.


## 9. /var

`/var` contains variable data such as logs, caches, spool files and service state. Logs are commonly under `/var/log`. This directory matters for diagnostics and incident response.


## 10. /tmp

`/tmp` contains temporary files. It is useful for short-lived experiments, but files there may be cleaned automatically. Do not store important project work only in `/tmp`.


## 11. /usr

`/usr` contains user-space programs, libraries and shared resources. Commands often live in `/usr/bin`. Understanding `/usr` helps when diagnosing where a command is installed.


## 12. /bin and /sbin

`/bin` and `/sbin` contain essential binaries. Historically, `/sbin` was for system binaries, often administrative tools. On some distributions, these paths may be merged with `/usr/bin` and `/usr/sbin`.


## 13. /proc

`/proc` is a virtual filesystem exposing kernel and process information. Files under `/proc` are not ordinary disk files. They represent live system state.


## 14. /dev

`/dev` contains device files. Devices, disks, terminals and special pseudo-devices appear here. Most users inspect `/dev` only when doing system or hardware-level work.


## 15. Hidden files

Files beginning with `.` are hidden by default in many listings. Use `ls -la` to show them. Examples include `.git`, `.env`, `.bashrc`, `.zshrc` and `.ssh`. Hidden files may contain configuration or sensitive data.


## 16. File metadata

`ls -la` shows permissions, link count, owner, group, size, timestamp and name. This metadata explains who owns a file, whether it can be executed, and whether it is a file, directory or symlink.


## 17. Directories versus files

A directory contains names that point to files or other directories. The execute bit on a directory means the user can enter or traverse it. The read bit means the user can list it.


## 18. Symbolic links

A symbolic link is a path that points to another path. It can simplify workflows but also introduce confusion if the target is missing or unexpected. Use `ls -l` and `readlink` to inspect links.


## 19. Mount points

A mount point is a directory where a filesystem is attached. External drives, Docker volumes, virtual filesystems and network mounts can appear as part of the same tree.


## 20. Repository-relative paths

Inside a Git repository, paths are often written relative to the repository root. For example, `docs/linux_user_manual/README.md` only works as expected if the user is in the repository root.


## 21. Safe filesystem inspection

Safe commands include `pwd`, `ls -la`, `find`, `tree`, `du -sh`, `df -h`, `cat`, `less`, `head`, `tail` and `file`. These read filesystem state without intentionally modifying it.


## 22. State-changing filesystem commands

Commands such as `mkdir`, `touch`, `cp`, `mv`, `rm`, `chmod` and `chown` modify files or metadata. They are necessary but should be used with clear targets.


## 23. Dangerous filesystem patterns

Patterns such as `rm -rf`, recursive chmod, recursive chown and broad wildcards can destroy or expose data. They require extreme caution and should not be used casually.


## 24. Filesystem and Git

Git tracks files relative to the repository root. `git status` shows modified, staged and untracked files. Before committing, the user should verify that no private logs, secrets or generated local reports are being added accidentally.


## 25. Filesystem and security

Filesystem security depends on paths, permissions, ownership and content. Sensitive files such as `.env`, private keys, tokens, certificates and logs should be reviewed carefully and usually excluded from public repositories.


## 26. Filesystem and reports

A good report should include the path of important files, but should not expose private local data unnecessarily. Paths provide reproducibility, but they can also reveal usernames or machine structure.


## Command card 1: `pwd`

### Purpose

Print the current working directory.

### Example

```bash
pwd
```

### Expected output

```text
An absolute path such as /Users/antonmorosi/linux-network-security-lab.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Use before running scripts to confirm location.


## Command card 2: `ls -la`

### Purpose

List files including hidden files and metadata.

### Example

```bash
ls -la
```

### Expected output

```text
Permissions, owners, groups, sizes, dates and names.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Use to inspect repository contents and permissions.


## Command card 3: `cd`

### Purpose

Change directory.

### Example

```bash
cd docs/linux_user_manual
```

### Expected output

```text
No output if successful.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Use carefully; relative paths depend on where you are.


## Command card 4: `mkdir`

### Purpose

Create a directory.

### Example

```bash
mkdir -p docs/new_folder
```

### Expected output

```text
No output if successful.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

State-changing; verify target first.


## Command card 5: `touch`

### Purpose

Create an empty file or update timestamp.

### Example

```bash
touch notes.txt
```

### Expected output

```text
No output if successful.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Useful for placeholders but can alter timestamps.


## Command card 6: `cp`

### Purpose

Copy files or directories.

### Example

```bash
cp source.txt target.txt
```

### Expected output

```text
No output if successful.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Can overwrite if target exists depending on options.


## Command card 7: `mv`

### Purpose

Move or rename files.

### Example

```bash
mv old.txt new.txt
```

### Expected output

```text
No output if successful.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Can overwrite or relocate files.


## Command card 8: `rm`

### Purpose

Remove files.

### Example

```bash
rm file.txt
```

### Expected output

```text
No output if successful.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Dangerous if target is wrong.


## Command card 9: `find`

### Purpose

Search files by criteria.

### Example

```bash
find . -name '*.md'
```

### Expected output

```text
Matching paths.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Safe for inspection unless combined with delete actions.


## Command card 10: `tree`

### Purpose

Show directory hierarchy.

### Example

```bash
tree -L 2
```

### Expected output

```text
Indented tree output.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

May need installation.


## Command card 11: `du`

### Purpose

Show disk usage.

### Example

```bash
du -sh .
```

### Expected output

```text
Human-readable size.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Useful before publishing or packaging.


## Command card 12: `df`

### Purpose

Show filesystem capacity.

### Example

```bash
df -h
```

### Expected output

```text
Mounted filesystems and free space.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Useful for diagnosing disk space issues.


## Command card 13: `file`

### Purpose

Identify file type.

### Example

```bash
file README.md
```

### Expected output

```text
Text, binary, image or other type.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Useful before opening unknown files.


## Command card 14: `readlink`

### Purpose

Resolve symbolic links.

### Example

```bash
readlink path
```

### Expected output

```text
Link target.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Useful when symlinks are involved.


## Command card 15: `stat`

### Purpose

Show detailed file metadata.

### Example

```bash
stat README.md
```

### Expected output

```text
Metadata including size, mode and timestamps.
```

### Interpretation

The command helps understand filesystem state. A strong interpretation should explain what location, file, directory, metadata or size was inspected and why that matters for the current lab.

### Safety note

Output differs between Linux and macOS.


## Filesystem study card 1: Absolute versus relative paths

### Concept

Absolute paths begin with `/`; relative paths depend on the current working directory.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 2: Repository root

### Concept

The repository root is the safest reference point for repo-relative scripts and documentation paths.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 3: Hidden files

### Concept

Hidden files may contain important configuration or sensitive data.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 4: Permissions in listings

### Concept

The first field of `ls -la` explains file type and permissions.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 5: Ownership

### Concept

Owner and group fields explain who controls a file.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 6: File size

### Concept

Size helps identify unexpectedly large files before publishing.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 7: Path safety

### Concept

Always inspect path context before using `rm`, `mv`, `chmod` or `chown`.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 8: Generated files

### Concept

Reports and logs generated under home directories should be reviewed before committing.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 9: Examples folder

### Concept

Example outputs are useful when they are synthetic or sanitized.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 10: Images folder

### Concept

SVG diagrams are lightweight and versionable compared with heavy screenshots.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 11: Tables folder

### Concept

Tables organize commands by purpose, risk and expected output.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 12: Git staging

### Concept

A file is not committed just because it exists; it must be staged and committed.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 13: Git hygiene

### Concept

Use `git status` before every commit to avoid accidental publication.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 14: Temporary files

### Concept

Temporary files should not become permanent documentation unless reviewed.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 15: Backups

### Concept

Backups outside the repo protect original files without cluttering Git history.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 16: Absolute versus relative paths

### Concept

Absolute paths begin with `/`; relative paths depend on the current working directory.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 17: Repository root

### Concept

The repository root is the safest reference point for repo-relative scripts and documentation paths.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 18: Hidden files

### Concept

Hidden files may contain important configuration or sensitive data.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 19: Permissions in listings

### Concept

The first field of `ls -la` explains file type and permissions.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 20: Ownership

### Concept

Owner and group fields explain who controls a file.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 21: File size

### Concept

Size helps identify unexpectedly large files before publishing.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 22: Path safety

### Concept

Always inspect path context before using `rm`, `mv`, `chmod` or `chown`.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 23: Generated files

### Concept

Reports and logs generated under home directories should be reviewed before committing.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 24: Examples folder

### Concept

Example outputs are useful when they are synthetic or sanitized.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 25: Images folder

### Concept

SVG diagrams are lightweight and versionable compared with heavy screenshots.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 26: Tables folder

### Concept

Tables organize commands by purpose, risk and expected output.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 27: Git staging

### Concept

A file is not committed just because it exists; it must be staged and committed.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 28: Git hygiene

### Concept

Use `git status` before every commit to avoid accidental publication.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 29: Temporary files

### Concept

Temporary files should not become permanent documentation unless reviewed.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 30: Backups

### Concept

Backups outside the repo protect original files without cluttering Git history.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 31: Absolute versus relative paths

### Concept

Absolute paths begin with `/`; relative paths depend on the current working directory.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 32: Repository root

### Concept

The repository root is the safest reference point for repo-relative scripts and documentation paths.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 33: Hidden files

### Concept

Hidden files may contain important configuration or sensitive data.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 34: Permissions in listings

### Concept

The first field of `ls -la` explains file type and permissions.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 35: Ownership

### Concept

Owner and group fields explain who controls a file.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 36: File size

### Concept

Size helps identify unexpectedly large files before publishing.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 37: Path safety

### Concept

Always inspect path context before using `rm`, `mv`, `chmod` or `chown`.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 38: Generated files

### Concept

Reports and logs generated under home directories should be reviewed before committing.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 39: Examples folder

### Concept

Example outputs are useful when they are synthetic or sanitized.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 40: Images folder

### Concept

SVG diagrams are lightweight and versionable compared with heavy screenshots.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 41: Tables folder

### Concept

Tables organize commands by purpose, risk and expected output.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 42: Git staging

### Concept

A file is not committed just because it exists; it must be staged and committed.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 43: Git hygiene

### Concept

Use `git status` before every commit to avoid accidental publication.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 44: Temporary files

### Concept

Temporary files should not become permanent documentation unless reviewed.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 45: Backups

### Concept

Backups outside the repo protect original files without cluttering Git history.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 46: Absolute versus relative paths

### Concept

Absolute paths begin with `/`; relative paths depend on the current working directory.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 47: Repository root

### Concept

The repository root is the safest reference point for repo-relative scripts and documentation paths.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 48: Hidden files

### Concept

Hidden files may contain important configuration or sensitive data.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 49: Permissions in listings

### Concept

The first field of `ls -la` explains file type and permissions.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 50: Ownership

### Concept

Owner and group fields explain who controls a file.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 51: File size

### Concept

Size helps identify unexpectedly large files before publishing.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 52: Path safety

### Concept

Always inspect path context before using `rm`, `mv`, `chmod` or `chown`.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 53: Generated files

### Concept

Reports and logs generated under home directories should be reviewed before committing.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 54: Examples folder

### Concept

Example outputs are useful when they are synthetic or sanitized.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 55: Images folder

### Concept

SVG diagrams are lightweight and versionable compared with heavy screenshots.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 56: Tables folder

### Concept

Tables organize commands by purpose, risk and expected output.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 57: Git staging

### Concept

A file is not committed just because it exists; it must be staged and committed.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 58: Git hygiene

### Concept

Use `git status` before every commit to avoid accidental publication.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 59: Temporary files

### Concept

Temporary files should not become permanent documentation unless reviewed.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 60: Backups

### Concept

Backups outside the repo protect original files without cluttering Git history.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 61: Absolute versus relative paths

### Concept

Absolute paths begin with `/`; relative paths depend on the current working directory.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 62: Repository root

### Concept

The repository root is the safest reference point for repo-relative scripts and documentation paths.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 63: Hidden files

### Concept

Hidden files may contain important configuration or sensitive data.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.


## Filesystem study card 64: Permissions in listings

### Concept

The first field of `ls -la` explains file type and permissions.

### Practical check

```bash
pwd
ls -la
git status
```

These commands establish the current path, visible and hidden files, metadata and repository state. They are safe read-only checks and should be used before changing files.

### Report interpretation

A good report sentence should explain the path being inspected, why it matters and whether the observed state matches expectations. For example: the repository root was confirmed before running a relative-path script.

### Safety note

Filesystem mistakes are common because paths can look similar. Always verify the working directory before state-changing commands.
