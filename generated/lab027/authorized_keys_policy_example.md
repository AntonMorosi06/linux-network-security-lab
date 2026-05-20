# authorized_keys Policy Example

## Purpose

This file describes how to review `authorized_keys` safely.

## Recommended checks

```text
one key per expected user/device
remove unknown keys
review comments at the end of keys
avoid sharing private keys
rotate old keys
use passphrases for private keys
restrict keys where appropriate
```

## Do not publish

```text
private keys
real usernames if sensitive
hostnames
internal comments
keys from production systems
```

## Example public key line format

```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA... labuser@example-lab
```

This is a format example only, not a real key.
