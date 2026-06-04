# File-by-File Safety Review — v1.1 macOS Rerun Evidence

Evidence bundle:

```text
reports/evidence/v1_1_mac_rerun_20260520_152216
```

Review date: 2026-06-04

Review type: targeted file-by-file safety pass over sanitized v1.1 evidence outputs

## Review Scope

This review focuses on the highest-risk sanitized evidence files in the v1.1 macOS rerun bundle:

- Nmap output
- Aircrack-ng awareness output
- SSH inspection output
- auditd-style auditing output
- Lynis-style audit output
- Fail2ban-style log protection output

A repository-level sensitive-pattern search was also performed for common risky terms such as passwords, tokens, secrets, private keys, credentials and AWS-style key prefixes. No matching results were returned by the GitHub search connector during this pass.

## Important Limitation

This review is a practical safety review of the committed sanitized evidence. It is not a cryptographic guarantee that no possible sensitive string exists anywhere in the repository. However, the reviewed files and manifest strongly support the conclusion that the v1.1 evidence bundle is publication-safe for the current portfolio stage.

## Reviewed Files

| File | Main risk checked | Result |
|---|---|---|
| `lab023_nmap_localhost_authorized_scanning_20260520_152421_SANITIZED.txt` | External scanning, unauthorized target, long service fingerprint leakage | Safe. Target is `127.0.0.1`; report states local authorization and no third-party target. Long Nmap fingerprint block is redacted. |
| `lab024_aircrack_ng_wireless_security_awareness_20260520_152623_SANITIZED.txt` | Wi-Fi attack workflow, capture, deauth, handshake collection, password cracking | Safe with caution. File contains tool help output, but explicitly states no live wireless testing, no network targeted, no capture, no deauth, no handshakes and no password cracking. |
| `lab027_ssh_hardening_key_based_access_20260520_152628_SANITIZED.txt` | Private key exposure, SSH configuration changes | Safe. File states no private key contents were printed, no SSH configuration was modified and no daemon was restarted. |
| `lab028_auditd_linux_event_auditing_20260520_152628_SANITIZED.txt` | Real audit log collection, real user activity exposure | Safe. File states no audit rules were loaded, no real audit logs were read, no real user activity was collected and generated events are synthetic. |
| `lab029_lynis_local_security_audit_20260520_152628_SANITIZED.txt` | Raw system audit exposure | Safe. File uses synthetic findings by default and states real Lynis output must remain private until sanitized. |
| `lab030_fail2ban_local_log_based_protection_20260520_152628_SANITIZED.txt` | Raw authentication logs, real IP bans, service modification | Safe. File states synthetic auth logs only, no real authentication logs, no Fail2ban modification, no service restart and no IP banned. |

## Detailed Findings

### Nmap evidence

The reviewed Nmap evidence is scoped to localhost only. The file states:

```text
Target: 127.0.0.1
Authorization: local machine / lab service
No third-party target.
```

The Nmap command uses `127.0.0.1`, and the report states that no third-party system was scanned and no exploitation or credential collection was performed.

Decision: safe for portfolio evidence.

### Aircrack-ng evidence

The Aircrack-ng evidence is the highest-risk topic because the tool family is commonly associated with wireless assessment. In this bundle, the evidence is limited to help/version awareness output. The file explicitly states:

```text
No live wireless testing.
No third-party networks.
No network was targeted.
No capture was performed.
No deauthentication was performed.
No handshakes were collected.
No password cracking was performed.
```

Decision: acceptable as awareness-only evidence, but keep the existing cautionary framing in README and limitations files.

### SSH evidence

The SSH evidence is read-only and dry-run. It reports tool availability and generated example configuration files, but explicitly states that private key contents were not printed, no SSH config was modified and no daemon was restarted.

Decision: safe for portfolio evidence.

### auditd evidence

The auditd evidence is based on read-only inspection, dry-run rules and synthetic events. The file explicitly states that no audit rules were loaded, no real audit logs were read and no real user activity was collected.

Decision: safe for portfolio evidence.

### Lynis evidence

The Lynis evidence uses synthetic findings by default. The file explicitly states that no real Lynis output was read and that real Lynis output must be reviewed and sanitized before publication.

Decision: safe for portfolio evidence.

### Fail2ban evidence

The Fail2ban evidence uses synthetic authentication logs. The file explicitly states that no real authentication logs were read, no Fail2ban configuration was applied, no service was restarted and no IP address was banned.

Decision: safe for portfolio evidence.

## Evidence Checklist Outcome

| Requirement | Result |
|---|---|
| Evidence contains no obvious secrets from targeted review | Pass |
| Evidence contains no private keys in reviewed files | Pass |
| Evidence contains no raw authentication logs in reviewed files | Pass |
| Evidence contains no private screenshots in reviewed files | Pass; reviewed bundle evidence is text/manifest-based in this pass |
| Evidence states local/synthetic/authorized scope | Pass |
| Evidence explains what the run proves | Pass |

## Remaining Caution

Before creating a final GitHub release tag, one last repository-wide check is still recommended:

1. Check all files under `reports/evidence/` for accidental private screenshots or binary artifacts.
2. Confirm that no raw PCAPs or raw logs were added outside the reviewed bundle.
3. Confirm that `git status` is clean locally before tagging.
4. Confirm that the README and release notes still describe the repository as defensive/local/authorized only.

## Final Decision

```text
The reviewed v1.1 macOS rerun evidence bundle is acceptable for portfolio-stage publication. The highest-risk sanitized evidence files were checked and found consistent with the repository's defensive, local and authorized safety model.
```
