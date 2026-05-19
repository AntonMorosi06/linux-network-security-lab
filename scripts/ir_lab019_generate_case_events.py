#!/usr/bin/env python3
from __future__ import annotations

from datetime import datetime, timedelta, timezone
from pathlib import Path
import json


OUT_DIR = Path.home() / "linux_lab" / "lab019_ir_case" / "events"
OUT_FILE = OUT_DIR / "ir_case_events.jsonl"
CASE_ID = "IR-LAB019-LOCAL-GENERATED"


def make_event(ts, source, event_type, status, path, message, user="lab-user"):
    return {
        "timestamp": ts.isoformat().replace("+00:00", "Z"),
        "case_id": CASE_ID,
        "source": source,
        "event_type": event_type,
        "status": status,
        "src_ip": "127.0.0.1",
        "user": user,
        "path": path,
        "message": message,
    }


def main() -> int:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    base = datetime.now(timezone.utc).replace(microsecond=0)
    events = []

    events.append(make_event(base, "capstone_api", "status_ok", 200, "/status", "status endpoint reached"))
    events.append(make_event(base + timedelta(seconds=5), "capstone_api", "health_ok", 200, "/health", "health endpoint reached"))

    for i in range(6):
        events.append(make_event(base + timedelta(seconds=60 + i * 10), "capstone_api", "auth_failure", 401, "/protected", "missing or invalid API key", user="anonymous"))

    for i in range(4):
        events.append(make_event(base + timedelta(seconds=150 + i * 10), "reverse_proxy", "not_found", 404, f"/missing-{i}", "unknown route"))

    for i in range(2):
        events.append(make_event(base + timedelta(seconds=220 + i * 10), "capstone_api", "controlled_error", 500, "/error", "controlled local error"))

    events.append(make_event(base + timedelta(seconds=260), "capstone_api", "admin_review", 200, "/events", "events reviewed by local admin", user="admin"))
    events.append(make_event(base + timedelta(seconds=300), "prometheus", "scrape_ok", 200, "/metrics", "metrics scrape succeeded", user="prometheus"))

    with OUT_FILE.open("w", encoding="utf-8") as handle:
        for event in events:
            handle.write(json.dumps(event, sort_keys=True) + "\n")

    print("[OK] Generated incident response case events:")
    print(OUT_FILE)
    print(f"[INFO] Event count: {len(events)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
