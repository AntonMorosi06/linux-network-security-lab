# Lab 025 Report — tcpdump Advanced Capture Filters

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
Interface:
Filter:
Target:
Port:
Capture file:
```

## Commands executed

```bash
./scripts/tcpdump_lab025_check_requirements.sh
./scripts/tcpdump_lab025_capture_loopback.sh
./scripts/tcpdump_lab025_create_report.sh
```

## Findings

| Item | Value |
|---|---|
| Local service port | 8090 |
| Interface |  |
| Capture filter | tcp port 8090 and host 127.0.0.1 |
| Packets captured |  |
| Third-party traffic included | No |

## Safety review

```text
Was traffic limited to loopback? Yes.
Was any Wi-Fi traffic captured? No.
Was any third-party traffic captured? No.
Were credentials collected? No.
Was the PCAP reviewed before publication? Pending.
```

## Defensive interpretation

```text
The capture demonstrates narrow-scope packet capture for local troubleshooting.
```

## Publication review

Before publishing, confirm that the PCAP/output contains only local lab traffic and no private data.
