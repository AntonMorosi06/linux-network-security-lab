# Linux Learning Map

| Stage | Topic | Main question | Core commands | Related file |
|---:|---|---|---|---|
| 1 | Context | Who, where, when? | `whoami`, `id`, `hostname`, `date`, `pwd`, `git status` | `01_LINUX_FOUNDATIONS.md` |
| 2 | Filesystem | Where are files? | `ls -la`, `find`, `tree`, `du -sh`, `df -h` | `02_FILESYSTEM_AND_PATHS.md` |
| 3 | Shell | How is input parsed? | `echo "$SHELL"`, `command -v`, `echo $?`, pipes, redirects | `03_TERMINAL_AND_SHELL.md` |
| 4 | Permissions | Who can access what? | `id`, `groups`, `ls -la`, `chmod`, `stat` | `04_USERS_GROUPS_AND_PERMISSIONS.md` |
| 5 | Processes | What is running? | `ps aux`, `pgrep -fl`, `top`, `lsof` | `05_PROCESSES_AND_SERVICES.md` |
| 6 | Networking | How does traffic move? | `ip addr`, `ip route`, `ping`, `curl` | `06_NETWORKING_BASICS.md` |
| 7 | Ports | What is listening? | `ss -tulpen`, `lsof -i -P -n`, `curl -i` | `07_PORTS_SOCKETS_AND_CONNECTIONS.md` |
| 8 | DNS/routing | Is it name, route or app failure? | `dig`, `nslookup`, `ip route`, `curl` | `08_DNS_ROUTING_AND_CONNECTIVITY.md` |
| 9 | Logs | What happened? | `tail`, `grep`, `journalctl`, `docker logs` | `09_LOGS_AND_SYSTEM_DIAGNOSTICS.md` |
| 10 | Packages | Is the tool installed? | `command -v`, `apt`, `dnf`, `brew`, `pip` | `10_PACKAGE_MANAGEMENT.md` |
| 11 | Hardening | What reduces risk? | `git status`, `find`, `ss`, `docker ps` | `11_SECURITY_AND_HARDENING.md` |
| 12 | Docker | What containers expose what? | `docker ps`, `docker compose ps`, `docker logs` | `12_DOCKER_AND_CONTAINERS.md` |
| 13 | Monitoring | Is it observable? | `/status`, `/health`, `/metrics`, Prometheus | `13_MONITORING_METRICS_AND_LOGS.md` |
| 14 | IR | What evidence supports the case? | context, ports, logs, timeline | `14_INCIDENT_RESPONSE_COMMANDS.md` |
| 15 | Troubleshooting | Which layer failed? | `pwd`, `command -v`, `lsof`, logs | `15_COMMON_ERRORS_AND_TROUBLESHOOTING.md` |
| 16 | Cybersecurity | How does Linux support defense? | context, permissions, logs, monitoring, IR | `16_LINUX_FOR_CYBERSECURITY.md` |
| 17 | Cheatsheets | What do I run quickly? | grouped command blocks | `17_LINUX_CHEATSHEETS.md` |
