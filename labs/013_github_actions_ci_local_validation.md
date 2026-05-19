# Lab 013 — GitHub Actions CI and Local Validation

## Objective

The objective of this lab is to add local and remote validation to the repository using shell scripts and GitHub Actions. This transforms the project from a collection of labs into a repository with a repeatable quality gate.

This lab teaches continuous integration, repository structure checks, Bash syntax validation, Python syntax validation, Docker Compose configuration validation, local CI execution, and GitHub Actions workflow execution.

## Why CI matters

A technical repository becomes more credible when every push can be checked automatically. Continuous integration does not prove that every lab works in every runtime environment, but it catches common problems early: missing files, broken Bash syntax, broken Python syntax, invalid Docker Compose files, and accidental repository structure drift.

## Files introduced

```text
.github/workflows/ci.yml
scripts/ci_local_validate.sh
scripts/ci_check_repository_structure.sh
scripts/ci_check_bash_syntax.sh
scripts/ci_check_python_syntax.sh
scripts/ci_check_compose_files.sh
```

## Local validation

Run from the repository root:

```bash
./scripts/ci_local_validate.sh
```

Expected high-level output:

```text
[OK] Repository structure check passed.
[OK] Bash syntax check passed.
[OK] Python syntax check passed.
[OK] Docker Compose config check completed.
[OK] Local CI validation completed.
```

## GitHub Actions validation

The workflow is stored at:

```text
.github/workflows/ci.yml
```

It runs on push to `main`, pull request to `main`, and manual workflow dispatch.

The workflow includes these jobs:

```text
repository-validation
bash-syntax
python-syntax
docker-compose-config
```

## Commands

Check repository structure:

```bash
./scripts/ci_check_repository_structure.sh
```

Check Bash syntax:

```bash
./scripts/ci_check_bash_syntax.sh
```

Check Python syntax:

```bash
./scripts/ci_check_python_syntax.sh
```

Check Docker Compose files:

```bash
./scripts/ci_check_compose_files.sh
```

Run everything locally:

```bash
./scripts/ci_local_validate.sh
```

## Interpretation

If local validation passes, the repository is structurally coherent and the main scripts can at least be parsed. If GitHub Actions passes, the same checks also work in a clean remote Ubuntu runner.

This gives the repository a professional baseline: every new lab should preserve syntax validity, structure, and Compose configuration integrity.

## Limitations

These checks are not full runtime tests. Network namespace labs still require a Linux environment. Docker labs still require Docker to run. Prometheus labs still require the stack to start correctly. CI here is a quality gate, not a full integration test for every possible environment.

## Defensive value

In cybersecurity and infrastructure work, repeatability and evidence matter. CI provides a visible record that the repository has been checked after each push.

## Final conclusion

The core chain is:

```text
local validation scripts
-> GitHub Actions workflow
-> automatic checks on push
-> cleaner repository state
-> stronger portfolio proof-of-work
```
