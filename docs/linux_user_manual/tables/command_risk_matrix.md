# Command Risk Matrix

| Risk | Command family | Examples | Safe habit |
|---|---|---|---|
| Safe | Context | `whoami`, `id`, `hostname`, `date`, `pwd` | Run before deeper checks |
| Safe | Read filesystem | `ls -la`, `find`, `du -sh`, `df -h` | Verify target paths |
| Safe | Inspect network | `ss`, `lsof`, `ip route` | Interpret binding address |
| Safe/Medium | Logs | `tail`, `grep`, `journalctl`, `docker logs` | Review privacy before sharing |
| Medium | File changes | `mkdir`, `touch`, `cp`, `mv`, `chmod` | Change only intended files |
| Medium | Runtime changes | `docker compose up/down`, `kill PID` | Confirm service/PID first |
| Medium | Git publish | `git add`, `git commit`, `git push` | Search secrets before push |
| High | Admin ownership | `sudo chown`, broad `chmod` | Avoid broad recursive changes |
| High | Firewall/network policy | `nft`, `ufw`, `tc` | Keep lab-only and reversible |
| High | Destructive cleanup | `rm -rf`, `docker system prune -a`, `git reset --hard` | Use only with explicit intent and backup |
