#!/usr/bin/env python3
"""
Start a tiny local HTTP service for Lab 025.

The service binds to 127.0.0.1 only.
It exists only to generate safe loopback traffic for tcpdump.
"""

from __future__ import annotations

from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from datetime import datetime, timezone
import json


HOST = "127.0.0.1"
PORT = 8090


class Handler(BaseHTTPRequestHandler):
    server_version = "Lab025LocalHTTP/1.0"

    def log_message(self, fmt: str, *args) -> None:
        print(f"[ACCESS] {self.address_string()} - {fmt % args}")

    def do_GET(self) -> None:
        payload = {
            "service": "lab025-local-http",
            "status": "ok",
            "scope": "loopback-only",
            "path": self.path,
            "timestamp": datetime.now(timezone.utc).isoformat(),
        }
        body = json.dumps(payload, indent=2).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


def main() -> None:
    server = ThreadingHTTPServer((HOST, PORT), Handler)
    print("[INFO] Lab 025 local HTTP service")
    print(f"[INFO] Listening on http://{HOST}:{PORT}")
    print("[INFO] Scope: loopback only")
    print("[INFO] Stop with CTRL + C.")
    server.serve_forever()


if __name__ == "__main__":
    main()
