# Capstone Secure Local Service Notes

The capstone lab combines the main repository topics into one local stack.

The architecture is:

```text
host -> reverse proxy -> API -> metrics -> Prometheus
```

The defensive controls are:

```text
localhost-only publishing
API not directly exposed
API key for protected endpoints
structured responses
structured events
Prometheus metrics
Docker Compose lifecycle
report generation
cleanup scripts
CI validation
threat model documentation
```

This is not a production system. It is a local proof-of-work capstone for Linux, networking, Docker, API security and observability.
