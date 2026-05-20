#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="generated/lab026"
mkdir -p "$OUT_DIR"

NFT_FILE="$OUT_DIR/nftables_dry_run_rules.nft"
IPTABLES_FILE="$OUT_DIR/iptables_dry_run_rules.sh"
UFW_FILE="$OUT_DIR/ufw_dry_run_rules.sh"

cat > "$NFT_FILE" <<'RULES'
# Lab 026 nftables dry-run example
# DO NOT APPLY WITHOUT REVIEW.
# This file is generated for documentation only.

table inet lab_filter {
  chain input {
    type filter hook input priority 0; policy drop;

    # Always allow loopback.
    iif "lo" accept

    # Allow established/related traffic.
    ct state established,related accept

    # Example documentation IP from RFC 5737, not a real trusted admin IP.
    tcp dport 22 ip saddr 192.0.2.10 accept

    # Example web service ports.
    tcp dport { 80, 443 } accept

    # Count and drop everything else.
    counter drop
  }
}
RULES

cat > "$IPTABLES_FILE" <<'RULES'
#!/usr/bin/env bash
# Lab 026 iptables dry-run example
# DO NOT RUN WITHOUT REVIEW.
# This file is generated for documentation only.

echo "DRY RUN ONLY — these commands are not executed automatically."

cat <<'COMMANDS'
iptables -P INPUT DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -s 192.0.2.10 -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -j DROP
COMMANDS
RULES

cat > "$UFW_FILE" <<'RULES'
#!/usr/bin/env bash
# Lab 026 ufw dry-run example
# DO NOT RUN WITHOUT REVIEW.
# This file is generated for documentation only.

echo "DRY RUN ONLY — these commands are not executed automatically."

cat <<'COMMANDS'
ufw default deny incoming
ufw default allow outgoing
ufw allow from 192.0.2.10 to any port 22 proto tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw status verbose
COMMANDS
RULES

chmod +x "$IPTABLES_FILE" "$UFW_FILE"

echo "[OK] Generated: $NFT_FILE"
echo "[OK] Generated: $IPTABLES_FILE"
echo "[OK] Generated: $UFW_FILE"
echo "[INFO] These files are examples only. They were not applied."
