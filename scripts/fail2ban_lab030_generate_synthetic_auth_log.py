#!/usr/bin/env python3
"""
Generate a synthetic authentication log for Lab 030.

No real authentication logs are read.
No real login service is touched.
The output is fake training data.
"""

from __future__ import annotations

from datetime import datetime, timedelta, timezone
from pathlib import Path


OUT = Path("data/lab030/synthetic_auth.log")


def main() -> None:
    OUT.parent.mkdir(parents=True, exist_ok=True)

    base = datetime.now(timezone.utc).replace(microsecond=0)
    lines = []

    template_failed = "{ts} labhost sshd[1234]: Failed password for invalid user {user} from {ip} port {port} ssh2"
    template_ok = "{ts} labhost sshd[1234]: Accepted publickey for {user} from {ip} port {port} ssh2"

    events = [
        ("failed", "admin", "192.0.2.50", 53310),
        ("failed", "admin", "192.0.2.50", 53311),
        ("failed", "admin", "192.0.2.50", 53312),
        ("failed", "root", "198.51.100.23", 53400),
        ("failed", "root", "198.51.100.23", 53401),
        ("ok", "labuser", "192.0.2.10", 53500),
        ("failed", "test", "203.0.113.77", 53600),
        ("failed", "test", "203.0.113.77", 53601),
        ("failed", "test", "203.0.113.77", 53602),
        ("failed", "test", "203.0.113.77", 53603),
        ("failed", "guest", "192.0.2.88", 53700),
        ("ok", "labuser", "192.0.2.10", 53710),
    ]

    for i, (kind, user, ip, port) in enumerate(events):
        ts = (base + timedelta(seconds=i * 15)).strftime("%b %d %H:%M:%S")
        if kind == "failed":
            lines.append(template_failed.format(ts=ts, user=user, ip=ip, port=port))
        else:
            lines.append(template_ok.format(ts=ts, user=user, ip=ip, port=port))

    OUT.write_text("\n".join(lines) + "\n", encoding="utf-8")

    print(f"[OK] Synthetic auth log created: {OUT}")
    print(f"[INFO] Lines written: {len(lines)}")
    print("[INFO] No real authentication logs were read.")


if __name__ == "__main__":
    main()
