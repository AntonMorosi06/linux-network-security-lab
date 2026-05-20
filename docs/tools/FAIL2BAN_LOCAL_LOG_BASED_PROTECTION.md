# Fail2ban Local Log-Based Protection

## Purpose

This document introduces Fail2ban as a defensive log-based protection tool.

Fail2ban watches log files, matches suspicious patterns and can apply actions such as temporary bans. Because real Fail2ban actions can block access, Lab 030 is intentionally designed with synthetic logs and dry-run configuration examples only.

This repository does not install Fail2ban, does not start or restart the service, does not modify `/etc/fail2ban`, and does not ban IP addresses.

## Safety boundary

Allowed:

```text
checking whether fail2ban-client exists
generating synthetic authentication logs
detecting repeated failed-login patterns in synthetic logs
generating dry-run filter and jail examples
writing a defensive report
```

Not allowed:

```text
modifying /etc/fail2ban
starting/stopping/restarting fail2ban
banning real IP addresses
testing against real login services
publishing real authentication logs
brute forcing services
```

## Main concepts

| Concept | Meaning |
|---|---|
| filter | regex pattern that detects suspicious log lines |
| jail | configuration linking filter, log path, ports, retry threshold and ban action |
| maxretry | number of failures before action |
| findtime | time window for counting failures |
| bantime | duration of a ban |
| action | what Fail2ban does after detection |
| fail2ban-client | command-line tool for interacting with Fail2ban |

## Synthetic log model

This lab uses fake authentication log lines such as:

```text
Failed password for invalid user admin from 192.0.2.50 port 53310 ssh2
Accepted publickey for labuser from 192.0.2.10 port 53311 ssh2
```

The IP ranges used in this lab are documentation/example ranges. They are not real targets.

## Defensive interpretation

A Fail2ban-style finding should answer:

```text
Which log lines matched?
Which source IP appeared repeatedly?
How many failures occurred?
Was there a successful login?
Would the threshold have been exceeded?
What action would be recommended?
Was any real service touched?
```

## Publication warning

Do not publish real authentication logs without review. They may contain:

```text
usernames
source IPs
hostnames
service names
timestamps
internal infrastructure details
```

## Correct wording

Correct:

```text
This lab uses synthetic authentication logs to explain Fail2ban-style detection and defensive reporting.
```

Incorrect:

```text
This lab brute-forces SSH and bans attackers.
```

## Final rule

Use synthetic logs for GitHub examples. Use real Fail2ban only on systems you own or administer, with a rollback plan.
