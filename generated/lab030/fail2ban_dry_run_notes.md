# Lab 030 Fail2ban Dry-Run Notes

## Safety

These files are examples only.

They were not installed into `/etc/fail2ban`.
No service was restarted.
No IP address was banned.

## Defensive model

```text
synthetic auth log
-> failregex
-> count failed attempts
-> compare with maxretry
-> report finding
```

## Before real deployment

Document:

```text
system owner
service being protected
log path
filter regex
jail settings
rollback plan
false positive risk
admin access plan
```

## Privacy warning

Do not publish real authentication logs without sanitization.
