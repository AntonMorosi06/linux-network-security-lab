# Containment Notes — Lab 019

## Local training context

This is a synthetic incident response case. No real containment action is required.

## If this were a real local service incident

Potential containment actions would include:

```text
confirm service binding
restrict service to localhost
rotate exposed API keys
disable affected endpoint temporarily
increase logging
preserve logs before cleanup
review reverse proxy rules
review firewall rules
review Docker published ports
```

## Safe lab containment

For this local lab:

```bash
docker ps
docker compose ps
lsof -i -P -n
git status
```

If lab services are running and no longer needed, stop them with their corresponding cleanup scripts.

## Evidence preservation

Before cleanup in a real case:

```text
export logs
save metrics snapshots
record timestamps
document commands run
avoid modifying evidence unnecessarily
```
