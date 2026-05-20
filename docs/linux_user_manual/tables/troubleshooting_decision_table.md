# Troubleshooting Decision Table

| Symptom | Likely layer | First safe command | What to look for | Typical next step |
|---|---|---|---|---|
| `command not found` | PATH/package | `command -v tool` | no path | install tool or fix PATH |
| `permission denied` | permissions | `ls -la target`, `id` | missing `x`, owner mismatch | minimal permission fix |
| `no such file or directory` | path | `pwd`, `ls`, `find` | wrong folder or missing file | correct path/regenerate file |
| `syntax error` | shell/parser | `bash -n script.sh` | broken quoting/heredoc | fix script syntax |
| backticks executed | shell/heredoc | inspect heredoc marker | unquoted heredoc | use `<<'EOF'` or `<<'PY'` |
| port already in use | process/port | `lsof -i :PORT -P -n` | PID owning port | stop correct process/change port |
| connection refused | service not listening | `ss -tulpen`, `docker ps` | no listener | start service/check Compose |
| HTTP 404 | app route | `curl -i URL` | server responds, path missing | check endpoint path |
| HTTP 401/403 | auth/access | `curl -i URL` | access denied | check token/policy |
| HTTP 500 | application | logs | server-side error | inspect app/container logs |
| Docker daemon error | Docker runtime | `docker info` | daemon unavailable | start Docker Desktop/daemon |
| CI failed | validation | local CI script | failing step | reproduce locally |
