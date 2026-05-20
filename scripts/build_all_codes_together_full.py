#!/usr/bin/env python3
"""
Build complete command/code documentation for linux-network-security-lab.

This script reads every Markdown lab file under labs/, extracts fenced
code blocks, and creates:

- docs/ALL_CODES_TOGETHER_FULL.md
- docs/ALL_CODES_TOGETHER_FULL.txt
- docs/COMMAND_INDEX_001_030.md

It does not execute lab commands.
"""

from __future__ import annotations

import re
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path


ROOT = Path(".")
LABS_DIR = ROOT / "labs"
DOCS_DIR = ROOT / "docs"

FULL_MD = DOCS_DIR / "ALL_CODES_TOGETHER_FULL.md"
FULL_TXT = DOCS_DIR / "ALL_CODES_TOGETHER_FULL.txt"
INDEX_MD = DOCS_DIR / "COMMAND_INDEX_001_030.md"

FENCE_RE = re.compile(r"```([A-Za-z0-9_+.#-]*)\n(.*?)\n```", re.DOTALL)
LAB_NUM_RE = re.compile(r"(\d{3})")


@dataclass
class CodeBlock:
    lang: str
    content: str
    block_type: str


@dataclass
class LabDoc:
    number: str
    title: str
    path: Path
    blocks: list[CodeBlock]


COMMAND_LANGS = {
    "bash",
    "sh",
    "shell",
    "zsh",
    "console",
    "terminal",
}

CONFIG_LANGS = {
    "text",
    "conf",
    "ini",
    "json",
    "yaml",
    "yml",
    "python",
    "dockerfile",
    "toml",
}


def lab_number(path: Path) -> str:
    match = LAB_NUM_RE.search(path.name)
    return match.group(1) if match else "999"


def extract_title(markdown: str, fallback: str) -> str:
    for line in markdown.splitlines():
        if line.startswith("# "):
            return line[2:].strip()
    return fallback


def classify_block(lang: str, content: str) -> str:
    normalized = lang.lower().strip()
    first = content.strip().splitlines()[0] if content.strip().splitlines() else ""

    if normalized in COMMAND_LANGS:
        return "command"
    if first.startswith(("./", "python", "python3", "bash ", "git ", "docker ", "curl ", "nmap ", "tshark ", "tcpdump ", "sudo ")):
        return "command"
    if normalized in CONFIG_LANGS:
        return "config_or_output"
    if normalized == "":
        return "plain_block"
    return "code_or_reference"


def read_lab(path: Path) -> LabDoc:
    markdown = path.read_text(encoding="utf-8")
    title = extract_title(markdown, path.stem)
    blocks: list[CodeBlock] = []

    for match in FENCE_RE.finditer(markdown):
        lang = match.group(1).strip()
        content = match.group(2).strip()
        if not content:
            continue
        blocks.append(CodeBlock(lang=lang or "text", content=content, block_type=classify_block(lang, content)))

    return LabDoc(number=lab_number(path), title=title, path=path, blocks=blocks)


def collect_labs() -> list[LabDoc]:
    lab_files = sorted(LABS_DIR.glob("*.md"), key=lambda p: (lab_number(p), p.name))
    labs = [read_lab(path) for path in lab_files]
    return [lab for lab in labs if "001" <= lab.number <= "030"]


def render_full(labs: list[LabDoc]) -> str:
    generated = datetime.now(timezone.utc).isoformat()

    lines: list[str] = []
    lines.append("# All Codes Together FULL — Linux Network Security Lab")
    lines.append("")
    lines.append(f"Generated: `{generated}`")
    lines.append("")
    lines.append("This document is the complete extracted command/code index for Labs 001-030.")
    lines.append("")
    lines.append("It is generated from the Markdown files in `labs/`. It includes fenced code blocks from the lab documents, including commands, configs, examples, expected outputs and report templates when they appear inside the lab file.")
    lines.append("")
    lines.append("## Safety rule")
    lines.append("")
    lines.append("Use these commands only on localhost, personal machines, VMs, containers, Linux namespaces or explicitly authorized lab environments.")
    lines.append("")
    lines.append("Do not scan, test, capture, monitor, audit or modify systems you do not own or do not have permission to assess.")
    lines.append("")
    lines.append("Do not publish raw outputs before privacy review.")
    lines.append("")
    lines.append("## Lab 000 — Setup")
    lines.append("")
    lines.append("```bash")
    lines.append('cd "/Users/antonmorosi/linux-network-security-lab"')
    lines.append("git status")
    lines.append("git pull --ff-only origin main")
    lines.append('mkdir -p "$HOME/linux_lab/reports"')
    lines.append('mkdir -p "$HOME/linux_lab/private_outputs"')
    lines.append('mkdir -p "$HOME/linux_lab/backups"')
    lines.append("python3 --version")
    lines.append("git --version")
    lines.append("./scripts/list_lab_commands.sh")
    lines.append("```")
    lines.append("")
    lines.append("## Generated lab coverage")
    lines.append("")
    lines.append("| Lab | Title | Code blocks extracted | Command blocks |")
    lines.append("|---:|---|---:|---:|")
    for lab in labs:
        command_count = sum(1 for b in lab.blocks if b.block_type == "command")
        lines.append(f"| {lab.number} | {lab.title} | {len(lab.blocks)} | {command_count} |")
    lines.append("")
    lines.append("## Labs 001-030 extracted blocks")
    lines.append("")

    for lab in labs:
        lines.append(f"## Lab {lab.number} — {lab.title}")
        lines.append("")
        lines.append(f"Source file: `{lab.path.as_posix()}`")
        lines.append("")
        if not lab.blocks:
            lines.append("No fenced code blocks were found in this lab file.")
            lines.append("")
            continue

        for i, block in enumerate(lab.blocks, start=1):
            lang = block.lang or "text"
            lines.append(f"### Lab {lab.number} Block {i:02d} — {block.block_type} — language: `{lang}`")
            lines.append("")
            lines.append(f"```{lang}")
            lines.append(block.content)
            lines.append("```")
            lines.append("")

    lines.append("## Safe v1.1 runner")
    lines.append("")
    lines.append("For Labs 021-030, a safe helper is available:")
    lines.append("")
    lines.append("```bash")
    lines.append('cd "/Users/antonmorosi/linux-network-security-lab"')
    lines.append("./scripts/run_safe_v11_labs_021_030.sh")
    lines.append("```")
    lines.append("")
    lines.append("The runner avoids forced sudo and skips gated real Lynis audit. It may report missing optional tools, which is acceptable.")
    lines.append("")
    lines.append("## Final privacy checklist")
    lines.append("")
    lines.append("```text")
    lines.append("No private keys.")
    lines.append("No real auth logs.")
    lines.append("No raw Lynis output.")
    lines.append("No third-party scan output.")
    lines.append("No Wi-Fi captures.")
    lines.append("No credentials.")
    lines.append("No tokens.")
    lines.append("No private hostnames.")
    lines.append("No unreviewed packet captures.")
    lines.append("```")
    lines.append("")

    return "\n".join(lines)


def render_index(labs: list[LabDoc]) -> str:
    generated = datetime.now(timezone.utc).isoformat()

    lines: list[str] = []
    lines.append("# Command Index 001-030")
    lines.append("")
    lines.append(f"Generated: `{generated}`")
    lines.append("")
    lines.append("This index summarizes how many fenced blocks were extracted from each lab file.")
    lines.append("")
    lines.append("| Lab | Source | Title | Total blocks | Command blocks | Config/output blocks |")
    lines.append("|---:|---|---|---:|---:|---:|")
    for lab in labs:
        command_count = sum(1 for b in lab.blocks if b.block_type == "command")
        config_count = sum(1 for b in lab.blocks if b.block_type != "command")
        lines.append(
            f"| {lab.number} | `{lab.path.as_posix()}` | {lab.title} | {len(lab.blocks)} | {command_count} | {config_count} |"
        )

    lines.append("")
    lines.append("## Regenerate")
    lines.append("")
    lines.append("```bash")
    lines.append('cd "/Users/antonmorosi/linux-network-security-lab"')
    lines.append("python3 scripts/build_all_codes_together_full.py")
    lines.append("```")
    lines.append("")

    return "\n".join(lines)


def main() -> None:
    DOCS_DIR.mkdir(parents=True, exist_ok=True)

    labs = collect_labs()
    if not labs:
        raise SystemExit("[ERROR] No lab Markdown files found under labs/")

    full = render_full(labs)
    index = render_index(labs)

    FULL_MD.write_text(full, encoding="utf-8")
    FULL_TXT.write_text(full, encoding="utf-8")
    INDEX_MD.write_text(index, encoding="utf-8")

    print(f"[OK] Wrote: {FULL_MD}")
    print(f"[OK] Wrote: {FULL_TXT}")
    print(f"[OK] Wrote: {INDEX_MD}")
    print(f"[INFO] Labs processed: {len(labs)}")
    print(f"[INFO] Code blocks extracted: {sum(len(lab.blocks) for lab in labs)}")


if __name__ == "__main__":
    main()
