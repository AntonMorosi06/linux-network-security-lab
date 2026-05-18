# Linux Network Security Lab

This repository contains a local and defensive Linux laboratory focused on system diagnostics, networking, service monitoring, firewall inspection, packet capture, logging, automation, and basic security analysis.

The purpose of this project is to document practical Linux, networking, and cybersecurity exercises in a safe environment using localhost, local services, virtual network namespaces, containers, and controlled scripts.

## Scope

This repository is designed for defensive learning and local experimentation only. The exercises are intended to be executed on a personal machine, virtual machine, container, local namespace lab, or explicitly authorized environment.

The project includes:

- Linux system inspection
- Network interface analysis
- Routing and gateway diagnostics
- DNS troubleshooting
- Local HTTP servers
- TCP and UDP local testing
- Socket and port inspection
- Process and service monitoring
- systemd and journalctl usage
- Firewall inspection with UFW, nftables, and iptables
- Packet capture with tcpdump
- Local network namespaces
- Basic NAT and routing laboratories
- Local JSON API experiments
- Structured logs
- Health-check scripts
- Defensive mini-SOC style reports
- Documentation with commands, expected outputs, and interpretation

## Repository structure

linux-network-security-lab/
  README.md
  docs/
  labs/
  scripts/
  reports/
  pcaps/
  screenshots/
  notes/
  security/
  examples/

## Safety rule

All commands and exercises in this repository must be used only on:

- localhost
- personal machines
- virtual machines
- containers
- Linux network namespaces
- explicitly authorized labs

Do not scan, test, probe, or monitor systems that you do not own or do not have permission to assess.

## Status

Initial public baseline created.

This repository will be expanded progressively with documented labs, command snippets, expected outputs, explanations, troubleshooting notes, and defensive security reports.

## Labs

- Lab 001 — Local System and Network Baseline
- Lab 002 — Local HTTP Server, curl, ss and tcpdump
- Lab 003 — Ports, Processes, Logs and Local Diagnostics
- Lab 004 — DNS, Routing and Connectivity Diagnostics
- Lab 005 — Network Namespace Client-Router-Server Topology
- Lab 006 — Firewall and NAT inside a Network Namespace Router
