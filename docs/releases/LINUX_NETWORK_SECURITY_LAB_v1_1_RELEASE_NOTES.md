# Linux Network Security Lab v1.1 — Safe Tools Expansion

Release status: release candidate

Release tag proposal:

```text
v1.1.0-safe-tools-expansion
```

## Release Summary

Version 1.1 extends the original Linux Network Security Lab with a second sequence of local, defensive and carefully bounded exercises focused on safe tool awareness, evidence handling and portfolio-ready documentation.

The goal of this release is not to turn the repository into an offensive security toolkit. The goal is to demonstrate practical Linux and networking competence through controlled local exercises, clear safety boundaries, sanitized outputs and reproducible documentation.

This release builds on the v1.0 baseline, which introduced the core defensive lab sequence, Linux User Manual, monitoring concepts, local diagnostics, structured reports and proof-of-work documentation.

## What This Release Adds

| Area | Description |
|---|---|
| Safe tool-awareness track | Adds a second lab sequence focused on understanding common Linux and security-adjacent tools in a controlled way. |
| Labs 021-030 | Extends the repository from the original 20-lab baseline to a 30-lab structure. |
| Evidence pointer | Adds a verified pointer to the latest sanitized v1.1 safe-run evidence bundle. |
| Evidence review | Adds metadata-level and targeted file-by-file review documents for the v1.1 evidence bundle. |
| Portfolio entry points | Adds clearer reviewer-facing documents: current status, known limitations, lab index, evidence policy and portfolio summary. |
| Release checklist | Adds a dedicated checklist for tracking release readiness. |

## Main Files Added or Updated

| File | Purpose |
|---|---|
| `CURRENT_STATUS.md` | Defines the real maturity of the project and separates complete, in-progress and portfolio-ready parts. |
| `KNOWN_LIMITATIONS.md` | Documents local-only, defensive-only and authorized-use boundaries. |
| `LAB_INDEX.md` | Provides a structured index of Labs 001-030. |
| `PORTFOLIO_SUMMARY.md` | Gives a reviewer-friendly explanation of the skills demonstrated by the repository. |
| `EVIDENCE.md` | Defines how evidence should be sanitized, reviewed and published. |
| `RELEASE_CHECKLIST_v1_1.md` | Tracks release readiness for v1.1. |
| `reports/evidence/LATEST_V1_1_SAFE_RUN.md` | Points to the current sanitized v1.1 safe-run evidence bundle. |
| `reports/evidence/v1_1_mac_rerun_20260520_152216/EVIDENCE_REVIEW.md` | Reviews the evidence bundle metadata, scope and safety notes. |
| `reports/evidence/v1_1_mac_rerun_20260520_152216/FILE_BY_FILE_SAFETY_REVIEW.md` | Reviews the highest-risk sanitized evidence files before release. |
| `README.md` | Updated with reviewer entry points and clearer portfolio framing. |

## Lab Coverage

The repository now documents a 30-lab structure.

| Range | Focus | Status |
|---|---|---|
| Labs 001-020 | Core Linux, networking, local diagnostics, logs, monitoring, incident-style reporting and release preparation. | v1.0 baseline |
| Labs 021-030 | Safe tool-awareness expansion, local analysis workflows, dry-run examples, synthetic evidence and release-focused review. | v1.1 release candidate |

## Evidence Model

The release uses a sanitized evidence model.

Raw outputs may contain private host details, local paths, usernames, timestamps, system-specific findings or other sensitive information. For that reason, raw local outputs are kept outside the repository until manually reviewed.

Public evidence should be:

- sanitized;
- clearly scoped;
- local or explicitly controlled;
- reproducible where possible;
- documented with safety notes;
- free of private credential material;
- free of private screenshots;
- connected to the lab sequence.

The latest evidence pointer is:

```text
reports/evidence/LATEST_V1_1_SAFE_RUN.md
```

The current evidence bundle is:

```text
reports/evidence/v1_1_mac_rerun_20260520_152216
```

## Safety Boundary

This release preserves the safety model of the repository.

All work is intended for:

- localhost;
- personal machines;
- virtual machines;
- containers;
- Linux network namespaces;
- synthetic data;
- explicitly authorized lab environments.

The repository must not be presented as:

- an offensive toolkit;
- a production monitoring platform;
- an enterprise security platform;
- a complete incident-response system;
- a system for testing targets without authorization.

## Portfolio Value

This release makes the repository stronger as a portfolio project because it shows:

1. practical Linux command-line work;
2. structured networking and diagnostic thinking;
3. careful safety boundaries;
4. documentation discipline;
5. evidence handling and sanitization;
6. release engineering habits;
7. ability to explain technical work to external reviewers.

A safe portfolio description is:

```text
Built a defensive Linux and network security laboratory with 30 staged local labs covering system diagnostics, networking, logs, local services, firewall concepts, packet analysis, monitoring, incident-style documentation and safe tool-awareness workflows. The project uses localhost, controlled environments and sanitized evidence to keep the work reproducible, defensive and authorized.
```

## Release Readiness

Current status:

```text
Release candidate.
```

Completed readiness items:

- reviewer entry points added to README;
- current status documented;
- limitations documented;
- lab index added;
- portfolio summary added;
- evidence policy added;
- release checklist added;
- evidence pointer verified;
- evidence metadata review added;
- targeted file-by-file evidence safety review added.

Remaining recommended items before final release tag:

1. Confirm that all Labs 021-030 have clear safety notes in their individual lab files.
2. Confirm that generated command indexes point to the current lab sequence.
3. Create GitHub issues for the last release-polish tasks.
4. Optionally add a final `CHANGELOG.md` entry for v1.1.
5. Review whether the repository should be pinned or linked from the main portfolio after release.

## Final Release Note

Version 1.1 should be considered a strong portfolio-stage release candidate. The repository now has clear scope, documented limitations, reviewer entry points, evidence review and a structured release checklist.

The final release tag should be created only after the remaining checklist items have been reviewed.
