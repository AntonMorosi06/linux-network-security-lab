# HTTP and tcpdump Lab Notes

## Loopback

The loopback interface is a virtual network interface used by the host to communicate with itself.

Common addresses:

```text
127.0.0.1
localhost
::1
```

Traffic sent to `127.0.0.1` does not leave the machine.

## Local HTTP server

Python can start a simple local HTTP server:

```bash
python3 -m http.server 8080 --bind 127.0.0.1
```

This is useful for local testing, but it is not intended as a production web server.

## curl

`curl` is a command-line HTTP client. It can retrieve pages, headers, timing data, and verbose connection details.

Useful forms:

```bash
curl http://127.0.0.1:8080
curl -I http://127.0.0.1:8080
curl -v http://127.0.0.1:8080
```

## ss

`ss` inspects sockets.

Useful forms:

```bash
ss -ltnp
ss -tulpen
ss -tan state established
```

## tcpdump

`tcpdump` captures packets.

Useful local capture:

```bash
sudo tcpdump -i lo port 8080 -c 20
```

Save to pcap:

```bash
sudo tcpdump -i lo port 8080 -w local_http_8080.pcap -c 50
```

Read pcap:

```bash
tcpdump -r local_http_8080.pcap
```

## TCP handshake

The beginning of a TCP connection usually includes:

```text
SYN
SYN-ACK
ACK
```

In tcpdump flags:

```text
[S]   SYN
[S.]  SYN-ACK
[.]   ACK
[P.]  PSH + ACK, usually payload data
```

## Defensive value

This lab helps develop safe practical understanding of:

- local services
- ports
- listening sockets
- client-server communication
- packet capture
- troubleshooting
- service verification
