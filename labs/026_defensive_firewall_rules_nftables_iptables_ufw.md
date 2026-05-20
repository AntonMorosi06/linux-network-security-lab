# Lab 026 — Defensive Firewall Rules with nftables, iptables and ufw

## Objective

The objective of this lab is to understand defensive firewall rule design without modifying the system firewall.

This lab performs read-only inspection and generates dry-run firewall rule examples for `nftables`, `iptables` and `ufw`.

It does not apply firewall rules. It does not flush rules. It does not block ports. It does not modify the machine firewall.

## Safety boundary

Allowed:

```text
checking whether firewall tools exist
read-only firewall inspection
socket inventory
dry-run rule generation
report writing
```

Not allowed:

```text
applying firewall rules automatically
flushing existing rules
blocking SSH or other admin access
changing production firewall state
using sudo to apply unreviewed rules
```

## Files

This lab adds:

```text
docs/tools/DEFENSIVE_FIREWALL_RULES_NFTABLES_IPTABLES_UFW.md
scripts/firewall_lab026_check_requirements.sh
scripts/firewall_lab026_inspect_readonly.sh
scripts/firewall_lab026_generate_dry_run_rules.sh
scripts/firewall_lab026_create_report.sh
examples/lab_026_expected_outputs.txt
reports/templates/lab_026_defensive_firewall_rules_report_template.md
```

## Step 1 — Check requirements

```bash
./scripts/firewall_lab026_check_requirements.sh
```

Expected output may include:

```text
[OK] found: nft
[OK] found: iptables
[OK] found: ufw
```

or warnings if tools are not installed.

Missing tools are not lab failures because this lab is conceptual and read-only.

## Step 2 — Read-only inspection

```bash
./scripts/firewall_lab026_inspect_readonly.sh
```

The script attempts read-only inspection only. It may print:

```text
nft not found
iptables not found
ufw not found
pfctl available on macOS
```

On macOS, Linux firewall tools may not exist. That is normal.

## Step 3 — Generate dry-run rules

```bash
./scripts/firewall_lab026_generate_dry_run_rules.sh
```

This creates dry-run files under:

```text
generated/lab026/
```

The generated files are examples only. They are not applied.

## Step 4 — Create report

```bash
./scripts/firewall_lab026_create_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/lab026_defensive_firewall_rules_YYYYMMDD_HHMMSS.txt
```

## Defensive rule design model

A basic defensive firewall design often follows this order:

```text
1. allow loopback
2. allow established/related traffic
3. allow required admin access
4. allow required service ports
5. log or count unexpected traffic
6. drop everything else
```

## What this lab does not do

This lab does not:

```text
run nft -f
run iptables -A on the system
run ufw enable
flush existing rules
block ports
change remote access
```

## Common issues

### nft/iptables/ufw not found

On macOS, this is normal. macOS uses a different firewall stack.

On Linux, install only inside a lab environment if needed.

### Permission denied during inspection

Some read-only firewall commands require elevated privileges. The script does not force sudo changes. Document the limitation in the report.

### Fear of breaking the machine

That is exactly why this lab is dry-run only.

## Final conclusion

This lab teaches firewall reasoning, not blind firewall modification.

The safe chain is:

```text
inspect
document
generate dry-run examples
review
write report
do not apply automatically
```
