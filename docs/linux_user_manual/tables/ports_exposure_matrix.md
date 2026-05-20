# Ports and Exposure Matrix

| Listener form | Meaning | Risk | Lab interpretation |
|---|---|---|---|
| `127.0.0.1:PORT` | IPv4 loopback only | Low | Preferred for local services |
| `localhost:PORT` | name usually resolving to loopback | Low | Good for local testing |
| `0.0.0.0:PORT` | all IPv4 interfaces | Higher | Review exposure |
| `::1:PORT` | IPv6 loopback | Low | Safe local IPv6 |
| `[::]:PORT` | all IPv6 interfaces | Higher | Review IPv6 exposure |
| Docker `127.0.0.1:8800:8800` | host loopback to container | Low | Preferred Docker mapping |
| Docker `8800:8800` | may bind broadly | Medium/Higher | Review with `docker ps` |
| internal Compose service | reachable inside Docker network | Low externally | Good backend pattern |
