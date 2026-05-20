# SSH Hardening and Key-Based Access

## Purpose

This document introduces SSH hardening from a defensive and local-administration perspective.

SSH is a remote administration protocol. Hardening SSH is important, but mistakes can lock a user out of a machine. For this reason, Lab 027 is intentionally designed as read-only inspection plus dry-run configuration examples.

This repository does not modify `/etc/ssh/sshd_config`, does not restart `sshd`, does not disable password login automatically and does not delete keys.

## Safety boundary

Allowed:

```text
checking whether SSH client/server tools exist
reading local SSH client version
read-only inspection of user SSH directory names and permissions
generating example client config
generating example sshd_config hardening file
writing a defensive report
```

Not allowed:

```text
modifying real sshd_config automatically
restarting sshd automatically
disabling password login automatically
deleting keys
publishing private keys
publishing real hostnames or private IPs without review
brute forcing SSH
testing third-party hosts
```

## SSH key concepts

| Item | Meaning |
|---|---|
| private key | secret file that must never be published |
| public key | shareable key placed in `authorized_keys` |
| passphrase | protects the private key if the file is stolen |
| `authorized_keys` | server-side list of allowed public keys |
| `known_hosts` | client-side record of host keys previously seen |
| ssh-agent | helper that stores decrypted keys in memory |
| `sshd_config` | server-side OpenSSH daemon configuration |

## Recommended defensive settings

These are conceptual recommendations that must be tested in a safe environment before use:

```text
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
KbdInteractiveAuthentication no
X11Forwarding no
AllowTcpForwarding no, unless needed
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2
AllowUsers specific_user
```

Important: do not disable password authentication on a remote server until key-based login has been tested in a second active session.

## Safe client config example

```text
Host lab-vm
  HostName 127.0.0.1
  Port 2222
  User labuser
  IdentityFile ~/.ssh/lab_ed25519
  IdentitiesOnly yes
```

## Permissions checklist

Common SSH permission expectations:

```text
~/.ssh                  700
private key             600
public key              644
authorized_keys         600
known_hosts             644
```

## Publication warning

Never publish:

```text
private keys
real server IPs if sensitive
real usernames if sensitive
full known_hosts if it reveals private infrastructure
authorized_keys with identifiable comments
screenshots showing hostnames or private paths
```

## Defensive workflow

A safe SSH hardening workflow is:

```text
1. inventory current SSH tools and files
2. generate a new key in a lab if needed
3. add public key to authorized_keys in a lab
4. test key login in one session
5. keep a fallback session open
6. edit sshd_config manually after review
7. validate config syntax
8. restart sshd only when recovery is possible
9. document results
```

## Final rule

Hardening SSH is defensive, but it must be done carefully. A learning repository should generate examples and reports, not automatically change SSH access.
