#!/usr/bin/env python3
"""
Create synthetic audit-like events for Lab 028.

No real audit logs are read.
No user activity is collected.
The output is safe training data.
"""

from __future__ import annotations

import json
from datetime import datetime, timezone
from pathlib import Path


OUT = Path("data/lab028/synthetic_audit_events.jsonl")


def main() -> None:
    OUT.parent.mkdir(parents=True, exist_ok=True)

    now = datetime.now(timezone.utc).isoformat()
    events = [
        {
            "event_id": "audit-lab-001",
            "timestamp": now,
            "source": "synthetic",
            "category": "identity",
            "key": "identity_changes",
            "asset": "/etc/passwd",
            "action": "write_attempt",
            "actor": "lab-user",
            "result": "simulated",
            "severity": "medium",
            "interpretation": "Synthetic example of a user database change event.",
        },
        {
            "event_id": "audit-lab-002",
            "timestamp": now,
            "source": "synthetic",
            "category": "privilege",
            "key": "privilege_policy_changes",
            "asset": "/etc/sudoers",
            "action": "attribute_change",
            "actor": "lab-admin",
            "result": "simulated",
            "severity": "high",
            "interpretation": "Synthetic example of a sudo policy change event.",
        },
        {
            "event_id": "audit-lab-003",
            "timestamp": now,
            "source": "synthetic",
            "category": "ssh",
            "key": "ssh_config_changes",
            "asset": "/etc/ssh/sshd_config",
            "action": "write_attempt",
            "actor": "lab-admin",
            "result": "simulated",
            "severity": "medium",
            "interpretation": "Synthetic example of an SSH daemon config change event.",
        },
        {
            "event_id": "audit-lab-004",
            "timestamp": now,
            "source": "synthetic",
            "category": "command",
            "key": "command_execution",
            "asset": "execve",
            "action": "command_execution",
            "actor": "lab-user",
            "result": "simulated",
            "severity": "low",
            "interpretation": "Synthetic example of command execution telemetry.",
        },
        {
            "event_id": "audit-lab-005",
            "timestamp": now,
            "source": "synthetic",
            "category": "credential-store",
            "key": "credential_store_changes",
            "asset": "/etc/shadow",
            "action": "read_or_write_interest",
            "actor": "lab-process",
            "result": "simulated",
            "severity": "high",
            "interpretation": "Synthetic example of sensitive credential store monitoring.",
        },
    ]

    with OUT.open("w", encoding="utf-8") as f:
        for event in events:
            f.write(json.dumps(event, sort_keys=True) + "\n")

    print(f"[OK] Synthetic audit events created: {OUT}")
    print(f"[INFO] Events written: {len(events)}")
    print("[INFO] No real audit logs were read.")


if __name__ == "__main__":
    main()
