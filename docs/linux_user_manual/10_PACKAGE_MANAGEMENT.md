# Package Management

This file explains package management in Linux and related development environments. Package management is the controlled process of installing, updating, removing and auditing software. It matters because many Linux commands used in this repository may not exist by default on every system. Tools such as `tree`, `dig`, `traceroute`, `tcpdump`, Docker, Python packages and monitoring utilities may require installation depending on the environment.

The purpose of this file is to make package management safe, explainable and reportable. A package command is not just a way to install something quickly. It changes the system. It may add binaries, libraries, configuration files, services, users, groups, caches and dependencies. A good Linux workflow distinguishes between checking whether a tool exists, installing it through the correct package manager, verifying the installation and documenting what changed.


## 1. What a package is

A package is a structured unit of software distributed by an operating system or package ecosystem. It can contain executable programs, libraries, configuration files, documentation, service definitions and metadata.


## 2. Why package managers exist

Package managers solve the problem of installing software together with dependencies, versions, repositories and update logic. Without a package manager, users would manually download, compile and track software, which is error-prone.


## 3. Repositories

A repository is a source of packages. Linux distributions maintain official repositories. Third-party repositories may provide additional packages but require more trust and review.


## 4. Dependencies

A dependency is software required by another package. Installing one package may install many dependencies. This is normal, but should be understood before installing software on a production or security-sensitive system.


## 5. Package metadata

Packages include metadata such as name, version, architecture, dependencies, maintainer, description and installed files. This metadata helps with search, audit and removal.


## 6. Installing versus updating

Installing adds new software. Updating refreshes package metadata or upgrades installed software. These are different operations and should not be confused.


## 7. Removing packages

Removing a package deletes installed software, but may leave configuration files depending on the package manager and command. Purge-style commands may remove configuration too.


## 8. System package managers

System package managers manage software at the operating-system level. Examples include `apt`, `dnf`, `pacman`, `apk` and `zypper`. They generally require administrative privileges for installation.


## 9. Language package managers

Language package managers manage libraries for a programming ecosystem. Examples include `pip` for Python, `npm` for Node.js, `cargo` for Rust and `gem` for Ruby.


## 10. Homebrew

Homebrew is common on macOS and can install developer tools such as Python, Git, tree, wget, jq and other utilities. It is not a Linux distribution package manager, but it fills a similar role for development workflows.


## 11. apt

`apt` is common on Debian and Ubuntu systems. Typical commands include `sudo apt update`, `sudo apt install package`, `sudo apt remove package` and `apt search package`.


## 12. dnf

`dnf` is common on Fedora and related systems. Typical commands include `sudo dnf install package`, `sudo dnf remove package` and `dnf search package`.


## 13. pacman

`pacman` is the Arch Linux package manager. It uses commands such as `sudo pacman -S package`, `sudo pacman -R package` and `pacman -Ss package`.


## 14. apk

`apk` is used by Alpine Linux. It is common in lightweight containers. Commands include `apk add package`, `apk del package` and `apk search package`.


## 15. zypper

`zypper` is used by openSUSE and SUSE systems. Commands include `zypper install`, `zypper remove` and `zypper search`.


## 16. Checking command availability

Before installing anything, check whether the command already exists. Use `command -v tool`, `tool --version` or package-manager query commands.


## 17. PATH and package tools

A package can be installed but not found if its binary directory is not in PATH. This is common with some language package managers and user-local installs.


## 18. sudo and package management

System-level package installation usually requires sudo. This means package management can modify protected system areas and should be treated as state-changing.


## 19. Package cache

Package managers often keep cache metadata. Commands such as `apt update` refresh package lists; they do not necessarily upgrade installed packages.


## 20. Upgrade risk

Upgrading packages can change behavior. On production systems, upgrades should be planned. In local labs, upgrades are usually safer but still worth documenting.


## 21. Security updates

Security updates fix known vulnerabilities. Keeping packages updated is part of system hardening, but updates should be obtained from trusted sources.


## 22. Third-party repositories

Third-party repositories expand available software but increase trust risk. Before adding one, understand who maintains it and why it is needed.


## 23. Installing diagnostic tools

Tools such as `tree`, `dig`, `traceroute`, `tcpdump`, `jq` and Docker are useful in this repository. The exact installation command depends on the operating system.


## 24. Installing Docker

Docker installation varies by platform. On macOS, Docker Desktop is common. On Linux, Docker may be installed from distribution repositories or official Docker repositories.


## 25. Python packages

Python packages should often be installed inside a virtual environment. Installing Python packages globally can create version conflicts.


## 26. Virtual environments

A Python virtual environment isolates project dependencies. It is a safer pattern than installing every Python package globally.


## 27. Requirements files

`requirements.txt` lists Python dependencies. Installing from it with `pip install -r requirements.txt` should ideally happen inside a virtual environment.


## 28. Node packages

Node.js projects often use `npm install` to install dependencies from `package.json`. This can create a large `node_modules` directory that usually should not be committed.


## 29. Generated dependencies and Git

Dependency folders such as `.venv`, `node_modules` and package caches should normally be excluded from Git using `.gitignore`.


## 30. Package management and security

Packages are code. Installing a package means trusting its source. Security-aware package management requires official sources, version awareness and minimal unnecessary installs.


## 31. Package management in reports

A good report should mention when a tool was missing, which package manager was used, which package was installed and how installation was verified.


## 32. macOS versus Linux

The user may work on macOS while studying Linux. Homebrew commands are useful locally, but Linux-specific labs may still require a Linux VM or container.


## 33. Containers and package managers

Containers often use package managers inside Dockerfiles. For example, an Ubuntu image may use apt, while an Alpine image may use apk.


## 34. Cleanup after package experiments

If software was installed only for a test, document it and consider whether it should remain. Avoid cluttering a system with tools that are no longer needed.


## Command card 1: `command -v`

### Purpose

Check whether a command exists in PATH.

### Example

```bash
command -v tree
```

### Expected output

```text
/usr/bin/tree or no output
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

Safe read-only check before installing.


## Command card 2: `tool --version`

### Purpose

Check installed tool version.

### Example

```bash
python3 --version
```

### Expected output

```text
Version string.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

Safe; not every tool supports --version.


## Command card 3: `apt update`

### Purpose

Refresh apt package metadata.

### Example

```bash
sudo apt update
```

### Expected output

```text
Repository metadata update output.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

State-changing; Debian/Ubuntu.


## Command card 4: `apt install`

### Purpose

Install a package with apt.

### Example

```bash
sudo apt install tree
```

### Expected output

```text
Package install output.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

State-changing; review package name.


## Command card 5: `apt remove`

### Purpose

Remove a package with apt.

### Example

```bash
sudo apt remove tree
```

### Expected output

```text
Removal output.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

State-changing.


## Command card 6: `apt search`

### Purpose

Search apt packages.

### Example

```bash
apt search tcpdump
```

### Expected output

```text
Matching packages.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

Safe read-only.


## Command card 7: `dnf install`

### Purpose

Install package with dnf.

### Example

```bash
sudo dnf install tree
```

### Expected output

```text
Install output.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

State-changing; Fedora.


## Command card 8: `dnf search`

### Purpose

Search dnf packages.

### Example

```bash
dnf search tcpdump
```

### Expected output

```text
Matching packages.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

Safe read-only.


## Command card 9: `pacman -S`

### Purpose

Install package with pacman.

### Example

```bash
sudo pacman -S tree
```

### Expected output

```text
Install output.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

State-changing; Arch.


## Command card 10: `pacman -Ss`

### Purpose

Search pacman packages.

### Example

```bash
pacman -Ss tcpdump
```

### Expected output

```text
Matching packages.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

Safe read-only.


## Command card 11: `apk add`

### Purpose

Install package with apk.

### Example

```bash
apk add curl
```

### Expected output

```text
Install output.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

State-changing; Alpine.


## Command card 12: `apk search`

### Purpose

Search Alpine packages.

### Example

```bash
apk search tcpdump
```

### Expected output

```text
Matching packages.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

Safe read-only.


## Command card 13: `brew install`

### Purpose

Install package with Homebrew.

### Example

```bash
brew install tree
```

### Expected output

```text
Install output.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

State-changing; macOS developer environment.


## Command card 14: `brew search`

### Purpose

Search Homebrew packages.

### Example

```bash
brew search jq
```

### Expected output

```text
Matching packages.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

Safe read-only.


## Command card 15: `pip install`

### Purpose

Install Python package.

### Example

```bash
pip install requests
```

### Expected output

```text
Install output.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

Use virtual environment when possible.


## Command card 16: `python3 -m venv`

### Purpose

Create Python virtual environment.

### Example

```bash
python3 -m venv .venv
```

### Expected output

```text
Creates .venv directory.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

State-changing in project folder.


## Command card 17: `pip freeze`

### Purpose

List Python packages.

### Example

```bash
pip freeze
```

### Expected output

```text
Installed package list.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

Safe but may reveal environment details.


## Command card 18: `npm install`

### Purpose

Install Node dependencies.

### Example

```bash
npm install
```

### Expected output

```text
Creates/updates node_modules and lockfile.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

State-changing; node_modules should not be committed.


## Command card 19: `docker --version`

### Purpose

Check Docker version.

### Example

```bash
docker --version
```

### Expected output

```text
Docker version string.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

Safe availability check.


## Command card 20: `jq --version`

### Purpose

Check jq version.

### Example

```bash
jq --version
```

### Expected output

```text
jq version string.
```

### Interpretation

This command helps determine whether a tool exists, whether package metadata is available, whether software was installed, or whether dependencies are present. A strong interpretation should state the environment, package manager, package name and verification result.

### Safety note

Safe availability check.


## Package management reference tables

| System | Package manager | Install example | Search example |
|---|---|---|---|
| Debian/Ubuntu | `apt` | `sudo apt install tree` | `apt search tree` |
| Fedora | `dnf` | `sudo dnf install tree` | `dnf search tree` |
| Arch | `pacman` | `sudo pacman -S tree` | `pacman -Ss tree` |
| Alpine | `apk` | `apk add tree` | `apk search tree` |
| openSUSE | `zypper` | `sudo zypper install tree` | `zypper search tree` |
| macOS | `brew` | `brew install tree` | `brew search tree` |
| Python | `pip` | `pip install package` | `pip index versions package` |
| Node.js | `npm` | `npm install` | `npm search package` |

| Tool | Why useful in this repo |
|---|---|
| `tree` | directory overview |
| `curl` | HTTP/API testing |
| `dig` | DNS diagnostics |
| `traceroute` | path diagnostics |
| `tcpdump` | packet observation in authorized labs |
| `jq` | JSON inspection |
| `docker` | container labs |
| `git` | repository workflow |
| `python3` | scripts and analyzers |


## Package management study card 1: Check first

### Concept

Always check whether a command already exists before installing it.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 2: Install minimally

### Concept

Install only tools needed for the current task.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 3: Trusted sources

### Concept

Prefer official repositories and well-known package sources.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 4: Version awareness

### Concept

Record tool versions when they affect lab behavior.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 5: Virtual environments

### Concept

Use Python virtual environments to avoid global dependency conflicts.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 6: Dependency folders

### Concept

Do not commit .venv or node_modules.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 7: System changes

### Concept

Package installation changes the system and should be documented.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 8: Sudo caution

### Concept

sudo gives administrative power; use only when necessary.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 9: macOS distinction

### Concept

Homebrew is useful on macOS but does not make macOS a Linux system.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 10: Container distinction

### Concept

Package installs inside containers affect images or container layers, not necessarily the host.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 11: Search before install

### Concept

Search commands help find correct package names.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 12: Remove carefully

### Concept

Removing packages can affect dependencies.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 13: Security updates

### Concept

Updates are important but should be planned in sensitive systems.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 14: Report clarity

### Concept

Reports should state what was installed and why.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 15: Git hygiene

### Concept

Generated dependency folders should be ignored.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 16: Check first

### Concept

Always check whether a command already exists before installing it.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 17: Install minimally

### Concept

Install only tools needed for the current task.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 18: Trusted sources

### Concept

Prefer official repositories and well-known package sources.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 19: Version awareness

### Concept

Record tool versions when they affect lab behavior.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 20: Virtual environments

### Concept

Use Python virtual environments to avoid global dependency conflicts.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 21: Dependency folders

### Concept

Do not commit .venv or node_modules.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 22: System changes

### Concept

Package installation changes the system and should be documented.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 23: Sudo caution

### Concept

sudo gives administrative power; use only when necessary.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 24: macOS distinction

### Concept

Homebrew is useful on macOS but does not make macOS a Linux system.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 25: Container distinction

### Concept

Package installs inside containers affect images or container layers, not necessarily the host.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 26: Search before install

### Concept

Search commands help find correct package names.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 27: Remove carefully

### Concept

Removing packages can affect dependencies.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 28: Security updates

### Concept

Updates are important but should be planned in sensitive systems.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 29: Report clarity

### Concept

Reports should state what was installed and why.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 30: Git hygiene

### Concept

Generated dependency folders should be ignored.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 31: Check first

### Concept

Always check whether a command already exists before installing it.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 32: Install minimally

### Concept

Install only tools needed for the current task.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 33: Trusted sources

### Concept

Prefer official repositories and well-known package sources.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 34: Version awareness

### Concept

Record tool versions when they affect lab behavior.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 35: Virtual environments

### Concept

Use Python virtual environments to avoid global dependency conflicts.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 36: Dependency folders

### Concept

Do not commit .venv or node_modules.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 37: System changes

### Concept

Package installation changes the system and should be documented.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 38: Sudo caution

### Concept

sudo gives administrative power; use only when necessary.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 39: macOS distinction

### Concept

Homebrew is useful on macOS but does not make macOS a Linux system.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 40: Container distinction

### Concept

Package installs inside containers affect images or container layers, not necessarily the host.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 41: Search before install

### Concept

Search commands help find correct package names.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 42: Remove carefully

### Concept

Removing packages can affect dependencies.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 43: Security updates

### Concept

Updates are important but should be planned in sensitive systems.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 44: Report clarity

### Concept

Reports should state what was installed and why.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 45: Git hygiene

### Concept

Generated dependency folders should be ignored.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 46: Check first

### Concept

Always check whether a command already exists before installing it.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 47: Install minimally

### Concept

Install only tools needed for the current task.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 48: Trusted sources

### Concept

Prefer official repositories and well-known package sources.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 49: Version awareness

### Concept

Record tool versions when they affect lab behavior.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 50: Virtual environments

### Concept

Use Python virtual environments to avoid global dependency conflicts.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 51: Dependency folders

### Concept

Do not commit .venv or node_modules.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 52: System changes

### Concept

Package installation changes the system and should be documented.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 53: Sudo caution

### Concept

sudo gives administrative power; use only when necessary.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 54: macOS distinction

### Concept

Homebrew is useful on macOS but does not make macOS a Linux system.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 55: Container distinction

### Concept

Package installs inside containers affect images or container layers, not necessarily the host.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 56: Search before install

### Concept

Search commands help find correct package names.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 57: Remove carefully

### Concept

Removing packages can affect dependencies.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 58: Security updates

### Concept

Updates are important but should be planned in sensitive systems.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 59: Report clarity

### Concept

Reports should state what was installed and why.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 60: Git hygiene

### Concept

Generated dependency folders should be ignored.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 61: Check first

### Concept

Always check whether a command already exists before installing it.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 62: Install minimally

### Concept

Install only tools needed for the current task.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 63: Trusted sources

### Concept

Prefer official repositories and well-known package sources.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 64: Version awareness

### Concept

Record tool versions when they affect lab behavior.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 65: Virtual environments

### Concept

Use Python virtual environments to avoid global dependency conflicts.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 66: Dependency folders

### Concept

Do not commit .venv or node_modules.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 67: System changes

### Concept

Package installation changes the system and should be documented.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 68: Sudo caution

### Concept

sudo gives administrative power; use only when necessary.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.


## Package management study card 69: macOS distinction

### Concept

Homebrew is useful on macOS but does not make macOS a Linux system.

### Practical check

```bash
command -v tree
command -v docker
python3 --version
git status
```

These commands check command availability, runtime environment and repository state before installing or modifying dependencies.

### Interpretation pattern

A good interpretation should identify whether the tool already existed, which package manager is appropriate, whether installation is necessary and how the result was verified.

### Repository connection

This concept appears when installing diagnostic tools, Docker utilities, Python dependencies, JSON tools and documentation helpers needed for the Linux Network Security Lab.

### Safety note

Package installation is state-changing. Review the command, source and package name before running it.
