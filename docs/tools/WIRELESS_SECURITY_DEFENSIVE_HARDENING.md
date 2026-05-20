# Wireless Security Defensive Hardening

## Purpose

This document turns Lab 024 into a defensive learning exercise.

The point of studying wireless security tools is to understand the risk model and improve configuration, not to attack networks.

## Defensive checklist

| Area | Recommendation | Reason |
|---|---|---|
| Encryption | Use WPA2-Personal/AES or WPA3 where available | Older/weak configurations are easier to abuse |
| Passphrase | Use a long random passphrase | Short or reused passphrases are weak |
| WPS | Disable WPS if not needed | WPS can increase attack surface |
| Router admin | Change default admin password | Default credentials are unsafe |
| Firmware | Keep router firmware updated | Updates fix vulnerabilities |
| Guest network | Use guest network for visitors/IoT | Reduces access to trusted devices |
| SSID | Avoid revealing personal information in SSID | Reduces unnecessary exposure |
| Client review | Review connected devices periodically | Detects unknown devices |
| Physical access | Protect router from unauthorized access | Local access can bypass assumptions |
| Documentation | Record authorization before testing | Prevents unsafe or illegal testing |

## Safe home-lab model

A safe wireless lab must be:

```text
owned by the learner
isolated from neighbors and public users
documented before testing
limited to training traffic
free of private third-party data
stopped after testing
```

## What to document

A defensive wireless report can document:

```text
router model
firmware version
encryption mode
WPS status
guest network status
admin password changed yes/no
testing authorization
hardening recommendations
```

Do not publish:

```text
real SSID if it identifies a person or home
BSSID/MAC addresses of nearby networks
captures from real users
passwords
router admin URLs with credentials
private screenshots
```

## Defensive conclusion

A good wireless security lab ends with safer configuration, clearer documentation and explicit authorization boundaries.
