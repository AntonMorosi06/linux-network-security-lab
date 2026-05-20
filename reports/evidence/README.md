# Evidence Reports

This directory contains sanitized evidence bundles generated from local lab executions.

Raw outputs should remain outside the repository until reviewed.

Each evidence bundle should contain:

```text
RUN_SUMMARY.md
EVIDENCE_MANIFEST.json
*_SANITIZED.txt
```

Publication rules:

```text
Do not commit private keys.
Do not commit raw authentication logs.
Do not commit raw Lynis output without sanitization.
Do not commit real Wi-Fi captures.
Do not commit third-party scan output.
Do not commit credentials, tokens or private hostnames.
```
