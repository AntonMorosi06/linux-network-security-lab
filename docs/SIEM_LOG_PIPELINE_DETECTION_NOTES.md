# SIEM Log Pipeline and Detection Notes

## SIEM-style pipeline

A SIEM-style workflow can be simplified as:

```text
collect events
normalize events
apply detection rules
assign severity
build timeline
write report
```

## JSONL events

JSONL stores one JSON event per line. This makes logs easy to append, stream and parse.

## Detection rules

This lab uses simple threshold rules. They are intentionally readable.

Example:

```text
auth_failure >= 5 -> MEDIUM finding
not_found >= 3 -> LOW finding
controlled_error >= 2 -> MEDIUM finding
```

## Timeline

A timeline orders events by timestamp so an analyst can understand sequence and context.

## Defensive interpretation

A finding is not automatically an incident. It is a signal that needs interpretation.

Examples:

```text
401 events can be unauthorized attempts or a broken client.
404 events can be probing or a wrong frontend route.
500 events can be service failure or controlled local testing.
```

## Safety

Do not commit real private logs. Use synthetic events unless you have reviewed and sanitized the data.
