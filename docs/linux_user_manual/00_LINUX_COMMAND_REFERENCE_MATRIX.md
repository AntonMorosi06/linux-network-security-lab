# Linux Command Reference Matrix

## Purpose

This is the main command matrix for the Linux User Manual.

The table is designed to answer:

```text
What does the command do?
When should I use it?
What output should I expect?
Is it safe?
Which lab does it connect to?
```

## Command matrix

| Area | Command | Purpose | Example | Expected output | Risk level | Lab connection | Notes |
|---|---|---|---|---|---|---|---|
| Identity | `whoami` | Show current user | `whoami` | current username | Safe | Lab 001 | First identity check |
| Identity | `id` | Show UID, GID and groups | `id` | uid/gid/group list | Safe | Lab 001 | Useful for permission diagnosis |
| System | `uname -a` | Show kernel/system info | `uname -a` | kernel name/version/arch | Safe | Lab 001 | Good baseline command |
| System | `hostname` | Show machine hostname | `hostname` | local hostname | Safe | Lab 001 | Useful in reports |
| Filesystem | `pwd` | Show current directory | `pwd` | absolute path | Safe | Lab 001 | Helps avoid working in wrong folder |
| Filesystem | `ls -la` | List files with metadata | `ls -la` | permissions, owner, size | Safe | Lab 001 | Core navigation command |
| Filesystem | `cd` | Change directory | `cd docs` | no output if successful | Safe | All labs | Shell built-in |
| Filesystem | `tree` | Show folder tree | `tree -L 2` | directory hierarchy | Safe | Lab 016/020 | May need installation |
| Filesystem | `find` | Search files by rules | `find . -name "*.sh"` | matching file paths | Safe | CI/Lab 013 | Powerful and scriptable |
| Filesystem | `du -sh` | Show disk usage | `du -sh .` | total size | Safe | Audit | Useful before publishing |
| Filesystem | `df -h` | Show filesystem free space | `df -h` | disk usage by mount | Safe | Lab 001 | System capacity check |
| Text | `cat` | Print file content | `cat README.md` | file text | Safe | All labs | Use for short files |
| Text | `less` | Read file interactively | `less README.md` | pager view | Safe | All labs | Press `q` to quit |
| Text | `head` | Print first lines | `head -20 file` | first 20 lines | Safe | Logs/reports | Useful for previews |
| Text | `tail` | Print last lines | `tail -50 log.txt` | last 50 lines | Safe | Logs | `tail -f` follows logs |
| Text | `grep` | Search text | `grep "ERROR" file` | matching lines | Safe | Lab 003/018 | Core analysis command |
| Text | `awk` | Field processing | `awk '{print $1}' file` | selected fields | Safe | Logs | More advanced |
| Text | `sed` | Stream editing | `sed 's/a/b/g' file` | modified stream | Safe/Medium | Scripts | Risk depends on in-place use |
| Permissions | `chmod` | Change file permissions | `chmod +x script.sh` | no output if OK | Medium | All scripts | Can reduce or increase access |
| Permissions | `chown` | Change owner | `sudo chown user file` | no output if OK | High | Admin | Requires care |
| Permissions | `umask` | Show default permission mask | `umask` | numeric mask | Safe | Hardening | Affects new files |
| Processes | `ps aux` | List processes | `ps aux` | process table | Safe | Lab 003 | Good process baseline |
| Processes | `top` | Interactive process monitor | `top` | live process list | Safe | Lab 003 | Press `q` to quit |
| Processes | `pgrep` | Find process IDs | `pgrep -fl python` | matching processes | Safe | Lab 003 | Useful before stopping services |
| Processes | `kill` | Send signal to process | `kill PID` | no output if OK | Medium | Lab 003 | Can stop important processes |
| Services | `systemctl status` | Check systemd service | `systemctl status ssh` | service state/logs | Safe | Linux only | Not available on macOS |
| Services | `journalctl -xe` | View systemd logs | `journalctl -xe` | recent logs | Safe | Lab 003 | Linux/systemd |
| Network | `ip addr` | Show IP interfaces | `ip addr` | interface addresses | Safe | Lab 004 | Linux replacement for ifconfig |
| Network | `ip route` | Show routing table | `ip route` | default route and networks | Safe | Lab 004 | Essential route check |
| Network | `ping` | Test reachability | `ping -c 4 127.0.0.1` | replies and latency | Safe | Lab 004 | Use authorized targets |
| Network | `traceroute` | Show path to host | `traceroute example.com` | hop list | Safe/Medium | Lab 004 | Use only appropriate targets |
| Network | `curl` | HTTP client | `curl -i http://127.0.0.1:8080` | HTTP response | Safe | Lab 002+ | Very useful for APIs |
| Network | `ss -tulpen` | Show sockets/ports | `ss -tulpen` | listening ports | Safe | Lab 003 | Linux-specific |
| Network | `lsof -i -P -n` | Show network files | `lsof -i -P -n` | processes using ports | Safe | macOS/Linux | Useful fallback |
| DNS | `nslookup` | DNS query | `nslookup example.com` | DNS result | Safe | Lab 004 | Common diagnostic |
| DNS | `dig` | Advanced DNS query | `dig example.com` | DNS records | Safe | Lab 004 | Better than nslookup |
| Capture | `tcpdump` | Packet capture | `sudo tcpdump -i lo port 8080` | packet lines | High | Lab 002 | Use only local/authorized traffic |
| Firewall | `nft` | nftables control | `sudo nft list ruleset` | firewall rules | High | Lab 006 | Linux firewall command |
| Traffic | `tc` | Traffic control | `tc qdisc show` | qdisc state | High | Lab 007 | Can affect networking |
| Docker | `docker ps` | Show containers | `docker ps` | container list | Safe | Lab 010+ | Requires Docker |
| Docker | `docker logs` | Show container logs | `docker logs name` | container logs | Safe | Lab 010+ | Useful diagnosis |
| Docker | `docker inspect` | Detailed metadata | `docker inspect name` | JSON metadata | Safe | Lab 010+ | Large output |
| Compose | `docker compose up -d` | Start stack | `docker compose up -d` | service startup | Medium | Lab 011+ | Starts containers |
| Compose | `docker compose down` | Stop stack | `docker compose down` | cleanup output | Medium | Lab 011+ | Removes stack resources |
| Git | `git status` | Show repository state | `git status` | branch and changes | Safe | All labs | Always check before commit |
| Git | `git add` | Stage files | `git add docs/` | no output if OK | Medium | All labs | Prepares commit |
| Git | `git commit` | Create commit | `git commit -m "msg"` | commit hash | Medium | All labs | Permanent history locally |
| Git | `git push` | Push to remote | `git push origin main` | upload output | Medium | All labs | Publishes to GitHub |
