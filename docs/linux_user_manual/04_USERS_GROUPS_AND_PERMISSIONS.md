# Users, Groups and Permissions

This file explains Linux users, groups and permissions in depth. It is one of the most important foundations for secure Linux work because every file and process has an identity context. When a command fails with `permission denied`, when a script cannot be executed, when Docker access is blocked, or when a file should not be published, the answer often depends on users, groups, ownership and permission modes.

The purpose of this file is to make access control understandable at command-line level. The user should be able to read `ls -la`, interpret file type and permission bits, understand owner and group fields, use `chmod` safely, know why `chown` is powerful, recognize dangerous permission patterns, and document permission-related findings in a report.


## 1. Identity context

Every shell session runs as a user. Commands such as `whoami`, `id` and `groups` show that identity context. Before running administrative or filesystem-changing commands, the user should know which identity is active.


## 2. Users

A Linux user is an identity recognized by the system. Users own files, run processes and may belong to groups. A normal user has limited privileges. The root user has administrative power and must be treated carefully.


## 3. UID

A UID is a numeric user identifier. The username is human-readable, but the system uses UID internally. The root user normally has UID 0.


## 4. Groups

Groups allow permissions to be shared among multiple users. A user may belong to several groups. Group membership can explain access to Docker, logs, shared project folders or administrative tools.


## 5. GID

A GID is a numeric group identifier. Files have both an owner user and an owner group. Commands such as `id` reveal UID, primary GID and supplementary groups.


## 6. whoami

`whoami` prints the current effective username. It is a simple but important baseline command. If the output is `root`, later commands can have much stronger impact.


## 7. id

`id` prints UID, GID and group membership. This command is more informative than `whoami` and should be used when diagnosing permission issues.


## 8. groups

`groups` prints the group names associated with the current user. It can help determine whether the user is in a group such as `docker`, `sudo`, `adm` or a project-specific group.


## 9. File ownership

Every file has an owner and a group. These fields appear in `ls -la` output. Ownership helps explain who can modify or execute a file.


## 10. Permission triplets

Linux permission strings usually show owner, group and others permissions. For example, `rwxr-xr--` means owner can read/write/execute, group can read/execute, others can read only.


## 11. File type character

The first character in `ls -la` output indicates file type. `-` means regular file, `d` means directory, `l` means symbolic link. This character should not be confused with permission bits.


## 12. Read permission

Read permission allows reading file content. On a directory, read permission allows listing names, but execute permission is also needed to traverse entries effectively.


## 13. Write permission

Write permission allows modifying a file. On a directory, write permission allows creating, deleting or renaming entries, usually combined with execute permission.


## 14. Execute permission

Execute permission allows running a file as a program or script. On a directory, execute permission allows entering or traversing the directory.


## 15. Directory permissions

Directory permissions have slightly different meaning from file permissions. A directory needs execute permission to be entered and read permission to list contents.


## 16. Numeric permission modes

Numeric modes encode permissions. Read is 4, write is 2, execute is 1. `7` means read/write/execute, `6` means read/write, `5` means read/execute, `4` means read only.


## 17. Common mode 644

`644` is common for documentation files. Owner can read/write, group and others can read. This is appropriate for README files and most Markdown docs.


## 18. Common mode 755

`755` is common for scripts and directories. Owner can read/write/execute, group and others can read/execute. For directories, execute means traversal.


## 19. Common mode 600

`600` is appropriate for private files readable and writable only by the owner. Sensitive configuration should often be more restrictive than public documentation.


## 20. Common mode 700

`700` gives full access only to the owner. It is useful for private directories or scripts that should not be accessible to others.


## 21. Avoid chmod 777

`777` gives everyone read/write/execute. It is usually a bad habit and should not be used as a quick fix unless the context is temporary and fully controlled.


## 22. chmod

`chmod` changes file permission modes. It can use symbolic form such as `chmod +x script.sh` or numeric form such as `chmod 755 script.sh`. It changes metadata and must be used intentionally.


## 23. chown

`chown` changes file owner and group. It is powerful and often requires sudo. Incorrect recursive `chown` can break project or system access.


## 24. umask

`umask` defines default permission restrictions for newly created files and directories. It influences the permissions files receive at creation time.


## 25. sudo

`sudo` runs a command with elevated privileges if the user is allowed. It should not be used blindly. If a command only needs read-only user-level access, avoid sudo.


## 26. Root user

The root user has unrestricted administrative power. Commands run as root can modify system files, change ownership, stop services or damage the environment. Root context should always be explicit in reports.


## 27. Setuid and setgid

Special permission bits such as setuid and setgid affect execution identity or group inheritance. They are advanced and security-sensitive. They should be inspected carefully when present.


## 28. Sticky bit

The sticky bit is common on shared writable directories such as `/tmp`. It helps prevent users from deleting files they do not own in shared directories.


## 29. Permissions and scripts

A script run as `./script.sh` needs execute permission. A script run as `bash script.sh` does not need the execute bit, because bash reads it as input.


## 30. Permissions and Git

Git can track executable bit changes. This matters when scripts should be executable in the repository. Use `git status` and `git diff --summary` to review mode changes.


## 31. Permissions and Docker

Docker access may depend on group membership or daemon permissions. Being in the Docker group can effectively grant powerful control over the host. Treat Docker access as security-relevant.


## 32. Permissions and logs

Some logs require elevated permissions. If a log cannot be read, do not immediately use sudo blindly; first understand which log is needed and whether it is safe to access.


## 33. Permissions and publication

Before publishing a repository, review permissions and hidden files. Secrets, `.env` files, private keys and private logs should not be committed.


## 34. Permission troubleshooting

Permission problems should be diagnosed in order: confirm user with `whoami`, confirm groups with `id`, inspect target with `ls -la`, inspect parent directory permissions, then decide whether chmod or chown is appropriate.


## 35. Report writing

A permission report should identify the user, target file, owner, group, permission mode and conclusion. Do not simply write that a command failed.


## Command card 1: `whoami`

### Purpose

Show current effective username.

### Example

```bash
whoami
```

### Expected output

```text
anton
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

Safe baseline identity command.


## Command card 2: `id`

### Purpose

Show UID, GID and groups.

### Example

```bash
id
```

### Expected output

```text
uid=501(anton) gid=20(staff) groups=...
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

Safe and useful for permission diagnosis.


## Command card 3: `groups`

### Purpose

Show group membership.

### Example

```bash
groups
```

### Expected output

```text
staff everyone localaccounts
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

Safe; useful to explain shared access.


## Command card 4: `ls -la`

### Purpose

Show permissions, ownership and metadata.

### Example

```bash
ls -la script.sh
```

### Expected output

```text
-rwxr-xr-x 1 anton staff ... script.sh
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

Safe; primary permission inspection command.


## Command card 5: `chmod +x`

### Purpose

Add executable bit.

### Example

```bash
chmod +x script.sh
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

State-changing but common for scripts.


## Command card 6: `chmod 644`

### Purpose

Set documentation-style permissions.

### Example

```bash
chmod 644 README.md
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

State-changing; verify target.


## Command card 7: `chmod 755`

### Purpose

Set executable/script or directory-style permissions.

### Example

```bash
chmod 755 script.sh
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

State-changing; common for scripts.


## Command card 8: `chmod 600`

### Purpose

Restrict file to owner read/write.

### Example

```bash
chmod 600 private.conf
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

Useful for private files.


## Command card 9: `chown`

### Purpose

Change owner/group.

### Example

```bash
sudo chown user:group file
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

High risk; use carefully.


## Command card 10: `umask`

### Purpose

Show or set default permission mask.

### Example

```bash
umask
```

### Expected output

```text
0022
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

Safe when read-only; changing affects new files.


## Command card 11: `stat`

### Purpose

Show detailed file metadata.

### Example

```bash
stat file
```

### Expected output

```text
Mode, owner, size, timestamps.
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

Safe; output differs by OS.


## Command card 12: `sudo`

### Purpose

Run a command with elevated privileges.

### Example

```bash
sudo command
```

### Expected output

```text
Password prompt or command output.
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

High impact; avoid unless necessary.


## Command card 13: `find permission-like files`

### Purpose

Find files by pattern.

### Example

```bash
find . -name '.env' -o -name '*.pem' -o -name '*.key'
```

### Expected output

```text
Matching paths.
```

### Interpretation

This command helps explain access control state. The important fields are the active user, groups, target path, file type, owner, group and permission bits.

### Safety note

Safe search; review sensitive files.


## Permission reference tables

| Symbol | Meaning for file | Meaning for directory |
|---|---|---|
| `r` | read file content | list directory names |
| `w` | modify file content | create/delete/rename entries |
| `x` | execute file | enter/traverse directory |

| Mode | Meaning |
|---|---|
| `644` | documentation file, owner write, everyone read |
| `600` | private owner-only file |
| `755` | executable script or traversable directory |
| `700` | private owner-only executable/directory |
| `777` | everyone read/write/execute, usually avoid |


## Users and permissions study card 1: User context

### Concept

Always know which user is active before changing files or running scripts.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 2: Group context

### Concept

Groups explain shared access and can grant powerful permissions.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 3: Owner field

### Concept

The owner field in ls output explains who controls the file.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 4: Group field

### Concept

The group field explains shared access for group members.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 5: Others field

### Concept

Others means everyone not owner and not in the owning group.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 6: Execute bit

### Concept

Scripts need execute bit for ./script.sh but not for bash script.sh.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 7: Directory execute

### Concept

Directory execute permission means traversal, not program execution.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 8: chmod safety

### Concept

chmod changes metadata and should target specific files.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 9: chown safety

### Concept

chown can break access if used recursively or on the wrong path.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 10: sudo caution

### Concept

sudo should be used only when the need is understood.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 11: Hidden secrets

### Concept

Hidden files can contain secrets and must be reviewed before commit.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 12: Git mode changes

### Concept

Git can record executable bit changes.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 13: Private keys

### Concept

Private keys should not be committed.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 14: Logs privacy

### Concept

Logs can contain usernames, paths, tokens and IPs.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 15: Report clarity

### Concept

Permission findings should be written with user, path, owner, group and mode.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 16: User context

### Concept

Always know which user is active before changing files or running scripts.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 17: Group context

### Concept

Groups explain shared access and can grant powerful permissions.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 18: Owner field

### Concept

The owner field in ls output explains who controls the file.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 19: Group field

### Concept

The group field explains shared access for group members.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 20: Others field

### Concept

Others means everyone not owner and not in the owning group.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 21: Execute bit

### Concept

Scripts need execute bit for ./script.sh but not for bash script.sh.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 22: Directory execute

### Concept

Directory execute permission means traversal, not program execution.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 23: chmod safety

### Concept

chmod changes metadata and should target specific files.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 24: chown safety

### Concept

chown can break access if used recursively or on the wrong path.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 25: sudo caution

### Concept

sudo should be used only when the need is understood.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 26: Hidden secrets

### Concept

Hidden files can contain secrets and must be reviewed before commit.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 27: Git mode changes

### Concept

Git can record executable bit changes.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 28: Private keys

### Concept

Private keys should not be committed.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 29: Logs privacy

### Concept

Logs can contain usernames, paths, tokens and IPs.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 30: Report clarity

### Concept

Permission findings should be written with user, path, owner, group and mode.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 31: User context

### Concept

Always know which user is active before changing files or running scripts.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 32: Group context

### Concept

Groups explain shared access and can grant powerful permissions.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 33: Owner field

### Concept

The owner field in ls output explains who controls the file.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 34: Group field

### Concept

The group field explains shared access for group members.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 35: Others field

### Concept

Others means everyone not owner and not in the owning group.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 36: Execute bit

### Concept

Scripts need execute bit for ./script.sh but not for bash script.sh.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 37: Directory execute

### Concept

Directory execute permission means traversal, not program execution.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 38: chmod safety

### Concept

chmod changes metadata and should target specific files.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 39: chown safety

### Concept

chown can break access if used recursively or on the wrong path.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 40: sudo caution

### Concept

sudo should be used only when the need is understood.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 41: Hidden secrets

### Concept

Hidden files can contain secrets and must be reviewed before commit.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 42: Git mode changes

### Concept

Git can record executable bit changes.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 43: Private keys

### Concept

Private keys should not be committed.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 44: Logs privacy

### Concept

Logs can contain usernames, paths, tokens and IPs.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 45: Report clarity

### Concept

Permission findings should be written with user, path, owner, group and mode.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 46: User context

### Concept

Always know which user is active before changing files or running scripts.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 47: Group context

### Concept

Groups explain shared access and can grant powerful permissions.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 48: Owner field

### Concept

The owner field in ls output explains who controls the file.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 49: Group field

### Concept

The group field explains shared access for group members.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 50: Others field

### Concept

Others means everyone not owner and not in the owning group.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 51: Execute bit

### Concept

Scripts need execute bit for ./script.sh but not for bash script.sh.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 52: Directory execute

### Concept

Directory execute permission means traversal, not program execution.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 53: chmod safety

### Concept

chmod changes metadata and should target specific files.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 54: chown safety

### Concept

chown can break access if used recursively or on the wrong path.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 55: sudo caution

### Concept

sudo should be used only when the need is understood.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 56: Hidden secrets

### Concept

Hidden files can contain secrets and must be reviewed before commit.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 57: Git mode changes

### Concept

Git can record executable bit changes.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 58: Private keys

### Concept

Private keys should not be committed.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 59: Logs privacy

### Concept

Logs can contain usernames, paths, tokens and IPs.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 60: Report clarity

### Concept

Permission findings should be written with user, path, owner, group and mode.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 61: User context

### Concept

Always know which user is active before changing files or running scripts.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 62: Group context

### Concept

Groups explain shared access and can grant powerful permissions.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 63: Owner field

### Concept

The owner field in ls output explains who controls the file.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 64: Group field

### Concept

The group field explains shared access for group members.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 65: Others field

### Concept

Others means everyone not owner and not in the owning group.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 66: Execute bit

### Concept

Scripts need execute bit for ./script.sh but not for bash script.sh.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 67: Directory execute

### Concept

Directory execute permission means traversal, not program execution.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 68: chmod safety

### Concept

chmod changes metadata and should target specific files.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.


## Users and permissions study card 69: chown safety

### Concept

chown can break access if used recursively or on the wrong path.

### Practical check

```bash
whoami
id
ls -la
git status
```

These commands identify the active user, group membership, filesystem metadata and repository state. They are safe read-only checks and should be used before permission-changing commands.

### Interpretation pattern

A good interpretation should explain who is acting, what file or directory is involved, who owns it, what the permission bits allow, and whether any change is necessary.

### Repository connection

This concept appears whenever scripts need executable permissions, when hidden files must be reviewed, when generated reports should not leak private data, and when Docker access depends on user/group permissions.

### Safety note

Do not use broad recursive permission changes as a quick fix. Avoid `chmod 777` unless the environment is temporary and fully controlled.
