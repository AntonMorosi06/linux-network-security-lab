# Threat Model

## Scope

This threat model covers the Linux Network Security Lab repository and its local defensive labs.

In scope:

```text
local APIs
Docker labs
Docker Compose labs
network namespace labs
local logs
reports
GitHub Actions workflow
documentation
```

Out of scope:

```text
third-party networks
real production services
offensive exploitation
unauthorized scanning
real secrets
```

## Main assets

```text
repository integrity
local machine safety
lab services
logs and reports
Docker resources
namespace resources
documentation accuracy
GitHub workflow reliability
```

## Main entry points

```text
terminal commands
local HTTP endpoints
Docker published ports
reverse proxy endpoints
Prometheus UI
GitHub push events
scripts executed by the user
```

## Threats and mitigations

### Accidental public exposure

A local API or Docker service could be bound to all interfaces instead of localhost.

Mitigations include binding to `127.0.0.1`, documenting port mappings, inspecting listening ports and preferring local-only Docker publishing.

### Broken or unsafe scripts

A malformed script can fail or modify unintended resources.

Mitigations include Bash syntax checks, CI validation, clear variable names, explicit cleanup scripts and repository structure checks.

### Secrets accidentally committed

Real tokens or credentials could be added to the repo.

Mitigations include `.gitignore`, safe-use policy, fake lab tokens only and manual review before commit.

### Confusing lab traffic with real traffic

A user could run tests against unauthorized targets.

Mitigations include safety warnings, localhost defaults, controlled target addresses and documentation boundaries.

### Docker resource drift

Containers or networks could remain active after tests.

Mitigations include cleanup scripts, Docker inspect scripts, Docker ps checks and Compose down scripts.

## Security posture

Current posture:

```text
local-only design
safe-use policy
structured docs
CI checks
hardening checklist
risk register
cleanup procedures
```

Recommended improvements:

```text
branch protection
secret scanning notes
release checklist
Docker healthchecks
Makefile for common commands
```
