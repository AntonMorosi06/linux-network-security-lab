# Lynis Local Security Audit

## Purpose

This document introduces Lynis as a local defensive security auditing tool.

Lynis is commonly used to inspect Unix-like systems and produce hardening suggestions. It can be useful for learning because it groups checks into areas such as boot, kernel, users, authentication, file systems, networking, logging, malware defenses and hardening.

A Lynis report can contain sensitive local details. For this reason, this repository treats Lynis output as local/private until reviewed.

## Safety boundary

Allowed:

```text
checking whether Lynis is installed
printing Lynis version/help
running Lynis only on your own machine or VM
saving output locally
creating sanitized summaries
using synthetic findings for GitHub examples
```

Not allowed:

```text
running Lynis on machines you do not administer
publishing raw reports without review
publishing private hostnames, usernames or paths
publishing sensitive local configuration
claiming hardening is complete only because Lynis was run
```

## What Lynis can help with

A local Lynis audit may help identify:

```text
missing hardening settings
weak service configuration
logging gaps
file permission issues
authentication recommendations
kernel/system configuration warnings
package/update recommendations
```

## What Lynis does not replace

Lynis does not replace:

```text
threat modeling
manual review
patch management
secure configuration baselines
incident response
backup strategy
professional security assessment
```

## Safe command examples

Version/help only:

```bash
lynis --version
lynis show commands
```

Optional local audit, only on a system you own or administer:

```bash
RUN_LYNIS_LOCAL_AUDIT=yes ./scripts/lynis_lab029_run_local_audit.sh
```

The repository uses an environment variable confirmation so that a full audit is not launched accidentally.

## Publication review

Before publishing any Lynis output, remove or generalize:

```text
hostnames
usernames
internal paths
local package lists if sensitive
network interface details
service banners
security tool configuration
private logs
```

## Defensive interpretation

A good Lynis report should be interpreted as:

```text
a local hardening checklist
a starting point for investigation
a source of recommendations
not proof that a system is secure or insecure by itself
```

## Recommended report structure

```text
scope
machine type
audit date
tool version
raw output location
sanitized findings
risk grouping
next hardening actions
privacy review
```

## Final rule

Run Lynis only on systems you own or administer, keep raw output local, and publish only sanitized summaries.
