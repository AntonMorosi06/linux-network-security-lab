#!/usr/bin/env python3
from __future__ import annotations

from collections import Counter
from pathlib import Path
import json
import sys
from typing import Any


DEFAULT_EVENTS = Path("data/lab018/sample_events.jsonl")
DEFAULT_RULES = Path("data/lab018/detection_rules.json")


def load_events(path: Path) -> tuple[list[dict[str, Any]], int]:
    events = []
    bad_lines = 0

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
                    bad_lines += 1
            except json.JSONDecodeError:
                bad_lines += 1

    return events, bad_lines


def count_matches(events: list[dict[str, Any]], field: str, expected: Any) -> int:
    return sum(1 for event in events if event.get(field) == expected)


def main() -> int:
    events_file = Path(sys.argv[1]) if len(sys.argv) > 1 else DEFAULT_EVENTS
    rules_file = Path(sys.argv[2]) if len(sys.argv) > 2 else DEFAULT_RULES

    if not events_file.exists():
        print(f"[ERROR] Events file not found: {events_file}")
        return 1

    if not rules_file.exists():
        print(f"[ERROR] Rules file not found: {rules_file}")
        return 1

    events, bad_lines = load_events(events_file)
    rules = json.loads(rules_file.read_text(encoding="utf-8")).get("rules", [])

    event_type_counts = Counter(str(event.get("event_type", "unknown")) for event in events)
    status_counts = Counter(str(event.get("status", "unknown")) for event in events)
    source_counts = Counter(str(event.get("source", "unknown")) for event in events)

    findings = []

    for rule in rules:
        if "compound" in rule:
            parts = rule["compound"]
            matched_parts = []
            for part in parts:
                count = count_matches(events, part["field"], part["equals"])
                matched_parts.append(count >= int(part["threshold"]))
            if all(matched_parts):
                findings.append(
                    {
                        "id": rule["id"],
                        "severity": rule["severity"],
                        "description": rule["description"],
                        "matched": True,
                    }
                )
            continue

        count = count_matches(events, rule["field"], rule["equals"])
        if count >= int(rule["threshold"]):
            findings.append(
                {
                    "id": rule["id"],
                    "severity": rule["severity"],
                    "description": rule["description"],
                    "count": count,
                    "threshold": int(rule["threshold"]),
                }
            )

    print("============================================================")
    print("SIEM LAB 018 EVENT ANALYSIS")
    print(f"Events file: {events_file}")
    print(f"Rules file: {rules_file}")
    print("============================================================")
    print(f"Total events: {len(events)}")
    print(f"Bad JSON lines: {bad_lines}")
    print("")
    print("Event type counts:")
    for key, value in event_type_counts.most_common():
        print(f"  {key}: {value}")
    print("")
    print("Status counts:")
    for key, value in sorted(status_counts.items()):
        print(f"  HTTP {key}: {value}")
    print("")
    print("Source counts:")
    for key, value in source_counts.most_common():
        print(f"  {key}: {value}")
    print("")
    print("Findings:")
    if findings:
        for finding in findings:
            extra = f" count={finding.get('count')} threshold={finding.get('threshold')}" if "count" in finding else ""
            print(f"  - {finding['id']} severity={finding['severity']}{extra}")
            print(f"    {finding['description']}")
    else:
        print("  - no findings")
    print("============================================================")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
