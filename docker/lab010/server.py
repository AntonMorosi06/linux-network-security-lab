#!/usr/bin/env python3
"""
Docker Lab 010 API server.

This server runs inside a Docker container and listens on 0.0.0.0:8500.
The host should publish it only to 127.0.0.1:8500 for local safety.
"""

from __future__ import annotations

from http.server import BaseHTTPRequestHandler, HTTPServer
import json
import os
import socket
import time
from typing import Any, Dict


HOST = "0.0.0.0"
PORT = 8500


class DockerLabHandler(BaseHTTPRequestHandler):
    server_version = "DockerLab010/0.1"

    def _send_json(self, status_code: int, payload: Dict[str, Any]) -> None:
        body = json.dumps(payload, indent=2).encode("utf-8")
        self.send_response(status_code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("X-Content-Type-Options", "nosniff")
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self) -> None:
        if self.path == "/status":
            self._send_json(
                200,
                {
                    "service": "docker_lab010_api",
                    "status": "ok",
                    "context": "container",
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
                        "container": "ok",
                    },
                },
            )
            return

        if self.path == "/env":
            self._send_json(
                200,
                {
                    "hostname": socket.gethostname(),
                    "working_directory": os.getcwd(),
                    "python_process": "running",
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
    server = HTTPServer((HOST, PORT), DockerLabHandler)
    print(f"[API] Docker Lab 010 server listening on {HOST}:{PORT}", flush=True)
    print("[API] Endpoints: /status, /health, /env", flush=True)

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("[API] Server stopped.", flush=True)
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
