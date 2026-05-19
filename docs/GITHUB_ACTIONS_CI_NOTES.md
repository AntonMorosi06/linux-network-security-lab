# GitHub Actions CI Notes

Continuous Integration is a workflow where checks run automatically whenever code is pushed or a pull request is opened.

This repository uses `.github/workflows/ci.yml` to validate structure, Bash syntax, Python syntax and Docker Compose configuration.

The same checks can be run locally with:

```bash
./scripts/ci_local_validate.sh
```

The workflow runs on push to `main`, pull request to `main`, and manual dispatch.

CI does not prove every lab works at runtime. It verifies that the repository remains parseable, structured and consistent.
