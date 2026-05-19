# Current Status

## Repository status

The repository currently contains a complete v0.1.0-style defensive baseline.

It includes 16 progressive labs covering Linux, networking, local services, Docker, monitoring, CI, threat modeling and release readiness.

## Technical maturity

Current status:

```text
documentation baseline: complete
local Linux diagnostics: complete
networking diagnostics: complete
namespace labs: complete
Docker labs: complete
monitoring baseline: complete
CI baseline: complete
threat model baseline: complete
capstone baseline: complete
release readiness baseline: prepared
```

## What is validated

The repository includes local and remote validation for:

```text
repository structure
Bash syntax
Python syntax
Docker Compose configuration
```

## What is not fully validated

Runtime behavior depends on the local environment.

Linux-only labs require Linux features such as:

```text
ip netns
nftables
tc/netem
```

Docker labs require Docker Desktop or Docker Engine.

Prometheus labs require Docker Compose services to start correctly.

## Publication state

The repository is close to a first public release, but before publishing a formal release it should be reviewed for:

```text
private information
generated reports
local machine data
screenshots
secret leakage
README clarity
GitHub Actions status
```
