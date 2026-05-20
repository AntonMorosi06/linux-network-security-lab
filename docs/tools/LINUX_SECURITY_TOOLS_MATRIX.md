# Linux Security Tools Matrix

This matrix summarizes tools for Phase v1.1 of the repository.

| Tool | Category | Safe GitHub use | Avoid |
|---|---|---|---|
| `tcpdump` | packet capture | localhost, lab interfaces, generated traffic, sample PCAP | capturing third-party/private traffic |
| Wireshark | packet analysis | offline PCAP review, local lab traffic | publishing private captures |
| `tshark` | CLI packet analysis | reading sample PCAP files with filters | live capture from unauthorized networks |
| `nmap` | network discovery | `127.0.0.1`, own VM, own container, authorized lab | scanning public/third-party systems |
| Aircrack-ng | wireless security awareness | help/version review, authorized lab notes, sample PCAP concepts | Wi-Fi cracking instructions or unauthorized access |
| `nft` | firewall | local defensive rules and inspection | blocking systems you do not administer |
| `iptables` | firewall | local lab filtering and inspection | production changes without review |
| `ufw` | firewall frontend | simple local firewall policy | unsafe remote lockout |
| SSH | remote access | key-based local/VM access, hardening notes | credential sharing or brute force |
| auditd | host audit | local event auditing | collecting private user data unnecessarily |
| Lynis | local audit | own machine or VM hardening audit | publishing sensitive audit output without review |
| Fail2ban | log-based protection | local SSH/API logs, controlled auth failures | using real third-party logs |
| OpenSSL | TLS and crypto | self-signed certs, local TLS inspection | exposing private keys |
| GPG | signing/integrity | test files, detached signatures | publishing private keys |
| Zeek | network security monitoring | sample PCAP analysis | monitoring unauthorized traffic |
| Suricata | IDS/IPS | sample PCAP rules and alerts | deploying intrusive monitoring without permission |

## Risk levels

| Risk | Meaning |
|---|---|
| Low | tool mostly reads local files or prints local information |
| Medium | tool can inspect network/service state and must be scoped |
| High | tool can be dual-use and must be restricted to authorized labs |
| Sensitive | output may contain private information and must be reviewed before publishing |

## Reporting questions

For each tool, the report should answer:

```text
What did the tool inspect?
Was the target local or authorized?
What output was expected?
What did the output mean?
What risk does this tool have?
What should be reviewed before publication?
What defensive lesson was learned?
```
