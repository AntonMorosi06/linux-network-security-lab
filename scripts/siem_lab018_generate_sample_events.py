#!/usr/bin/env python3
from __future__ import annotations

from datetime import datetime, timedelta, timezone
from pathlib import Path
import json


OUT_DIR = Path.home() / "linux_lab" / "lab018_siem" / "events"
OUT_FILE = OUT_DIR / "generated_events.jsonl"


def event(ts: datetime, source: str, event_type: str, status: int, path: str, message: str, user: str = "lab-user") -> dict:
    return {
        "timestamp": ts.isoformat().replace("+00:00", "Z"),
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

    for i in range(10):
        events.append(event(base + timedelta(seconds=i * 5), "local_api", "status_ok", 200, "/status", "status endpoint reached"))

    for i in range(7):
        events.append(event(base + timedelta(seconds=60 + i * 5), "local_api", "auth_failure", 401, "/protected", "missing or invalid API key", user="anonymous"))

    for i in range(5):
        events.append(event(base + timedelta(seconds=120 + i * 5), "reverse_proxy", "not_found", 404, f"/missing-{i}", "unknown route"))

    for i in range(3):
        events.append(event(base + timedelta(seconds=180 + i * 5), "capstone_api", "controlled_error", 500, "/error", "controlled local error"))

    events.append(event(base + timedelta(seconds=240), "capstone_api", "admin_access", 200, "/events", "events endpoint accessed", user="admin"))
    events.append(event(base + timedelta(seconds=245), "prometheus", "scrape_ok", 200, "/metrics", "metrics scrape succeeded", user="prometheus"))
    events.append(event(base + timedelta(seconds=250), "grafana", "dashboard_view", 200, "/dashboard", "local dashboard viewed", user="admin"))

    with OUT_FILE.open("w", encoding="utf-8") as handle:
        for item in events:
            handle.write(json.dumps(item, sort_keys=True) + "\n")

    print("[OK] Generated synthetic events:")
    print(OUT_FILE)
    print(f"[INFO] Event count: {len(events)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
