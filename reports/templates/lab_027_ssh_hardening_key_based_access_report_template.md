# Lab 027 Report — SSH Hardening and Key-Based Access

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
Read-only SSH inspection:
Dry-run config generation:
Real SSH configuration modified: No
sshd restarted: No
Password login disabled: No
```

## Tools observed

| Tool | Present | Notes |
|---|---|---|
| ssh |  |  |
| ssh-keygen |  |  |
| ssh-agent |  |  |
| ssh-add |  |  |
| sshd |  |  |

## Local SSH file review

Do not paste private key contents.

| File type | Present | Permission | Safe to publish? |
|---|---|---|---|
| private key |  |  | No |
| public key |  |  | Usually yes, review comments |
| known_hosts |  |  | Review before publishing |
| config |  |  | Review before publishing |

## Generated dry-run files

```text
generated/lab027/ssh_client_config_example
generated/lab027/sshd_config_hardening_example.conf
generated/lab027/authorized_keys_policy_example.md
```

## Safety review

```text
Were real SSH settings modified? No.
Was sshd restarted? No.
Was password login disabled? No.
Were private keys printed? No.
Were third-party hosts tested? No.
```

## Defensive interpretation

```text
This lab demonstrates SSH hardening planning and key-based access concepts without modifying real access.
```

## Publication review

Before publishing, remove private keys, private hostnames, real infrastructure comments, known_hosts entries and usernames if sensitive.
