# Lab 022 — Wireshark and TShark Packet Analysis

## Objective

The objective of this lab is to analyze a synthetic PCAP file with TShark and document the result in a safe local report.

This lab teaches:

```text
PCAP file concept
TShark requirement checking
synthetic packet generation
DNS and HTTP display filters
field extraction
privacy-safe packet analysis
defensive interpretation
report writing
```

## Safety boundary

This lab is local, defensive and synthetic.

It does not capture live traffic. It does not inspect third-party networks. It does not publish private traffic.

The capture file is generated locally by:

```text
scripts/tshark_lab022_generate_sample_pcap.py
```

The generated packet data uses fake lab addresses:

```text
10.10.10.10
10.10.10.20
10.10.10.53
```

## Files

This lab adds:

```text
docs/tools/WIRESHARK_TSHARK_PACKET_ANALYSIS.md
data/lab022/.gitkeep
scripts/tshark_lab022_check_requirements.sh
scripts/tshark_lab022_generate_sample_pcap.py
scripts/tshark_lab022_analyze_sample_pcap.sh
scripts/tshark_lab022_create_report.sh
reports/templates/lab_022_wireshark_tshark_packet_analysis_report_template.md
examples/lab_022_expected_outputs.txt
```

## Step 1 — Check requirements

```bash
./scripts/tshark_lab022_check_requirements.sh
```

Expected output may include:

```text
[OK] python3 found
[OK] tshark found
```

or:

```text
[WARN] tshark not found
```

Missing TShark is not a safety failure. The lab still generates a synthetic PCAP and explains what to run after installing TShark.

## Step 2 — Generate synthetic PCAP

```bash
./scripts/tshark_lab022_generate_sample_pcap.py
```

Expected output:

```text
[OK] Synthetic PCAP created: data/lab022/local_http_dns_sample.pcap
```

## Step 3 — Analyze the PCAP

```bash
./scripts/tshark_lab022_analyze_sample_pcap.sh
```

If TShark is installed, the script prints packet summaries and filtered DNS/HTTP views.

If TShark is missing, the script explains how to install it and exits safely.

## Step 4 — Create report

```bash
./scripts/tshark_lab022_create_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/lab022_tshark_packet_analysis_YYYYMMDD_HHMMSS.txt
```

## Safe TShark commands

```bash
tshark -r data/lab022/local_http_dns_sample.pcap
tshark -r data/lab022/local_http_dns_sample.pcap -Y "dns"
tshark -r data/lab022/local_http_dns_sample.pcap -Y "http"
tshark -r data/lab022/local_http_dns_sample.pcap -T fields -e frame.number -e ip.src -e ip.dst -e _ws.col.Protocol -e _ws.col.Info
```

## What this lab does not do

This lab does not:

```text
capture live traffic
read private network traffic
monitor Wi-Fi networks
collect credentials
inspect third-party systems
publish real packet captures
```

## Defensive interpretation

The expected synthetic traffic contains:

```text
a DNS query for lab.local
a DNS response for lab.local
an HTTP GET request
an HTTP 200 OK response
```

The correct analyst conclusion is:

```text
The capture contains controlled synthetic DNS and HTTP traffic.
The packets are suitable for learning filters and field extraction.
No real private traffic was collected.
```

## Common issues

### TShark not installed

On macOS:

```bash
brew install wireshark
```

Depending on installation method, the CLI binary may require shell restart.

On Debian/Ubuntu:

```bash
sudo apt install tshark
```

### No PCAP file found

Run:

```bash
./scripts/tshark_lab022_generate_sample_pcap.py
```

### Permission prompt during installation

Some platforms ask whether non-root users may capture packets. This lab does not require live capture.

## Final conclusion

The core chain is:

```text
synthetic PCAP
-> TShark read
-> DNS filter
-> HTTP filter
-> field extraction
-> local report
-> defensive interpretation
```

This lab introduces packet analysis without collecting real traffic.
