# API Security Controls Notes

## Local-only binding

Binding to `127.0.0.1` means the service listens only on the local machine.

Example:

```text
127.0.0.1:8400
```

This is safer for a lab than exposing the service on all interfaces.

## API key authentication

An API key is a simple shared secret used to authorize requests.

In this lab:

```text
X-API-Key: microbot-api-token
```

Requests without the correct API key receive:

```text
401 Unauthorized
```

## Admin key separation

Admin endpoints should require stronger or separate authorization.

In this lab:

```text
X-Admin-Key: microbot-admin-token
```

Requests without it receive:

```text
403 Forbidden
```

## 401 vs 403

`401 Unauthorized` usually means authentication is missing or invalid.

`403 Forbidden` means the request is understood, but the client is not allowed to access the resource.

## Input validation

Input validation checks that user-provided values match expected formats.

Example valid node ID:

```text
node-001
```

Invalid examples:

```text
../../etc/passwd
bad-node
node-abc
node-9999
```

Invalid input receives:

```text
400 Bad Request
```

## Command allowlist

The lab API accepts only known safe commands:

```text
heartbeat
status
safe_stop
telemetry_snapshot
```

This is safer than allowing arbitrary command strings.

## Rate limiting

Rate limiting reduces the impact of repeated requests.

In this lab:

```text
12 requests per 10 seconds per client IP
```

If exceeded, the API returns:

```text
429 Too Many Requests
```

## Security headers

The lab API sends basic defensive headers:

```text
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
Cache-Control: no-store
Access-Control-Allow-Origin: http://127.0.0.1
```

These are simple examples, not a complete production policy.

## Structured security logs

Each event is logged as JSONL with fields such as:

```text
timestamp
client_ip
method
path
status
event_type
has_api_key
has_admin_key
user_agent
```

This makes it easier to analyze events automatically.

## Detection logic

The detector looks for patterns such as:

```text
auth_failure
forbidden
validation_error
rate_limited
not_found
method_not_allowed
```

The purpose is not to build a complete SIEM, but to understand how local defensive signals can be collected, counted and reported.

## Defensive value

This lab is useful for:

- API security basics
- backend defensive design
- telemetry API safety
- MicroBot command/control API design
- local detection logic
- report writing
- portfolio proof-of-work
