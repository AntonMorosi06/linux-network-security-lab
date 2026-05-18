#!/usr/bin/env bash
set -euo pipefail

LAB_DIR="$HOME/linux_lab/http_packet_lab"
PORT="8080"
BIND_ADDR="127.0.0.1"

mkdir -p "$LAB_DIR"
cd "$LAB_DIR"

cat > index.html <<'HTML'
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Linux Local HTTP Lab</title>
</head>
<body>
  <h1>Linux Local HTTP Lab</h1>
  <p>This page is served from a local Python HTTP server.</p>
</body>
</html>
HTML

echo "[INFO] Starting local HTTP server"
echo "[INFO] Directory: $LAB_DIR"
echo "[INFO] URL: http://$BIND_ADDR:$PORT"
echo "[INFO] Stop with CTRL + C"
echo ""

python3 -m http.server "$PORT" --bind "$BIND_ADDR"
