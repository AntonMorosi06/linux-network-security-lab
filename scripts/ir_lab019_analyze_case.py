#!/usr/bin/env python3
from __future__ import annotations

from collections import Counter
from pathlib import Path
import json
import sys


DEFAULT_EVENTS = Path("data/lab019/ir_case_events.jsonl")


def load_events(path: Path):
    events = []
    bad = 0
    with path.open("r", encoding="utf-8") as handle:
        for line in handle:
            line = line.strip()
            if not line:
                continue
            try:
                item = json.loads(line)
                if isinstance(item, dict):
                    events.append(item)
                else:
                    bad += 1
            except json.JSONDecodeError:
                bad += 1
    return events, bad


def main() -> int:
    events_file = Path(sys.argv[1]) if len(sys.argv) > 1 else DEFAULT_EVENTS

    if not events_file.exists():
        print(f"[ERROR] Events file not found: {events_file}")
        return 1

    events, bad = load_events(events_file)
    events.sort(key=lambda item: str(item.get("timestamp", "")))

    types = Counter(str(e.get("event_type", "unknown")) for e in events)
    statuses = Counter(str(e.get("status", "unknown")) for e in events)
    sources = Counter(str(e.get("source", "unknown")) for e in events)

    auth_failures = types.get("auth_failure", 0)
    not_found = types.get("not_found", 0)
    errors = statuses.get("500", 0)
    admin_review = types.get("admin_review", 0)

    severity = "LOW"
    findings = []

    if auth_failures >= 5:
        findings.append("Multiple authentication failures observed.")
        severity = "MEDIUM"

    if not_found >= 3:
        findings.append("Multiple not-found events observed.")

    if errors >= 2:
        findings.append("Multiple controlled backend errors observed.")
        severity = "MEDIUM"

    if auth_failures >= 5 and not_found >= 3:
        findings.append("Combined authentication failure and route anomaly pattern observed.")
        severity = "HIGH"

    if admin_review:
        findings.append("Administrative review event observed after anomalies.")

    print("============================================================")
    print("IR LAB 019 CASE ANALYSIS")
    print(f"Events file: {events_file}")
    print("============================================================")
    print(f"Total events: {len(events)}")
    print(f"Bad JSON lines: {bad}")

    if events:
        print(f"First event: {events[0].get('timestamp')}")
        print(f"Last event: {events[-1].get('timestamp')}")

    print("")
    print("Event type counts:")
    for key, value in types.most_common():
        print(f"  {key}: {value}")

    print("")
    print("Status counts:")
    for key, value in sorted(statuses.items()):
        print(f"  HTTP {key}: {value}")

    print("")
    print("Source counts:")
    for key, value in sources.most_common():
        print(f"  {key}: {value}")

    print("")
    print(f"Case severity: {severity}")
    print("Findings:")
    if findings:
        for finding in findings:
            print(f"  - {finding}")
    else:
        print("  - No major findings.")

    print("")
    print("Timeline:")
    for event in events:
        print(
            f"  {event.get('timestamp')} | {event.get('source')} | "
            f"{event.get('event_type')} | status={event.get('status')} | "
            f"path={event.get('path')} | user={event.get('user')}"
        )

    print("============================================================")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
