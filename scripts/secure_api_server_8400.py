#!/usr/bin/env python3
"""
Local API Security Controls Lab Server.

This server is intentionally local-only and binds to 127.0.0.1:8400.

It demonstrates:
- API key authentication
- admin key authorization
- basic rate limiting
- input validation
- method validation
- structured security event logs

Logs:
~/linux_lab/api_security_controls/logs/security_events.jsonl
"""

from __future__ import annotations

from collections import defaultdict, deque
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path
from urllib.parse import urlparse, parse_qs
import json
import re
import time
from typing import Any, Dict, Tuple


HOST = "127.0.0.1"
PORT = 8400

API_TOKEN = "microbot-api-token"
ADMIN_TOKEN = "microbot-admin-token"

BASE_DIR = Path.home() / "linux_lab" / "api_security_controls"
LOG_DIR = BASE_DIR / "logs"
LOG_FILE = LOG_DIR / "security_events.jsonl"

RATE_WINDOW_SECONDS = 10
RATE_LIMIT_REQUESTS = 12

ALLOWED_COMMANDS = {"heartbeat", "status", "safe_stop", "telemetry_snapshot"}
NODE_ID_PATTERN = re.compile(r"^node-[0-9]{3}$")

REQUEST_HISTORY: Dict[str, deque[float]] = defaultdict(deque)


def now() -> float:
    return time.time()


class SecureApiHandler(BaseHTTPRequestHandler):
    server_version = "SecureApiLab/0.1"

    def _client_key(self) -> str:
        return self.client_address[0]

    def _rate_limited(self) -> bool:
        client = self._client_key()
        current = now()
        history = REQUEST_HISTORY[client]

        while history and current - history[0] > RATE_WINDOW_SECONDS:
            history.popleft()

        history.append(current)
        return len(history) > RATE_LIMIT_REQUESTS

    def _send_json(self, status_code: int, payload: Dict[str, Any], event_type: str) -> None:
        body = json.dumps(payload, indent=2).encode("utf-8")

        self.send_response(status_code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("X-Content-Type-Options", "nosniff")
        self.send_header("X-Frame-Options", "DENY")
        self.send_header("Cache-Control", "no-store")
        self.send_header("Access-Control-Allow-Origin", "http://127.0.0.1")
        self.end_headers()
        self.wfile.write(body)

        self._write_event(status_code, event_type, response_size=len(body))

    def _write_event(self, status_code: int, event_type: str, response_size: int = 0) -> None:
        LOG_DIR.mkdir(parents=True, exist_ok=True)

        parsed = urlparse(self.path)

        event = {
            "timestamp": now(),
            "timestamp_readable": time.strftime("%Y-%m-%dT%H:%M:%S%z"),
            "client_ip": self.client_address[0],
            "method": self.command,
            "path": parsed.path,
            "query": parsed.query,
            "status": status_code,
            "event_type": event_type,
            "user_agent": self.headers.get("User-Agent", "-"),
            "has_api_key": bool(self.headers.get("X-API-Key")),
            "has_admin_key": bool(self.headers.get("X-Admin-Key")),
            "response_size": response_size,
        }

        with LOG_FILE.open("a", encoding="utf-8") as handle:
            handle.write(json.dumps(event, sort_keys=True) + "\n")

    def _valid_api_key(self) -> bool:
        return self.headers.get("X-API-Key") == API_TOKEN

    def _valid_admin_key(self) -> bool:
        return self.headers.get("X-Admin-Key") == ADMIN_TOKEN

    def _validate_node_id(self, node_id: str) -> bool:
        return bool(NODE_ID_PATTERN.match(node_id))

    def _parse_json_body(self) -> Tuple[bool, Dict[str, Any] | None, str | None]:
        length_header = self.headers.get("Content-Length", "0")
        try:
            length = int(length_header)
        except ValueError:
            return False, None, "invalid content length"

        if length <= 0:
            return False, None, "empty request body"

        if length > 4096:
            return False, None, "request body too large"

        raw = self.rfile.read(length)
        try:
            data = json.loads(raw.decode("utf-8"))
        except json.JSONDecodeError:
            return False, None, "invalid JSON body"

        if not isinstance(data, dict):
            return False, None, "JSON body must be an object"

        return True, data, None

    def do_OPTIONS(self) -> None:
        self.send_response(204)
        self.send_header("Access-Control-Allow-Origin", "http://127.0.0.1")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type, X-API-Key, X-Admin-Key")
        self.send_header("Access-Control-Max-Age", "600")
        self.end_headers()
        self._write_event(204, "cors_preflight")

    def do_GET(self) -> None:
        if self._rate_limited():
            self._send_json(
                429,
                {"error": "rate_limited", "message": "too many requests in local lab window"},
                "rate_limited",
            )
            return

        parsed = urlparse(self.path)
        path = parsed.path
        query = parse_qs(parsed.query)

        if path == "/public/status":
            self._send_json(
                200,
                {"service": "secure_api_lab", "status": "ok", "public": True},
                "public_ok",
            )
            return

        if path == "/public/health":
            self._send_json(
                200,
                {"service": "secure_api_lab", "health": "green", "checks": {"api": "ok", "security_controls": "enabled"}},
                "public_ok",
            )
            return

        if path == "/metrics":
            total_events = 0
            if LOG_FILE.exists():
                with LOG_FILE.open("r", encoding="utf-8") as handle:
                    total_events = sum(1 for _ in handle)
            self._send_json(
                200,
                {"service": "secure_api_lab", "metrics": {"events_logged_total": total_events, "rate_limit_window_seconds": RATE_WINDOW_SECONDS}},
                "metrics",
            )
            return

        if path == "/api/telemetry":
            if not self._valid_api_key():
                self._send_json(
                    401,
                    {"error": "unauthorized", "message": "missing or invalid X-API-Key"},
                    "auth_failure",
                )
                return

            node_id = query.get("node_id", [""])[0]
            if not self._validate_node_id(node_id):
                self._send_json(
                    400,
                    {"error": "validation_error", "field": "node_id", "expected": "node-001 style format"},
                    "validation_error",
                )
                return

            self._send_json(
                200,
                {
                    "node_id": node_id,
                    "battery": 87,
                    "temperature_c": 31.5,
                    "status": "nominal",
                    "telemetry_timestamp": now(),
                },
                "api_success",
            )
            return

        if path == "/admin/config":
            if not self._valid_admin_key():
                self._send_json(
                    403,
                    {"error": "forbidden", "message": "admin key required"},
                    "forbidden",
                )
                return

            self._send_json(
                200,
                {
                    "service": "secure_api_lab",
                    "admin": True,
                    "config": {
                        "bind": HOST,
                        "port": PORT,
                        "rate_window_seconds": RATE_WINDOW_SECONDS,
                        "rate_limit_requests": RATE_LIMIT_REQUESTS,
                    },
                },
                "admin_success",
            )
            return

        self._send_json(
            404,
            {"error": "not_found", "path": path},
            "not_found",
        )

    def do_POST(self) -> None:
        if self._rate_limited():
            self._send_json(
                429,
                {"error": "rate_limited", "message": "too many requests in local lab window"},
                "rate_limited",
            )
            return

        parsed = urlparse(self.path)
        path = parsed.path

        if path != "/api/command":
            self._send_json(
                404,
                {"error": "not_found", "path": path},
                "not_found",
            )
            return

        if not self._valid_api_key():
            self._send_json(
                401,
                {"error": "unauthorized", "message": "missing or invalid X-API-Key"},
                "auth_failure",
            )
            return

        ok, data, error = self._parse_json_body()
        if not ok or data is None:
            self._send_json(
                400,
                {"error": "validation_error", "message": error},
                "validation_error",
            )
            return

        node_id = str(data.get("node_id", ""))
        command = str(data.get("command", ""))

        if not self._validate_node_id(node_id):
            self._send_json(
                400,
                {"error": "validation_error", "field": "node_id", "expected": "node-001 style format"},
                "validation_error",
            )
            return

        if command not in ALLOWED_COMMANDS:
            self._send_json(
                400,
                {"error": "validation_error", "field": "command", "allowed_commands": sorted(ALLOWED_COMMANDS)},
                "validation_error",
            )
            return

        self._send_json(
            202,
            {
                "accepted": True,
                "node_id": node_id,
                "command": command,
                "message": "command accepted in local defensive lab",
            },
            "command_accepted",
        )

    def do_PUT(self) -> None:
        self._send_json(
            405,
            {"error": "method_not_allowed", "allowed": ["GET", "POST", "OPTIONS"]},
            "method_not_allowed",
        )

    def do_DELETE(self) -> None:
        self._send_json(
            405,
            {"error": "method_not_allowed", "allowed": ["GET", "POST", "OPTIONS"]},
            "method_not_allowed",
        )

    def log_message(self, format: str, *args: Any) -> None:
        print(
            json.dumps(
                {
                    "timestamp": now(),
                    "client_ip": self.client_address[0],
                    "request": self.requestline,
                    "message": format % args,
                },
                sort_keys=True,
            )
        )


def main() -> None:
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    server = HTTPServer((HOST, PORT), SecureApiHandler)

    print(f"[SECURE-API] Listening on http://{HOST}:{PORT}")
    print(f"[SECURE-API] Logs: {LOG_FILE}")
    print("[SECURE-API] Tokens:")
    print("  X-API-Key: microbot-api-token")
    print("  X-Admin-Key: microbot-admin-token")
    print("[SECURE-API] Stop with CTRL + C")

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n[SECURE-API] Server stopped by user.")
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
