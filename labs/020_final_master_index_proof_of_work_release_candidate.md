# Lab 020 — Final Master Index, Proof-of-Work Bundle and Release Candidate Review

## Objective

The objective of this final lab is to close the first complete 20-lab baseline of the Linux Network Security Lab repository.

This lab produces:

- a master lab index
- a final project summary
- a proof-of-work document
- a final review checklist
- a release candidate review
- a portfolio/recruiter/professor presentation guide
- a local proof-of-work bundle
- a final release candidate report

This lab does not add another technical runtime stack. Instead, it consolidates the whole repository into a reviewable, publishable and defensible body of work.

## Safety boundary

This lab is administrative, defensive and local.

It does not run offensive tests, does not scan networks, does not collect private logs and does not publish a GitHub release automatically.

Generated reports may include local paths and should be reviewed before public sharing.

## Why a final master index matters

A repository with many labs can become difficult to evaluate if the structure is not summarized clearly.

The final master index answers:

```text
What did this repository cover?
What skills are demonstrated?
Which labs are Linux-specific?
Which labs are Docker-specific?
Which labs are documentation/security-process oriented?
Which scripts should be run to validate the project?
What should be shown to a professor, recruiter or collaborator?
```

## Lab outputs

This lab creates:

```text
docs/MASTER_LAB_INDEX.md
docs/FINAL_PROJECT_SUMMARY.md
docs/PROOF_OF_WORK.md
docs/FINAL_REVIEW_CHECKLIST.md
docs/V0_1_0_RELEASE_CANDIDATE_REVIEW.md
docs/WHAT_TO_SHOW_RECRUITER_OR_PROFESSOR.md
scripts/final_lab020_validate_all.sh
scripts/final_lab020_generate_master_index.sh
scripts/final_lab020_create_proof_of_work_bundle.sh
scripts/final_lab020_create_release_candidate_report.sh
scripts/final_lab020_run_final_review.sh
```

## Step 1 — Validate repository baseline

```bash
./scripts/final_lab020_validate_all.sh
```

Expected output:

```text
[OK] Lab count is 20 or higher.
[OK] Required documentation exists.
[OK] Required security documents exist.
[OK] Required CI workflow exists.
```

## Step 2 — Generate master index

```bash
./scripts/final_lab020_generate_master_index.sh
```

Expected output:

```text
[OK] Master lab index generated:
docs/MASTER_LAB_INDEX.md
```

## Step 3 — Create proof-of-work bundle

```bash
./scripts/final_lab020_create_proof_of_work_bundle.sh
```

Expected output:

```text
[OK] Proof-of-work bundle created:
~/linux_lab/final_review/proof_of_work_bundle_YYYYMMDD_HHMMSS
```

The bundle contains selected documents, indexes, release notes, status files, security documentation and file listings. It is created outside the repository working tree by default.

## Step 4 — Create release candidate report

```bash
./scripts/final_lab020_create_release_candidate_report.sh
```

Expected output:

```text
[OK] Release candidate report created:
~/linux_lab/reports/final_release_candidate_report_YYYYMMDD_HHMMSS.txt
```

## Step 5 — Run final review workflow

```bash
./scripts/final_lab020_run_final_review.sh
```

This runs:

```text
baseline validation
master index generation
proof-of-work bundle creation
release candidate report generation
```

## What the 20-lab baseline demonstrates

The repository now demonstrates:

```text
Linux diagnostics
network diagnostics
HTTP and packet capture
ports, processes and logs
DNS and routing
network namespaces
firewall and NAT
traffic shaping
local JSON APIs
API security controls
Docker networking
Docker Compose reverse proxy
Prometheus metrics
GitHub Actions CI
threat modeling
secure service capstone
release engineering
Grafana dashboards and alerts
SIEM-style log pipeline
incident response case documentation
final proof-of-work packaging
```

## Manual release guidance

This lab does not create a Git tag automatically.

After manual review, a release could be created with:

```bash
git tag -a v0.1.0 -m "Linux Network Security Lab v0.1.0"
git push origin v0.1.0
```

Then create a GitHub Release using `RELEASE_NOTES_v0.1.0.md`.

Do this only after:

```text
CI passes
README is reviewed
private data is absent
generated reports are reviewed
screenshots are reviewed
Docker labs are tested where possible
```

## Final conclusion

This lab turns the repository into a complete proof-of-work package.

The final chain is:

```text
20 labs
-> master index
-> validation
-> proof-of-work bundle
-> release candidate report
-> manual review
-> optional GitHub release
```

The project is now suitable as a serious local Linux/network/security portfolio repository.
