#!/usr/bin/env python3
"""
Docker Lab 010 client check.

This client runs inside a container and tests another container by URL.
It uses only Python standard library.
"""

from __future__ import annotations

from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError
import sys


def main() -> int:
    url = sys.argv[1] if len(sys.argv) > 1 else "http://lab010_api_server:8500/status"

    print(f"[CLIENT] Testing URL: {url}")

    request = Request(url, method="GET")

    try:
        with urlopen(request, timeout=5) as response:
            body = response.read().decode("utf-8", errors="replace")
            print(f"[CLIENT] HTTP status: {response.status}")
            print("[CLIENT] Response body:")
            print(body)
            return 0 if response.status == 200 else 1
    except HTTPError as exc:
        print(f"[CLIENT] HTTP error: {exc.code}")
        print(exc.read().decode("utf-8", errors="replace"))
        return 1
    except URLError as exc:
        print(f"[CLIENT] URL error: {exc}")
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
