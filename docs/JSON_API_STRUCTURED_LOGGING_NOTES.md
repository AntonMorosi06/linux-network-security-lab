# JSON API and Structured Logging Notes

## Local JSON API

A JSON API is an HTTP service that returns structured data encoded as JSON.

Example response:

```json
{
  "service": "local_json_api_lab",
  "status": "ok"
}
```

## HTTP status codes

Useful status codes in this lab:

```text
200 OK
401 Unauthorized
404 Not Found
```

## Structured logging

Structured logs store events as fields rather than plain text.

Example JSONL event:

```json
{"timestamp": 1779100000.123, "client_ip": "127.0.0.1", "method": "GET", "path": "/status", "status": 200, "event_type": "normal"}
```

## JSONL format

JSONL means JSON Lines. Each line is a complete JSON object.

This format is easy to:

- append
- parse
- filter
- count
- analyze
- import into other tools

## Why structured logs matter

Structured logs are useful because they allow reliable detection logic.

Instead of searching raw text, a script can count exact fields:

```text
status == 401
status == 404
path == /protected
event_type == auth_failure
```

## Mini detector

A mini detector is a simple script that reads logs and applies threshold rules.

Example:

```text
if HTTP 401 >= 5:
    finding = elevated unauthorized access attempts

if HTTP 404 >= 10:
    finding = elevated not-found requests
```

This is not a replacement for a SIEM, but it teaches the same basic reasoning:

```text
event collection
-> normalization
-> counting
-> detection
-> report
```

## Defensive value

This lab is useful for:

- API security basics
- local backend testing
- log analysis
- simple detection logic
- report writing
- observability
- telemetry and dashboard projects
- MicroBot control API design
