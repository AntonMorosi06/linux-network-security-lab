#!/usr/bin/env python3
"""
Start a tiny local HTTP service for Lab 023.

The service binds to 127.0.0.1 only.
It is intended to create a safe local target for Nmap scanning.
"""

from __future__ import annotations

from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from datetime import datetime, timezone
import json


HOST = "127.0.0.1"
PORT = 8088


class Handler(BaseHTTPRequestHandler):
    server_version = "Lab023LocalHTTP/1.0"

    def log_message(self, fmt: str, *args) -> None:
        print(f"[ACCESS] {self.address_string()} - {fmt % args}")

    def do_GET(self) -> None:
        if self.path in ("/", "/status", "/health"):
            payload = {
                "service": "lab023-local-http",
                "status": "ok",
                "scope": "localhost-only",
                "timestamp": datetime.now(timezone.utc).isoformat(),
            }
            body = json.dumps(payload, indent=2).encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
            return

        body = b"not found\n"
        self.send_response(404)
        self.send_header("Content-Type", "text/plain")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


def main() -> None:
    server = ThreadingHTTPServer((HOST, PORT), Handler)
    print("[INFO] Lab 023 local HTTP service")
    print(f"[INFO] Listening on http://{HOST}:{PORT}")
    print("[INFO] Scope: localhost only")
    print("[INFO] Stop with CTRL + C.")
    server.serve_forever()


if __name__ == "__main__":
    main()
