#!/usr/bin/env python3
from __future__ import annotations

from http.server import BaseHTTPRequestHandler, HTTPServer
import json
import os
import socket
import time
from typing import Any, Dict


HOST = "0.0.0.0"
PORT = int(os.environ.get("API_PORT", "8901"))
LAB_NAME = os.environ.get("LAB_NAME", "lab017")

START_TIME = time.time()
REQUESTS_TOTAL = 0
STATUS_REQUESTS_TOTAL = 0
HEALTH_REQUESTS_TOTAL = 0
METRICS_REQUESTS_TOTAL = 0
ERROR_REQUESTS_TOTAL = 0
NOT_FOUND_TOTAL = 0
LAST_REQUEST_TIMESTAMP = 0.0


def now() -> float:
    return time.time()


def record(path: str, status: int) -> None:
    global REQUESTS_TOTAL
    global STATUS_REQUESTS_TOTAL
    global HEALTH_REQUESTS_TOTAL
    global METRICS_REQUESTS_TOTAL
    global ERROR_REQUESTS_TOTAL
    global NOT_FOUND_TOTAL
    global LAST_REQUEST_TIMESTAMP

    REQUESTS_TOTAL += 1
    LAST_REQUEST_TIMESTAMP = now()

    if path == "/status":
        STATUS_REQUESTS_TOTAL += 1
    elif path == "/health":
        HEALTH_REQUESTS_TOTAL += 1
    elif path == "/metrics":
        METRICS_REQUESTS_TOTAL += 1

    if status >= 500:
        ERROR_REQUESTS_TOTAL += 1
    if status == 404:
        NOT_FOUND_TOTAL += 1


class ObservableHandler(BaseHTTPRequestHandler):
    server_version = "Lab017ObservableApi/0.1"

    def _send_json(self, status: int, payload: Dict[str, Any]) -> None:
        record(self.path, status)
        body = json.dumps(payload, indent=2).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("X-Content-Type-Options", "nosniff")
        self.end_headers()
        self.wfile.write(body)

    def _send_text(self, status: int, body: str, content_type: str = "text/plain") -> None:
        record(self.path, status)
        encoded = body.encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(encoded)))
        self.send_header("X-Content-Type-Options", "nosniff")
        self.end_headers()
        self.wfile.write(encoded)

    def _metrics(self) -> str:
        uptime = now() - START_TIME
        return f"""# HELP lab017_requests_total Total HTTP requests.
# TYPE lab017_requests_total counter
lab017_requests_total {REQUESTS_TOTAL}

# HELP lab017_status_requests_total Total /status requests.
# TYPE lab017_status_requests_total counter
lab017_status_requests_total {STATUS_REQUESTS_TOTAL}

# HELP lab017_health_requests_total Total /health requests.
# TYPE lab017_health_requests_total counter
lab017_health_requests_total {HEALTH_REQUESTS_TOTAL}

# HELP lab017_metrics_requests_total Total /metrics requests.
# TYPE lab017_metrics_requests_total counter
lab017_metrics_requests_total {METRICS_REQUESTS_TOTAL}

# HELP lab017_error_requests_total Total 5xx responses.
# TYPE lab017_error_requests_total counter
lab017_error_requests_total {ERROR_REQUESTS_TOTAL}

# HELP lab017_not_found_total Total 404 responses.
# TYPE lab017_not_found_total counter
lab017_not_found_total {NOT_FOUND_TOTAL}

# HELP lab017_uptime_seconds API uptime in seconds.
# TYPE lab017_uptime_seconds gauge
lab017_uptime_seconds {uptime:.3f}

# HELP lab017_last_request_timestamp_seconds Unix timestamp of last request.
# TYPE lab017_last_request_timestamp_seconds gauge
lab017_last_request_timestamp_seconds {LAST_REQUEST_TIMESTAMP:.3f}

# HELP lab017_build_info Static build info.
# TYPE lab017_build_info gauge
lab017_build_info{{lab="{LAB_NAME}",service="observable_api",hostname="{socket.gethostname()}"}} 1
"""

    def do_GET(self) -> None:
        if self.path == "/status":
            self._send_json(
                200,
                {
                    "service": "lab017_observable_api",
                    "status": "ok",
                    "lab": LAB_NAME,
                    "hostname": socket.gethostname(),
                    "timestamp": now(),
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
                        "metrics": "ok",
                        "grafana_ready": "ok",
                    },
                },
            )
            return

        if self.path == "/metrics":
            self._send_text(
                200,
                self._metrics(),
                content_type="text/plain; version=0.0.4; charset=utf-8",
            )
            return

        if self.path == "/error":
            self._send_json(
                500,
                {
                    "error": "controlled_error",
                    "message": "intentional local error for dashboard and alert testing",
                },
            )
            return

        self._send_json(404, {"error": "not_found", "path": self.path})

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
    server = HTTPServer((HOST, PORT), ObservableHandler)
    print(f"[LAB017-API] listening on {HOST}:{PORT}", flush=True)
    print("[LAB017-API] endpoints: /status /health /metrics /error", flush=True)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("[LAB017-API] stopped", flush=True)
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
