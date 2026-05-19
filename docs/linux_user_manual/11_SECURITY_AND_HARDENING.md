# Security and Hardening

This file explains Linux security and hardening in depth for a local defensive lab environment. Hardening means reducing unnecessary risk by limiting exposure, using least privilege, reviewing services, protecting secrets, controlling permissions, validating configurations and documenting security decisions.

The purpose of this file is not to teach offensive security. It is a defensive checklist and explanation layer for the Linux Network Security Lab. The user should learn how to inspect local exposure, understand which services are running, avoid publishing secrets, use safe defaults, document risks, and keep all activities inside owned or explicitly authorized environments.


## 1. Hardening definition

Hardening is the process of reducing unnecessary attack surface and operational risk. In local labs, it means using localhost bindings, minimal services, reviewed permissions, safe logs and explicit cleanup.


## 2. Security boundary

The repository is defensive and local-first. Commands should be used on personal systems, local VMs, containers and authorized environments only.


## 3. Least privilege

Least privilege means using the minimum permissions needed. Avoid root and sudo unless necessary. Avoid broad permissions such as chmod 777.


## 4. Local-only binding

Services should bind to 127.0.0.1 when intended for local testing. A service bound to 0.0.0.0 may be exposed through external interfaces.


## 5. Service exposure

Exposure review asks what is listening, on which address, which port, which protocol, which process, which user and whether it is expected.


## 6. Port review

Use ss or lsof to inspect ports. A hardening review should identify unexpected listeners and broad bindings.


## 7. Process review

Use ps, pgrep and top to inspect running processes. Unexpected processes should be explained before being ignored.


## 8. Permission review

Use ls -la, id and groups to understand file access. Scripts, private files and generated reports should have appropriate modes.


## 9. Secrets

Secrets include tokens, passwords, API keys, private keys, certificates, .env files and credentials. They should not be committed to public repositories.


## 10. Secret scanning mindset

Before committing, search for secret-like files. Use find patterns for .env, .pem, .key, credentials and token-related names.


## 11. Git hygiene

Git status should be reviewed before commits. Untracked files may include logs, reports, screenshots, keys or generated artifacts.


## 12. Generated reports

Reports generated under ~/linux_lab may include local paths and hostnames. Review before publishing or copying into the repo.


## 13. Logs and privacy

Logs can contain usernames, paths, tokens, IPs and request data. Publish only synthetic or sanitized logs.


## 14. Docker exposure

Docker port mappings must be reviewed. Prefer 127.0.0.1 host bindings for local labs.


## 15. Docker privilege

Docker access can be powerful. A user who controls Docker may be able to affect the host. Treat Docker group membership as security-relevant.


## 16. Container secrets

Environment variables in containers may contain secrets. docker inspect can reveal environment variables, so review output before publishing.


## 17. Package trust

Installing packages means trusting the package source. Prefer official repositories and document third-party sources.


## 18. Updates

Security updates reduce known vulnerabilities. In local labs, keep tooling reasonably updated, but be aware that upgrades can change behavior.


## 19. Firewall concept

A firewall controls traffic. In Linux, nftables or ufw may be used depending on distribution. Firewall changes should be explicit and reversible.


## 20. nftables caution

nft commands can affect connectivity. Listing rules is safer than modifying them. Avoid flushing rules blindly.


## 21. ufw concept

ufw provides a simpler firewall interface on some Ubuntu systems. It is easier to use but still changes network policy.


## 22. SSH hardening

SSH exposure should be minimized. Use strong authentication, avoid unnecessary remote access and understand whether sshd is running.


## 23. Authentication

Authentication checks identity. Local API labs may use API keys to demonstrate protected endpoints.


## 24. Authorization

Authorization decides whether an authenticated identity can access a resource. 403-like behavior is authorization-related.


## 25. Input validation

Local APIs should validate input and return controlled errors. This prevents unexpected behavior and improves logs.


## 26. Error handling

Errors should be controlled and logged. A safe local service should not expose secrets in error messages.


## 27. Threat modeling

Threat modeling identifies assets, boundaries, entry points, threats, mitigations and assumptions.


## 28. Risk register

A risk register records risks, likelihood, impact, mitigation and status. It makes security reasoning explicit.


## 29. Hardening checklist

A checklist turns security review into a repeatable workflow. It reduces the chance of forgetting common issues.


## 30. CI validation

CI checks help prevent broken scripts, malformed files and accidental regressions. CI is part of repository hardening.


## 31. Safe use policy

A safe use policy states what the project is and is not intended for. This protects the project from misuse.


## 32. Incident response link

Hardening and incident response are connected. Hardening reduces risk; incident response documents what happens when something suspicious appears.


## 33. Portfolio safety

A portfolio repository should show skill without exposing private data, secrets, offensive misuse or uncontrolled infrastructure.


## 34. Manual review

Automation helps, but final security review requires human judgment. Always review README, reports, logs, screenshots and secrets before release.


## Command card 1: `git status`

### Purpose

Review repository state before commit.

### Example

```bash
git status
```

### Expected output

```text
Branch and changed files.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Safe read-only command.


## Command card 2: `find secret-like files`

### Purpose

Search for files that may contain secrets.

### Example

```bash
find . -name '.env' -o -name '*.pem' -o -name '*.key'
```

### Expected output

```text
Matching paths.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Safe search; review results carefully.


## Command card 3: `grep secret-like words`

### Purpose

Search for risky words in files.

### Example

```bash
grep -Rni 'token\|password\|secret\|api_key' .
```

### Expected output

```text
Matching lines.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

May reveal sensitive content; do not publish raw output.


## Command card 4: `ss -tulpen`

### Purpose

Inspect listening ports.

### Example

```bash
ss -tulpen
```

### Expected output

```text
Listening sockets and processes.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Safe Linux inspection.


## Command card 5: `lsof -i -P -n`

### Purpose

Inspect network sockets and processes.

### Example

```bash
lsof -i -P -n
```

### Expected output

```text
Processes using ports.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Safe macOS/Linux inspection.


## Command card 6: `ps aux`

### Purpose

Inspect running processes.

### Example

```bash
ps aux
```

### Expected output

```text
Process table.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Safe read-only command.


## Command card 7: `id`

### Purpose

Inspect current UID/GID/groups.

### Example

```bash
id
```

### Expected output

```text
uid, gid and groups.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Safe identity check.


## Command card 8: `ls -la`

### Purpose

Inspect file permissions.

### Example

```bash
ls -la
```

### Expected output

```text
Permissions, owner, group and names.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Safe read-only command.


## Command card 9: `docker ps`

### Purpose

Inspect containers and port mappings.

### Example

```bash
docker ps
```

### Expected output

```text
Containers and PORTS column.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Safe Docker inspection.


## Command card 10: `docker inspect`

### Purpose

Inspect detailed container metadata.

### Example

```bash
docker inspect container
```

### Expected output

```text
JSON metadata.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Can reveal env values; review before sharing.


## Command card 11: `docker compose ps`

### Purpose

Inspect Compose service state.

### Example

```bash
docker compose ps
```

### Expected output

```text
Services and ports.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Safe inspection.


## Command card 12: `nft list ruleset`

### Purpose

Inspect nftables firewall rules.

### Example

```bash
sudo nft list ruleset
```

### Expected output

```text
Firewall ruleset.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Read-only but may require sudo.


## Command card 13: `ufw status`

### Purpose

Inspect ufw firewall status.

### Example

```bash
sudo ufw status verbose
```

### Expected output

```text
Firewall status and rules.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Read-only but may require sudo.


## Command card 14: `chmod 600`

### Purpose

Restrict file to owner.

### Example

```bash
chmod 600 private.conf
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

State-changing; verify target.


## Command card 15: `chmod 777 warning`

### Purpose

Example of broad permission to avoid.

### Example

```bash
chmod 777 file
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command supports defensive review. A strong interpretation should state what risk or control was inspected, what was observed and whether the state matches the expected local lab boundary.

### Safety note

Usually avoid; too permissive.


## Security and hardening reference tables

| Hardening area | Question | Command/document |
|---|---|---|
| Identity | Who is running commands? | `whoami`, `id` |
| Permissions | Are files too open? | `ls -la`, `chmod` review |
| Secrets | Are secrets present? | `find`, `grep`, `.gitignore` |
| Ports | What is listening? | `ss`, `lsof` |
| Docker | What ports are published? | `docker ps`, Compose YAML |
| Firewall | What rules exist? | `nft list ruleset`, `ufw status` |
| Logs | Are logs safe to publish? | manual review |
| CI | Do validation checks pass? | GitHub Actions, local CI |
| Threat model | What are assets and risks? | `security/THREAT_MODEL.md` |
| Release | Is publication safe? | release checklist |

| Risk | Example | Safer habit |
|---|---|---|
| Secret commit | `.env` tracked | keep ignored and reviewed |
| Broad binding | `0.0.0.0:PORT` | prefer `127.0.0.1:PORT` for labs |
| Broad permissions | `chmod 777` | use least required mode |
| Raw logs | private paths/tokens | sanitize or use synthetic logs |
| Docker exposure | broad published ports | bind host port to localhost |


## Security and hardening study card 1: Least privilege

### Concept

Use only the permissions needed for the task.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 2: Local binding

### Concept

Prefer 127.0.0.1 for local lab services.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 3: Secret review

### Concept

Search for secret-like files before commit.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 4: Log review

### Concept

Logs may contain sensitive paths or tokens.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 5: Docker ports

### Concept

Docker published ports define exposure.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 6: Git review

### Concept

git status prevents accidental publication.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 7: Threat model

### Concept

Threat modeling makes assumptions explicit.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 8: Risk register

### Concept

A risk register turns vague concerns into tracked items.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 9: CI hardening

### Concept

CI catches broken scripts and invalid files.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 10: Firewall caution

### Concept

Firewall changes can break connectivity.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 11: Sudo caution

### Concept

sudo should be justified and scoped.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 12: API keys

### Concept

API keys demonstrate access control but must not be real secrets.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 13: Screenshots

### Concept

Screenshots can leak private UI or paths.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 14: Generated reports

### Concept

Generated reports need review before publication.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 15: Safe use

### Concept

Documentation should state authorized-use boundaries.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 16: Least privilege

### Concept

Use only the permissions needed for the task.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 17: Local binding

### Concept

Prefer 127.0.0.1 for local lab services.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 18: Secret review

### Concept

Search for secret-like files before commit.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 19: Log review

### Concept

Logs may contain sensitive paths or tokens.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 20: Docker ports

### Concept

Docker published ports define exposure.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 21: Git review

### Concept

git status prevents accidental publication.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 22: Threat model

### Concept

Threat modeling makes assumptions explicit.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 23: Risk register

### Concept

A risk register turns vague concerns into tracked items.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 24: CI hardening

### Concept

CI catches broken scripts and invalid files.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 25: Firewall caution

### Concept

Firewall changes can break connectivity.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 26: Sudo caution

### Concept

sudo should be justified and scoped.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 27: API keys

### Concept

API keys demonstrate access control but must not be real secrets.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 28: Screenshots

### Concept

Screenshots can leak private UI or paths.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 29: Generated reports

### Concept

Generated reports need review before publication.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 30: Safe use

### Concept

Documentation should state authorized-use boundaries.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 31: Least privilege

### Concept

Use only the permissions needed for the task.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 32: Local binding

### Concept

Prefer 127.0.0.1 for local lab services.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 33: Secret review

### Concept

Search for secret-like files before commit.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 34: Log review

### Concept

Logs may contain sensitive paths or tokens.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 35: Docker ports

### Concept

Docker published ports define exposure.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 36: Git review

### Concept

git status prevents accidental publication.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 37: Threat model

### Concept

Threat modeling makes assumptions explicit.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 38: Risk register

### Concept

A risk register turns vague concerns into tracked items.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 39: CI hardening

### Concept

CI catches broken scripts and invalid files.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 40: Firewall caution

### Concept

Firewall changes can break connectivity.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 41: Sudo caution

### Concept

sudo should be justified and scoped.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 42: API keys

### Concept

API keys demonstrate access control but must not be real secrets.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 43: Screenshots

### Concept

Screenshots can leak private UI or paths.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 44: Generated reports

### Concept

Generated reports need review before publication.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 45: Safe use

### Concept

Documentation should state authorized-use boundaries.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 46: Least privilege

### Concept

Use only the permissions needed for the task.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 47: Local binding

### Concept

Prefer 127.0.0.1 for local lab services.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 48: Secret review

### Concept

Search for secret-like files before commit.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 49: Log review

### Concept

Logs may contain sensitive paths or tokens.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 50: Docker ports

### Concept

Docker published ports define exposure.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 51: Git review

### Concept

git status prevents accidental publication.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 52: Threat model

### Concept

Threat modeling makes assumptions explicit.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 53: Risk register

### Concept

A risk register turns vague concerns into tracked items.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 54: CI hardening

### Concept

CI catches broken scripts and invalid files.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 55: Firewall caution

### Concept

Firewall changes can break connectivity.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 56: Sudo caution

### Concept

sudo should be justified and scoped.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 57: API keys

### Concept

API keys demonstrate access control but must not be real secrets.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 58: Screenshots

### Concept

Screenshots can leak private UI or paths.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 59: Generated reports

### Concept

Generated reports need review before publication.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 60: Safe use

### Concept

Documentation should state authorized-use boundaries.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 61: Least privilege

### Concept

Use only the permissions needed for the task.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 62: Local binding

### Concept

Prefer 127.0.0.1 for local lab services.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 63: Secret review

### Concept

Search for secret-like files before commit.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 64: Log review

### Concept

Logs may contain sensitive paths or tokens.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 65: Docker ports

### Concept

Docker published ports define exposure.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 66: Git review

### Concept

git status prevents accidental publication.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 67: Threat model

### Concept

Threat modeling makes assumptions explicit.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 68: Risk register

### Concept

A risk register turns vague concerns into tracked items.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.


## Security and hardening study card 69: CI hardening

### Concept

CI catches broken scripts and invalid files.

### Practical check

```bash
git status
find . -name ".env" -o -name "*.pem" -o -name "*.key"
ss -tulpen
docker ps
```

These commands inspect repository state, potential secret-like files, local listeners and Docker port mappings. They support a practical hardening review.

### Interpretation pattern

A good interpretation should identify the risk category, observed evidence, expected safe state and next action if something does not match.

### Repository connection

This concept appears in API security, Docker labs, threat modeling, capstone service, release engineering and final proof-of-work review.

### Safety note

Do not publish raw output that may contain secrets, private paths, hostnames, tokens or sensitive logs.
