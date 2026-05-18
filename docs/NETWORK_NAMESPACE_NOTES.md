# Network Namespace Notes

## What is a network namespace?

A Linux network namespace is an isolated networking environment inside the same Linux kernel.

Each network namespace can have its own:

- interfaces
- IP addresses
- routing table
- firewall rules
- loopback interface
- sockets
- network configuration

This makes network namespaces useful for safe local labs.

## Why use network namespaces?

Network namespaces allow simulation of multiple hosts without creating full virtual machines.

They are useful for learning:

- routing
- network segmentation
- virtual Ethernet links
- firewalling
- NAT
- packet capture
- service exposure
- troubleshooting

## veth pair

A veth pair is a virtual Ethernet cable.

When two interfaces are created as a pair, packets entering one side leave the other side.

Example:

```bash
sudo ip link add veth_client type veth peer name veth_router_client
```

This creates two linked virtual interfaces:

```text
veth_client <-> veth_router_client
```

## Namespace topology

The Lab 005 topology is:

```text
lab_client -> lab_router -> lab_server
```

With IP addresses:

```text
lab_client: 10.10.1.2/24
lab_router client side: 10.10.1.1/24
lab_router server side: 10.10.2.1/24
lab_server: 10.10.2.2/24
```

## Routing

The client uses the router as default gateway:

```bash
sudo ip netns exec lab_client ip route add default via 10.10.1.1
```

The server uses the router as default gateway:

```bash
sudo ip netns exec lab_server ip route add default via 10.10.2.1
```

## IP forwarding

For the router namespace to forward packets between its interfaces:

```bash
sudo ip netns exec lab_router sysctl -w net.ipv4.ip_forward=1
```

Without IP forwarding, the router namespace has addresses on both networks but will not route packets between them.

## Packet capture

Traffic can be observed from the router namespace:

```bash
sudo ip netns exec lab_router tcpdump -i veth_router_server port 8080
```

This simulates observing traffic at an intermediate network device.

## Defensive value

Network namespaces are safe and useful for defensive cybersecurity because they make it possible to create controlled local scenarios:

- client-server communication
- routed networks
- blocked traffic
- firewall rules
- NAT
- latency simulation
- packet loss simulation
- logging and monitoring

## Cleanup

Always remove lab namespaces when finished:

```bash
./scripts/cleanup_namespace_client_router_server.sh
```

If namespaces remain active, they can keep virtual interfaces and lab state around.
