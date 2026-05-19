# Incident Response Commands

Incident response starts with preserving context and collecting safe evidence.

## Safe local commands

```bash
date
hostname
whoami
uname -a
git status
ss -tulpen
lsof -i -P -n
docker ps
docker network ls
```

## Case documentation

A good case file includes:

```text
case ID
scope
timeline
evidence index
findings
severity
containment notes
lessons learned
```

## Repository connection

```text
Lab 018 -> SIEM-style detection
Lab 019 -> incident response case file
Lab 020 -> final proof-of-work review
```

## Safety

Do not collect or publish private logs unless reviewed and authorized.
