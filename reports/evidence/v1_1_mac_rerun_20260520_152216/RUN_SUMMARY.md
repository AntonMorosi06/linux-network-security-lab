# v1.1 macOS Rerun Evidence — Labs 021-030

Date: 2026-05-20 13:26:29 UTC

This folder contains sanitized evidence from a macOS rerun of the v1.1 Labs 021-030 sequence in the `linux-network-security-lab` repository.

## Scope

The run used:

```bash
./scripts/run_safe_v11_labs_021_030.sh
```

Optional sudo tcpdump was enabled only if the environment variable below was used:

```bash
RUN_TCPDUMP_SUDO=yes
```

## Result

The run produced local reports under:

```text
~/linux_lab/reports/
```

This evidence folder contains sanitized copies only.

## Platform

The run was performed on macOS. Some Linux-specific tools may still be unavailable on macOS even after Homebrew installation. That is expected for tools such as:

```text
nft
iptables
ufw
auditctl
ausearch
aureport
systemctl
journalctl
```

Those tools are better tested inside an Ubuntu VM.

## Safety notes

No third-party hosts were scanned.

No Wi-Fi network was attacked.

No wireless traffic was captured.

No firewall rules were applied.

No SSH configuration was modified.

No auditd rules were loaded.

No real Fail2ban configuration was modified.

No raw private outputs were committed.

## Sanitization

Common local identifiers were replaced, long Nmap fingerprint blocks were removed, and detailed local listening-process output was redacted.

Raw reports remain local and should not be committed without review.

## Evidence files

See:

```text
EVIDENCE_MANIFEST.json
```
