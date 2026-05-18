# Lab 002 — Local HTTP Server, curl, ss and tcpdump

## Objective

The objective of this lab is to start a local HTTP server on the loopback interface, test it with `curl`, inspect the listening TCP port with `ss`, and capture local packets with `tcpdump`.

This lab connects four important concepts:

1. A local process can open a listening TCP port.
2. `curl` can generate an HTTP request toward that local service.
3. `ss` can show which process is listening on the port.
4. `tcpdump` can capture packets on the loopback interface.

The entire exercise is local. Traffic sent to `127.0.0.1` stays inside the machine and does not leave the host.

## Safety boundary

This lab must be executed only on the local machine. It uses:

- `127.0.0.1`
- `localhost`
- loopback interface `lo`
- local TCP port `8080`

It does not scan external systems, does not contact unauthorized targets, and does not inspect other people's traffic.

## Theory

The address `127.0.0.1` is the IPv4 loopback address. When a program connects to `127.0.0.1`, the packet does not go through the physical network card. It is handled internally by the Linux kernel through the loopback interface, usually named `lo`.

A minimal HTTP server can be started with Python using:

```bash
python3 -m http.server 8080 --bind 127.0.0.1
```

This command starts a web server on TCP port `8080`, bound only to the local loopback address. Because it is bound to `127.0.0.1`, it is reachable from the same machine but not exposed to the external network.

## Step 1 — Create the local lab directory

```bash
mkdir -p ~/linux_lab/http_packet_lab
cd ~/linux_lab/http_packet_lab
```

### Command description

`mkdir -p` creates the directory if it does not already exist.

`cd` enters the directory.

### Expected output

Usually there is no output if the command succeeds.

## Step 2 — Create a test HTML file

```bash
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
```

### Command description

This creates a simple `index.html` file. The Python HTTP server will serve this file when the browser or `curl` requests `/`.

### Expected output

There is no terminal output if the file is created correctly.

To verify the file:

```bash
ls -l index.html
cat index.html
```

Expected output example:

```text
-rw-r--r-- 1 anton staff 221 May 18 12:00 index.html
```

## Step 3 — Start the local HTTP server

```bash
python3 -m http.server 8080 --bind 127.0.0.1
```

### Command description

`python3 -m http.server` starts Python's built-in HTTP server.

`8080` is the TCP port.

`--bind 127.0.0.1` forces the server to listen only on the local loopback address.

### Expected output

```text
Serving HTTP on 127.0.0.1 port 8080 (http://127.0.0.1:8080/) ...
```

### Important note

This command remains active. It is not frozen. It is waiting for HTTP requests.

To stop it:

```text
CTRL + C
```

## Step 4 — Test the server from a second terminal

Open a second terminal and run:

```bash
curl http://127.0.0.1:8080
```

### Expected output

```html
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
```

### Interpretation

The server is working. `curl` requested the page from `127.0.0.1:8080`, and the Python process returned the content of `index.html`.

## Step 5 — Read only HTTP headers

```bash
curl -I http://127.0.0.1:8080
```

### Expected output

```text
HTTP/1.0 200 OK
Server: SimpleHTTP/0.6 Python/3.x
Date: Mon, 18 May 2026 12:00:00 GMT
Content-type: text/html
Content-Length: 221
Last-Modified: Mon, 18 May 2026 12:00:00 GMT
```

### Interpretation

`HTTP/1.0 200 OK` means that the server responded successfully.

`Content-type: text/html` means that the served file is interpreted as HTML.

`Content-Length` indicates the size of the response body in bytes.

## Step 6 — Use verbose curl

```bash
curl -v http://127.0.0.1:8080
```

### Expected output example

```text
*   Trying 127.0.0.1:8080...
* Connected to 127.0.0.1 (127.0.0.1) port 8080
> GET / HTTP/1.1
> Host: 127.0.0.1:8080
> User-Agent: curl/8.x
> Accept: */*
< HTTP/1.0 200 OK
< Server: SimpleHTTP/0.6 Python/3.x
< Content-type: text/html
```

### Interpretation

The `>` lines represent the HTTP request sent by the client.

The `<` lines represent the HTTP response received from the server.

This is useful for understanding the client-server exchange.

## Step 7 — Inspect the listening port with ss

```bash
ss -ltnp | grep 8080
```

If permission is needed to see process details:

```bash
sudo ss -ltnp | grep 8080
```

### Expected output

```text
LISTEN 0 5 127.0.0.1:8080 0.0.0.0:* users:(("python3",pid=12345,fd=3))
```

### Interpretation

`LISTEN` means that a process is waiting for incoming TCP connections.

`127.0.0.1:8080` is the local address and port.

`python3` is the process that opened the port.

`pid=12345` is the process ID.

## Step 8 — Capture packets with tcpdump

Open a third terminal and run:

```bash
sudo tcpdump -i lo port 8080 -c 20
```

Then, from the second terminal, generate traffic:

```bash
curl http://127.0.0.1:8080
```

### Expected tcpdump output

```text
IP localhost.54321 > localhost.8080: Flags [S], seq ...
IP localhost.8080 > localhost.54321: Flags [S.], seq ..., ack ...
IP localhost.54321 > localhost.8080: Flags [.], ack ...
IP localhost.54321 > localhost.8080: Flags [P.], seq ..., ack ...
IP localhost.8080 > localhost.54321: Flags [P.], seq ..., ack ...
```

### Interpretation

The first packets show the TCP handshake.

`[S]` is SYN.

`[S.]` is SYN-ACK.

`[.]` is ACK.

`[P.]` usually indicates that payload data is being pushed, such as the HTTP request or response.

## Step 9 — Save a pcap file

```bash
mkdir -p ~/linux_lab/pcaps
sudo tcpdump -i lo port 8080 -w ~/linux_lab/pcaps/local_http_8080.pcap -c 50
```

Generate traffic from another terminal:

```bash
curl http://127.0.0.1:8080
curl -I http://127.0.0.1:8080
```

Then read the pcap:

```bash
tcpdump -r ~/linux_lab/pcaps/local_http_8080.pcap
```

### Expected output

```text
reading from file /home/anton/linux_lab/pcaps/local_http_8080.pcap, link-type EN10MB
IP localhost.54321 > localhost.8080: Flags [S]
IP localhost.8080 > localhost.54321: Flags [S.]
```

### Interpretation

The `.pcap` file stores captured packets. It can be inspected later with `tcpdump` or opened with Wireshark.

## Step 10 — Cleanup

Stop the Python HTTP server with:

```text
CTRL + C
```

Check that port `8080` is no longer listening:

```bash
ss -ltnp | grep 8080 || echo "Port 8080 is no longer listening"
```

### Expected output

```text
Port 8080 is no longer listening
```

## Common issues

### Port already in use

If port `8080` is already used:

```text
OSError: [Errno 98] Address already in use
```

Find the process:

```bash
sudo ss -ltnp | grep 8080
```

Use another local port, for example:

```bash
python3 -m http.server 8081 --bind 127.0.0.1
```

### tcpdump permission denied

If tcpdump fails with permission errors, use:

```bash
sudo tcpdump -i lo port 8080 -c 20
```

### curl connection refused

If `curl` says:

```text
Connection refused
```

it usually means the server is not running or is listening on a different address/port.

## Final conclusion

This lab demonstrates the complete local chain:

```text
Python HTTP server
-> TCP listening port 8080
-> curl HTTP request
-> ss process/port inspection
-> tcpdump packet capture on loopback
```

This is a safe and fundamental exercise for Linux networking, system administration, troubleshooting, and defensive cybersecurity documentation.
