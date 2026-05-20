#!/usr/bin/env bash
# Lab 026 iptables dry-run example
# DO NOT RUN WITHOUT REVIEW.
# This file is generated for documentation only.

echo "DRY RUN ONLY — these commands are not executed automatically."

cat <<'COMMANDS'
iptables -P INPUT DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -s 192.0.2.10 -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -j DROP
COMMANDS
