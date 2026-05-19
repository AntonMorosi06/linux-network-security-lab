# Asset Inventory

## Purpose

This document lists assets protected and documented inside the Linux Network Security Lab repository.

## Primary assets

The main assets are the repository content, local API services, Docker and Docker Compose services, network namespace topology, generated logs, generated reports, GitHub Actions workflow and technical documentation.

## Local API assets

```text
Lab 008 JSON API
Lab 009 secure API
Lab 010 Docker API
Lab 011 Compose API
Lab 012 metrics API
```

## Docker assets

```text
single-container API
reverse proxy
metrics API
Prometheus
custom bridge networks
Compose networks
```

## Namespace assets

```text
lab_client
lab_router
lab_server
veth links
nftables rules
tc/netem qdisc state
```

## Sensitive assets that must not be committed

```text
real secrets
real API keys
private certificates
private logs
tokens
.env files
private packet captures
personal credentials
```

The tokens used in the labs are intentionally fake and local-only.
