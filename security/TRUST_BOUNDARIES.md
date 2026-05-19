# Trust Boundaries

## Host to local API

```text
host terminal/browser -> 127.0.0.1 API service
```

Controls include localhost binding, API key in Lab 009, structured logs and input validation.

## Host to Docker container

```text
host -> published Docker port -> container service
```

Controls include publishing to `127.0.0.1`, port inspection and cleanup scripts.

## Reverse proxy to API

```text
reverse_proxy -> api
```

Controls include Nginx configuration, Docker Compose network, API not directly published and logs from both services.

## Prometheus to metrics API

```text
prometheus -> metrics_api:/metrics
```

Controls include Prometheus scrape configuration, target checks and query scripts.

## Namespace client/router/server

```text
lab_client -> lab_router -> lab_server
```

Controls include isolated namespace topology, nftables inside router namespace, cleanup scripts and tcpdump observation.

## Repository to GitHub Actions runner

```text
GitHub repository -> GitHub Actions ubuntu runner
```

Controls include CI workflow, syntax checks, structure checks and Compose config checks.
