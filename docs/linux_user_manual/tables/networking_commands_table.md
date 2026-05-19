# Networking Commands Table

| Command | Purpose | Example | Expected output | Notes |
|---|---|---|---|---|
| `ip addr` | Show interfaces | `ip addr` | interface list | Linux |
| `ip route` | Show routes | `ip route` | default route | Linux |
| `ping` | Reachability | `ping -c 4 127.0.0.1` | replies/loss | Use authorized targets |
| `curl` | HTTP test | `curl -i http://127.0.0.1:8080` | HTTP response | Great for APIs |
| `ss` | Sockets/ports | `ss -tulpen` | listening ports | Linux |
| `lsof` | Open files/ports | `lsof -i -P -n` | process/port list | macOS/Linux |
| `dig` | DNS query | `dig example.com` | DNS records | May need install |
| `nslookup` | DNS query | `nslookup example.com` | DNS result | Common tool |
