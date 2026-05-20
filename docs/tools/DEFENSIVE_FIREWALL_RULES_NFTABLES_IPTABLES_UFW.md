# Defensive Firewall Rules — nftables, iptables and ufw

## Purpose

This document introduces defensive firewall reasoning on Linux.

A firewall rule is powerful because it can allow, deny, log or shape traffic. A mistake can also lock the user out of a machine or break a local service. For this reason, Lab 026 is intentionally designed as read-only inspection plus dry-run rule generation.

This repository does not apply firewall rules automatically.

## Tools

| Tool | Role |
|---|---|
| `nft` | modern Linux packet filtering interface for nftables |
| `iptables` | legacy/classic Linux packet filtering interface |
| `ufw` | simplified firewall frontend commonly used on Ubuntu |
| `pfctl` | macOS packet filter inspection tool, included only as read-only awareness |
| `ss` | socket inspection, useful before deciding firewall rules |
| `ip` | address and route inspection on Linux |

## Safety boundary

Allowed:

```text
read-only firewall inspection
listing current rules
checking whether tools exist
generating dry-run rule examples
writing reports
learning default-deny vs allow-list concepts
```

Not allowed:

```text
flushing firewall rules
applying rules automatically
blocking SSH on a remote system
changing production firewall policy
locking yourself out
running unreviewed firewall scripts with sudo
```

## Core defensive concepts

### Default allow

A default allow policy permits traffic unless a rule blocks it. It is easier to use but can expose services accidentally.

### Default deny

A default deny policy blocks traffic unless a rule allows it. It is more defensive but must be planned carefully, especially on remote systems.

### Allow-list

An allow-list explicitly permits only known required traffic.

Example concept:

```text
allow loopback
allow established/related
allow SSH only from trusted admin IP
allow HTTP/HTTPS if this is a web server
drop everything else
```

### Loopback rule

Loopback traffic is internal to the machine. Blocking loopback can break local services.

### Established/related rule

This allows replies for connections that were already allowed.

## Safe dry-run examples

nftables conceptual example:

```text
table inet lab_filter {
  chain input {
    type filter hook input priority 0; policy drop;
    iif "lo" accept
    ct state established,related accept
    tcp dport 22 ip saddr 192.0.2.10 accept
    tcp dport { 80, 443 } accept
    counter drop
  }
}
```

iptables conceptual example:

```text
iptables -P INPUT DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -s 192.0.2.10 -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 80,443 -j ACCEPT
```

ufw conceptual example:

```text
ufw default deny incoming
ufw default allow outgoing
ufw allow from 192.0.2.10 to any port 22 proto tcp
ufw allow 80/tcp
ufw allow 443/tcp
```

These examples are not applied by this repository.

## Documentation checklist

Before applying firewall rules in a real environment, document:

```text
machine type
local or remote
current open ports
critical services
admin access method
rollback method
maintenance window
rules to apply
expected effect
test plan
recovery plan
```

## Publication warning

Do not publish:

```text
real trusted admin IPs
internal network diagrams
production firewall rules
public server banners
private hostnames
sensitive allow-lists
```

## Final rule

Never apply firewall rules automatically from a learning repository. Generate, review, understand, backup and test in a safe local environment first.
