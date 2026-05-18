# Documentation Index

## 1. Introduction

This section explains the purpose of the Linux Network Security Lab, the safe operating boundaries, and the defensive learning method used throughout the repository.

## 2. Linux System Basics

Topics:

- hostname
- current user
- kernel version
- distribution information
- uptime
- CPU, RAM, and disk usage
- filesystem inspection

## 3. Network Diagnostics

Topics:

- network interfaces
- IP addresses
- loopback
- routing table
- default gateway
- DNS configuration
- connectivity tests
- traceroute and tracepath

## 4. Ports, Sockets, and Processes

Topics:

- listening ports
- active connections
- TCP and UDP
- process-to-port mapping
- ss
- lsof
- ps
- top
- htop

## 5. Local Services

Topics:

- local HTTP server
- curl testing
- netcat TCP and UDP tests
- Python socket server
- JSON API endpoint
- service logs

## 6. Logs and Monitoring

Topics:

- journalctl
- dmesg
- systemd service logs
- warning and error logs
- custom log events with logger
- structured JSON logs

## 7. Firewall and Filtering

Topics:

- UFW
- nftables
- iptables
- local allow/drop tests
- firewall counters
- stateful filtering
- defensive interpretation

## 8. Packet Capture

Topics:

- tcpdump
- loopback capture
- HTTP packet capture
- ICMP capture
- TCP handshake observation
- pcap files
- Wireshark analysis

## 9. Network Namespace Laboratory

Topics:

- namespace creation
- virtual Ethernet pairs
- isolated client-router-server topology
- routing
- IP forwarding
- NAT
- firewall rules
- traffic shaping
- latency and packet loss simulation

## 10. Automation and Reports

Topics:

- health-check scripts
- ports report
- logs report
- full lab report
- advanced lab report
- timestamped output files

## 11. Defensive Mini-SOC

Topics:

- event generation
- log collection
- log analysis
- HTTP status detection
- simple alert logic
- report generation

## 12. Security Notes

Topics:

- safe-use boundaries
- local-only testing
- permissions
- auditd
- systemd hardening
- threat modeling
