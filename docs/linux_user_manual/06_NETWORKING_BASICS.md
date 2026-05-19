# Networking Basics

Linux networking diagnostics focus on interfaces, IP addresses, routes, DNS, ports and traffic.

## Core commands

```bash
ip addr
ip route
ping -c 4 127.0.0.1
curl -i http://127.0.0.1:8080
ss -tulpen
lsof -i -P -n
```

## Interface concepts

```text
lo        loopback interface
eth0      Ethernet-style interface
wlan0     wireless interface
docker0   Docker bridge interface
veth      virtual Ethernet pair
```

## IP and route

```bash
ip addr
ip route
```

Expected output includes interface names, IP addresses and default gateway.

## Safe local testing

Use localhost for safe service testing:

```bash
curl -i http://127.0.0.1:8080
ping -c 4 127.0.0.1
```

## Safety

Do not scan or test networks you do not own or do not have permission to test.
