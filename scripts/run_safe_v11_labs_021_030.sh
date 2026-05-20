#!/usr/bin/env bash
# Safe runner for v1.1 labs 021-030.
#
# This script avoids forced sudo and does not run the gated real Lynis audit.
# It is intended for local, defensive execution only.

set -euo pipefail

echo "============================================================"
echo "[INFO] Running safe v1.1 labs 021-030"
echo "============================================================"

cd "$(dirname "$0")/.."

mkdir -p "$HOME/linux_lab/reports"
mkdir -p "$HOME/linux_lab/private_outputs"

run_optional() {
  echo ""
  echo "============================================================"
  echo "[RUN] $*"
  echo "============================================================"
  "$@" || {
    echo "[WARN] Command failed or optional tool missing: $*"
    echo "[INFO] Continuing safe runner."
  }
}

run_optional ./scripts/tools_lab021_inventory.sh
run_optional ./scripts/tools_lab021_create_report.sh

run_optional ./scripts/tshark_lab022_check_requirements.sh
run_optional ./scripts/tshark_lab022_generate_sample_pcap.py
run_optional ./scripts/tshark_lab022_analyze_sample_pcap.sh
run_optional ./scripts/tshark_lab022_create_report.sh

run_optional ./scripts/nmap_lab023_check_requirements.sh
if [ -x ./scripts/nmap_lab023_start_local_service.py ]; then
  python3 ./scripts/nmap_lab023_start_local_service.py > /tmp/lab023_service.log 2>&1 &
  LAB023_PID=$!
  sleep 1
  run_optional ./scripts/nmap_lab023_scan_localhost.sh
  run_optional ./scripts/nmap_lab023_create_report.sh
  kill "$LAB023_PID" 2>/dev/null || true
else
  echo "[WARN] Lab 023 service script not found or not executable."
fi

run_optional ./scripts/aircrack_lab024_check_requirements.sh
run_optional ./scripts/aircrack_lab024_help_inventory.sh
run_optional ./scripts/aircrack_lab024_create_report.sh

run_optional ./scripts/tcpdump_lab025_check_requirements.sh
run_optional ./scripts/tcpdump_lab025_capture_loopback.sh
run_optional ./scripts/tcpdump_lab025_create_report.sh

run_optional ./scripts/firewall_lab026_check_requirements.sh
run_optional ./scripts/firewall_lab026_inspect_readonly.sh
run_optional ./scripts/firewall_lab026_generate_dry_run_rules.sh
run_optional ./scripts/firewall_lab026_create_report.sh

run_optional ./scripts/ssh_lab027_check_requirements.sh
run_optional ./scripts/ssh_lab027_inspect_readonly.sh
run_optional ./scripts/ssh_lab027_generate_dry_run_config.sh
run_optional ./scripts/ssh_lab027_create_report.sh

run_optional ./scripts/auditd_lab028_check_requirements.sh
run_optional ./scripts/auditd_lab028_inspect_readonly.sh
run_optional ./scripts/auditd_lab028_generate_dry_run_rules.sh
run_optional ./scripts/auditd_lab028_create_synthetic_events.py
run_optional ./scripts/auditd_lab028_create_report.sh

run_optional ./scripts/lynis_lab029_check_requirements.sh
run_optional ./scripts/lynis_lab029_create_synthetic_findings.py
run_optional ./scripts/lynis_lab029_create_report.sh

run_optional ./scripts/fail2ban_lab030_check_requirements.sh
run_optional ./scripts/fail2ban_lab030_generate_synthetic_auth_log.py
run_optional ./scripts/fail2ban_lab030_analyze_synthetic_auth_log.py
run_optional ./scripts/fail2ban_lab030_generate_dry_run_config.sh
run_optional ./scripts/fail2ban_lab030_create_report.sh

echo ""
echo "============================================================"
echo "[OK] Safe v1.1 labs 021-030 completed"
echo "============================================================"
echo "[INFO] Reports:"
find "$HOME/linux_lab/reports" -type f | sort | tail -n 30 || true
