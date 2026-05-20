# All Codes Together FULL — Linux Network Security Lab

Generated: `2026-05-20T12:21:47.146659+00:00`

This document is the complete extracted command/code index for Labs 001-030.

It is generated from the Markdown files in `labs/`. It includes fenced code blocks from the lab documents, including commands, configs, examples, expected outputs and report templates when they appear inside the lab file.

## Safety rule

Use these commands only on localhost, personal machines, VMs, containers, Linux namespaces or explicitly authorized lab environments.

Do not scan, test, capture, monitor, audit or modify systems you do not own or do not have permission to assess.

Do not publish raw outputs before privacy review.

## Lab 000 — Setup

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
git status
git pull --ff-only origin main
mkdir -p "$HOME/linux_lab/reports"
mkdir -p "$HOME/linux_lab/private_outputs"
mkdir -p "$HOME/linux_lab/backups"
python3 --version
git --version
./scripts/list_lab_commands.sh
```

## Generated lab coverage

| Lab | Title | Code blocks extracted | Command blocks |
|---:|---|---:|---:|
| 001 | Lab 001 — Local System and Network Baseline | 2 | 1 |
| 002 | Lab 002 — Local HTTP Server, curl, ss and tcpdump | 33 | 19 |
| 003 | Lab 003 — Ports, Processes, Logs and Local Diagnostics | 24 | 16 |
| 004 | Lab 004 — DNS, Routing and Connectivity Diagnostics | 27 | 14 |
| 005 | Lab 005 — Network Namespace Client-Router-Server Topology | 35 | 17 |
| 006 | Lab 006 — Firewall and NAT inside a Network Namespace Router | 43 | 25 |
| 007 | Lab 007 — Traffic Shaping, Latency, Packet Loss and Bandwidth Limits | 32 | 21 |
| 008 | Lab 008 — Local JSON API, Structured Logs and Mini Detector | 35 | 12 |
| 009 | Lab 009 — Local API Security Controls | 37 | 15 |
| 010 | Lab 010 — Docker Bridge Network and Container Diagnostics | 36 | 20 |
| 011 | Lab 011 — Docker Compose API, Reverse Proxy and Local Logs | 31 | 15 |
| 012 | Lab 012 — Prometheus-style Metrics and Local Monitoring | 19 | 8 |
| 013 | Lab 013 — GitHub Actions CI and Local Validation | 11 | 6 |
| 014 | Lab 014 — Threat Modeling and Hardening Checklist | 10 | 2 |
| 015 | Lab 015 — Final Capstone Secure Local Service | 35 | 12 |
| 016 | Lab 016 — Release Engineering, Repository Audit and Publication Readiness | 17 | 5 |
| 017 | Lab 017 — Grafana Dashboard and Prometheus Alert Rules | 33 | 12 |
| 018 | Lab 018 — Local SIEM-style Log Pipeline and Detection Rules | 22 | 8 |
| 019 | Lab 019 — Incident Response Case File and Evidence Bundle | 22 | 8 |
| 020 | Lab 020 — Final Master Index, Proof-of-Work Bundle and Release Candidate Review | 16 | 6 |
| 021 | Lab 021 — Linux Security Tools Overview | 8 | 3 |
| 022 | Lab 022 — Wireshark and TShark Packet Analysis | 20 | 8 |
| 023 | Lab 023 — Nmap Localhost and Authorized Service Scanning | 17 | 8 |
| 024 | Lab 024 — Aircrack-ng Wireless Security Awareness | 14 | 4 |
| 025 | Lab 025 — tcpdump Advanced Capture Filters | 18 | 7 |
| 026 | Lab 026 — Defensive Firewall Rules with nftables, iptables and ufw | 14 | 4 |
| 027 | Lab 027 — SSH Hardening and Key-Based Access | 14 | 4 |
| 028 | Lab 028 — auditd and Linux Event Auditing | 15 | 5 |
| 029 | Lab 029 — Lynis Local Security Audit | 17 | 6 |
| 030 | Lab 030 — Fail2ban Local Log-Based Protection | 17 | 5 |

## Labs 001-030 extracted blocks

## Lab 001 — Lab 001 — Local System and Network Baseline

Source file: `labs/001_local_system_and_network_baseline.md`

### Lab 001 Block 01 — command — language: `bash`

```bash
uname -a
hostname
whoami
id
ip -br addr
ip route
cat /etc/resolv.conf
ss -tulpen
systemctl --failed
journalctl -p warning -n 30 --no-pager
```

### Lab 001 Block 02 — config_or_output — language: `text`

```text
Linux anton-linux 6.x.x-generic x86_64 GNU/Linux
anton-linux
anton
uid=1000(anton) gid=1000(anton) groups=1000(anton),27(sudo)

lo      UNKNOWN 127.0.0.1/8 ::1/128
wlan0   UP      192.168.1.45/24

default via 192.168.1.1 dev wlan0
192.168.1.0/24 dev wlan0 proto kernel scope link src 192.168.1.45
```

## Lab 002 — Lab 002 — Local HTTP Server, curl, ss and tcpdump

Source file: `labs/002_local_http_server_curl_ss_tcpdump.md`

### Lab 002 Block 01 — command — language: `bash`

```bash
python3 -m http.server 8080 --bind 127.0.0.1
```

### Lab 002 Block 02 — command — language: `bash`

```bash
mkdir -p ~/linux_lab/http_packet_lab
cd ~/linux_lab/http_packet_lab
```

### Lab 002 Block 03 — command — language: `bash`

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

### Lab 002 Block 04 — command — language: `bash`

```bash
ls -l index.html
cat index.html
```

### Lab 002 Block 05 — config_or_output — language: `text`

```text
-rw-r--r-- 1 anton staff 221 May 18 12:00 index.html
```

### Lab 002 Block 06 — command — language: `bash`

```bash
python3 -m http.server 8080 --bind 127.0.0.1
```

### Lab 002 Block 07 — config_or_output — language: `text`

```text
Serving HTTP on 127.0.0.1 port 8080 (http://127.0.0.1:8080/) ...
```

### Lab 002 Block 08 — config_or_output — language: `text`

```text
CTRL + C
```

### Lab 002 Block 09 — command — language: `bash`

```bash
curl http://127.0.0.1:8080
```

### Lab 002 Block 10 — code_or_reference — language: `html`

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

### Lab 002 Block 11 — command — language: `bash`

```bash
curl -I http://127.0.0.1:8080
```

### Lab 002 Block 12 — config_or_output — language: `text`

```text
HTTP/1.0 200 OK
Server: SimpleHTTP/0.6 Python/3.x
Date: Mon, 18 May 2026 12:00:00 GMT
Content-type: text/html
Content-Length: 221
Last-Modified: Mon, 18 May 2026 12:00:00 GMT
```

### Lab 002 Block 13 — command — language: `bash`

```bash
curl -v http://127.0.0.1:8080
```

### Lab 002 Block 14 — config_or_output — language: `text`

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

### Lab 002 Block 15 — command — language: `bash`

```bash
ss -ltnp | grep 8080
```

### Lab 002 Block 16 — command — language: `bash`

```bash
sudo ss -ltnp | grep 8080
```

### Lab 002 Block 17 — config_or_output — language: `text`

```text
LISTEN 0 5 127.0.0.1:8080 0.0.0.0:* users:(("python3",pid=12345,fd=3))
```

### Lab 002 Block 18 — command — language: `bash`

```bash
sudo tcpdump -i lo port 8080 -c 20
```

### Lab 002 Block 19 — command — language: `bash`

```bash
curl http://127.0.0.1:8080
```

### Lab 002 Block 20 — config_or_output — language: `text`

```text
IP localhost.54321 > localhost.8080: Flags [S], seq ...
IP localhost.8080 > localhost.54321: Flags [S.], seq ..., ack ...
IP localhost.54321 > localhost.8080: Flags [.], ack ...
IP localhost.54321 > localhost.8080: Flags [P.], seq ..., ack ...
IP localhost.8080 > localhost.54321: Flags [P.], seq ..., ack ...
```

### Lab 002 Block 21 — command — language: `bash`

```bash
mkdir -p ~/linux_lab/pcaps
sudo tcpdump -i lo port 8080 -w ~/linux_lab/pcaps/local_http_8080.pcap -c 50
```

### Lab 002 Block 22 — command — language: `bash`

```bash
curl http://127.0.0.1:8080
curl -I http://127.0.0.1:8080
```

### Lab 002 Block 23 — command — language: `bash`

```bash
tcpdump -r ~/linux_lab/pcaps/local_http_8080.pcap
```

### Lab 002 Block 24 — config_or_output — language: `text`

```text
reading from file /home/anton/linux_lab/pcaps/local_http_8080.pcap, link-type EN10MB
IP localhost.54321 > localhost.8080: Flags [S]
IP localhost.8080 > localhost.54321: Flags [S.]
```

### Lab 002 Block 25 — config_or_output — language: `text`

```text
CTRL + C
```

### Lab 002 Block 26 — command — language: `bash`

```bash
ss -ltnp | grep 8080 || echo "Port 8080 is no longer listening"
```

### Lab 002 Block 27 — config_or_output — language: `text`

```text
Port 8080 is no longer listening
```

### Lab 002 Block 28 — config_or_output — language: `text`

```text
OSError: [Errno 98] Address already in use
```

### Lab 002 Block 29 — command — language: `bash`

```bash
sudo ss -ltnp | grep 8080
```

### Lab 002 Block 30 — command — language: `bash`

```bash
python3 -m http.server 8081 --bind 127.0.0.1
```

### Lab 002 Block 31 — command — language: `bash`

```bash
sudo tcpdump -i lo port 8080 -c 20
```

### Lab 002 Block 32 — config_or_output — language: `text`

```text
Connection refused
```

### Lab 002 Block 33 — config_or_output — language: `text`

```text
Python HTTP server
-> TCP listening port 8080
-> curl HTTP request
-> ss process/port inspection
-> tcpdump packet capture on loopback
```

## Lab 003 — Lab 003 — Ports, Processes, Logs and Local Diagnostics

Source file: `labs/003_ports_processes_logs_diagnostics.md`

### Lab 003 Block 01 — config_or_output — language: `text`

```text
program
-> process
-> socket
-> port
-> protocol
-> logs
-> service manager
```

### Lab 003 Block 02 — command — language: `bash`

```bash
ss -tulpen
```

### Lab 003 Block 03 — command — language: `bash`

```bash
sudo ss -tulpen
```

### Lab 003 Block 04 — config_or_output — language: `text`

```text
Netid State  Recv-Q Send-Q Local Address:Port  Peer Address:Port Process
tcp   LISTEN 0      5      127.0.0.1:8080     0.0.0.0:*     users:(("python3",pid=12345,fd=3))
```

### Lab 003 Block 05 — command — language: `bash`

```bash
ss -ltnp | grep 8080
```

### Lab 003 Block 06 — command — language: `bash`

```bash
sudo lsof -i :8080 -P -n
```

### Lab 003 Block 07 — command — language: `text`

```text
python3 12345 anton 3u IPv4 123456 0t0 TCP 127.0.0.1:8080 (LISTEN)
```

### Lab 003 Block 08 — command — language: `bash`

```bash
ps aux
```

### Lab 003 Block 09 — command — language: `bash`

```bash
ps aux | sort -nrk 3 | head -15
```

### Lab 003 Block 10 — command — language: `bash`

```bash
ps aux | sort -nrk 4 | head -15
```

### Lab 003 Block 11 — config_or_output — language: `text`

```text
USER       PID  %CPU %MEM COMMAND
anton    12345   0.1  0.3 python3 -m http.server 8080 --bind 127.0.0.1
```

### Lab 003 Block 12 — command — language: `bash`

```bash
systemctl --failed
```

### Lab 003 Block 13 — config_or_output — language: `text`

```text
0 loaded units listed.
```

### Lab 003 Block 14 — command — language: `bash`

```bash
systemctl status SERVICE_NAME --no-pager
journalctl -u SERVICE_NAME -n 100 --no-pager
```

### Lab 003 Block 15 — command — language: `bash`

```bash
journalctl -p warning -n 50 --no-pager
```

### Lab 003 Block 16 — command — language: `bash`

```bash
journalctl -p err -n 50 --no-pager
```

### Lab 003 Block 17 — command — language: `bash`

```bash
journalctl -b -p err --no-pager
```

### Lab 003 Block 18 — config_or_output — language: `text`

```text
May 18 12:30:00 anton-linux systemd[1]: example.service: Failed with result 'exit-code'.
```

### Lab 003 Block 19 — command — language: `bash`

```bash
logger "LINUX_LAB_003: normal diagnostic event"
logger -p user.warning "LINUX_LAB_003: controlled warning event"
logger -p user.err "LINUX_LAB_003: controlled error event"
```

### Lab 003 Block 20 — command — language: `bash`

```bash
journalctl -n 50 --no-pager | grep LINUX_LAB_003
```

### Lab 003 Block 21 — config_or_output — language: `text`

```text
May 18 12:35:00 anton-linux anton: LINUX_LAB_003: normal diagnostic event
May 18 12:35:01 anton-linux anton: LINUX_LAB_003: controlled warning event
May 18 12:35:02 anton-linux anton: LINUX_LAB_003: controlled error event
```

### Lab 003 Block 22 — command — language: `bash`

```bash
./scripts/create_ports_logs_report.sh
```

### Lab 003 Block 23 — config_or_output — language: `text`

```text
[OK] Report creato:
~/linux_lab/reports/ports_logs_report_20260518_123500.txt
```

### Lab 003 Block 24 — config_or_output — language: `text`

```text
1. Check whether the process exists.
2. Check whether the port is listening.
3. Check which address the port is bound to.
4. Check whether systemd reports failed services.
5. Check warning and error logs.
6. Generate controlled events if testing log collection.
7. Save a report.
```

## Lab 004 — Lab 004 — DNS, Routing and Connectivity Diagnostics

Source file: `labs/004_dns_routing_connectivity_diagnostics.md`

### Lab 004 Block 01 — config_or_output — language: `text`

```text
local host
-> interface
-> IP address
-> route
-> default gateway
-> IP connectivity
-> DNS resolution
-> application protocol
```

### Lab 004 Block 02 — command — language: `bash`

```bash
ip -br addr
```

### Lab 004 Block 03 — command — language: `bash`

```bash
ifconfig
```

### Lab 004 Block 04 — config_or_output — language: `text`

```text
lo      UNKNOWN 127.0.0.1/8 ::1/128
wlan0   UP      192.168.1.45/24
```

### Lab 004 Block 05 — command — language: `bash`

```bash
ip route
```

### Lab 004 Block 06 — command — language: `bash`

```bash
netstat -rn
```

### Lab 004 Block 07 — config_or_output — language: `text`

```text
default via 192.168.1.1 dev wlan0 proto dhcp metric 600
192.168.1.0/24 dev wlan0 proto kernel scope link src 192.168.1.45
```

### Lab 004 Block 08 — config_or_output — language: `text`

```text
192.168.1.1
```

### Lab 004 Block 09 — command — language: `bash`

```bash
ip route | awk '/default/ {print $3; exit}'
```

### Lab 004 Block 10 — config_or_output — language: `text`

```text
192.168.1.1
```

### Lab 004 Block 11 — command — language: `bash`

```bash
ping -c 4 127.0.0.1
```

### Lab 004 Block 12 — config_or_output — language: `text`

```text
4 packets transmitted, 4 received, 0% packet loss
```

### Lab 004 Block 13 — command — language: `bash`

```bash
GATEWAY=$(ip route | awk '/default/ {print $3; exit}')
echo "Gateway: $GATEWAY"
ping -c 4 "$GATEWAY"
```

### Lab 004 Block 14 — config_or_output — language: `text`

```text
Gateway: 192.168.1.1
4 packets transmitted, 4 received, 0% packet loss
```

### Lab 004 Block 15 — command — language: `bash`

```bash
ping -c 4 1.1.1.1
```

### Lab 004 Block 16 — config_or_output — language: `text`

```text
4 packets transmitted, 4 received, 0% packet loss
```

### Lab 004 Block 17 — command — language: `bash`

```bash
getent hosts example.com
```

### Lab 004 Block 18 — command — language: `bash`

```bash
dig example.com
nslookup example.com
```

### Lab 004 Block 19 — config_or_output — language: `text`

```text
93.184.216.34 example.com
```

### Lab 004 Block 20 — command — language: `bash`

```bash
cat /etc/resolv.conf
```

### Lab 004 Block 21 — command — language: `bash`

```bash
resolvectl status
```

### Lab 004 Block 22 — config_or_output — language: `text`

```text
nameserver 127.0.0.53
options edns0 trust-ad
search home
```

### Lab 004 Block 23 — command — language: `bash`

```bash
curl -I https://example.com
```

### Lab 004 Block 24 — config_or_output — language: `text`

```text
HTTP/2 200
content-type: text/html
```

### Lab 004 Block 25 — config_or_output — language: `text`

```text
HTTP/1.1 200 OK
Content-Type: text/html
```

### Lab 004 Block 26 — command — language: `bash`

```bash
ip -br addr
ip route
ip route get 1.1.1.1
cat /etc/resolv.conf
ping -c 4 127.0.0.1
ping -c 4 1.1.1.1
getent hosts example.com
dig example.com
nslookup example.com
curl -I https://example.com
```

### Lab 004 Block 27 — config_or_output — language: `text`

```text
If IP works but names do not work, check DNS.
If local gateway does not work, check local network.
If DNS works but HTTPS does not work, check application/TLS/proxy/firewall layers.
```

## Lab 005 — Lab 005 — Network Namespace Client-Router-Server Topology

Source file: `labs/005_network_namespace_client_router_server.md`

### Lab 005 Block 01 — config_or_output — language: `text`

```text
lab_client  ->  lab_router  ->  lab_server
```

### Lab 005 Block 02 — config_or_output — language: `text`

```text
10.10.1.0/24                  10.10.2.0/24

 lab_client ---------------- lab_router ---------------- lab_server
 10.10.1.2       10.10.1.1     10.10.2.1       10.10.2.2
```

### Lab 005 Block 03 — config_or_output — language: `text`

```text
lab_client:
  veth_client = 10.10.1.2/24

lab_router:
  veth_router_client = 10.10.1.1/24
  veth_router_server = 10.10.2.1/24

lab_server:
  veth_server = 10.10.2.2/24
```

### Lab 005 Block 04 — config_or_output — language: `text`

```text
lab_client default gateway -> 10.10.1.1
lab_server default gateway -> 10.10.2.1
```

### Lab 005 Block 05 — command — language: `bash`

```bash
./scripts/setup_namespace_client_router_server.sh
```

### Lab 005 Block 06 — config_or_output — language: `text`

```text
[OK] Created namespace: lab_client
[OK] Created namespace: lab_router
[OK] Created namespace: lab_server
[OK] Created veth pairs
[OK] Assigned IP addresses
[OK] Enabled IPv4 forwarding inside lab_router
[OK] Namespace topology ready
```

### Lab 005 Block 07 — command — language: `bash`

```bash
ip netns list
```

### Lab 005 Block 08 — config_or_output — language: `text`

```text
lab_server
lab_router
lab_client
```

### Lab 005 Block 09 — command — language: `bash`

```bash
sudo ip netns exec lab_client ip -br addr
sudo ip netns exec lab_router ip -br addr
sudo ip netns exec lab_server ip -br addr
```

### Lab 005 Block 10 — config_or_output — language: `text`

```text
lo             UNKNOWN        127.0.0.1/8 ::1/128
veth_client    UP             10.10.1.2/24
```

### Lab 005 Block 11 — config_or_output — language: `text`

```text
lo                    UNKNOWN        127.0.0.1/8 ::1/128
veth_router_client    UP             10.10.1.1/24
veth_router_server    UP             10.10.2.1/24
```

### Lab 005 Block 12 — config_or_output — language: `text`

```text
lo             UNKNOWN        127.0.0.1/8 ::1/128
veth_server    UP             10.10.2.2/24
```

### Lab 005 Block 13 — command — language: `bash`

```bash
sudo ip netns exec lab_client ping -c 3 10.10.1.1
sudo ip netns exec lab_server ping -c 3 10.10.2.1
```

### Lab 005 Block 14 — config_or_output — language: `text`

```text
3 packets transmitted, 3 received, 0% packet loss
```

### Lab 005 Block 15 — command — language: `bash`

```bash
sudo ip netns exec lab_client ping -c 3 10.10.2.2
sudo ip netns exec lab_server ping -c 3 10.10.1.2
```

### Lab 005 Block 16 — config_or_output — language: `text`

```text
3 packets transmitted, 3 received, 0% packet loss
```

### Lab 005 Block 17 — command — language: `bash`

```bash
./scripts/start_namespace_http_server.sh
```

### Lab 005 Block 18 — config_or_output — language: `text`

```text
[INFO] Starting HTTP server inside lab_server
[INFO] URL from lab_client: http://10.10.2.2:8080
Serving HTTP on 10.10.2.2 port 8080 ...
```

### Lab 005 Block 19 — config_or_output — language: `text`

```text
CTRL + C
```

### Lab 005 Block 20 — command — language: `bash`

```bash
sudo ip netns exec lab_client curl http://10.10.2.2:8080
```

### Lab 005 Block 21 — config_or_output — language: `text`

```text
HTTP server inside lab_server namespace
```

### Lab 005 Block 22 — command — language: `bash`

```bash
./scripts/capture_namespace_http_traffic.sh
```

### Lab 005 Block 23 — command — language: `bash`

```bash
sudo ip netns exec lab_client curl http://10.10.2.2:8080
```

### Lab 005 Block 24 — config_or_output — language: `text`

```text
IP 10.10.1.2.54321 > 10.10.2.2.8080: Flags [S]
IP 10.10.2.2.8080 > 10.10.1.2.54321: Flags [S.]
IP 10.10.1.2.54321 > 10.10.2.2.8080: Flags [.]
IP 10.10.1.2.54321 > 10.10.2.2.8080: Flags [P.]
```

### Lab 005 Block 25 — command — language: `bash`

```bash
./scripts/test_namespace_client_router_server.sh
```

### Lab 005 Block 26 — command — language: `bash`

```bash
./scripts/cleanup_namespace_client_router_server.sh
```

### Lab 005 Block 27 — config_or_output — language: `text`

```text
[OK] Deleted namespace: lab_client
[OK] Deleted namespace: lab_router
[OK] Deleted namespace: lab_server
[OK] Cleanup complete
```

### Lab 005 Block 28 — command — language: `bash`

```bash
ip netns list
```

### Lab 005 Block 29 — command — language: `bash`

```bash
sudo apt update
sudo apt install iproute2 -y
```

### Lab 005 Block 30 — command — language: `bash`

```bash
sudo ip netns exec lab_router sysctl net.ipv4.ip_forward
sudo ip netns exec lab_client ip route
sudo ip netns exec lab_server ip route
```

### Lab 005 Block 31 — config_or_output — language: `text`

```text
net.ipv4.ip_forward = 1
```

### Lab 005 Block 32 — command — language: `bash`

```bash
sudo ip netns exec lab_server ss -ltnp | grep 8080
```

### Lab 005 Block 33 — command — language: `bash`

```bash
sudo ip netns exec lab_client curl http://10.10.2.2:8080
```

### Lab 005 Block 34 — command — language: `bash`

```bash
sudo apt install tcpdump -y
```

### Lab 005 Block 35 — config_or_output — language: `text`

```text
namespace isolation
-> veth links
-> IP addressing
-> routing
-> IP forwarding
-> client-server test
-> packet capture
-> cleanup
```

## Lab 006 — Lab 006 — Firewall and NAT inside a Network Namespace Router

Source file: `labs/006_namespace_firewall_nat_nftables.md`

### Lab 006 Block 01 — command — language: `bash`

```bash
./scripts/setup_namespace_client_router_server.sh
```

### Lab 006 Block 02 — command — language: `bash`

```bash
./scripts/test_namespace_client_router_server.sh
```

### Lab 006 Block 03 — config_or_output — language: `text`

```text
lab_client 10.10.1.2/24
    |
lab_router 10.10.1.1/24 + 10.10.2.1/24
    |
lab_server 10.10.2.2/24
```

### Lab 006 Block 04 — config_or_output — language: `text`

```text
routing only
routing + firewall filtering
routing + NAT
```

### Lab 006 Block 05 — config_or_output — language: `text`

```text
forward
```

### Lab 006 Block 06 — config_or_output — language: `text`

```text
postrouting
```

### Lab 006 Block 07 — command — language: `bash`

```bash
./scripts/namespace_firewall_flush_rules.sh
```

### Lab 006 Block 08 — command — language: `bash`

```bash
./scripts/namespace_firewall_stateful_rules.sh
```

### Lab 006 Block 09 — command — language: `bash`

```bash
./scripts/namespace_firewall_show_rules.sh
```

### Lab 006 Block 10 — config_or_output — language: `text`

```text
table inet lab_fw {
  chain forward {
    type filter hook forward priority filter; policy drop;
    ct state established,related counter accept
    ip protocol icmp counter accept
    ip saddr 10.10.1.2 ip daddr 10.10.2.2 tcp dport 8080 ct state new counter accept
    counter drop
  }
}
```

### Lab 006 Block 11 — command — language: `bash`

```bash
./scripts/start_namespace_http_server.sh
```

### Lab 006 Block 12 — config_or_output — language: `text`

```text
Serving HTTP on 10.10.2.2 port 8080 ...
```

### Lab 006 Block 13 — command — language: `bash`

```bash
sudo ip netns exec lab_client curl --max-time 3 http://10.10.2.2:8080
```

### Lab 006 Block 14 — config_or_output — language: `text`

```text
HTTP server inside lab_server namespace
```

### Lab 006 Block 15 — config_or_output — language: `text`

```text
source: 10.10.1.2
destination: 10.10.2.2
tcp dport: 8080
state: new
```

### Lab 006 Block 16 — config_or_output — language: `text`

```text
ct state established,related accept
```

### Lab 006 Block 17 — command — language: `bash`

```bash
./scripts/namespace_firewall_block_http.sh
```

### Lab 006 Block 18 — command — language: `bash`

```bash
sudo ip netns exec lab_client curl --max-time 3 http://10.10.2.2:8080
```

### Lab 006 Block 19 — config_or_output — language: `text`

```text
curl: (28) Connection timed out after 3000 milliseconds
```

### Lab 006 Block 20 — config_or_output — language: `text`

```text
service exists
network exists
route exists
firewall blocks traffic
```

### Lab 006 Block 21 — command — language: `bash`

```bash
./scripts/namespace_firewall_allow_http.sh
```

### Lab 006 Block 22 — command — language: `bash`

```bash
sudo ip netns exec lab_client curl --max-time 3 http://10.10.2.2:8080
```

### Lab 006 Block 23 — config_or_output — language: `text`

```text
HTTP server inside lab_server namespace
```

### Lab 006 Block 24 — command — language: `bash`

```bash
./scripts/namespace_firewall_show_rules.sh
```

### Lab 006 Block 25 — config_or_output — language: `text`

```text
ct state established,related counter packets 8 bytes 1024 accept
ip protocol icmp counter packets 6 bytes 504 accept
ip saddr 10.10.1.2 ip daddr 10.10.2.2 tcp dport 8080 ct state new counter packets 2 bytes 120 accept
counter packets 3 bytes 180 drop
```

### Lab 006 Block 26 — command — language: `bash`

```bash
./scripts/namespace_firewall_flush_rules.sh
```

### Lab 006 Block 27 — command — language: `bash`

```bash
./scripts/namespace_nat_enable_snat.sh
```

### Lab 006 Block 28 — config_or_output — language: `text`

```text
10.10.1.2 -> 10.10.2.2
```

### Lab 006 Block 29 — config_or_output — language: `text`

```text
10.10.2.1 -> 10.10.2.2
```

### Lab 006 Block 30 — command — language: `bash`

```bash
./scripts/start_namespace_http_server.sh
```

### Lab 006 Block 31 — command — language: `bash`

```bash
sudo ip netns exec lab_server tcpdump -i veth_server port 8080 -c 10
```

### Lab 006 Block 32 — command — language: `bash`

```bash
sudo ip netns exec lab_client curl http://10.10.2.2:8080
```

### Lab 006 Block 33 — config_or_output — language: `text`

```text
IP 10.10.2.1.54321 > 10.10.2.2.8080: Flags [S]
IP 10.10.2.2.8080 > 10.10.2.1.54321: Flags [S.]
```

### Lab 006 Block 34 — command — language: `bash`

```bash
./scripts/namespace_nat_test_snat.sh
```

### Lab 006 Block 35 — command — language: `bash`

```bash
./scripts/namespace_firewall_flush_rules.sh
```

### Lab 006 Block 36 — command — language: `bash`

```bash
./scripts/cleanup_namespace_client_router_server.sh
```

### Lab 006 Block 37 — command — language: `bash`

```bash
sudo apt update
sudo apt install nftables -y
```

### Lab 006 Block 38 — command — language: `bash`

```bash
./scripts/setup_namespace_client_router_server.sh
```

### Lab 006 Block 39 — command — language: `bash`

```bash
./scripts/start_namespace_http_server.sh
```

### Lab 006 Block 40 — command — language: `bash`

```bash
./scripts/namespace_firewall_show_rules.sh
```

### Lab 006 Block 41 — command — language: `bash`

```bash
sudo ip netns exec lab_server ss -ltnp | grep 8080
```

### Lab 006 Block 42 — config_or_output — language: `text`

```text
routing problem
service problem
firewall problem
NAT behavior
visibility problem
```

### Lab 006 Block 43 — config_or_output — language: `text`

```text
client
-> router namespace
-> nftables forward filtering
-> optional SNAT postrouting
-> server
-> packet capture
-> interpretation
```

## Lab 007 — Lab 007 — Traffic Shaping, Latency, Packet Loss and Bandwidth Limits

Source file: `labs/007_namespace_traffic_shaping_netem.md`

### Lab 007 Block 01 — command — language: `bash`

```bash
./scripts/setup_namespace_client_router_server.sh
```

### Lab 007 Block 02 — command — language: `bash`

```bash
./scripts/test_namespace_client_router_server.sh
```

### Lab 007 Block 03 — config_or_output — language: `text`

```text
lab_client 10.10.1.2/24
    |
lab_router 10.10.1.1/24 + 10.10.2.1/24
    |
lab_server 10.10.2.2/24
```

### Lab 007 Block 04 — config_or_output — language: `text`

```text
lab_client / veth_client
```

### Lab 007 Block 05 — config_or_output — language: `text`

```text
netem  -> latency, jitter, loss, corruption, reordering simulation
tbf    -> bandwidth limiting using token bucket filter
```

### Lab 007 Block 06 — command — language: `bash`

```bash
./scripts/namespace_tc_show_qdisc.sh
```

### Lab 007 Block 07 — config_or_output — language: `text`

```text
qdisc noqueue 0: dev lo root refcnt 2
qdisc noqueue 0: dev veth_client root refcnt 2
```

### Lab 007 Block 08 — config_or_output — language: `text`

```text
qdisc netem 8001: dev veth_client root refcnt 2 delay 200ms
```

### Lab 007 Block 09 — command — language: `bash`

```bash
./scripts/namespace_tc_test_ping_latency.sh
```

### Lab 007 Block 10 — config_or_output — language: `text`

```text
3 packets transmitted, 3 received, 0% packet loss
rtt min/avg/max/mdev = 0.050/0.080/0.120/0.030 ms
```

### Lab 007 Block 11 — command — language: `bash`

```bash
./scripts/namespace_tc_add_latency.sh
```

### Lab 007 Block 12 — command — language: `bash`

```bash
./scripts/namespace_tc_test_ping_latency.sh
```

### Lab 007 Block 13 — config_or_output — language: `text`

```text
64 bytes from 10.10.2.2: icmp_seq=1 ttl=63 time=400 ms
64 bytes from 10.10.2.2: icmp_seq=2 ttl=63 time=400 ms
```

### Lab 007 Block 14 — command — language: `bash`

```bash
./scripts/namespace_tc_clear.sh
```

### Lab 007 Block 15 — command — language: `bash`

```bash
./scripts/namespace_tc_add_packet_loss.sh
```

### Lab 007 Block 16 — command — language: `bash`

```bash
./scripts/namespace_tc_test_ping_latency.sh
```

### Lab 007 Block 17 — config_or_output — language: `text`

```text
10 packets transmitted, 7 received, 30% packet loss
```

### Lab 007 Block 18 — command — language: `bash`

```bash
./scripts/namespace_tc_clear.sh
./scripts/namespace_tc_add_latency_loss.sh
./scripts/namespace_tc_test_ping_latency.sh
```

### Lab 007 Block 19 — config_or_output — language: `text`

```text
Higher latency and visible packet loss
```

### Lab 007 Block 20 — command — language: `bash`

```bash
./scripts/namespace_tc_clear.sh
./scripts/namespace_tc_add_bandwidth_limit.sh
```

### Lab 007 Block 21 — command — language: `bash`

```bash
./scripts/start_namespace_http_server.sh
```

### Lab 007 Block 22 — command — language: `bash`

```bash
./scripts/namespace_tc_test_http_timing.sh
```

### Lab 007 Block 23 — config_or_output — language: `text`

```text
DNS lookup: 0.000000
Connect: 0.001234
Start transfer: 0.003210
Total: 0.015678
Speed download: 12345 bytes/s
HTTP code: 200
```

### Lab 007 Block 24 — command — language: `bash`

```bash
./scripts/namespace_tc_clear.sh
```

### Lab 007 Block 25 — command — language: `bash`

```bash
./scripts/namespace_tc_show_qdisc.sh
```

### Lab 007 Block 26 — command — language: `bash`

```bash
./scripts/cleanup_namespace_client_router_server.sh
```

### Lab 007 Block 27 — command — language: `bash`

```bash
sudo apt update
sudo apt install iproute2 -y
```

### Lab 007 Block 28 — command — language: `bash`

```bash
./scripts/setup_namespace_client_router_server.sh
```

### Lab 007 Block 29 — command — language: `bash`

```bash
./scripts/namespace_tc_clear.sh
```

### Lab 007 Block 30 — command — language: `bash`

```bash
./scripts/start_namespace_http_server.sh
```

### Lab 007 Block 31 — command — language: `bash`

```bash
./scripts/namespace_tc_test_http_timing.sh
```

### Lab 007 Block 32 — config_or_output — language: `text`

```text
namespace topology
-> qdisc on virtual interface
-> latency / packet loss / bandwidth limit
-> ping and curl measurements
-> interpretation
-> cleanup
```

## Lab 008 — Lab 008 — Local JSON API, Structured Logs and Mini Detector

Source file: `labs/008_local_json_api_structured_logs_detector.md`

### Lab 008 Block 01 — config_or_output — language: `text`

```text
127.0.0.1:8300
```

### Lab 008 Block 02 — config_or_output — language: `text`

```text
local API
-> HTTP requests
-> structured JSONL logs
-> analysis script
-> detector rule
-> report
```

### Lab 008 Block 03 — config_or_output — language: `text`

```text
timestamp
client_ip
method
path
status
user_agent
event_type
```

### Lab 008 Block 04 — config_or_output — language: `text`

```text
many 404 responses
many 401 responses
many requests to unknown paths
repeated access to protected endpoints without a valid token
```

### Lab 008 Block 05 — config_or_output — language: `text`

```text
GET /status
GET /health
GET /metrics
GET /protected
GET /logs-path
GET /anything-else
```

### Lab 008 Block 06 — config_or_output — language: `text`

```text
/status     -> 200 OK
/health     -> 200 OK
/metrics    -> 200 OK
/protected  -> 401 without token, 200 with token
unknown     -> 404
```

### Lab 008 Block 07 — config_or_output — language: `text`

```text
microbot-lab-token
```

### Lab 008 Block 08 — config_or_output — language: `text`

```text
X-Lab-Token: microbot-lab-token
```

### Lab 008 Block 09 — command — language: `bash`

```bash
python3 scripts/local_json_api_server_8300.py
```

### Lab 008 Block 10 — config_or_output — language: `text`

```text
[API] Local JSON API listening on http://127.0.0.1:8300
[API] Logs: /Users/antonmorosi/linux_lab/json_api_mini_soc/logs/api_events.jsonl
```

### Lab 008 Block 11 — config_or_output — language: `text`

```text
CTRL + C
```

### Lab 008 Block 12 — command — language: `bash`

```bash
curl http://127.0.0.1:8300/status
curl http://127.0.0.1:8300/health
curl http://127.0.0.1:8300/metrics
```

### Lab 008 Block 13 — config_or_output — language: `json`

```json
{
  "service": "local_json_api_lab",
  "status": "ok",
  "endpoint": "/status"
}
```

### Lab 008 Block 14 — command — language: `bash`

```bash
curl -i http://127.0.0.1:8300/protected
```

### Lab 008 Block 15 — config_or_output — language: `text`

```text
HTTP/1.0 401 Unauthorized
```

### Lab 008 Block 16 — config_or_output — language: `json`

```json
{
  "error": "unauthorized",
  "message": "missing or invalid X-Lab-Token"
}
```

### Lab 008 Block 17 — command — language: `bash`

```bash
curl -i -H "X-Lab-Token: microbot-lab-token" http://127.0.0.1:8300/protected
```

### Lab 008 Block 18 — config_or_output — language: `text`

```text
HTTP/1.0 200 OK
```

### Lab 008 Block 19 — config_or_output — language: `json`

```json
{
  "service": "local_json_api_lab",
  "status": "authorized",
  "endpoint": "/protected"
}
```

### Lab 008 Block 20 — command — language: `bash`

```bash
./scripts/generate_api_lab_traffic.sh
```

### Lab 008 Block 21 — config_or_output — language: `text`

```text
[OK] Controlled API traffic generated.
```

### Lab 008 Block 22 — config_or_output — language: `text`

```text
~/linux_lab/json_api_mini_soc/logs/api_events.jsonl
```

### Lab 008 Block 23 — command — language: `bash`

```bash
tail -20 ~/linux_lab/json_api_mini_soc/logs/api_events.jsonl
```

### Lab 008 Block 24 — config_or_output — language: `json`

```json
{"timestamp": 1779100000.123, "client_ip": "127.0.0.1", "method": "GET", "path": "/status", "status": 200, "event_type": "normal"}
{"timestamp": 1779100001.456, "client_ip": "127.0.0.1", "method": "GET", "path": "/protected", "status": 401, "event_type": "auth_failure"}
{"timestamp": 1779100002.789, "client_ip": "127.0.0.1", "method": "GET", "path": "/not_found_1", "status": 404, "event_type": "not_found"}
```

### Lab 008 Block 25 — command — language: `bash`

```bash
./scripts/analyze_api_json_logs.sh
```

### Lab 008 Block 26 — config_or_output — language: `text`

```text
Total events: 55
HTTP 200: 35
HTTP 401: 10
HTTP 404: 10
Finding: elevated number of 401 or 404 events
Severity: MEDIUM
```

### Lab 008 Block 27 — command — language: `bash`

```bash
./scripts/create_api_security_report.sh
```

### Lab 008 Block 28 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/json_api_mini_soc/reports/api_security_report_YYYYMMDD_HHMMSS.txt
```

### Lab 008 Block 29 — config_or_output — language: `text`

```text
if 404 >= 10 -> MEDIUM finding
if 401 >= 5  -> MEDIUM finding
if both are elevated -> HIGH finding
otherwise -> LOW / OK
```

### Lab 008 Block 30 — command — language: `bash`

```bash
lsof -i :8300 -P -n
```

### Lab 008 Block 31 — command — language: `bash`

```bash
python3 scripts/local_json_api_server_8300.py
```

### Lab 008 Block 32 — command — language: `bash`

```bash
./scripts/generate_api_lab_traffic.sh
```

### Lab 008 Block 33 — command — language: `bash`

```bash
cat ~/linux_lab/json_api_mini_soc/logs/api_events.jsonl | jq .
```

### Lab 008 Block 34 — config_or_output — language: `text`

```text
collect events
normalize events
count status codes
identify anomalies
write a report
```

### Lab 008 Block 35 — config_or_output — language: `text`

```text
Python JSON API
-> curl traffic
-> JSONL event logs
-> detector script
-> security report
```

## Lab 009 — Lab 009 — Local API Security Controls

Source file: `labs/009_local_api_security_controls.md`

### Lab 009 Block 01 — config_or_output — language: `text`

```text
127.0.0.1:8400
```

### Lab 009 Block 02 — config_or_output — language: `text`

```text
authentication
authorization
rate limiting
input validation
logging
error handling
security headers
```

### Lab 009 Block 03 — config_or_output — language: `text`

```text
API token:   microbot-api-token
Admin token: microbot-admin-token
```

### Lab 009 Block 04 — config_or_output — language: `text`

```text
X-API-Key: microbot-api-token
```

### Lab 009 Block 05 — config_or_output — language: `text`

```text
X-Admin-Key: microbot-admin-token
```

### Lab 009 Block 06 — config_or_output — language: `text`

```text
GET  /public/status
GET  /public/health
GET  /api/telemetry?node_id=node-001
POST /api/command
GET  /admin/config
GET  /metrics
```

### Lab 009 Block 07 — config_or_output — language: `text`

```text
/public/status                  -> 200 without token
/public/health                  -> 200 without token
/api/telemetry without token     -> 401
/api/telemetry with token        -> 200
/api/telemetry invalid node_id   -> 400
/api/command without token       -> 401
/api/command invalid JSON        -> 400
/api/command valid token/body    -> 202
/admin/config without admin key  -> 403
/admin/config with admin key     -> 200
too many requests                -> 429
unknown endpoint                 -> 404
unsupported method               -> 405
```

### Lab 009 Block 08 — command — language: `bash`

```bash
python3 scripts/secure_api_server_8400.py
```

### Lab 009 Block 09 — config_or_output — language: `text`

```text
[SECURE-API] Listening on http://127.0.0.1:8400
[SECURE-API] Logs: ~/linux_lab/api_security_controls/logs/security_events.jsonl
```

### Lab 009 Block 10 — config_or_output — language: `text`

```text
CTRL + C
```

### Lab 009 Block 11 — command — language: `bash`

```bash
curl http://127.0.0.1:8400/public/status
```

### Lab 009 Block 12 — config_or_output — language: `json`

```json
{
  "service": "secure_api_lab",
  "status": "ok",
  "public": true
}
```

### Lab 009 Block 13 — command — language: `bash`

```bash
curl -i "http://127.0.0.1:8400/api/telemetry?node_id=node-001"
```

### Lab 009 Block 14 — config_or_output — language: `text`

```text
HTTP/1.0 401 Unauthorized
```

### Lab 009 Block 15 — command — language: `bash`

```bash
curl -i -H "X-API-Key: microbot-api-token" "http://127.0.0.1:8400/api/telemetry?node_id=node-001"
```

### Lab 009 Block 16 — config_or_output — language: `text`

```text
HTTP/1.0 200 OK
```

### Lab 009 Block 17 — config_or_output — language: `json`

```json
{
  "node_id": "node-001",
  "battery": 87,
  "temperature_c": 31.5,
  "status": "nominal"
}
```

### Lab 009 Block 18 — command — language: `bash`

```bash
curl -i -H "X-API-Key: microbot-api-token" "http://127.0.0.1:8400/api/telemetry?node_id=../../etc/passwd"
```

### Lab 009 Block 19 — config_or_output — language: `text`

```text
HTTP/1.0 400 Bad Request
```

### Lab 009 Block 20 — command — language: `bash`

```bash
curl -i \
  -H "X-API-Key: microbot-api-token" \
  -H "Content-Type: application/json" \
  -d '{"node_id":"node-001","command":"heartbeat"}' \
  http://127.0.0.1:8400/api/command
```

### Lab 009 Block 21 — config_or_output — language: `text`

```text
HTTP/1.0 202 Accepted
```

### Lab 009 Block 22 — command — language: `bash`

```bash
curl -i \
  -H "X-API-Key: microbot-api-token" \
  -H "Content-Type: application/json" \
  -d '{"node_id":"node-001","command":"delete_everything"}' \
  http://127.0.0.1:8400/api/command
```

### Lab 009 Block 23 — config_or_output — language: `text`

```text
HTTP/1.0 400 Bad Request
```

### Lab 009 Block 24 — command — language: `bash`

```bash
curl -i http://127.0.0.1:8400/admin/config
```

### Lab 009 Block 25 — config_or_output — language: `text`

```text
HTTP/1.0 403 Forbidden
```

### Lab 009 Block 26 — command — language: `bash`

```bash
curl -i -H "X-Admin-Key: microbot-admin-token" http://127.0.0.1:8400/admin/config
```

### Lab 009 Block 27 — config_or_output — language: `text`

```text
HTTP/1.0 200 OK
```

### Lab 009 Block 28 — command — language: `bash`

```bash
./scripts/generate_api_security_traffic.sh
```

### Lab 009 Block 29 — command — language: `bash`

```bash
./scripts/analyze_api_security_logs.sh
```

### Lab 009 Block 30 — config_or_output — language: `text`

```text
Total events: 80
auth_failure: 10
forbidden: 5
validation_error: 8
rate_limited: 12
not_found: 6
Severity: HIGH
```

### Lab 009 Block 31 — command — language: `bash`

```bash
./scripts/create_api_security_controls_report.sh
```

### Lab 009 Block 32 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/api_security_controls/reports/api_security_controls_report_YYYYMMDD_HHMMSS.txt
```

### Lab 009 Block 33 — config_or_output — language: `text`

```text
401 -> authentication failure
403 -> authorization failure
400 -> validation failure
404 -> unknown path
405 -> unsupported method
429 -> rate limit exceeded
```

### Lab 009 Block 34 — command — language: `bash`

```bash
lsof -i :8400 -P -n
```

### Lab 009 Block 35 — command — language: `bash`

```bash
python3 scripts/secure_api_server_8400.py
```

### Lab 009 Block 36 — command — language: `bash`

```bash
./scripts/generate_api_security_traffic.sh
```

### Lab 009 Block 37 — config_or_output — language: `text`

```text
secure local API
-> authentication and validation controls
-> controlled traffic
-> structured security logs
-> detector
-> report
```

## Lab 010 — Lab 010 — Docker Bridge Network and Container Diagnostics

Source file: `labs/010_docker_bridge_network_container_diagnostics.md`

### Lab 010 Block 01 — config_or_output — language: `text`

```text
image:   linux-sec-lab010-api
network: lab010_bridge_net
server:  lab010_api_server
client:  lab010_api_client
```

### Lab 010 Block 02 — config_or_output — language: `text`

```text
0.0.0.0:8500
```

### Lab 010 Block 03 — config_or_output — language: `text`

```text
127.0.0.1:8500
```

### Lab 010 Block 04 — config_or_output — language: `text`

```text
image
-> container
-> network
-> port mapping
-> logs
-> inspect
-> cleanup
```

### Lab 010 Block 05 — config_or_output — language: `text`

```text
Host machine
  |
  | localhost port mapping
  v
127.0.0.1:8500 -> lab010_api_server:8500

Docker bridge network: lab010_bridge_net

lab010_api_client ---> http://lab010_api_server:8500/status
```

### Lab 010 Block 06 — config_or_output — language: `text`

```text
lab010_api_server
```

### Lab 010 Block 07 — command — language: `bash`

```bash
./scripts/docker_lab010_check_requirements.sh
```

### Lab 010 Block 08 — config_or_output — language: `text`

```text
[OK] docker command found
[OK] Docker daemon is reachable
```

### Lab 010 Block 09 — command — language: `bash`

```bash
./scripts/docker_lab010_build_image.sh
```

### Lab 010 Block 10 — config_or_output — language: `text`

```text
[OK] Docker image built: linux-sec-lab010-api
```

### Lab 010 Block 11 — command — language: `bash`

```bash
./scripts/docker_lab010_create_network.sh
```

### Lab 010 Block 12 — config_or_output — language: `text`

```text
[OK] Network ready: lab010_bridge_net
```

### Lab 010 Block 13 — command — language: `bash`

```bash
./scripts/docker_lab010_run_server.sh
```

### Lab 010 Block 14 — config_or_output — language: `text`

```text
[OK] Server container running: lab010_api_server
[INFO] Host URL: http://127.0.0.1:8500/status
```

### Lab 010 Block 15 — command — language: `bash`

```bash
./scripts/docker_lab010_test_from_host.sh
```

### Lab 010 Block 16 — config_or_output — language: `json`

```json
{
  "service": "docker_lab010_api",
  "status": "ok",
  "context": "container",
  "port": 8500
}
```

### Lab 010 Block 17 — command — language: `bash`

```bash
./scripts/docker_lab010_test_from_container.sh
```

### Lab 010 Block 18 — config_or_output — language: `text`

```text
[CLIENT] Testing container DNS name: lab010_api_server
[CLIENT] HTTP status: 200
[CLIENT] Response body:
{
  "service": "docker_lab010_api",
  "status": "ok",
  "context": "container",
  "port": 8500
}
```

### Lab 010 Block 19 — command — language: `bash`

```bash
./scripts/docker_lab010_inspect.sh
```

### Lab 010 Block 20 — command — language: `bash`

```bash
./scripts/docker_lab010_logs.sh
```

### Lab 010 Block 21 — config_or_output — language: `text`

```text
[API] Docker Lab 010 server listening on 0.0.0.0:8500
```

### Lab 010 Block 22 — command — language: `bash`

```bash
./scripts/docker_lab010_cleanup.sh
```

### Lab 010 Block 23 — config_or_output — language: `text`

```text
[OK] Removed container: lab010_api_server
[OK] Removed network: lab010_bridge_net
```

### Lab 010 Block 24 — command — language: `bash`

```bash
docker build -t linux-sec-lab010-api docker/lab010
```

### Lab 010 Block 25 — command — language: `bash`

```bash
docker network create lab010_bridge_net
```

### Lab 010 Block 26 — command — language: `bash`

```bash
docker run -d \
  --name lab010_api_server \
  --network lab010_bridge_net \
  -p 127.0.0.1:8500:8500 \
  linux-sec-lab010-api
```

### Lab 010 Block 27 — command — language: `bash`

```bash
curl http://127.0.0.1:8500/status
```

### Lab 010 Block 28 — command — language: `bash`

```bash
docker run --rm \
  --name lab010_api_client \
  --network lab010_bridge_net \
  linux-sec-lab010-api \
  python3 /app/client_check.py http://lab010_api_server:8500/status
```

### Lab 010 Block 29 — command — language: `bash`

```bash
docker network inspect lab010_bridge_net
```

### Lab 010 Block 30 — command — language: `bash`

```bash
docker logs lab010_api_server
```

### Lab 010 Block 31 — command — language: `bash`

```bash
docker rm -f lab010_api_server
docker network rm lab010_bridge_net
```

### Lab 010 Block 32 — command — language: `bash`

```bash
systemctl status docker
```

### Lab 010 Block 33 — command — language: `bash`

```bash
lsof -i :8500 -P -n
```

### Lab 010 Block 34 — command — language: `bash`

```bash
./scripts/docker_lab010_cleanup.sh
```

### Lab 010 Block 35 — config_or_output — language: `text`

```text
service isolation
port exposure
container DNS
bridge networks
logs
inspect output
cleanup
local service diagnostics
```

### Lab 010 Block 36 — config_or_output — language: `text`

```text
Dockerfile
-> image
-> bridge network
-> server container
-> host port mapping
-> client container test
-> logs and inspect
-> cleanup
```

## Lab 011 — Lab 011 — Docker Compose API, Reverse Proxy and Local Logs

Source file: `labs/011_docker_compose_reverse_proxy_logs.md`

### Lab 011 Block 01 — config_or_output — language: `text`

```text
reverse_proxy -> api
```

### Lab 011 Block 02 — config_or_output — language: `text`

```text
127.0.0.1:8600
```

### Lab 011 Block 03 — command — language: `text`

```text
docker build
docker network create
docker run
docker inspect
docker logs
```

### Lab 011 Block 04 — config_or_output — language: `text`

```text
compose.yaml
-> api service
-> reverse proxy service
-> dedicated network
-> one command up/down
```

### Lab 011 Block 05 — config_or_output — language: `text`

```text
Host
  |
  | http://127.0.0.1:8600
  v
reverse_proxy container
  |
  | http://api:8601
  v
api container
```

### Lab 011 Block 06 — config_or_output — language: `text`

```text
api
```

### Lab 011 Block 07 — config_or_output — language: `text`

```text
docker/lab011/
  compose.yaml
  api/
    Dockerfile
    api_server.py
  nginx/
    nginx.conf
```

### Lab 011 Block 08 — command — language: `bash`

```bash
./scripts/compose_lab011_check_requirements.sh
```

### Lab 011 Block 09 — config_or_output — language: `text`

```text
[OK] docker command found
[OK] Docker daemon is reachable
[OK] docker compose is available
```

### Lab 011 Block 10 — command — language: `bash`

```bash
./scripts/compose_lab011_up.sh
```

### Lab 011 Block 11 — config_or_output — language: `text`

```text
[OK] Compose stack is running.
[INFO] Proxy URL: http://127.0.0.1:8600/status
```

### Lab 011 Block 12 — command — language: `bash`

```bash
./scripts/compose_lab011_test.sh
```

### Lab 011 Block 13 — config_or_output — language: `json`

```json
{
  "service": "compose_lab011_api",
  "status": "ok",
  "served_by": "api",
  "port": 8601
}
```

### Lab 011 Block 14 — config_or_output — language: `text`

```text
/status
/health
/headers
/proxy-status
/unknown
```

### Lab 011 Block 15 — command — language: `bash`

```bash
./scripts/compose_lab011_inspect.sh
```

### Lab 011 Block 16 — command — language: `bash`

```bash
./scripts/compose_lab011_logs.sh
```

### Lab 011 Block 17 — config_or_output — language: `text`

```text
api
reverse_proxy
```

### Lab 011 Block 18 — command — language: `bash`

```bash
./scripts/compose_lab011_down.sh
```

### Lab 011 Block 19 — config_or_output — language: `text`

```text
[OK] Compose stack stopped and removed.
```

### Lab 011 Block 20 — command — language: `bash`

```bash
docker compose -f docker/lab011/compose.yaml up -d --build
```

### Lab 011 Block 21 — command — language: `bash`

```bash
curl http://127.0.0.1:8600/status
curl http://127.0.0.1:8600/health
curl http://127.0.0.1:8600/headers
```

### Lab 011 Block 22 — command — language: `bash`

```bash
docker compose -f docker/lab011/compose.yaml logs
```

### Lab 011 Block 23 — command — language: `bash`

```bash
docker compose -f docker/lab011/compose.yaml ps
docker network ls | grep lab011
docker inspect lab011_reverse_proxy
docker inspect lab011_api
```

### Lab 011 Block 24 — command — language: `bash`

```bash
docker compose -f docker/lab011/compose.yaml down
```

### Lab 011 Block 25 — config_or_output — language: `text`

```text
127.0.0.1:8600 -> reverse_proxy:8600
```

### Lab 011 Block 26 — config_or_output — language: `text`

```text
http://api:8601
```

### Lab 011 Block 27 — config_or_output — language: `text`

```text
X-Forwarded-For
X-Forwarded-Proto
X-Proxy-Lab
```

### Lab 011 Block 28 — command — language: `bash`

```bash
lsof -i :8600 -P -n
```

### Lab 011 Block 29 — command — language: `bash`

```bash
docker compose -f docker/lab011/compose.yaml logs api
```

### Lab 011 Block 30 — command — language: `bash`

```bash
docker compose version
```

### Lab 011 Block 31 — config_or_output — language: `text`

```text
Docker Compose
-> API container
-> Nginx reverse proxy
-> local-only port publishing
-> host tests
-> logs
-> inspect
-> cleanup
```

## Lab 012 — Lab 012 — Prometheus-style Metrics and Local Monitoring

Source file: `labs/012_prometheus_metrics_local_monitoring.md`

### Lab 012 Block 01 — config_or_output — language: `text`

```text
API:        http://127.0.0.1:8701
Prometheus: http://127.0.0.1:9090
```

### Lab 012 Block 02 — config_or_output — language: `text`

```text
Host
  |
  | http://127.0.0.1:8701/status
  | http://127.0.0.1:8701/metrics
  v
metrics_api container
  |
  | scraped by Prometheus over Docker Compose network
  v
prometheus container
  |
  | http://127.0.0.1:9090
  v
Prometheus UI and HTTP API
```

### Lab 012 Block 03 — config_or_output — language: `text`

```text
lab012_requests_total
lab012_status_requests_total
lab012_health_requests_total
lab012_metrics_requests_total
lab012_error_requests_total
lab012_not_found_requests_total
lab012_uptime_seconds
lab012_last_request_timestamp_seconds
lab012_build_info
```

### Lab 012 Block 04 — config_or_output — language: `text`

```text
# HELP lab012_requests_total Total number of HTTP requests handled by the API.
# TYPE lab012_requests_total counter
lab012_requests_total 42
```

### Lab 012 Block 05 — command — language: `bash`

```bash
./scripts/monitoring_lab012_check_requirements.sh
```

### Lab 012 Block 06 — config_or_output — language: `text`

```text
[OK] docker command found
[OK] Docker daemon is reachable
[OK] docker compose is available
```

### Lab 012 Block 07 — command — language: `bash`

```bash
./scripts/monitoring_lab012_up.sh
```

### Lab 012 Block 08 — config_or_output — language: `text`

```text
[OK] Monitoring stack is running.
[INFO] API URL: http://127.0.0.1:8701/status
[INFO] Metrics URL: http://127.0.0.1:8701/metrics
[INFO] Prometheus URL: http://127.0.0.1:9090
```

### Lab 012 Block 09 — command — language: `bash`

```bash
./scripts/monitoring_lab012_test_api.sh
```

### Lab 012 Block 10 — command — language: `bash`

```bash
./scripts/monitoring_lab012_generate_traffic.sh
```

### Lab 012 Block 11 — command — language: `bash`

```bash
./scripts/monitoring_lab012_query_prometheus.sh
```

### Lab 012 Block 12 — config_or_output — language: `text`

```text
up
lab012_requests_total
lab012_status_requests_total
lab012_error_requests_total
lab012_not_found_requests_total
lab012_uptime_seconds
rate(lab012_requests_total[1m])
```

### Lab 012 Block 13 — config_or_output — language: `text`

```text
http://127.0.0.1:9090
```

### Lab 012 Block 14 — config_or_output — language: `text`

```text
up
lab012_requests_total
lab012_error_requests_total
rate(lab012_requests_total[1m])
```

### Lab 012 Block 15 — config_or_output — language: `text`

```text
http://127.0.0.1:9090/targets
```

### Lab 012 Block 16 — command — language: `bash`

```bash
./scripts/monitoring_lab012_inspect.sh
./scripts/monitoring_lab012_logs.sh
```

### Lab 012 Block 17 — command — language: `bash`

```bash
./scripts/monitoring_lab012_down.sh
```

### Lab 012 Block 18 — command — language: `bash`

```bash
docker compose -f docker/lab012/compose.yaml up -d --build
curl http://127.0.0.1:8701/status
curl http://127.0.0.1:8701/metrics
curl --get "http://127.0.0.1:9090/api/v1/query" --data-urlencode "query=lab012_requests_total"
docker compose -f docker/lab012/compose.yaml logs
docker compose -f docker/lab012/compose.yaml down
```

### Lab 012 Block 19 — config_or_output — language: `text`

```text
API service
-> /metrics endpoint
-> Prometheus scrape
-> query API
-> interpretation
-> logs and inspect
-> cleanup
```

## Lab 013 — Lab 013 — GitHub Actions CI and Local Validation

Source file: `labs/013_github_actions_ci_local_validation.md`

### Lab 013 Block 01 — config_or_output — language: `text`

```text
.github/workflows/ci.yml
scripts/ci_local_validate.sh
scripts/ci_check_repository_structure.sh
scripts/ci_check_bash_syntax.sh
scripts/ci_check_python_syntax.sh
scripts/ci_check_compose_files.sh
```

### Lab 013 Block 02 — command — language: `bash`

```bash
./scripts/ci_local_validate.sh
```

### Lab 013 Block 03 — config_or_output — language: `text`

```text
[OK] Repository structure check passed.
[OK] Bash syntax check passed.
[OK] Python syntax check passed.
[OK] Docker Compose config check completed.
[OK] Local CI validation completed.
```

### Lab 013 Block 04 — config_or_output — language: `text`

```text
.github/workflows/ci.yml
```

### Lab 013 Block 05 — config_or_output — language: `text`

```text
repository-validation
bash-syntax
python-syntax
docker-compose-config
```

### Lab 013 Block 06 — command — language: `bash`

```bash
./scripts/ci_check_repository_structure.sh
```

### Lab 013 Block 07 — command — language: `bash`

```bash
./scripts/ci_check_bash_syntax.sh
```

### Lab 013 Block 08 — command — language: `bash`

```bash
./scripts/ci_check_python_syntax.sh
```

### Lab 013 Block 09 — command — language: `bash`

```bash
./scripts/ci_check_compose_files.sh
```

### Lab 013 Block 10 — command — language: `bash`

```bash
./scripts/ci_local_validate.sh
```

### Lab 013 Block 11 — config_or_output — language: `text`

```text
local validation scripts
-> GitHub Actions workflow
-> automatic checks on push
-> cleaner repository state
-> stronger portfolio proof-of-work
```

## Lab 014 — Lab 014 — Threat Modeling and Hardening Checklist

Source file: `labs/014_threat_modeling_hardening_checklist.md`

### Lab 014 Block 01 — config_or_output — language: `text`

```text
security/ASSET_INVENTORY.md
security/TRUST_BOUNDARIES.md
security/THREAT_MODEL.md
security/HARDENING_CHECKLIST.md
security/RISK_REGISTER.md
scripts/security_check_local_exposure.sh
scripts/security_generate_threat_model_report.sh
```

### Lab 014 Block 02 — config_or_output — language: `text`

```text
security/ASSET_INVENTORY.md
```

### Lab 014 Block 03 — config_or_output — language: `text`

```text
security/TRUST_BOUNDARIES.md
```

### Lab 014 Block 04 — config_or_output — language: `text`

```text
security/THREAT_MODEL.md
```

### Lab 014 Block 05 — config_or_output — language: `text`

```text
security/HARDENING_CHECKLIST.md
```

### Lab 014 Block 06 — config_or_output — language: `text`

```text
security/RISK_REGISTER.md
```

### Lab 014 Block 07 — command — language: `bash`

```bash
./scripts/security_check_local_exposure.sh
```

### Lab 014 Block 08 — command — language: `bash`

```bash
./scripts/security_generate_threat_model_report.sh
```

### Lab 014 Block 09 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/threat_model_report_YYYYMMDD_HHMMSS.txt
```

### Lab 014 Block 10 — config_or_output — language: `text`

```text
asset inventory
-> trust boundaries
-> threat model
-> hardening checklist
-> local exposure check
-> risk register
-> final report
```

## Lab 015 — Lab 015 — Final Capstone Secure Local Service

Source file: `labs/015_final_capstone_secure_local_service.md`

### Lab 015 Block 01 — config_or_output — language: `text`

```text
127.0.0.1:8800
```

### Lab 015 Block 02 — config_or_output — language: `text`

```text
127.0.0.1:9095
```

### Lab 015 Block 03 — config_or_output — language: `text`

```text
Host
  |
  | http://127.0.0.1:8800
  v
Nginx reverse proxy
  |
  | http://api:8801
  v
Capstone API container
  |
  | /metrics scraped by
  v
Prometheus container

Prometheus UI:
http://127.0.0.1:9095
```

### Lab 015 Block 04 — config_or_output — language: `text`

```text
api
reverse_proxy
prometheus
```

### Lab 015 Block 05 — config_or_output — language: `text`

```text
GET  http://127.0.0.1:8800/status
GET  http://127.0.0.1:8800/health
GET  http://127.0.0.1:8800/metrics
GET  http://127.0.0.1:8800/protected
GET  http://127.0.0.1:8800/events
POST http://127.0.0.1:8800/command
```

### Lab 015 Block 06 — config_or_output — language: `text`

```text
http://127.0.0.1:9095
```

### Lab 015 Block 07 — config_or_output — language: `text`

```text
X-API-Key: capstone-local-token
```

### Lab 015 Block 08 — command — language: `bash`

```bash
./scripts/capstone_lab015_check_requirements.sh
```

### Lab 015 Block 09 — config_or_output — language: `text`

```text
[OK] docker command found
[OK] Docker daemon is reachable
[OK] docker compose is available
```

### Lab 015 Block 10 — command — language: `bash`

```bash
./scripts/capstone_lab015_up.sh
```

### Lab 015 Block 11 — config_or_output — language: `text`

```text
[OK] Capstone stack is running.
[INFO] Proxy URL: http://127.0.0.1:8800/status
[INFO] Prometheus URL: http://127.0.0.1:9095
```

### Lab 015 Block 12 — command — language: `bash`

```bash
./scripts/capstone_lab015_test.sh
```

### Lab 015 Block 13 — config_or_output — language: `text`

```text
/status
/health
/protected without token
/protected with token
/command with valid token
/metrics
/unknown
```

### Lab 015 Block 14 — config_or_output — language: `text`

```text
/status -> 200
/health -> 200
/protected without token -> 401
/protected with token -> 200
/command valid -> 202
/metrics -> Prometheus text format
/unknown -> 404
```

### Lab 015 Block 15 — command — language: `bash`

```bash
./scripts/capstone_lab015_generate_traffic.sh
```

### Lab 015 Block 16 — config_or_output — language: `text`

```text
normal requests
authorized protected requests
unauthorized requests
valid command requests
unknown path requests
metrics requests
```

### Lab 015 Block 17 — command — language: `bash`

```bash
./scripts/capstone_lab015_query_metrics.sh
```

### Lab 015 Block 18 — config_or_output — language: `text`

```text
up
capstone_requests_total
capstone_auth_failures_total
capstone_commands_total
capstone_not_found_total
capstone_uptime_seconds
```

### Lab 015 Block 19 — command — language: `bash`

```bash
./scripts/capstone_lab015_inspect.sh
```

### Lab 015 Block 20 — config_or_output — language: `text`

```text
Compose services
running containers
published ports
network state
container summaries
Prometheus configuration
```

### Lab 015 Block 21 — command — language: `bash`

```bash
./scripts/capstone_lab015_logs.sh
```

### Lab 015 Block 22 — config_or_output — language: `text`

```text
api
reverse_proxy
prometheus
```

### Lab 015 Block 23 — command — language: `bash`

```bash
./scripts/capstone_lab015_create_report.sh
```

### Lab 015 Block 24 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/capstone_lab015_report_YYYYMMDD_HHMMSS.txt
```

### Lab 015 Block 25 — config_or_output — language: `text`

```text
system identity
Git state
Compose state
endpoint test output
Prometheus query output
recent logs
security interpretation
recommended next actions
```

### Lab 015 Block 26 — command — language: `bash`

```bash
./scripts/capstone_lab015_down.sh
```

### Lab 015 Block 27 — config_or_output — language: `text`

```text
[OK] Capstone stack stopped and removed.
```

### Lab 015 Block 28 — config_or_output — language: `text`

```text
client -> reverse proxy -> API -> metrics -> Prometheus -> report
```

### Lab 015 Block 29 — config_or_output — language: `text`

```text
localhost-only publishing
API not directly exposed
API key for protected endpoints
structured logs
metrics endpoint
Prometheus scraping
controlled report generation
cleanup scripts
CI already present in repository
threat model already present in repository
```

### Lab 015 Block 30 — command — language: `bash`

```bash
lsof -i :8800 -P -n
```

### Lab 015 Block 31 — command — language: `bash`

```bash
lsof -i :9095 -P -n
```

### Lab 015 Block 32 — config_or_output — language: `text`

```text
http://127.0.0.1:9095/targets
```

### Lab 015 Block 33 — config_or_output — language: `text`

```text
api:8801
```

### Lab 015 Block 34 — command — language: `bash`

```bash
./scripts/capstone_lab015_logs.sh
```

### Lab 015 Block 35 — config_or_output — language: `text`

```text
Linux diagnostics
network diagnostics
local services
ports and logs
DNS and routing
network namespaces
firewall and NAT
traffic shaping
local APIs
API security
Docker networking
Docker Compose
Prometheus metrics
CI validation
threat modeling
final secure service capstone
```

## Lab 016 — Lab 016 — Release Engineering, Repository Audit and Publication Readiness

Source file: `labs/016_release_engineering_repository_audit.md`

### Lab 016 Block 01 — config_or_output — language: `text`

```text
clear version
clear status
clear changelog
clear roadmap
clear safety boundaries
clear evidence
clear next steps
```

### Lab 016 Block 02 — config_or_output — language: `text`

```text
VERSION
CHANGELOG.md
RELEASE_NOTES_v0.1.0.md
docs/CURRENT_STATUS.md
docs/ROADMAP.md
docs/PORTFOLIO_SUMMARY.md
docs/REPOSITORY_AUDIT.md
docs/PUBLICATION_CHECKLIST.md
.github/ISSUE_TEMPLATE/
scripts/release_lab016_check_publication_readiness.sh
scripts/release_lab016_generate_repository_summary.sh
scripts/release_lab016_create_release_report.sh
```

### Lab 016 Block 03 — config_or_output — language: `text`

```text
docs/CURRENT_STATUS.md
```

### Lab 016 Block 04 — config_or_output — language: `text`

```text
CHANGELOG.md
```

### Lab 016 Block 05 — config_or_output — language: `text`

```text
RELEASE_NOTES_v0.1.0.md
```

### Lab 016 Block 06 — config_or_output — language: `text`

```text
docs/ROADMAP.md
```

### Lab 016 Block 07 — command — language: `bash`

```bash
./scripts/release_lab016_check_publication_readiness.sh
```

### Lab 016 Block 08 — config_or_output — language: `text`

```text
[OK] File exists: README.md
[OK] File exists: CHANGELOG.md
[OK] File exists: VERSION
[OK] File exists: .github/workflows/ci.yml
[OK] Directory exists: labs
[OK] Lab count is 16 or higher
```

### Lab 016 Block 09 — command — language: `bash`

```bash
./scripts/release_lab016_generate_repository_summary.sh
```

### Lab 016 Block 10 — config_or_output — language: `text`

```text
repository name
current branch
Git status
lab count
script count
documentation count
Docker lab count
security document count
CI workflow status
```

### Lab 016 Block 11 — command — language: `bash`

```bash
./scripts/release_lab016_create_release_report.sh
```

### Lab 016 Block 12 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/release_readiness_report_YYYYMMDD_HHMMSS.txt
```

### Lab 016 Block 13 — command — language: `bash`

```bash
git tag -a v0.1.0 -m "Linux Network Security Lab v0.1.0"
git push origin v0.1.0
```

### Lab 016 Block 14 — config_or_output — language: `text`

```text
README is clear
labs are indexed
safe-use policy exists
threat model exists
hardening checklist exists
CI exists
release notes exist
changelog exists
current status exists
roadmap exists
local validation passes
no secrets are present
generated reports are reviewed before commit
```

### Lab 016 Block 15 — command — language: `bash`

```bash
./scripts/ci_local_validate.sh
```

### Lab 016 Block 16 — config_or_output — language: `text`

```text
what is included
what is not included
what has been checked
what remains future work
what evidence exists
what safety boundaries apply
```

### Lab 016 Block 17 — config_or_output — language: `text`

```text
15 technical labs
1 release engineering lab
CI validation
threat model
hardening checklist
capstone stack
publication checklist
portfolio summary
release notes
roadmap
```

## Lab 017 — Lab 017 — Grafana Dashboard and Prometheus Alert Rules

Source file: `labs/017_grafana_dashboard_prometheus_alerts.md`

### Lab 017 Block 01 — config_or_output — language: `text`

```text
Observable API: http://127.0.0.1:8901
Prometheus:     http://127.0.0.1:9096
Grafana:        http://127.0.0.1:3001
```

### Lab 017 Block 02 — config_or_output — language: `text`

```text
Host
  |
  | http://127.0.0.1:8901
  v
observable_api container
  |
  | /metrics scraped by Prometheus
  v
prometheus container
  |
  | datasource for Grafana
  v
grafana container
```

### Lab 017 Block 03 — config_or_output — language: `text`

```text
observable_api
prometheus
grafana
```

### Lab 017 Block 04 — config_or_output — language: `text`

```text
username: admin
password: admin
```

### Lab 017 Block 05 — config_or_output — language: `text`

```text
lab017_requests_total
lab017_status_requests_total
lab017_error_requests_total
lab017_not_found_total
lab017_uptime_seconds
lab017_build_info
```

### Lab 017 Block 06 — config_or_output — language: `text`

```text
docker/lab017/prometheus/alert_rules.yml
```

### Lab 017 Block 07 — config_or_output — language: `text`

```text
Lab017ApiTargetDown
Lab017HighErrorCount
Lab017HighNotFoundCount
```

### Lab 017 Block 08 — command — language: `bash`

```bash
./scripts/grafana_lab017_check_requirements.sh
```

### Lab 017 Block 09 — config_or_output — language: `text`

```text
[OK] docker command found
[OK] Docker daemon is reachable
[OK] docker compose is available
```

### Lab 017 Block 10 — command — language: `bash`

```bash
./scripts/grafana_lab017_up.sh
```

### Lab 017 Block 11 — config_or_output — language: `text`

```text
[OK] Grafana monitoring stack is running.
[INFO] API URL: http://127.0.0.1:8901/status
[INFO] Prometheus URL: http://127.0.0.1:9096
[INFO] Grafana URL: http://127.0.0.1:3001
```

### Lab 017 Block 12 — command — language: `bash`

```bash
./scripts/grafana_lab017_test_api.sh
```

### Lab 017 Block 13 — config_or_output — language: `text`

```text
/status
/health
/metrics
/error
/not_found_example
```

### Lab 017 Block 14 — command — language: `bash`

```bash
./scripts/grafana_lab017_generate_traffic.sh
```

### Lab 017 Block 15 — command — language: `bash`

```bash
./scripts/grafana_lab017_query_prometheus.sh
```

### Lab 017 Block 16 — config_or_output — language: `text`

```text
up
lab017_requests_total
lab017_error_requests_total
lab017_not_found_total
rate(lab017_requests_total[1m])
```

### Lab 017 Block 17 — command — language: `bash`

```bash
./scripts/grafana_lab017_check_alerts.sh
```

### Lab 017 Block 18 — config_or_output — language: `text`

```text
/api/v1/alerts
```

### Lab 017 Block 19 — config_or_output — language: `text`

```text
http://127.0.0.1:3001
```

### Lab 017 Block 20 — config_or_output — language: `text`

```text
admin / admin
```

### Lab 017 Block 21 — config_or_output — language: `text`

```text
Linux Security Lab — Lab 017
```

### Lab 017 Block 22 — config_or_output — language: `text`

```text
target up
request count
error count
404 count
uptime
request rate
```

### Lab 017 Block 23 — command — language: `bash`

```bash
./scripts/grafana_lab017_logs.sh
```

### Lab 017 Block 24 — command — language: `bash`

```bash
./scripts/grafana_lab017_inspect.sh
```

### Lab 017 Block 25 — command — language: `bash`

```bash
./scripts/grafana_lab017_down.sh
```

### Lab 017 Block 26 — config_or_output — language: `text`

```text
[OK] Grafana monitoring stack stopped and removed.
```

### Lab 017 Block 27 — config_or_output — language: `text`

```text
metrics endpoint
-> Prometheus scrape
-> alert rules
-> Grafana dashboard
-> local investigation
```

### Lab 017 Block 28 — command — language: `bash`

```bash
lsof -i :3001 -P -n
```

### Lab 017 Block 29 — command — language: `bash`

```bash
lsof -i :9096 -P -n
```

### Lab 017 Block 30 — command — language: `bash`

```bash
./scripts/grafana_lab017_logs.sh
```

### Lab 017 Block 31 — config_or_output — language: `text`

```text
http://127.0.0.1:9096/targets
```

### Lab 017 Block 32 — config_or_output — language: `text`

```text
observable_api:8901
```

### Lab 017 Block 33 — config_or_output — language: `text`

```text
observable API
-> Prometheus scrape
-> Prometheus alert rules
-> Grafana datasource
-> Grafana dashboard
-> local report
```

## Lab 018 — Lab 018 — Local SIEM-style Log Pipeline and Detection Rules

Source file: `labs/018_local_siem_log_pipeline_detection_rules.md`

### Lab 018 Block 01 — config_or_output — language: `text`

```text
local repository
fake event files
controlled generated events
defensive analysis
portfolio demonstration
```

### Lab 018 Block 02 — config_or_output — language: `text`

```text
event source
-> JSONL log file
-> normalization
-> detection rules
-> findings
-> severity
-> timeline
-> report
```

### Lab 018 Block 03 — config_or_output — language: `text`

```text
data/lab018/sample_events.jsonl
data/lab018/detection_rules.json
scripts/siem_lab018_generate_sample_events.py
scripts/siem_lab018_validate_rules.py
scripts/siem_lab018_analyze_events.py
scripts/siem_lab018_create_timeline_report.sh
scripts/siem_lab018_run_pipeline.sh
docs/SIEM_LOG_PIPELINE_DETECTION_NOTES.md
```

### Lab 018 Block 04 — config_or_output — language: `json`

```json
{
  "timestamp": "2026-05-20T10:00:00Z",
  "source": "local_api",
  "event_type": "auth_failure",
  "status": 401,
  "src_ip": "127.0.0.1",
  "user": "lab-user",
  "path": "/protected",
  "message": "missing or invalid local API key"
}
```

### Lab 018 Block 05 — config_or_output — language: `text`

```text
data/lab018/detection_rules.json
```

### Lab 018 Block 06 — config_or_output — language: `text`

```text
If auth_failure occurs at least 5 times in the event file, raise a MEDIUM finding.
```

### Lab 018 Block 07 — command — language: `bash`

```bash
./scripts/siem_lab018_validate_rules.py
```

### Lab 018 Block 08 — config_or_output — language: `text`

```text
[OK] Loaded rules: 5
[OK] Rule validation completed.
```

### Lab 018 Block 09 — command — language: `bash`

```bash
./scripts/siem_lab018_analyze_events.py
```

### Lab 018 Block 10 — config_or_output — language: `text`

```text
Total events: 22
Findings:
- AUTH_FAILURE_THRESHOLD severity=MEDIUM
- NOT_FOUND_THRESHOLD severity=LOW
```

### Lab 018 Block 11 — command — language: `bash`

```bash
./scripts/siem_lab018_generate_sample_events.py
```

### Lab 018 Block 12 — config_or_output — language: `text`

```text
[OK] Generated synthetic events:
~/linux_lab/lab018_siem/events/generated_events.jsonl
```

### Lab 018 Block 13 — command — language: `bash`

```bash
./scripts/siem_lab018_analyze_events.py ~/linux_lab/lab018_siem/events/generated_events.jsonl
```

### Lab 018 Block 14 — command — language: `bash`

```bash
./scripts/siem_lab018_create_timeline_report.sh
```

### Lab 018 Block 15 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/siem_lab018_timeline_report_YYYYMMDD_HHMMSS.txt
```

### Lab 018 Block 16 — command — language: `bash`

```bash
./scripts/siem_lab018_run_pipeline.sh
```

### Lab 018 Block 17 — config_or_output — language: `text`

```text
rule validation
synthetic event generation
event analysis
timeline report generation
```

### Lab 018 Block 18 — config_or_output — language: `text`

```text
multiple authentication failures
multiple 404/not-found events
controlled 5xx errors
admin access events
mixed auth failure + not-found pattern
```

### Lab 018 Block 19 — config_or_output — language: `text`

```text
Many 401 events can mean a broken client, a misconfigured integration, or unauthorized attempts.
Many 404 events can mean a wrong route, a broken frontend, or path probing.
Many 5xx events can mean a service bug or backend failure.
```

### Lab 018 Block 20 — command — language: `bash`

```bash
python3 --version
```

### Lab 018 Block 21 — command — language: `bash`

```bash
./scripts/siem_lab018_generate_sample_events.py
```

### Lab 018 Block 22 — config_or_output — language: `text`

```text
synthetic events
-> JSONL event file
-> detection rules
-> rule validation
-> analysis
-> timeline report
-> defensive interpretation
```

## Lab 019 — Lab 019 — Incident Response Case File and Evidence Bundle

Source file: `labs/019_incident_response_case_file_evidence_bundle.md`

### Lab 019 Block 01 — config_or_output — language: `text`

```text
what happened
when it happened
what evidence supports it
what systems were involved
what severity it has
what containment actions are appropriate
what lessons were learned
```

### Lab 019 Block 02 — config_or_output — language: `text`

```text
incident_response/lab019/CASE_FILE.md
incident_response/lab019/TRIAGE_CHECKLIST.md
incident_response/lab019/EVIDENCE_INDEX.md
incident_response/lab019/CONTAINMENT_NOTES.md
incident_response/lab019/LESSONS_LEARNED.md
data/lab019/ir_case_events.jsonl
data/lab019/ir_case_metadata.json
scripts/ir_lab019_generate_case_events.py
scripts/ir_lab019_analyze_case.py
scripts/ir_lab019_build_case_bundle.sh
scripts/ir_lab019_create_final_report.sh
scripts/ir_lab019_run_workflow.sh
```

### Lab 019 Block 03 — config_or_output — language: `text`

```text
successful status checks
multiple authentication failures
multiple unknown paths
controlled backend errors
an administrative event review
normal Prometheus scrape events
```

### Lab 019 Block 04 — command — language: `bash`

```bash
./scripts/ir_lab019_generate_case_events.py
```

### Lab 019 Block 05 — config_or_output — language: `text`

```text
[OK] Generated incident response case events:
~/linux_lab/lab019_ir_case/events/ir_case_events.jsonl
```

### Lab 019 Block 06 — command — language: `bash`

```bash
./scripts/ir_lab019_analyze_case.py
```

### Lab 019 Block 07 — config_or_output — language: `text`

```text
data/lab019/ir_case_events.jsonl
```

### Lab 019 Block 08 — command — language: `bash`

```bash
./scripts/ir_lab019_analyze_case.py ~/linux_lab/lab019_ir_case/events/ir_case_events.jsonl
```

### Lab 019 Block 09 — command — language: `bash`

```bash
./scripts/ir_lab019_build_case_bundle.sh
```

### Lab 019 Block 10 — config_or_output — language: `text`

```text
[OK] Evidence bundle created:
~/linux_lab/lab019_ir_case/bundles/ir_case_bundle_YYYYMMDD_HHMMSS
```

### Lab 019 Block 11 — config_or_output — language: `text`

```text
events
metadata
case file
triage checklist
evidence index
containment notes
lessons learned
analysis output
```

### Lab 019 Block 12 — command — language: `bash`

```bash
./scripts/ir_lab019_create_final_report.sh
```

### Lab 019 Block 13 — config_or_output — language: `text`

```text
[OK] Final incident response report created:
~/linux_lab/reports/ir_lab019_final_report_YYYYMMDD_HHMMSS.txt
```

### Lab 019 Block 14 — command — language: `bash`

```bash
./scripts/ir_lab019_run_workflow.sh
```

### Lab 019 Block 15 — config_or_output — language: `text`

```text
case event generation
case analysis
evidence bundle creation
final report generation
```

### Lab 019 Block 16 — config_or_output — language: `text`

```text
Preparation
Identification
Triage
Containment
Eradication
Recovery
Lessons learned
```

### Lab 019 Block 17 — config_or_output — language: `text`

```text
identified
indexed
timestamped
kept local
reviewed before publication
not mixed with private user data
```

### Lab 019 Block 18 — config_or_output — language: `text`

```text
The local service produced suspicious-looking patterns under controlled lab conditions.
The event sequence is useful for practicing evidence handling and response documentation.
No real external incident occurred.
```

### Lab 019 Block 19 — command — language: `bash`

```bash
python3 --version
```

### Lab 019 Block 20 — command — language: `bash`

```bash
./scripts/ir_lab019_generate_case_events.py
```

### Lab 019 Block 21 — config_or_output — language: `text`

```text
~/linux_lab/lab019_ir_case/
```

### Lab 019 Block 22 — config_or_output — language: `text`

```text
synthetic case events
-> analysis
-> case file
-> evidence index
-> bundle
-> final report
-> lessons learned
```

## Lab 020 — Lab 020 — Final Master Index, Proof-of-Work Bundle and Release Candidate Review

Source file: `labs/020_final_master_index_proof_of_work_release_candidate.md`

### Lab 020 Block 01 — config_or_output — language: `text`

```text
What did this repository cover?
What skills are demonstrated?
Which labs are Linux-specific?
Which labs are Docker-specific?
Which labs are documentation/security-process oriented?
Which scripts should be run to validate the project?
What should be shown to a professor, recruiter or collaborator?
```

### Lab 020 Block 02 — config_or_output — language: `text`

```text
docs/MASTER_LAB_INDEX.md
docs/FINAL_PROJECT_SUMMARY.md
docs/PROOF_OF_WORK.md
docs/FINAL_REVIEW_CHECKLIST.md
docs/V0_1_0_RELEASE_CANDIDATE_REVIEW.md
docs/WHAT_TO_SHOW_RECRUITER_OR_PROFESSOR.md
scripts/final_lab020_validate_all.sh
scripts/final_lab020_generate_master_index.sh
scripts/final_lab020_create_proof_of_work_bundle.sh
scripts/final_lab020_create_release_candidate_report.sh
scripts/final_lab020_run_final_review.sh
```

### Lab 020 Block 03 — command — language: `bash`

```bash
./scripts/final_lab020_validate_all.sh
```

### Lab 020 Block 04 — config_or_output — language: `text`

```text
[OK] Lab count is 20 or higher.
[OK] Required documentation exists.
[OK] Required security documents exist.
[OK] Required CI workflow exists.
```

### Lab 020 Block 05 — command — language: `bash`

```bash
./scripts/final_lab020_generate_master_index.sh
```

### Lab 020 Block 06 — config_or_output — language: `text`

```text
[OK] Master lab index generated:
docs/MASTER_LAB_INDEX.md
```

### Lab 020 Block 07 — command — language: `bash`

```bash
./scripts/final_lab020_create_proof_of_work_bundle.sh
```

### Lab 020 Block 08 — config_or_output — language: `text`

```text
[OK] Proof-of-work bundle created:
~/linux_lab/final_review/proof_of_work_bundle_YYYYMMDD_HHMMSS
```

### Lab 020 Block 09 — command — language: `bash`

```bash
./scripts/final_lab020_create_release_candidate_report.sh
```

### Lab 020 Block 10 — config_or_output — language: `text`

```text
[OK] Release candidate report created:
~/linux_lab/reports/final_release_candidate_report_YYYYMMDD_HHMMSS.txt
```

### Lab 020 Block 11 — command — language: `bash`

```bash
./scripts/final_lab020_run_final_review.sh
```

### Lab 020 Block 12 — config_or_output — language: `text`

```text
baseline validation
master index generation
proof-of-work bundle creation
release candidate report generation
```

### Lab 020 Block 13 — config_or_output — language: `text`

```text
Linux diagnostics
network diagnostics
HTTP and packet capture
ports, processes and logs
DNS and routing
network namespaces
firewall and NAT
traffic shaping
local JSON APIs
API security controls
Docker networking
Docker Compose reverse proxy
Prometheus metrics
GitHub Actions CI
threat modeling
secure service capstone
release engineering
Grafana dashboards and alerts
SIEM-style log pipeline
incident response case documentation
final proof-of-work packaging
```

### Lab 020 Block 14 — command — language: `bash`

```bash
git tag -a v0.1.0 -m "Linux Network Security Lab v0.1.0"
git push origin v0.1.0
```

### Lab 020 Block 15 — config_or_output — language: `text`

```text
CI passes
README is reviewed
private data is absent
generated reports are reviewed
screenshots are reviewed
Docker labs are tested where possible
```

### Lab 020 Block 16 — config_or_output — language: `text`

```text
20 labs
-> master index
-> validation
-> proof-of-work bundle
-> release candidate report
-> manual review
-> optional GitHub release
```

## Lab 021 — Lab 021 — Linux Security Tools Overview

Source file: `labs/021_linux_security_tools_overview.md`

### Lab 021 Block 01 — config_or_output — language: `text`

```text
checking whether a command exists
printing local version/help output
documenting tool purpose
creating a local report
running on a personal machine, VM or container
```

### Lab 021 Block 02 — config_or_output — language: `text`

```text
scanning third-party systems
capturing third-party traffic
testing Wi-Fi networks without authorization
collecting credentials
publishing private logs
publishing real network identifiers
```

### Lab 021 Block 03 — command — language: `bash`

```bash
./scripts/tools_lab021_inventory.sh
```

### Lab 021 Block 04 — config_or_output — language: `text`

```text
[INFO] Lab 021 Linux security tools inventory
[OK] found: git
[OK] found: python3
[INFO] optional tool not found: tshark
[INFO] optional tool not found: aircrack-ng
[OK] Inventory completed.
```

### Lab 021 Block 05 — command — language: `bash`

```bash
./scripts/tools_lab021_create_report.sh
```

### Lab 021 Block 06 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/lab021_linux_security_tools_overview_YYYYMMDD_HHMMSS.txt
```

### Lab 021 Block 07 — command — language: `bash`

```bash
tcpdump --version
tshark --version
nmap --version
aircrack-ng --help
openssl version
gpg --version
```

### Lab 021 Block 08 — config_or_output — language: `text`

```text
scan external hosts
attack Wi-Fi networks
capture real user traffic
run password attacks
run exploit tools
publish real logs
publish private host data
```

## Lab 022 — Lab 022 — Wireshark and TShark Packet Analysis

Source file: `labs/022_wireshark_tshark_packet_analysis.md`

### Lab 022 Block 01 — config_or_output — language: `text`

```text
PCAP file concept
TShark requirement checking
synthetic packet generation
DNS and HTTP display filters
field extraction
privacy-safe packet analysis
defensive interpretation
report writing
```

### Lab 022 Block 02 — config_or_output — language: `text`

```text
scripts/tshark_lab022_generate_sample_pcap.py
```

### Lab 022 Block 03 — config_or_output — language: `text`

```text
10.10.10.10
10.10.10.20
10.10.10.53
```

### Lab 022 Block 04 — config_or_output — language: `text`

```text
docs/tools/WIRESHARK_TSHARK_PACKET_ANALYSIS.md
data/lab022/.gitkeep
scripts/tshark_lab022_check_requirements.sh
scripts/tshark_lab022_generate_sample_pcap.py
scripts/tshark_lab022_analyze_sample_pcap.sh
scripts/tshark_lab022_create_report.sh
reports/templates/lab_022_wireshark_tshark_packet_analysis_report_template.md
examples/lab_022_expected_outputs.txt
```

### Lab 022 Block 05 — command — language: `bash`

```bash
./scripts/tshark_lab022_check_requirements.sh
```

### Lab 022 Block 06 — config_or_output — language: `text`

```text
[OK] python3 found
[OK] tshark found
```

### Lab 022 Block 07 — config_or_output — language: `text`

```text
[WARN] tshark not found
```

### Lab 022 Block 08 — command — language: `bash`

```bash
./scripts/tshark_lab022_generate_sample_pcap.py
```

### Lab 022 Block 09 — config_or_output — language: `text`

```text
[OK] Synthetic PCAP created: data/lab022/local_http_dns_sample.pcap
```

### Lab 022 Block 10 — command — language: `bash`

```bash
./scripts/tshark_lab022_analyze_sample_pcap.sh
```

### Lab 022 Block 11 — command — language: `bash`

```bash
./scripts/tshark_lab022_create_report.sh
```

### Lab 022 Block 12 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/lab022_tshark_packet_analysis_YYYYMMDD_HHMMSS.txt
```

### Lab 022 Block 13 — command — language: `bash`

```bash
tshark -r data/lab022/local_http_dns_sample.pcap
tshark -r data/lab022/local_http_dns_sample.pcap -Y "dns"
tshark -r data/lab022/local_http_dns_sample.pcap -Y "http"
tshark -r data/lab022/local_http_dns_sample.pcap -T fields -e frame.number -e ip.src -e ip.dst -e _ws.col.Protocol -e _ws.col.Info
```

### Lab 022 Block 14 — config_or_output — language: `text`

```text
capture live traffic
read private network traffic
monitor Wi-Fi networks
collect credentials
inspect third-party systems
publish real packet captures
```

### Lab 022 Block 15 — config_or_output — language: `text`

```text
a DNS query for lab.local
a DNS response for lab.local
an HTTP GET request
an HTTP 200 OK response
```

### Lab 022 Block 16 — config_or_output — language: `text`

```text
The capture contains controlled synthetic DNS and HTTP traffic.
The packets are suitable for learning filters and field extraction.
No real private traffic was collected.
```

### Lab 022 Block 17 — command — language: `bash`

```bash
brew install wireshark
```

### Lab 022 Block 18 — command — language: `bash`

```bash
sudo apt install tshark
```

### Lab 022 Block 19 — command — language: `bash`

```bash
./scripts/tshark_lab022_generate_sample_pcap.py
```

### Lab 022 Block 20 — config_or_output — language: `text`

```text
synthetic PCAP
-> TShark read
-> DNS filter
-> HTTP filter
-> field extraction
-> local report
-> defensive interpretation
```

## Lab 023 — Lab 023 — Nmap Localhost and Authorized Service Scanning

Source file: `labs/023_nmap_localhost_authorized_scanning.md`

### Lab 023 Block 01 — config_or_output — language: `text`

```text
127.0.0.1
localhost
local service started by this lab
personal VM
personal container
explicitly authorized lab target
```

### Lab 023 Block 02 — config_or_output — language: `text`

```text
third-party hosts
public IP ranges
school/company networks without authorization
stealth/evasion scanning
exploit execution
brute force
credential collection
```

### Lab 023 Block 03 — config_or_output — language: `text`

```text
docs/tools/NMAP_AUTHORIZED_SCANNING_NOTES.md
scripts/nmap_lab023_check_requirements.sh
scripts/nmap_lab023_start_local_service.py
scripts/nmap_lab023_scan_localhost.sh
scripts/nmap_lab023_create_report.sh
examples/lab_023_expected_outputs.txt
reports/templates/lab_023_nmap_localhost_authorized_scanning_report_template.md
```

### Lab 023 Block 04 — command — language: `bash`

```bash
./scripts/nmap_lab023_check_requirements.sh
```

### Lab 023 Block 05 — config_or_output — language: `text`

```text
[OK] python3 found
[OK] nmap found
```

### Lab 023 Block 06 — command — language: `bash`

```bash
./scripts/nmap_lab023_start_local_service.py
```

### Lab 023 Block 07 — config_or_output — language: `text`

```text
[INFO] Lab 023 local HTTP service
[INFO] Listening on http://127.0.0.1:8088
```

### Lab 023 Block 08 — command — language: `bash`

```bash
./scripts/nmap_lab023_scan_localhost.sh
```

### Lab 023 Block 09 — command — language: `bash`

```bash
./scripts/nmap_lab023_create_report.sh
```

### Lab 023 Block 10 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/lab023_nmap_localhost_authorized_scanning_YYYYMMDD_HHMMSS.txt
```

### Lab 023 Block 11 — command — language: `bash`

```bash
nmap 127.0.0.1
nmap -p 8088 127.0.0.1
nmap -sV -p 8088 127.0.0.1
```

### Lab 023 Block 12 — config_or_output — language: `text`

```text
Port 8088/tcp is open because the lab started a local HTTP service.
The service is expected.
The service is bound to 127.0.0.1.
No third-party target was scanned.
```

### Lab 023 Block 13 — config_or_output — language: `text`

```text
scan external IPs
scan public networks
scan Wi-Fi networks
perform stealth or evasion
exploit services
brute force credentials
collect sensitive banners from third-party systems
```

### Lab 023 Block 14 — command — language: `bash`

```bash
brew install nmap
```

### Lab 023 Block 15 — command — language: `bash`

```bash
sudo apt install nmap
```

### Lab 023 Block 16 — command — language: `bash`

```bash
./scripts/nmap_lab023_start_local_service.py
```

### Lab 023 Block 17 — config_or_output — language: `text`

```text
local service
-> localhost scan
-> expected open port
-> local report
-> defensive service inventory
```

## Lab 024 — Lab 024 — Aircrack-ng Wireless Security Awareness

Source file: `labs/024_aircrack_ng_wireless_security_awareness.md`

### Lab 024 Block 01 — config_or_output — language: `text`

```text
checking whether Aircrack-ng tools are installed
printing local help/version output
reading the safe usage policy
writing defensive wireless hardening notes
documenting authorization requirements
```

### Lab 024 Block 02 — config_or_output — language: `text`

```text
testing third-party Wi-Fi networks
capturing live wireless traffic
performing deauthentication
collecting handshakes
cracking passwords
publishing real SSIDs/BSSIDs/MAC addresses
publishing real wireless captures
```

### Lab 024 Block 03 — config_or_output — language: `text`

```text
docs/tools/AIRCRACK_NG_TOOL_OVERVIEW.md
docs/tools/WIRELESS_SECURITY_DEFENSIVE_HARDENING.md
scripts/aircrack_lab024_check_requirements.sh
scripts/aircrack_lab024_help_inventory.sh
scripts/aircrack_lab024_create_report.sh
examples/lab_024_expected_outputs.txt
reports/templates/lab_024_aircrack_ng_wireless_security_awareness_report_template.md
```

### Lab 024 Block 04 — config_or_output — language: `text`

```text
docs/tools/AIRCRACK_NG_SAFE_USAGE_POLICY.md
docs/tools/AIRCRACK_NG_TOOL_OVERVIEW.md
docs/tools/WIRELESS_SECURITY_DEFENSIVE_HARDENING.md
```

### Lab 024 Block 05 — command — language: `bash`

```bash
./scripts/aircrack_lab024_check_requirements.sh
```

### Lab 024 Block 06 — config_or_output — language: `text`

```text
[OK] aircrack-ng found
```

### Lab 024 Block 07 — config_or_output — language: `text`

```text
[WARN] aircrack-ng not found
```

### Lab 024 Block 08 — command — language: `bash`

```bash
./scripts/aircrack_lab024_help_inventory.sh
```

### Lab 024 Block 09 — command — language: `bash`

```bash
./scripts/aircrack_lab024_create_report.sh
```

### Lab 024 Block 10 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/lab024_aircrack_ng_wireless_security_awareness_YYYYMMDD_HHMMSS.txt
```

### Lab 024 Block 11 — command — language: `bash`

```bash
aircrack-ng --help
airmon-ng --help
airodump-ng --help
```

### Lab 024 Block 12 — config_or_output — language: `text`

```text
scan Wi-Fi networks
capture packets
monitor neighbors
deauthenticate clients
collect handshakes
run cracking workflows
recover passwords
publish wireless identifiers
```

### Lab 024 Block 13 — config_or_output — language: `text`

```text
Aircrack-ng is a dual-use wireless auditing suite. It should be studied only in owned or explicitly authorized labs. This repository documents tool awareness and defensive Wi-Fi hardening, not unauthorized wireless attacks.
```

### Lab 024 Block 14 — config_or_output — language: `text`

```text
use WPA2/WPA3
use long random passphrases
disable WPS if not needed
update router firmware
separate guest/IoT networks
change default admin credentials
document authorization before testing
avoid publishing real SSIDs or captures
```

## Lab 025 — Lab 025 — tcpdump Advanced Capture Filters

Source file: `labs/025_tcpdump_advanced_capture_filters.md`

### Lab 025 Block 01 — config_or_output — language: `text`

```text
127.0.0.1
loopback interface
local service created by this lab
short packet-count capture
local PCAP file
local report
```

### Lab 025 Block 02 — config_or_output — language: `text`

```text
third-party networks
Wi-Fi traffic from real users
private browsing capture
credential capture
public network monitoring
publishing sensitive PCAP files
```

### Lab 025 Block 03 — config_or_output — language: `text`

```text
docs/tools/TCPDUMP_ADVANCED_CAPTURE_FILTERS.md
scripts/tcpdump_lab025_check_requirements.sh
scripts/tcpdump_lab025_start_local_service.py
scripts/tcpdump_lab025_capture_loopback.sh
scripts/tcpdump_lab025_create_report.sh
examples/lab_025_expected_outputs.txt
reports/templates/lab_025_tcpdump_advanced_capture_filters_report_template.md
```

### Lab 025 Block 04 — command — language: `bash`

```bash
./scripts/tcpdump_lab025_check_requirements.sh
```

### Lab 025 Block 05 — config_or_output — language: `text`

```text
[OK] python3 found
[OK] curl found
[OK] tcpdump found
```

### Lab 025 Block 06 — command — language: `bash`

```bash
./scripts/tcpdump_lab025_capture_loopback.sh
```

### Lab 025 Block 07 — config_or_output — language: `text`

```text
http://127.0.0.1:8090
```

### Lab 025 Block 08 — config_or_output — language: `text`

```text
tcp port 8090 and host 127.0.0.1
```

### Lab 025 Block 09 — command — language: `bash`

```bash
./scripts/tcpdump_lab025_create_report.sh
```

### Lab 025 Block 10 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/lab025_tcpdump_advanced_capture_filters_YYYYMMDD_HHMMSS.txt
```

### Lab 025 Block 11 — command — language: `bash`

```bash
sudo tcpdump -i lo -nn -c 10 'tcp port 8090 and host 127.0.0.1'
```

### Lab 025 Block 12 — command — language: `bash`

```bash
sudo tcpdump -i lo0 -nn -c 10 'tcp port 8090 and host 127.0.0.1'
```

### Lab 025 Block 13 — command — language: `bash`

```bash
tcpdump -nn -r data/lab025/lab025_loopback_http.pcap
```

### Lab 025 Block 14 — config_or_output — language: `text`

```text
The capture contains local TCP packets generated by requests to 127.0.0.1:8090.
The filter limited scope to loopback traffic.
No third-party traffic was captured.
```

### Lab 025 Block 15 — config_or_output — language: `text`

```text
capture Wi-Fi traffic
capture third-party traffic
collect credentials
inspect private browsing
monitor public networks
publish sensitive packet captures
```

### Lab 025 Block 16 — command — language: `bash`

```bash
sudo ./scripts/tcpdump_lab025_capture_loopback.sh
```

### Lab 025 Block 17 — config_or_output — language: `text`

```text
lo0 on macOS
lo on Linux
```

### Lab 025 Block 18 — config_or_output — language: `text`

```text
local service
-> local requests
-> narrow tcpdump filter
-> local PCAP
-> defensive report
```

## Lab 026 — Lab 026 — Defensive Firewall Rules with nftables, iptables and ufw

Source file: `labs/026_defensive_firewall_rules_nftables_iptables_ufw.md`

### Lab 026 Block 01 — config_or_output — language: `text`

```text
checking whether firewall tools exist
read-only firewall inspection
socket inventory
dry-run rule generation
report writing
```

### Lab 026 Block 02 — config_or_output — language: `text`

```text
applying firewall rules automatically
flushing existing rules
blocking SSH or other admin access
changing production firewall state
using sudo to apply unreviewed rules
```

### Lab 026 Block 03 — config_or_output — language: `text`

```text
docs/tools/DEFENSIVE_FIREWALL_RULES_NFTABLES_IPTABLES_UFW.md
scripts/firewall_lab026_check_requirements.sh
scripts/firewall_lab026_inspect_readonly.sh
scripts/firewall_lab026_generate_dry_run_rules.sh
scripts/firewall_lab026_create_report.sh
examples/lab_026_expected_outputs.txt
reports/templates/lab_026_defensive_firewall_rules_report_template.md
```

### Lab 026 Block 04 — command — language: `bash`

```bash
./scripts/firewall_lab026_check_requirements.sh
```

### Lab 026 Block 05 — config_or_output — language: `text`

```text
[OK] found: nft
[OK] found: iptables
[OK] found: ufw
```

### Lab 026 Block 06 — command — language: `bash`

```bash
./scripts/firewall_lab026_inspect_readonly.sh
```

### Lab 026 Block 07 — config_or_output — language: `text`

```text
nft not found
iptables not found
ufw not found
pfctl available on macOS
```

### Lab 026 Block 08 — command — language: `bash`

```bash
./scripts/firewall_lab026_generate_dry_run_rules.sh
```

### Lab 026 Block 09 — config_or_output — language: `text`

```text
generated/lab026/
```

### Lab 026 Block 10 — command — language: `bash`

```bash
./scripts/firewall_lab026_create_report.sh
```

### Lab 026 Block 11 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/lab026_defensive_firewall_rules_YYYYMMDD_HHMMSS.txt
```

### Lab 026 Block 12 — config_or_output — language: `text`

```text
1. allow loopback
2. allow established/related traffic
3. allow required admin access
4. allow required service ports
5. log or count unexpected traffic
6. drop everything else
```

### Lab 026 Block 13 — config_or_output — language: `text`

```text
run nft -f
run iptables -A on the system
run ufw enable
flush existing rules
block ports
change remote access
```

### Lab 026 Block 14 — config_or_output — language: `text`

```text
inspect
document
generate dry-run examples
review
write report
do not apply automatically
```

## Lab 027 — Lab 027 — SSH Hardening and Key-Based Access

Source file: `labs/027_ssh_hardening_key_based_access.md`

### Lab 027 Block 01 — config_or_output — language: `text`

```text
checking SSH tool availability
printing SSH client version
read-only inspection of ~/.ssh file names and permissions
generating example client config
generating example sshd_config hardening file
creating a local report
```

### Lab 027 Block 02 — config_or_output — language: `text`

```text
modifying real sshd_config automatically
restarting sshd automatically
disabling password login automatically
deleting keys
publishing private keys
brute forcing SSH
testing third-party hosts
```

### Lab 027 Block 03 — config_or_output — language: `text`

```text
docs/tools/SSH_HARDENING_KEY_BASED_ACCESS.md
scripts/ssh_lab027_check_requirements.sh
scripts/ssh_lab027_inspect_readonly.sh
scripts/ssh_lab027_generate_dry_run_config.sh
scripts/ssh_lab027_create_report.sh
generated/lab027/ssh_client_config_example
generated/lab027/sshd_config_hardening_example.conf
generated/lab027/authorized_keys_policy_example.md
examples/lab_027_expected_outputs.txt
reports/templates/lab_027_ssh_hardening_key_based_access_report_template.md
```

### Lab 027 Block 04 — command — language: `bash`

```bash
./scripts/ssh_lab027_check_requirements.sh
```

### Lab 027 Block 05 — config_or_output — language: `text`

```text
[OK] found: ssh
[OK] found: ssh-keygen
```

### Lab 027 Block 06 — command — language: `bash`

```bash
./scripts/ssh_lab027_inspect_readonly.sh
```

### Lab 027 Block 07 — config_or_output — language: `text`

```text
cat ~/.ssh/id_*
printing private keys
modifying permissions
editing config
```

### Lab 027 Block 08 — command — language: `bash`

```bash
./scripts/ssh_lab027_generate_dry_run_config.sh
```

### Lab 027 Block 09 — config_or_output — language: `text`

```text
generated/lab027/
```

### Lab 027 Block 10 — command — language: `bash`

```bash
./scripts/ssh_lab027_create_report.sh
```

### Lab 027 Block 11 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/lab027_ssh_hardening_key_based_access_YYYYMMDD_HHMMSS.txt
```

### Lab 027 Block 12 — config_or_output — language: `text`

```text
use key-based authentication
protect private keys with passphrases
disable root login
disable password authentication only after key login is tested
limit allowed users
reduce max authentication attempts
avoid unnecessary forwarding
keep fallback access during changes
```

### Lab 027 Block 13 — config_or_output — language: `text`

```text
change real server settings
disable password login
restart sshd
open remote access
scan hosts
attack SSH
collect credentials
publish private keys
```

### Lab 027 Block 14 — config_or_output — language: `text`

```text
inspect
generate examples
review
test in lab
document
apply manually only with recovery plan
```

## Lab 028 — Lab 028 — auditd and Linux Event Auditing

Source file: `labs/028_auditd_linux_event_auditing.md`

### Lab 028 Block 01 — config_or_output — language: `text`

```text
checking whether audit tools exist
read-only status inspection
dry-run audit rule generation
synthetic event generation
local report writing
```

### Lab 028 Block 02 — config_or_output — language: `text`

```text
modifying /etc/audit
loading audit rules automatically
restarting auditd
collecting private user activity
publishing real audit logs without review
monitoring users without authorization
```

### Lab 028 Block 03 — config_or_output — language: `text`

```text
docs/tools/AUDITD_LINUX_EVENT_AUDITING.md
scripts/auditd_lab028_check_requirements.sh
scripts/auditd_lab028_inspect_readonly.sh
scripts/auditd_lab028_generate_dry_run_rules.sh
scripts/auditd_lab028_create_synthetic_events.py
scripts/auditd_lab028_create_report.sh
generated/lab028/auditd_dry_run_rules.rules
generated/lab028/auditd_rules_explanation.md
examples/lab_028_expected_outputs.txt
reports/templates/lab_028_auditd_linux_event_auditing_report_template.md
```

### Lab 028 Block 04 — command — language: `bash`

```bash
./scripts/auditd_lab028_check_requirements.sh
```

### Lab 028 Block 05 — config_or_output — language: `text`

```text
[OK] found: auditctl
[OK] found: ausearch
[OK] found: aureport
```

### Lab 028 Block 06 — command — language: `bash`

```bash
./scripts/auditd_lab028_inspect_readonly.sh
```

### Lab 028 Block 07 — command — language: `bash`

```bash
./scripts/auditd_lab028_generate_dry_run_rules.sh
```

### Lab 028 Block 08 — config_or_output — language: `text`

```text
generated/lab028/auditd_dry_run_rules.rules
generated/lab028/auditd_rules_explanation.md
```

### Lab 028 Block 09 — command — language: `bash`

```bash
./scripts/auditd_lab028_create_synthetic_events.py
```

### Lab 028 Block 10 — config_or_output — language: `text`

```text
data/lab028/synthetic_audit_events.jsonl
```

### Lab 028 Block 11 — command — language: `bash`

```bash
./scripts/auditd_lab028_create_report.sh
```

### Lab 028 Block 12 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/lab028_auditd_linux_event_auditing_YYYYMMDD_HHMMSS.txt
```

### Lab 028 Block 13 — config_or_output — language: `text`

```text
1. define sensitive asset
2. define event of interest
3. create narrow rule
4. label event with key
5. search by key
6. review findings
7. protect privacy
8. write report
```

### Lab 028 Block 14 — config_or_output — language: `text`

```text
install auditd
enable auditd
load rules into the kernel
restart services
collect real user command history
publish real audit logs
```

### Lab 028 Block 15 — config_or_output — language: `text`

```text
inspect
generate dry-run rules
create synthetic events
write report
do not load rules automatically
```

## Lab 029 — Lab 029 — Lynis Local Security Audit

Source file: `labs/029_lynis_local_security_audit.md`

### Lab 029 Block 01 — config_or_output — language: `text`

```text
checking whether Lynis is installed
printing version/help output
creating synthetic findings
running an audit only on your own machine or VM
saving raw output locally
publishing only sanitized summaries
```

### Lab 029 Block 02 — config_or_output — language: `text`

```text
running Lynis on machines you do not own/administer
publishing raw Lynis reports without review
publishing private hostnames, usernames or local paths
treating Lynis as a complete security certification
```

### Lab 029 Block 03 — config_or_output — language: `text`

```text
docs/tools/LYNIS_LOCAL_SECURITY_AUDIT.md
scripts/lynis_lab029_check_requirements.sh
scripts/lynis_lab029_create_synthetic_findings.py
scripts/lynis_lab029_run_local_audit.sh
scripts/lynis_lab029_create_report.sh
data/lab029/synthetic_lynis_findings.jsonl
examples/lab_029_expected_outputs.txt
reports/templates/lab_029_lynis_local_security_audit_report_template.md
```

### Lab 029 Block 04 — command — language: `bash`

```bash
./scripts/lynis_lab029_check_requirements.sh
```

### Lab 029 Block 05 — config_or_output — language: `text`

```text
[OK] found: lynis
```

### Lab 029 Block 06 — config_or_output — language: `text`

```text
[INFO] optional tool not found: lynis
```

### Lab 029 Block 07 — command — language: `bash`

```bash
./scripts/lynis_lab029_create_synthetic_findings.py
```

### Lab 029 Block 08 — config_or_output — language: `text`

```text
[OK] Synthetic Lynis-style findings created: data/lab029/synthetic_lynis_findings.jsonl
```

### Lab 029 Block 09 — command — language: `bash`

```bash
RUN_LYNIS_LOCAL_AUDIT=yes ./scripts/lynis_lab029_run_local_audit.sh
```

### Lab 029 Block 10 — config_or_output — language: `text`

```text
~/linux_lab/private_outputs/lab029/
```

### Lab 029 Block 11 — command — language: `bash`

```bash
./scripts/lynis_lab029_create_report.sh
```

### Lab 029 Block 12 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/lab029_lynis_local_security_audit_YYYYMMDD_HHMMSS.txt
```

### Lab 029 Block 13 — config_or_output — language: `text`

```text
recommendations
hardening prompts
evidence for follow-up
not final proof of security
not final proof of compromise
```

### Lab 029 Block 14 — config_or_output — language: `text`

```text
audit third-party machines
publish raw system audit output
apply hardening automatically
modify system configuration
install packages
claim certification
```

### Lab 029 Block 15 — command — language: `bash`

```bash
brew install lynis
```

### Lab 029 Block 16 — command — language: `bash`

```bash
sudo apt install lynis
```

### Lab 029 Block 17 — config_or_output — language: `text`

```text
check tool
generate synthetic findings
optionally run local audit with confirmation
sanitize
summarize
write defensive report
```

## Lab 030 — Lab 030 — Fail2ban Local Log-Based Protection

Source file: `labs/030_fail2ban_local_log_based_protection.md`

### Lab 030 Block 01 — config_or_output — language: `text`

```text
checking whether fail2ban-client exists
generating synthetic logs
analyzing synthetic failed-login patterns
generating dry-run configuration examples
writing a local report
```

### Lab 030 Block 02 — config_or_output — language: `text`

```text
modifying /etc/fail2ban
starting/restarting fail2ban
banning real IP addresses
testing against real login services
brute forcing SSH
publishing real authentication logs
```

### Lab 030 Block 03 — config_or_output — language: `text`

```text
docs/tools/FAIL2BAN_LOCAL_LOG_BASED_PROTECTION.md
scripts/fail2ban_lab030_check_requirements.sh
scripts/fail2ban_lab030_generate_synthetic_auth_log.py
scripts/fail2ban_lab030_analyze_synthetic_auth_log.py
scripts/fail2ban_lab030_generate_dry_run_config.sh
scripts/fail2ban_lab030_create_report.sh
data/lab030/synthetic_auth.log
data/lab030/synthetic_fail2ban_findings.jsonl
generated/lab030/fail2ban_filter_lab_auth.conf
generated/lab030/fail2ban_jail_lab_auth.local
generated/lab030/fail2ban_dry_run_notes.md
examples/lab_030_expected_outputs.txt
reports/templates/lab_030_fail2ban_local_log_based_protection_report_template.md
```

### Lab 030 Block 04 — command — language: `bash`

```bash
./scripts/fail2ban_lab030_check_requirements.sh
```

### Lab 030 Block 05 — config_or_output — language: `text`

```text
[OK] found: fail2ban-client
```

### Lab 030 Block 06 — config_or_output — language: `text`

```text
[INFO] optional tool not found: fail2ban-client
```

### Lab 030 Block 07 — command — language: `bash`

```bash
./scripts/fail2ban_lab030_generate_synthetic_auth_log.py
```

### Lab 030 Block 08 — config_or_output — language: `text`

```text
[OK] Synthetic auth log created: data/lab030/synthetic_auth.log
```

### Lab 030 Block 09 — command — language: `bash`

```bash
./scripts/fail2ban_lab030_analyze_synthetic_auth_log.py
```

### Lab 030 Block 10 — config_or_output — language: `text`

```text
[OK] Synthetic findings created: data/lab030/synthetic_fail2ban_findings.jsonl
```

### Lab 030 Block 11 — command — language: `bash`

```bash
./scripts/fail2ban_lab030_generate_dry_run_config.sh
```

### Lab 030 Block 12 — config_or_output — language: `text`

```text
generated/lab030/fail2ban_filter_lab_auth.conf
generated/lab030/fail2ban_jail_lab_auth.local
generated/lab030/fail2ban_dry_run_notes.md
```

### Lab 030 Block 13 — command — language: `bash`

```bash
./scripts/fail2ban_lab030_create_report.sh
```

### Lab 030 Block 14 — config_or_output — language: `text`

```text
[OK] Report created:
~/linux_lab/reports/lab030_fail2ban_local_log_based_protection_YYYYMMDD_HHMMSS.txt
```

### Lab 030 Block 15 — config_or_output — language: `text`

```text
failed login line
-> extract source IP
-> count failures by IP
-> compare with threshold
-> create finding
-> recommend defensive review
```

### Lab 030 Block 16 — config_or_output — language: `text`

```text
run brute force
touch SSH service
ban real IPs
modify Fail2ban service
publish real logs
collect real credentials
```

### Lab 030 Block 17 — config_or_output — language: `text`

```text
synthetic log
-> pattern analysis
-> dry-run filter/jail
-> local report
-> privacy review
```

## Safe v1.1 runner

For Labs 021-030, a safe helper is available:

```bash
cd "/Users/antonmorosi/linux-network-security-lab"
./scripts/run_safe_v11_labs_021_030.sh
```

The runner avoids forced sudo and skips gated real Lynis audit. It may report missing optional tools, which is acceptable.

## Final privacy checklist

```text
No private keys.
No real auth logs.
No raw Lynis output.
No third-party scan output.
No Wi-Fi captures.
No credentials.
No tokens.
No private hostnames.
No unreviewed packet captures.
```
