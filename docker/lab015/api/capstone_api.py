#!/usr/bin/env python3
from __future__ import annotations

from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path
import json
import os
import socket
import time
from typing import Any, Dict


HOST = "0.0.0.0"
PORT = int(os.environ.get("API_PORT", "8801"))
API_TOKEN = os.environ.get("API_TOKEN", "capstone-local-token")
LAB_NAME = os.environ.get("LAB_NAME", "lab015")

START_TIME = time.time()
EVENTS = []

REQUESTS_TOTAL = 0
AUTH_FAILURES_TOTAL = 0
COMMANDS_TOTAL = 0
NOT_FOUND_TOTAL = 0
ERRORS_TOTAL = 0
LAST_REQUEST_TIMESTAMP = 0.0


def now() -> float:
    return time.time()


def add_event(event: Dict[str, Any]) -> None:
    EVENTS.append(event)
    if len(EVENTS) > 100:
        del EVENTS[: len(EVENTS) - 100]


class CapstoneHandler(BaseHTTPRequestHandler):
    server_version = "CapstoneLab015Api/0.1"

    def _has_token(self) -> bool:
        return self.headers.get("X-API-Key") == API_TOKEN

    def _record(self, status: int, event_type: str) -> None:
        global REQUESTS_TOTAL
        global AUTH_FAILURES_TOTAL
        global COMMANDS_TOTAL
        global NOT_FOUND_TOTAL
        global ERRORS_TOTAL
        global LAST_REQUEST_TIMESTAMP

        REQUESTS_TOTAL += 1
        LAST_REQUEST_TIMESTAMP = now()

        if event_type == "auth_failure":
            AUTH_FAILURES_TOTAL += 1
        if event_type == "command_accepted":
            COMMANDS_TOTAL += 1
        if status == 404:
            NOT_FOUND_TOTAL += 1
        if status >= 500:
            ERRORS_TOTAL += 1

        add_event(
            {
                "timestamp": now(),
                "timestamp_readable": time.strftime("%Y-%m-%dT%H:%M:%S%z"),
                "client": self.client_address[0],
                "method": self.command,
                "path": self.path,
                "status": status,
                "event_type": event_type,
                "has_token": bool(self.headers.get("X-API-Key")),
                "user_agent": self.headers.get("User-Agent", "-"),
            }
        )

    def _send_json(self, status: int, payload: Dict[str, Any], event_type: str) -> None:
        self._record(status, event_type)
        body = json.dumps(payload, indent=2).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("X-Content-Type-Options", "nosniff")
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def _send_text(self, status: int, body: str, event_type: str, content_type: str = "text/plain") -> None:
        self._record(status, event_type)
        encoded = body.encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(encoded)))
        self.send_header("X-Content-Type-Options", "nosniff")
        self.end_headers()
        self.wfile.write(encoded)

    def _metrics(self) -> str:
        uptime = now() - START_TIME
        return f"""# HELP capstone_requests_total Total HTTP requests handled by the capstone API.
# TYPE capstone_requests_total counter
capstone_requests_total {REQUESTS_TOTAL}

# HELP capstone_auth_failures_total Total authentication failures.
# TYPE capstone_auth_failures_total counter
capstone_auth_failures_total {AUTH_FAILURES_TOTAL}

# HELP capstone_commands_total Total accepted local lab commands.
# TYPE capstone_commands_total counter
capstone_commands_total {COMMANDS_TOTAL}

# HELP capstone_not_found_total Total 404 responses.
# TYPE capstone_not_found_total counter
capstone_not_found_total {NOT_FOUND_TOTAL}

# HELP capstone_errors_total Total 5xx responses.
# TYPE capstone_errors_total counter
capstone_errors_total {ERRORS_TOTAL}

# HELP capstone_uptime_seconds API uptime in seconds.
# TYPE capstone_uptime_seconds gauge
capstone_uptime_seconds {uptime:.3f}

# HELP capstone_last_request_timestamp_seconds Unix timestamp of the last request.
# TYPE capstone_last_request_timestamp_seconds gauge
capstone_last_request_timestamp_seconds {LAST_REQUEST_TIMESTAMP:.3f}

# HELP capstone_build_info Static build information.
# TYPE capstone_build_info gauge
capstone_build_info{{lab="{LAB_NAME}",service="capstone_api",hostname="{socket.gethostname()}"}} 1
"""

    def do_GET(self) -> None:
        if self.path == "/status":
            self._send_json(
                200,
                {
                    "service": "capstone_lab015_api",
                    "status": "ok",
                    "lab": LAB_NAME,
                    "hostname": socket.gethostname(),
                    "timestamp": now(),
                },
                "status_ok",
            )
            return

        if self.path == "/health":
            self._send_json(
                200,
                {
                    "health": "green",
                    "checks": {
                        "api": "ok",
                        "auth_layer": "enabled",
                        "metrics": "enabled",
                        "structured_events": "enabled",
                    },
                },
                "health_ok",
            )
            return

        if self.path == "/protected":
            if not self._has_token():
                self._send_json(
                    401,
                    {"error": "unauthorized", "message": "missing or invalid X-API-Key"},
                    "auth_failure",
                )
                return
            self._send_json(
                200,
                {
                    "status": "authorized",
                    "message": "protected capstone endpoint reached",
                },
                "protected_ok",
            )
            return

        if self.path == "/events":
            if not self._has_token():
                self._send_json(
                    401,
                    {"error": "unauthorized", "message": "missing or invalid X-API-Key"},
                    "auth_failure",
                )
                return
            self._send_json(200, {"events": EVENTS[-20:]}, "events_read")
            return

        if self.path == "/metrics":
            self._send_text(
                200,
                self._metrics(),
                "metrics",
                content_type="text/plain; version=0.0.4; charset=utf-8",
            )
            return

        if self.path == "/error":
            self._send_json(
                500,
                {"error": "controlled_error", "message": "intentional local capstone error"},
                "controlled_error",
            )
            return

        self._send_json(404, {"error": "not_found", "path": self.path}, "not_found")

    def do_POST(self) -> None:
        if self.path != "/command":
            self._send_json(404, {"error": "not_found", "path": self.path}, "not_found")
            return

        if not self._has_token():
            self._send_json(
                401,
                {"error": "unauthorized", "message": "missing or invalid X-API-Key"},
                "auth_failure",
            )
            return

        length = int(self.headers.get("Content-Length", "0") or "0")
        if length <= 0 or length > 4096:
            self._send_json(400, {"error": "bad_request", "message": "invalid body length"}, "validation_error")
            return

        raw = self.rfile.read(length)
        try:
            payload = json.loads(raw.decode("utf-8"))
        except json.JSONDecodeError:
            self._send_json(400, {"error": "bad_request", "message": "invalid JSON"}, "validation_error")
            return

        command = str(payload.get("command", ""))
        allowed = {"status", "heartbeat", "safe_stop", "telemetry_snapshot"}
        if command not in allowed:
            self._send_json(
                400,
                {"error": "validation_error", "allowed_commands": sorted(allowed)},
                "validation_error",
            )
            return

        self._send_json(
            202,
            {"accepted": True, "command": command, "message": "local capstone command accepted"},
            "command_accepted",
        )

    def log_message(self, format: str, *args: Any) -> None:
        print(
            json.dumps(
                {
                    "timestamp": now(),
                    "client": self.client_address[0],
                    "request": self.requestline,
                    "message": format % args,
                },
                sort_keys=True,
            ),
            flush=True,
        )


def main() -> None:
    server = HTTPServer((HOST, PORT), CapstoneHandler)
    print(f"[CAPSTONE-API] listening on {HOST}:{PORT}", flush=True)
    print("[CAPSTONE-API] endpoints: /status /health /protected /events /metrics /command", flush=True)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("[CAPSTONE-API] stopped", flush=True)
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
