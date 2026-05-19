# Logs and System Diagnostics

Logs record system and application events.

## Common commands

```bash
journalctl -xe
journalctl -u service_name
dmesg
tail -f file.log
grep "ERROR" file.log
```

## Docker logs

```bash
docker logs container_name
docker compose logs
```

## JSONL logs

JSONL means one JSON object per line. It is useful for security analysis and local SIEM-style pipelines.

Example:

```json
{"timestamp":"2026-05-20T10:00:00Z","event_type":"auth_failure","status":401}
```

## Safety

Logs can contain sensitive data. Review logs before committing or publishing them.
