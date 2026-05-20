# Linux User Manual — Portfolio Overview

This document presents the Linux User Manual as a finished, portfolio-grade component of the `linux-network-security-lab` repository. The manual is not only a set of notes. It is a structured technical handbook connected to a complete local defensive lab sequence, visual reference material, expected command outputs, troubleshooting workflows, Docker and monitoring exercises, and incident response documentation.

The project demonstrates practical Linux, networking and cybersecurity skills in a safe environment. All work is designed for localhost, personal machines, virtual machines, containers, Linux namespaces and explicitly authorized labs. It does not promote unauthorized scanning, offensive testing or collection of private third-party data.

## Project identity

| Field | Value |
|---|---|
| Repository | `linux-network-security-lab` |
| Main manual path | `docs/linux_user_manual/` |
| Manual type | Linux, networking and defensive cybersecurity handbook |
| Lab style | Local, controlled, reproducible, report-driven |
| Safety model | Localhost, containers, namespaces, authorized systems only |
| Publication role | Portfolio proof-of-work and technical documentation |
| Current status | Main manual sequence complete, visual layer added |

## What this manual proves

The manual demonstrates that the author can work with Linux as a real operating environment rather than as a list of isolated commands. It covers system context, filesystem navigation, shell execution, users and permissions, processes and services, networking, ports and sockets, DNS and routing, logs, package management, hardening, Docker, monitoring, incident response and troubleshooting.

The strongest part of the work is the connection between command execution and interpretation. Each topic is designed around practical evidence: what command was run, what output is expected, what the output means, what risk level the command has, and how the result should be documented in a report.

## Main manual sequence

| Order | File | Purpose |
|---:|---|---|
| 0 | `README.md` | Entry point for the manual |
| 1 | `00_LINUX_COMMAND_REFERENCE_MATRIX.md` | Full command matrix with risk levels and interpretation |
| 2 | `01_LINUX_FOUNDATIONS.md` | Linux mental model, kernel/user space, distro and shell basics |
| 3 | `02_FILESYSTEM_AND_PATHS.md` | Filesystem tree, paths, metadata and repository-safe navigation |
| 4 | `03_TERMINAL_AND_SHELL.md` | Shell parsing, quoting, PATH, heredocs, pipes and scripts |
| 5 | `04_USERS_GROUPS_AND_PERMISSIONS.md` | Users, groups, ownership, permissions and least privilege |
| 6 | `05_PROCESSES_AND_SERVICES.md` | Process model, services, systemd, PIDs, signals and logs |
| 7 | `06_NETWORKING_BASICS.md` | Interfaces, routes, loopback, IPs, DNS, curl and TCP/UDP |
| 8 | `07_PORTS_SOCKETS_AND_CONNECTIONS.md` | Listener exposure, sockets, Docker mappings and process ownership |
| 9 | `08_DNS_ROUTING_AND_CONNECTIVITY.md` | Layered diagnosis for DNS, routing and HTTP reachability |
| 10 | `09_LOGS_AND_SYSTEM_DIAGNOSTICS.md` | Logs, journalctl, Docker logs, JSONL and evidence handling |
| 11 | `10_PACKAGE_MANAGEMENT.md` | apt, dnf, pacman, apk, Homebrew, pip and dependency safety |
| 12 | `11_SECURITY_AND_HARDENING.md` | Defensive hardening, secret review, port review and Git hygiene |
| 13 | `12_DOCKER_AND_CONTAINERS.md` | Docker images, containers, Compose, ports, volumes and logs |
| 14 | `13_MONITORING_METRICS_AND_LOGS.md` | Status, health, metrics, Prometheus, Grafana and alert logic |
| 15 | `14_INCIDENT_RESPONSE_COMMANDS.md` | Case files, timeline, evidence index and local IR workflow |
| 16 | `15_COMMON_ERRORS_AND_TROUBLESHOOTING.md` | Practical troubleshooting across shell, Git, Docker and networking |
| 17 | `16_LINUX_FOR_CYBERSECURITY.md` | Mapping Linux skills to defensive cybersecurity analyst work |
| 18 | `17_LINUX_CHEATSHEETS.md` | Quick-reference command blocks for lab execution |

## Visual and practical support layer

The manual includes a visual layer designed to make the project easier to review on GitHub.

| Asset group | Path | Role |
|---|---|---|
| Tables | `docs/linux_user_manual/tables/` | Learning maps, risk matrices and diagnostic decision tables |
| Images | `docs/linux_user_manual/images/` | SVG diagrams for system layers, networking, Docker and incident response |
| Examples | `docs/linux_user_manual/examples/` | Synthetic command outputs and mini report examples |
| Visual index | `docs/linux_user_manual/VISUAL_ASSETS_INDEX.md` | Index of visual and practical support files |
| Manifest | `docs/linux_user_manual/visual_assets_manifest.json` | Machine-readable index of visual assets |

## Suggested portfolio reading path

For a fast review, start with this file, then open `VISUAL_ASSETS_INDEX.md` and `tables/linux_learning_map.md`. After that, read the command matrix and one or two representative chapters, such as `07_PORTS_SOCKETS_AND_CONNECTIONS.md`, `11_SECURITY_AND_HARDENING.md`, `12_DOCKER_AND_CONTAINERS.md`, `13_MONITORING_METRICS_AND_LOGS.md` and `14_INCIDENT_RESPONSE_COMMANDS.md`.

For a deeper technical review, follow the numbered sequence from `00` to `17`. This shows the progression from Linux fundamentals to defensive cybersecurity workflows.

## Skills demonstrated

| Skill area | Evidence in the repository |
|---|---|
| Linux command line | command matrix, shell manual, cheatsheets |
| Filesystem and permissions | filesystem, users/groups and hardening chapters |
| Networking | networking, ports, DNS and connectivity chapters |
| Service diagnostics | processes/services, logs and troubleshooting chapters |
| Docker | Docker and Compose documentation plus lab integration |
| Monitoring | Prometheus/Grafana metrics and observability documentation |
| Cybersecurity fundamentals | hardening, threat modeling, incident response and safe-use boundaries |
| Reporting | expected outputs, examples, evidence mapping and final reports |
| GitHub portfolio practice | structured README, visual assets, manifests and commit-driven evolution |

## Why this is portfolio-grade

The manual is portfolio-grade because it combines theory, commands, expected outputs, safety boundaries, troubleshooting logic and evidence-based reporting. It does not simply say that Linux was studied; it shows a structured body of work that can be inspected, executed locally and extended.

The repository also shows professional habits: safe scope, local-only practice, synthetic examples, report templates, visual indexes, Git-based progression, and explicit separation between defensive learning and unauthorized activity.

## Safety statement

All examples are local, synthetic or intended for authorized environments. The manual should not be used to scan, test, probe or monitor systems without permission. Any real logs, secrets, credentials, private paths, screenshots or personal data must be reviewed and removed before publication.

## Next possible improvements

The next layer could include curated screenshots of the GitHub-rendered SVG diagrams, a release note for the completed manual, and a short public-facing project summary for a CV, portfolio website or GitHub pinned repository description.
