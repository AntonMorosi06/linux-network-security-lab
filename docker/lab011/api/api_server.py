#!/usr/bin/env python3
"""
Docker Compose Lab 011 API server.

This API is intended to run behind an Nginx reverse proxy inside a Docker Compose stack.
"""

from __future__ import annotations

from http.server import BaseHTTPRequestHandler, HTTPServer
import json
import os
import socket
import time
from typing import Any, Dict


HOST = "0.0.0.0"
PORT = int(os.environ.get("API_PORT", "8601"))
LAB_NAME = os.environ.get("LAB_NAME", "lab011")


class ComposeApiHandler(BaseHTTPRequestHandler):
    server_version = "ComposeLab011Api/0.1"

    def _send_json(self, status_code: int, payload: Dict[str, Any]) -> None:
        body = json.dumps(payload, indent=2).encode("utf-8")
        self.send_response(status_code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("X-Content-Type-Options", "nosniff")
        self.end_headers()
        self.wfile.write(body)

    def _request_headers_payload(self) -> Dict[str, str]:
        interesting = {}
        for key in [
            "Host",
            "User-Agent",
            "X-Forwarded-For",
            "X-Forwarded-Proto",
            "X-Proxy-Lab",
            "X-Real-IP",
        ]:
            interesting[key] = self.headers.get(key, "-")
        return interesting

    def do_GET(self) -> None:
        if self.path == "/status":
            self._send_json(
                200,
                {
                    "service": "compose_lab011_api",
                    "status": "ok",
                    "served_by": "api",
                    "lab": LAB_NAME,
                    "hostname": socket.gethostname(),
                    "port": PORT,
                    "timestamp": time.time(),
                },
            )
            return

        if self.path == "/health":
            self._send_json(
                200,
                {
                    "health": "green",
                    "checks": {
                        "api": "ok",
                        "reverse_proxy_expected": "ok",
                        "compose_network": "ok",
                    },
                },
            )
            return

        if self.path == "/headers":
            self._send_json(
                200,
                {
                    "service": "compose_lab011_api",
                    "headers_seen_by_api": self._request_headers_payload(),
                },
            )
            return

        if self.path == "/env":
            self._send_json(
                200,
                {
                    "lab": LAB_NAME,
                    "hostname": socket.gethostname(),
                    "working_directory": os.getcwd(),
                    "port": PORT,
                },
            )
            return

        self._send_json(
            404,
            {
                "error": "not_found",
                "path": self.path,
            },
        )

    def log_message(self, format: str, *args: Any) -> None:
        print(
            json.dumps(
                {
                    "timestamp": time.time(),
                    "client": self.client_address[0],
                    "request": self.requestline,
                    "message": format % args,
                },
                sort_keys=True,
            ),
            flush=True,
        )


def main() -> None:
    server = HTTPServer((HOST, PORT), ComposeApiHandler)
    print(f"[API] Compose Lab 011 API listening on {HOST}:{PORT}", flush=True)
    print("[API] Endpoints: /status, /health, /headers, /env", flush=True)

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("[API] Server stopped.", flush=True)
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
