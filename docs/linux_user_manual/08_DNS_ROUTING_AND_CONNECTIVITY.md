# DNS, Routing and Connectivity

DNS converts names into IP addresses. Routing decides where packets should go.

## DNS commands

```bash
nslookup example.com
dig example.com
cat /etc/resolv.conf
```

## Routing commands

```bash
ip route
ip addr
ping -c 4 8.8.8.8
ping -c 4 example.com
```

## Diagnostic logic

If `ping 8.8.8.8` works but `ping example.com` fails, DNS may be the problem.

If both fail, routing, firewall or connectivity may be the problem.

## Safe use

Use known safe test targets or local lab addresses. Avoid testing third-party networks aggressively.
