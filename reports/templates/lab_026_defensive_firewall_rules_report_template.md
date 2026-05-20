# Lab 026 Report — Defensive Firewall Rules

## Analyst

```text
Name:
Date:
Machine:
OS:
Repository commit:
```

## Scope

```text
Read-only inspection:
Dry-run generation:
Rules applied: No
```

## Tools observed

| Tool | Present | Read-only output collected | Notes |
|---|---|---|---|
| nft |  |  |  |
| iptables |  |  |  |
| ufw |  |  |  |
| ss |  |  |  |
| pfctl |  |  |  |

## Generated dry-run files

```text
generated/lab026/nftables_dry_run_rules.nft
generated/lab026/iptables_dry_run_rules.sh
generated/lab026/ufw_dry_run_rules.sh
```

## Defensive rule model

```text
allow loopback
allow established/related
allow required admin access
allow required service ports
drop unexpected inbound traffic
```

## Safety review

```text
Were any rules applied? No.
Were any rules flushed? No.
Was SSH blocked? No.
Was the firewall modified? No.
Were dry-run files reviewed before any possible use? Pending.
```

## Defensive interpretation

```text
This lab demonstrates safe firewall planning and documentation without modifying system firewall state.
```

## Publication review

Before publishing, remove or generalize real admin IPs, internal network ranges and production service details.
