# Release Notes — v0.1.0

## Linux Network Security Lab v0.1.0

This release candidate represents the first structured public baseline of the Linux Network Security Lab repository.

It contains a progressive sequence of local and defensive labs covering Linux diagnostics, networking, local services, packet capture, network namespaces, firewalling, NAT, traffic shaping, API security, Docker, Docker Compose, metrics, CI, threat modeling and release readiness.

## What is included

The release includes 16 labs:

```text
001 local system baseline
002 local HTTP and tcpdump
003 ports, processes and logs
004 DNS, routing and connectivity
005 namespace client-router-server topology
006 namespace firewall and NAT
007 traffic shaping with tc/netem
008 local JSON API and mini detector
009 local API security controls
010 Docker bridge networking
011 Docker Compose reverse proxy
012 Prometheus-style metrics
013 GitHub Actions CI
014 threat modeling and hardening
015 final capstone secure service
016 release engineering and publication readiness
```

## Safety model

The repository is built around local and authorized environments:

```text
localhost
personal machines
virtual machines
containers
Linux network namespaces
explicitly authorized labs
```

It is not intended for unauthorized scanning, exploitation or testing of third-party systems.

## Capstone

The capstone stack combines:

```text
Docker Compose
Nginx reverse proxy
Python API
API key protection
Prometheus metrics
structured logs
local report generation
cleanup scripts
```

## Quality controls

The repository includes:

```text
GitHub Actions CI
local validation scripts
Bash syntax checks
Python syntax checks
Docker Compose config checks
repository structure checks
```

## Known limitations

The project is a local learning lab, not a production security platform.

Some labs require Linux-specific features such as:

```text
ip netns
nftables
tc/netem
```

Docker labs require Docker Desktop or Docker Engine.

Generated reports may include local machine information and should be reviewed before publishing.

## Recommended next steps

Future releases may add:

```text
Grafana dashboards
alerting rules
Kubernetes local lab
Makefile command shortcuts
SIEM-style log pipeline
OpenTelemetry traces
screenshots and diagrams
GitHub release assets
```
