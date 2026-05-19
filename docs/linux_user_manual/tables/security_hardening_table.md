# Security Hardening Table

| Area | Check | Command/document | Why it matters |
|---|---|---|---|
| Secrets | Search secret-like files | `find . -name ".env" -o -name "*.pem"` | Avoid leaking credentials |
| Ports | Check listeners | `ss -tulpen` / `lsof -i` | Understand exposure |
| Docker | Check published ports | `docker ps` | Avoid unintended exposure |
| Git | Check changes | `git status` | Avoid committing private data |
| CI | Validate repo | `./scripts/ci_local_validate.sh` | Catch breakage |
| Threat model | Review risks | `security/THREAT_MODEL.md` | Document defensive posture |
