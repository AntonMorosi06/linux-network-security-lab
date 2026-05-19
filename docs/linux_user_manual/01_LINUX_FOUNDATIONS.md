# Linux Foundations

Linux is an operating system family built around the Linux kernel. In practice, when people say “Linux”, they usually mean a complete operating system distribution that includes the kernel, system libraries, command-line tools, package manager, shell, services and user-space applications.

A Linux distribution can be used as a desktop system, server system, container base image, embedded platform or cybersecurity lab environment. Common distributions include Ubuntu, Debian, Fedora, Arch Linux, Kali Linux and Alpine Linux. Each distribution has different defaults, but many command-line concepts remain similar.

The Linux command line is powerful because it exposes the system as a set of files, processes, users, permissions, sockets, logs and services. A good Linux workflow starts from observation before action. Commands such as `whoami`, `id`, `pwd`, `ls`, `uname`, `ip addr`, `ip route`, `ps`, `ss` and `journalctl` help understand the current state before modifying anything.

## Core mental model

```text
users run shells
shells launch processes
processes read/write files
files have permissions
services listen on ports
logs record events
package managers install software
network interfaces connect systems
```

## First baseline commands

```bash
whoami
id
hostname
uname -a
pwd
ls -la
date
```

## Expected output

```text
whoami          -> current username
id              -> uid, gid, groups
hostname        -> machine hostname
uname -a        -> kernel/system information
pwd             -> current working directory
ls -la          -> file list with permissions
date            -> current date/time
```

## Safety

These baseline commands are safe because they only read system state.
