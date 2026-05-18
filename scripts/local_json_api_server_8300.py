#!/usr/bin/env python3
"""
Local JSON API Lab Server.

This server is intentionally local-only and binds to 127.0.0.1:8300.

It provides basic JSON endpoints and writes structured JSONL logs to:
~/linux_lab/json_api_mini_soc/logs/api_events.jsonl

Endpoints:
- GET /status
- GET /health
- GET /metrics
- GET /protected
- GET /logs-path
- any other path returns 404

The /protected endpoint requires:
X-Lab-Token: microbot-lab-token
"""

from __future__ import annotations

from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path
import json
import time
from typing import Any, Dict


HOST = "127.0.0.1"
PORT = 8300
TOKEN = "microbot-lab-token"

BASE_DIR = Path.home() / "linux_lab" / "json_api_mini_soc"
LOG_DIR = BASE_DIR / "logs"
LOG_FILE = LOG_DIR / "api_events.jsonl"


class LocalJsonApiHandler(BaseHTTPRequestHandler):
    server_version = "LocalJsonApiLab/0.1"

    def _send_json(self, status_code: int, payload: Dict[str, Any]) -> None:
        body = json.dumps(payload, indent=2).encode("utf-8")
        self.send_response(status_code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def _event_type_for(self, status_code: int, path: str) -> str:
        if status_code == 401:
            return "auth_failure"
        if status_code == 404:
            return "not_found"
        if path == "/protected":
            return "auth_success"
        return "normal"

    def _write_event(self, status_code: int, response_size: int = 0) -> None:
        LOG_DIR.mkdir(parents=True, exist_ok=True)

        event = {
            "timestamp": time.time(),
            "timestamp_readable": time.strftime("%Y-%m-%dT%H:%M:%S%z"),
            "client_ip": self.client_address[0],
            "method": self.command,
            "path": self.path,
            "status": status_code,
            "event_type": self._event_type_for(status_code, self.path),
            "user_agent": self.headers.get("User-Agent", "-"),
            "has_lab_token": bool(self.headers.get("X-Lab-Token")),
            "response_size": response_size,
        }

        with LOG_FILE.open("a", encoding="utf-8") as handle:
            handle.write(json.dumps(event, sort_keys=True) + "\n")

    def do_GET(self) -> None:
        if self.path == "/status":
            payload = {
                "service": "local_json_api_lab",
                "status": "ok",
                "endpoint": "/status",
                "timestamp": time.time(),
            }
            status_code = 200

        elif self.path == "/health":
            payload = {
                "service": "local_json_api_lab",
                "health": "green",
                "checks": {
                    "api": "ok",
                    "logging": "ok",
                    "local_only": "ok",
                },
            }
            status_code = 200

        elif self.path == "/metrics":
            total_events = 0
            if LOG_FILE.exists():
                with LOG_FILE.open("r", encoding="utf-8") as handle:
                    total_events = sum(1 for _ in handle)

            payload = {
                "service": "local_json_api_lab",
                "metrics": {
                    "events_logged_total": total_events,
                    "port": PORT,
                    "bind_address": HOST,
                },
            }
            status_code = 200

        elif self.path == "/protected":
            if self.headers.get("X-Lab-Token") == TOKEN:
                payload = {
                    "service": "local_json_api_lab",
                    "status": "authorized",
                    "endpoint": "/protected",
                }
                status_code = 200
            else:
                payload = {
                    "error": "unauthorized",
                    "message": "missing or invalid X-Lab-Token",
                }
                status_code = 401

        elif self.path == "/logs-path":
            payload = {
                "log_file": str(LOG_FILE),
                "base_dir": str(BASE_DIR),
            }
            status_code = 200

        else:
            payload = {
                "error": "not_found",
                "path": self.path,
            }
            status_code = 404

        response_size = len(json.dumps(payload).encode("utf-8"))
        self._send_json(status_code, payload)
        self._write_event(status_code, response_size=response_size)

    def log_message(self, format: str, *args: Any) -> None:
        # Keep standard console output minimal and readable.
        print(
            json.dumps(
                {
                    "timestamp": time.time(),
                    "client_ip": self.client_address[0],
                    "request": self.requestline,
                    "message": format % args,
                },
                sort_keys=True,
            )
        )


def main() -> None:
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    server = HTTPServer((HOST, PORT), LocalJsonApiHandler)

    print(f"[API] Local JSON API listening on http://{HOST}:{PORT}")
    print(f"[API] Logs: {LOG_FILE}")
    print("[API] Endpoints: /status, /health, /metrics, /protected, /logs-path")
    print("[API] Stop with CTRL + C")

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n[API] Server stopped by user.")
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
