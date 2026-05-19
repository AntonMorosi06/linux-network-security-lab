# Linux User Manual — Practical Command Line, Networking and Security Handbook

## Purpose

This folder is a practical Linux handbook connected to the Linux Network Security Lab repository.

The goal is to explain not only which commands exist, but also when to use them, what output to expect, what risk level they have, and how they connect to the labs already present in the repository.

This manual is designed for:

```text
Linux command line practice
network diagnostics
local system diagnostics
security and hardening
Docker and monitoring basics
incident response workflow
portfolio-ready documentation
```

## Safety boundary

This handbook is defensive and educational. Commands should be used only on:

```text
your own machine
your own virtual machines
local containers
authorized lab environments
```

Do not run diagnostic, network, security or scanning commands against systems you do not own or do not have permission to test.

## Folder structure

```text
docs/linux_user_manual/
├── README.md
├── 00_LINUX_COMMAND_REFERENCE_MATRIX.md
├── 01_LINUX_FOUNDATIONS.md
├── 02_FILESYSTEM_AND_PATHS.md
├── 03_TERMINAL_AND_SHELL.md
├── 04_USERS_GROUPS_AND_PERMISSIONS.md
├── 05_PROCESSES_AND_SERVICES.md
├── 06_NETWORKING_BASICS.md
├── 07_PORTS_SOCKETS_AND_CONNECTIONS.md
├── 08_DNS_ROUTING_AND_CONNECTIVITY.md
├── 09_LOGS_AND_SYSTEM_DIAGNOSTICS.md
├── 10_PACKAGE_MANAGEMENT.md
├── 11_SECURITY_AND_HARDENING.md
├── 12_DOCKER_AND_CONTAINERS.md
├── 13_MONITORING_METRICS_AND_LOGS.md
├── 14_INCIDENT_RESPONSE_COMMANDS.md
├── 15_COMMON_ERRORS_AND_TROUBLESHOOTING.md
├── 16_LINUX_FOR_CYBERSECURITY.md
├── 17_LINUX_CHEATSHEETS.md
├── tables/
├── examples/
└── images/
```

## Recommended reading order

Start from:

```text
01_LINUX_FOUNDATIONS.md
02_FILESYSTEM_AND_PATHS.md
03_TERMINAL_AND_SHELL.md
04_USERS_GROUPS_AND_PERMISSIONS.md
05_PROCESSES_AND_SERVICES.md
06_NETWORKING_BASICS.md
00_LINUX_COMMAND_REFERENCE_MATRIX.md
```

Then continue with:

```text
09_LOGS_AND_SYSTEM_DIAGNOSTICS.md
11_SECURITY_AND_HARDENING.md
12_DOCKER_AND_CONTAINERS.md
13_MONITORING_METRICS_AND_LOGS.md
14_INCIDENT_RESPONSE_COMMANDS.md
```

## Main tables

The main command matrix is:

```text
00_LINUX_COMMAND_REFERENCE_MATRIX.md
```

Additional tables are stored in:

```text
tables/
```

## Diagrams

The `images/` folder contains lightweight SVG diagrams for:

```text
Linux filesystem tree
network stack
process lifecycle
permissions model
Docker networking
```

## Relation to labs

This manual explains the concepts behind the repository labs.

Examples:

```text
Filesystem and shell      -> Lab 001
Ports and processes       -> Lab 003
DNS and routing           -> Lab 004
Namespaces/firewall/NAT   -> Lab 005-007
API and logs              -> Lab 008-009
Docker                    -> Lab 010-011
Prometheus/Grafana        -> Lab 012 and Lab 017
SIEM and IR               -> Lab 018-019
Final packaging           -> Lab 020
```
