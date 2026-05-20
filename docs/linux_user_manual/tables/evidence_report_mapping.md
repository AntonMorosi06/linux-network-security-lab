# Evidence to Report Mapping

| Evidence source | Command/source | Important fields | Report focus |
|---|---|---|---|
| Context | `date`, `hostname`, `whoami` | time, host, user | where/when analysis happened |
| Git | `git status` | clean/modified/staged | repo state before/after change |
| Processes | `ps aux`, `pgrep -fl` | PID, user, command | expected or unexpected runtime |
| Ports | `ss`, `lsof` | address, port, process | exposure boundary |
| Docker | `docker ps`, Compose logs | container, status, ports | service state |
| HTTP | `curl -i` | status code, headers, body | app response |
| Logs | `tail`, `grep`, `journalctl` | timestamp, severity, message | event evidence |
| Metrics | `/metrics`, Prometheus query | metric name, value, labels | trend or state |
| SIEM-style events | JSONL detector output | rule, count, severity | synthetic finding |
| IR report | case file/timeline | summary, scope, lessons | final conclusion |
