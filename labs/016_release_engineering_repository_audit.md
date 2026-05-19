# Lab 016 — Release Engineering, Repository Audit and Publication Readiness

## Objective

The objective of this lab is to transform the repository from a sequence of technical exercises into a publishable, reviewable and portfolio-ready project.

After Lab 015, the repository already contains a complete defensive baseline: Linux diagnostics, networking, namespaces, firewalling, NAT, traffic shaping, local APIs, API security, Docker, Docker Compose, Prometheus metrics, CI, threat modeling and a capstone stack.

Lab 016 adds the release engineering layer.

This lab teaches:

- repository audit
- version tracking
- changelog writing
- release notes
- publication readiness
- portfolio summary
- current status documentation
- roadmap documentation
- issue templates
- local release report generation
- review-before-release workflow

## Safety boundary

This lab is administrative and defensive. It does not scan systems, run intrusive tests, exploit services or publish secrets.

It prepares documentation and local reports only.

The patch does not automatically create a Git tag or GitHub release. Tagging and release publishing should happen only after manual review.

## Why release engineering matters

A technical project becomes much stronger when it has:

```text
clear version
clear status
clear changelog
clear roadmap
clear safety boundaries
clear evidence
clear next steps
```

Without release engineering, a repository can look like a random collection of files. With release engineering, it looks like a maintained technical project.

## Lab outputs

This lab introduces:

```text
VERSION
CHANGELOG.md
RELEASE_NOTES_v0.1.0.md
docs/CURRENT_STATUS.md
docs/ROADMAP.md
docs/PORTFOLIO_SUMMARY.md
docs/REPOSITORY_AUDIT.md
docs/PUBLICATION_CHECKLIST.md
.github/ISSUE_TEMPLATE/
scripts/release_lab016_check_publication_readiness.sh
scripts/release_lab016_generate_repository_summary.sh
scripts/release_lab016_create_release_report.sh
```

## Step 1 — Review repository status

Open:

```text
docs/CURRENT_STATUS.md
```

This document explains the current repository state after the first 15 labs.

## Step 2 — Review changelog

Open:

```text
CHANGELOG.md
```

The changelog summarizes the v0.1.0 baseline.

## Step 3 — Review release notes

Open:

```text
RELEASE_NOTES_v0.1.0.md
```

These release notes describe what the first public baseline contains, what is intentionally local-only and what remains future work.

## Step 4 — Review roadmap

Open:

```text
docs/ROADMAP.md
```

The roadmap describes future directions after v0.1.0, such as alerting, Grafana, Kubernetes, SIEM-style pipelines, Makefile automation and improved evidence packaging.

## Step 5 — Run publication readiness check

```bash
./scripts/release_lab016_check_publication_readiness.sh
```

Expected output includes:

```text
[OK] File exists: README.md
[OK] File exists: CHANGELOG.md
[OK] File exists: VERSION
[OK] File exists: .github/workflows/ci.yml
[OK] Directory exists: labs
[OK] Lab count is 16 or higher
```

## Step 6 — Generate repository summary

```bash
./scripts/release_lab016_generate_repository_summary.sh
```

This prints:

```text
repository name
current branch
Git status
lab count
script count
documentation count
Docker lab count
security document count
CI workflow status
```

## Step 7 — Create release readiness report

```bash
./scripts/release_lab016_create_release_report.sh
```

Expected output:

```text
[OK] Report created:
~/linux_lab/reports/release_readiness_report_YYYYMMDD_HHMMSS.txt
```

## Step 8 — Optional manual release flow

After reviewing the repository, a future release could be created manually with:

```bash
git tag -a v0.1.0 -m "Linux Network Security Lab v0.1.0"
git push origin v0.1.0
```

Then create a GitHub release using `RELEASE_NOTES_v0.1.0.md`.

Do not do this automatically before review.

## Publication interpretation

A repository is publication-ready when:

```text
README is clear
labs are indexed
safe-use policy exists
threat model exists
hardening checklist exists
CI exists
release notes exist
changelog exists
current status exists
roadmap exists
local validation passes
no secrets are present
generated reports are reviewed before commit
```

## Common issues

### README missing latest lab

Update the README Labs section.

### CI failing

Run:

```bash
./scripts/ci_local_validate.sh
```

Fix Bash, Python or Compose errors before release.

### Reports contain private local data

Generated reports should be reviewed before committing.

### Docker not running

Release readiness does not require Docker runtime, but some validation scripts may skip Docker-specific runtime checks if Docker is unavailable.

## Defensive value

Release engineering is part of defensive engineering because it makes work reproducible, reviewable and auditable.

It helps answer:

```text
what is included
what is not included
what has been checked
what remains future work
what evidence exists
what safety boundaries apply
```

## Final conclusion

The repository now has a complete v0.1.0-style baseline:

```text
15 technical labs
1 release engineering lab
CI validation
threat model
hardening checklist
capstone stack
publication checklist
portfolio summary
release notes
roadmap
```

This makes the project much more presentable as a GitHub portfolio repository.
