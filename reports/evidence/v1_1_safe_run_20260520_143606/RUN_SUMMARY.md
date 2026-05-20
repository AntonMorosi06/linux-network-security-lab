# v1.1 Safe Run Evidence — Labs 021-030

Date: 2026-05-20 12:36:07 UTC

This folder contains sanitized evidence from the safe execution of Labs 021-030 in the `linux-network-security-lab` repository.

## Scope

The run was performed on a local machine using:

```bash
./scripts/run_safe_v11_labs_021_030.sh
```

## Result

The safe v1.1 runner completed the Labs 021-030 sequence and generated local reports under:

```text
~/linux_lab/reports/
```

This evidence folder contains sanitized copies only.

## Important platform notes

The run was performed on macOS. Some Linux-specific or optional tools may be missing on macOS. That is expected and not treated as a lab failure.

Examples of optional/Linux-oriented tools that may be unavailable on macOS:

```text
tshark
aircrack-ng
airmon-ng
airodump-ng
nft
iptables
ufw
auditctl
ausearch
aureport
systemctl
journalctl
lynis
fail2ban-client
zeek
suricata
```

## Safety notes

No third-party hosts were scanned.

No Wi-Fi network was attacked.

No wireless traffic was captured.

No real Fail2ban configuration was modified.

No firewall rules were applied.

No SSH configuration was modified.

No auditd rules were loaded.

No real Lynis audit was forced.

No private keys were printed.

No raw private outputs were committed.

## Sanitization

The sanitization step replaced common local identifiers, removed long Nmap fingerprint blocks, and redacted detailed local listening-process output.

Raw reports remain local and should not be committed without review.

## Evidence files

See:

```text
EVIDENCE_MANIFEST.json
```
