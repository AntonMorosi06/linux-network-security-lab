# Lab 028 auditd Dry-Run Rules Explanation

## Important safety note

These rules are not applied by the repository.

Do not load them on a real system without review. Audit rules can generate sensitive logs and large event volumes.

## Rule explanations

| Rule key | Purpose |
|---|---|
| `identity_changes` | detects changes to files related to local users/groups |
| `credential_store_changes` | detects changes to sensitive credential database files |
| `privilege_policy_changes` | detects changes to sudo policy |
| `ssh_config_changes` | detects SSH daemon configuration changes |
| `command_execution` | detects command execution events; can be noisy and privacy-sensitive |

## Privacy warning

Real audit data may include usernames, commands, process arguments, paths, hostnames and authentication details. Do not publish raw logs without review.

## Example search concepts

```text
ausearch -k identity_changes
ausearch -k ssh_config_changes
aureport -x
```

These are conceptual examples. This repository does not run them against real logs automatically.
