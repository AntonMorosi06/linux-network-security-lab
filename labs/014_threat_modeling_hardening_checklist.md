# Lab 014 — Threat Modeling and Hardening Checklist

## Objective

The objective of this lab is to add a defensive threat model and hardening checklist to the Linux Network Security Lab repository.

This lab teaches asset inventory, trust boundaries, data-flow reasoning, local attack surface review, defensive risk registration, Linux/API/Docker hardening, evidence collection and report generation.

## Safety boundary

This lab is defensive only. It does not exploit systems, bypass controls, scan third-party networks or perform unauthorized testing. It focuses on localhost, local repository files, local Docker labs, local API services, local Linux/Unix diagnostics and safe documentation.

## Why threat modeling matters

A technical project becomes stronger when it explains not only how something works, but also what could go wrong. Threat modeling asks what is being protected, who or what can interact with it, where trust boundaries exist, what can fail, what can be abused, which controls reduce risk and what evidence proves those controls exist.

## Lab outputs

This lab introduces:

```text
security/ASSET_INVENTORY.md
security/TRUST_BOUNDARIES.md
security/THREAT_MODEL.md
security/HARDENING_CHECKLIST.md
security/RISK_REGISTER.md
scripts/security_check_local_exposure.sh
scripts/security_generate_threat_model_report.sh
```

## Step 1 — Review asset inventory

Open:

```text
security/ASSET_INVENTORY.md
```

This document lists local APIs, Docker services, namespace labs, logs, reports, scripts, GitHub Actions workflow and documentation as protected assets.

## Step 2 — Review trust boundaries

Open:

```text
security/TRUST_BOUNDARIES.md
```

Important boundaries include host-to-container, reverse-proxy-to-API, Prometheus-to-metrics-API, namespace-client-to-router, and repository-to-GitHub-Actions-runner.

## Step 3 — Review threat model

Open:

```text
security/THREAT_MODEL.md
```

The threat model documents assets, entry points, trust boundaries, threats, controls and recommended mitigations.

## Step 4 — Review hardening checklist

Open:

```text
security/HARDENING_CHECKLIST.md
```

The checklist covers local host hardening, API service hardening, Docker hardening, Docker Compose hardening, monitoring hardening and repository hygiene.

## Step 5 — Review risk register

Open:

```text
security/RISK_REGISTER.md
```

The risk register maps risk, impact, likelihood, severity, current controls, recommended mitigation, evidence and status.

## Step 6 — Run local exposure check

```bash
./scripts/security_check_local_exposure.sh
```

Expected output includes security document checks, workflow presence, listening ports and Docker state if Docker is available.

## Step 7 — Generate threat model report

```bash
./scripts/security_generate_threat_model_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/threat_model_report_YYYYMMDD_HHMMSS.txt
```

## Defensive interpretation

If local APIs are listening only on `127.0.0.1`, exposure is lower than services listening on `0.0.0.0`. If Docker containers publish ports to `127.0.0.1`, they are local-only. If CI exists and passes, repository integrity is stronger. If threat model and checklist exist, the repository is easier to evaluate professionally.

## Final conclusion

The core chain is:

```text
asset inventory
-> trust boundaries
-> threat model
-> hardening checklist
-> local exposure check
-> risk register
-> final report
```

This turns the repository from a collection of technical labs into a security-aware portfolio project.
