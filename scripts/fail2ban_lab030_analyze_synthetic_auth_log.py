#!/usr/bin/env python3
"""
Analyze the synthetic Lab 030 auth log.

This script does not read real auth logs.
It extracts fake source IPs from synthetic failed-login lines.
"""

from __future__ import annotations

import json
import re
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path


LOG = Path("data/lab030/synthetic_auth.log")
OUT = Path("data/lab030/synthetic_fail2ban_findings.jsonl")
THRESHOLD = 3

FAILED_RE = re.compile(r"Failed password .* from (?P<ip>\d+\.\d+\.\d+\.\d+) port (?P<port>\d+) ssh2")


def main() -> None:
    if not LOG.exists():
        raise SystemExit("[ERROR] Synthetic auth log not found. Run ./scripts/fail2ban_lab030_generate_synthetic_auth_log.py first.")

    counts: Counter[str] = Counter()
    matched_lines: dict[str, list[str]] = {}

    for line in LOG.read_text(encoding="utf-8").splitlines():
        match = FAILED_RE.search(line)
        if match:
            ip = match.group("ip")
            counts[ip] += 1
            matched_lines.setdefault(ip, []).append(line)

    OUT.parent.mkdir(parents=True, exist_ok=True)

    now = datetime.now(timezone.utc).isoformat()
    findings = []

    for ip, count in sorted(counts.items()):
        exceeded = count >= THRESHOLD
        findings.append(
            {
                "timestamp": now,
                "source": "synthetic",
                "source_ip": ip,
                "failed_attempts": count,
                "threshold": THRESHOLD,
                "threshold_exceeded": exceeded,
                "severity": "medium" if exceeded else "low",
                "recommendation": "Would trigger defensive review in a lab Fail2ban-style model." if exceeded else "Monitor only in this synthetic model.",
                "matched_line_count": len(matched_lines[ip]),
            }
        )

    with OUT.open("w", encoding="utf-8") as f:
        for finding in findings:
            f.write(json.dumps(finding, sort_keys=True) + "\n")

    print(f"[OK] Synthetic findings created: {OUT}")
    print(f"[INFO] Sources analyzed: {len(findings)}")
    print(f"[INFO] Threshold: {THRESHOLD} failed attempts")
    print("[INFO] No real auth logs were analyzed.")


if __name__ == "__main__":
    main()
