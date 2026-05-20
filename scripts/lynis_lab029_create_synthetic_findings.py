#!/usr/bin/env python3
"""
Create synthetic Lynis-style findings for Lab 029.

No real Lynis output is read.
No local system data is collected.
The output is safe training data.
"""

from __future__ import annotations

import json
from datetime import datetime, timezone
from pathlib import Path


OUT = Path("data/lab029/synthetic_lynis_findings.jsonl")


def main() -> None:
    OUT.parent.mkdir(parents=True, exist_ok=True)
    now = datetime.now(timezone.utc).isoformat()

    findings = [
        {
            "finding_id": "LYNIS-LAB-001",
            "timestamp": now,
            "source": "synthetic",
            "category": "updates",
            "severity": "medium",
            "title": "Package update review recommended",
            "recommendation": "Review package update status and document patching policy.",
            "publication_safe": True,
        },
        {
            "finding_id": "LYNIS-LAB-002",
            "timestamp": now,
            "source": "synthetic",
            "category": "authentication",
            "severity": "medium",
            "title": "SSH hardening review recommended",
            "recommendation": "Review key-based authentication, root login and password login policy.",
            "publication_safe": True,
        },
        {
            "finding_id": "LYNIS-LAB-003",
            "timestamp": now,
            "source": "synthetic",
            "category": "logging",
            "severity": "low",
            "title": "Logging coverage review recommended",
            "recommendation": "Confirm that security-relevant logs are retained and reviewed.",
            "publication_safe": True,
        },
        {
            "finding_id": "LYNIS-LAB-004",
            "timestamp": now,
            "source": "synthetic",
            "category": "firewall",
            "severity": "medium",
            "title": "Firewall policy review recommended",
            "recommendation": "Document inbound services and confirm default policy expectations.",
            "publication_safe": True,
        },
        {
            "finding_id": "LYNIS-LAB-005",
            "timestamp": now,
            "source": "synthetic",
            "category": "permissions",
            "severity": "low",
            "title": "File permission review recommended",
            "recommendation": "Review permissions on sensitive configuration directories.",
            "publication_safe": True,
        },
    ]

    with OUT.open("w", encoding="utf-8") as f:
        for finding in findings:
            f.write(json.dumps(finding, sort_keys=True) + "\n")

    print(f"[OK] Synthetic Lynis-style findings created: {OUT}")
    print(f"[INFO] Findings written: {len(findings)}")
    print("[INFO] No real Lynis output was read.")


if __name__ == "__main__":
    main()
