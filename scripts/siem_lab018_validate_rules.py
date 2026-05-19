#!/usr/bin/env python3
from __future__ import annotations

from pathlib import Path
import json
import sys


RULES_FILE = Path("data/lab018/detection_rules.json")


def main() -> int:
    rules_file = Path(sys.argv[1]) if len(sys.argv) > 1 else RULES_FILE

    if not rules_file.exists():
        print(f"[ERROR] Rules file not found: {rules_file}")
        return 1

    data = json.loads(rules_file.read_text(encoding="utf-8"))
    rules = data.get("rules", [])

    if not isinstance(rules, list) or not rules:
        print("[ERROR] Rules file must contain a non-empty 'rules' list.")
        return 1

    required = {"id", "description", "severity"}
    failed = False

    for rule in rules:
        missing = required - set(rule)
        if missing:
            print(f"[ERROR] Rule missing fields {sorted(missing)}: {rule}")
            failed = True

        if "compound" not in rule:
            for field in ("field", "equals", "threshold"):
                if field not in rule:
                    print(f"[ERROR] Rule {rule.get('id', '<unknown>')} missing {field}")
                    failed = True
        else:
            if not isinstance(rule["compound"], list) or not rule["compound"]:
                print(f"[ERROR] Compound rule {rule.get('id')} has invalid compound list.")
                failed = True

    if failed:
        return 1

    print(f"[OK] Loaded rules: {len(rules)}")
    print("[OK] Rule validation completed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
