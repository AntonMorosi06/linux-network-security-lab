#!/usr/bin/env python3
from __future__ import annotations

from http.server import BaseHTTPRequestHandler, HTTPServer
import json
import os
import socket
import time
from typing import Any, Dict

HOST = "0.0.0.0"
PORT = int(os.environ.get("API_PORT", "8701"))
LAB_NAME = os.environ.get("LAB_NAME", "lab012")

START_TIME = time.time()
REQUESTS_TOTAL = 0
STATUS_REQUESTS_TOTAL = 0
HEALTH_REQUESTS_TOTAL = 0
METRICS_REQUESTS_TOTAL = 0
ERROR_REQUESTS_TOTAL = 0
NOT_FOUND_REQUESTS_TOTAL = 0
LAST_REQUEST_TIMESTAMP = 0.0


def update_counters(path: str, status_code: int) -> None:
    global REQUESTS_TOTAL, STATUS_REQUESTS_TOTAL, HEALTH_REQUESTS_TOTAL
    global METRICS_REQUESTS_TOTAL, ERROR_REQUESTS_TOTAL, NOT_FOUND_REQUESTS_TOTAL
    global LAST_REQUEST_TIMESTAMP

    REQUESTS_TOTAL += 1
    LAST_REQUEST_TIMESTAMP = time.time()

    if path == "/status":
        STATUS_REQUESTS_TOTAL += 1
    elif path == "/health":
        HEALTH_REQUESTS_TOTAL += 1
    elif path == "/metrics":
        METRICS_REQUESTS_TOTAL += 1

    if status_code >= 500:
        ERROR_REQUESTS_TOTAL += 1
    if status_code == 404:
        NOT_FOUND_REQUESTS_TOTAL += 1


class MetricsApiHandler(BaseHTTPRequestHandler):
    server_version = "MetricsLab012Api/0.1"

    def _send_json(self, status_code: int, payload: Dict[str, Any]) -> None:
        update_counters(self.path, status_code)
        body = json.dumps(payload, indent=2).encode("utf-8")
        self.send_response(status_code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("X-Content-Type-Options", "nosniff")
        self.end_headers()
        self.wfile.write(body)

    def _send_text(self, status_code: int, body: str, content_type: str = "text/plain") -> None:
        update_counters(self.path, status_code)
        encoded = body.encode("utf-8")
        self.send_response(status_code)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(encoded)))
        self.send_header("X-Content-Type-Options", "nosniff")
        self.end_headers()
        self.wfile.write(encoded)

    def _metrics_body(self) -> str:
        uptime = time.time() - START_TIME
        current = time.time()
        hostname = socket.gethostname()
        return f"""# HELP lab012_requests_total Total number of HTTP requests handled by the API.
# TYPE lab012_requests_total counter
lab012_requests_total {REQUESTS_TOTAL}

# HELP lab012_status_requests_total Total number of /status requests.
# TYPE lab012_status_requests_total counter
lab012_status_requests_total {STATUS_REQUESTS_TOTAL}

# HELP lab012_health_requests_total Total number of /health requests.
# TYPE lab012_health_requests_total counter
lab012_health_requests_total {HEALTH_REQUESTS_TOTAL}

# HELP lab012_metrics_requests_total Total number of /metrics requests.
# TYPE lab012_metrics_requests_total counter
lab012_metrics_requests_total {METRICS_REQUESTS_TOTAL}

# HELP lab012_error_requests_total Total number of 5xx responses.
# TYPE lab012_error_requests_total counter
lab012_error_requests_total {ERROR_REQUESTS_TOTAL}

# HELP lab012_not_found_requests_total Total number of 404 responses.
# TYPE lab012_not_found_requests_total counter
lab012_not_found_requests_total {NOT_FOUND_REQUESTS_TOTAL}

# HELP lab012_uptime_seconds API process uptime in seconds.
# TYPE lab012_uptime_seconds gauge
lab012_uptime_seconds {uptime:.3f}

# HELP lab012_last_request_timestamp_seconds Unix timestamp of the last request.
# TYPE lab012_last_request_timestamp_seconds gauge
lab012_last_request_timestamp_seconds {LAST_REQUEST_TIMESTAMP:.3f}

# HELP lab012_current_timestamp_seconds Current Unix timestamp at metrics scrape time.
# TYPE lab012_current_timestamp_seconds gauge
lab012_current_timestamp_seconds {current:.3f}

# HELP lab012_build_info Static build information for the lab service.
# TYPE lab012_build_info gauge
lab012_build_info{{lab="{LAB_NAME}",service="metrics_api",hostname="{hostname}"}} 1
"""

    def do_GET(self) -> None:
        if self.path == "/status":
            self._send_json(200, {"service": "metrics_lab012_api", "status": "ok", "lab": LAB_NAME, "hostname": socket.gethostname(), "port": PORT, "timestamp": time.time()})
        elif self.path == "/health":
            self._send_json(200, {"health": "green", "checks": {"api": "ok", "metrics_endpoint": "ok", "prometheus_scrape_ready": "ok"}})
        elif self.path == "/metrics":
            self._send_text(200, self._metrics_body(), "text/plain; version=0.0.4; charset=utf-8")
        elif self.path == "/error":
            self._send_json(500, {"error": "controlled_error", "message": "intentional local lab error for metrics testing"})
        else:
            self._send_json(404, {"error": "not_found", "path": self.path})

    def log_message(self, format: str, *args: Any) -> None:
        print(json.dumps({"timestamp": time.time(), "client": self.client_address[0], "request": self.requestline, "message": format % args}, sort_keys=True), flush=True)


def main() -> None:
    server = HTTPServer((HOST, PORT), MetricsApiHandler)
    print(f"[METRICS-API] Compose Lab 012 API listening on {HOST}:{PORT}", flush=True)
    print("[METRICS-API] Endpoints: /status, /health, /metrics, /error", flush=True)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("[METRICS-API] Server stopped.", flush=True)
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
