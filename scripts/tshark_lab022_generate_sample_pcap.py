#!/usr/bin/env python3
"""
Generate a tiny synthetic PCAP for Lab 022.

The PCAP contains fake lab traffic only:
- DNS query: lab.local
- DNS response: lab.local -> 10.10.10.20
- HTTP GET /status
- HTTP 200 OK

No live traffic is captured.
No third-party data is used.
"""

from __future__ import annotations

import struct
import time
from pathlib import Path


OUT = Path("data/lab022/local_http_dns_sample.pcap")


def checksum(data: bytes) -> int:
    if len(data) % 2:
        data += b"\x00"
    total = 0
    for i in range(0, len(data), 2):
        total += (data[i] << 8) + data[i + 1]
        total = (total & 0xFFFF) + (total >> 16)
    return (~total) & 0xFFFF


def ip_to_bytes(ip: str) -> bytes:
    return bytes(int(part) for part in ip.split("."))


def eth_frame(payload: bytes) -> bytes:
    dst = bytes.fromhex("020000000020")
    src = bytes.fromhex("020000000010")
    ethertype = b"\x08\x00"
    return dst + src + ethertype + payload


def ipv4_packet(src: str, dst: str, proto: int, payload: bytes, ident: int) -> bytes:
    version_ihl = 0x45
    tos = 0
    total_length = 20 + len(payload)
    flags_fragment = 0
    ttl = 64
    header_checksum = 0
    header = struct.pack(
        "!BBHHHBBH4s4s",
        version_ihl,
        tos,
        total_length,
        ident,
        flags_fragment,
        ttl,
        proto,
        header_checksum,
        ip_to_bytes(src),
        ip_to_bytes(dst),
    )
    header_checksum = checksum(header)
    header = struct.pack(
        "!BBHHHBBH4s4s",
        version_ihl,
        tos,
        total_length,
        ident,
        flags_fragment,
        ttl,
        proto,
        header_checksum,
        ip_to_bytes(src),
        ip_to_bytes(dst),
    )
    return header + payload


def udp_segment(src_port: int, dst_port: int, payload: bytes) -> bytes:
    length = 8 + len(payload)
    checksum_zero = 0
    return struct.pack("!HHHH", src_port, dst_port, length, checksum_zero) + payload


def tcp_segment(src_port: int, dst_port: int, seq: int, ack: int, flags: int, payload: bytes) -> bytes:
    data_offset = 5 << 4
    window = 8192
    checksum_zero = 0
    urgent = 0
    return struct.pack(
        "!HHIIBBHHH",
        src_port,
        dst_port,
        seq,
        ack,
        data_offset,
        flags,
        window,
        checksum_zero,
        urgent,
    ) + payload


def dns_name(name: str) -> bytes:
    out = b""
    for label in name.split("."):
        out += bytes([len(label)]) + label.encode("ascii")
    return out + b"\x00"


def dns_query() -> bytes:
    transaction_id = 0x1234
    flags = 0x0100
    qdcount = 1
    header = struct.pack("!HHHHHH", transaction_id, flags, qdcount, 0, 0, 0)
    question = dns_name("lab.local") + struct.pack("!HH", 1, 1)
    return header + question


def dns_response() -> bytes:
    transaction_id = 0x1234
    flags = 0x8180
    header = struct.pack("!HHHHHH", transaction_id, flags, 1, 1, 0, 0)
    question = dns_name("lab.local") + struct.pack("!HH", 1, 1)
    answer = b"\xc0\x0c" + struct.pack("!HHIH", 1, 1, 60, 4) + ip_to_bytes("10.10.10.20")
    return header + question + answer


def packet_record(ts: float, frame: bytes) -> bytes:
    sec = int(ts)
    usec = int((ts - sec) * 1_000_000)
    return struct.pack("<IIII", sec, usec, len(frame), len(frame)) + frame


def main() -> None:
    OUT.parent.mkdir(parents=True, exist_ok=True)
    now = time.time()

    packets = []

    dns_q = udp_segment(53000, 53, dns_query())
    dns_q_ip = ipv4_packet("10.10.10.10", "10.10.10.53", 17, dns_q, 1)
    packets.append(packet_record(now + 0.0, eth_frame(dns_q_ip)))

    dns_r = udp_segment(53, 53000, dns_response())
    dns_r_ip = ipv4_packet("10.10.10.53", "10.10.10.10", 17, dns_r, 2)
    packets.append(packet_record(now + 0.1, eth_frame(dns_r_ip)))

    http_get = b"GET /status HTTP/1.1\r\nHost: lab.local\r\nUser-Agent: lab022\r\n\r\n"
    tcp_get = tcp_segment(54000, 80, 1, 1, 0x18, http_get)
    tcp_get_ip = ipv4_packet("10.10.10.10", "10.10.10.20", 6, tcp_get, 3)
    packets.append(packet_record(now + 0.2, eth_frame(tcp_get_ip)))

    http_ok = b"HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nContent-Length: 2\r\n\r\nOK"
    tcp_ok = tcp_segment(80, 54000, 1, len(http_get) + 1, 0x18, http_ok)
    tcp_ok_ip = ipv4_packet("10.10.10.20", "10.10.10.10", 6, tcp_ok, 4)
    packets.append(packet_record(now + 0.3, eth_frame(tcp_ok_ip)))

    global_header = struct.pack("<IHHIIII", 0xA1B2C3D4, 2, 4, 0, 0, 65535, 1)

    OUT.write_bytes(global_header + b"".join(packets))

    print(f"[OK] Synthetic PCAP created: {OUT}")
    print("[INFO] Packets written: 4")
    print("[INFO] This file contains fake lab DNS/HTTP traffic only.")


if __name__ == "__main__":
    main()
