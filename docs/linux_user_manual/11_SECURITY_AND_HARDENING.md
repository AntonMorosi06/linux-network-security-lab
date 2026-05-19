# Security and Hardening

Hardening means reducing unnecessary exposure and making the system safer.

## Local checks

```bash
whoami
id
ss -tulpen
lsof -i -P -n
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
```

## Practical hardening principles

```text
keep services local unless needed
avoid running as root unnecessarily
do not commit secrets
review logs before publishing
stop containers after tests
validate scripts before push
use CI checks
document safety boundaries
```

## Repository connection

This repository includes:

```text
security/SAFE_USE_POLICY.md
security/THREAT_MODEL.md
security/HARDENING_CHECKLIST.md
security/RISK_REGISTER.md
```

## Safe practice

Security commands should be run only in authorized environments.
