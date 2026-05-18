# Lab 001 — Local System and Network Baseline

## Objective

Create a first local baseline of the Linux system and network configuration.

## Commands

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

## Expected output example

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

## Interpretation

This baseline identifies the machine, current user, IP addresses, default route, DNS configuration, listening ports, failed services, and recent warning logs.

## Security note

This lab is read-only and local. It does not scan external systems and does not modify the machine.
