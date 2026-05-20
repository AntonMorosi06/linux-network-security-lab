# Security Hardening Checklist Table

| Check | Command/document | Expected safe state |
|---|---|---|
| Repository state | `git status` | only reviewed changes staged |
| Secret-like files | `find . -name ".env" -o -name "*.pem" -o -name "*.key"` | no real secrets committed |
| Secret-like text | `grep -Rni "password\|token\|secret\|api_key" docs scripts security` | no real credentials |
| Local listeners | `ss -tulpen`, `lsof -i -P -n` | expected services only |
| Docker mappings | `docker ps` | localhost-bound when possible |
| Permissions | `ls -la` | no broad unnecessary modes |
| Logs | `tail`, `grep`, Docker logs | sanitized/synthetic before publishing |
| Reports | manual review | no private system details |
| Threat model | `security/THREAT_MODEL.md` | assets/boundaries defined |
| Risk register | risk docs | risks have mitigation/status |
