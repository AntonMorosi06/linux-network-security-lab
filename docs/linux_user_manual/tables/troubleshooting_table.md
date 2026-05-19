# Troubleshooting Table

| Symptom | Likely cause | Command to check | Possible fix |
|---|---|---|---|
| command not found | tool missing or PATH issue | `command -v tool` | install tool or fix PATH |
| permission denied | file not executable or insufficient rights | `ls -la file` | `chmod +x file` or check ownership |
| port already in use | another service is listening | `lsof -i :PORT -P -n` | stop service or change port |
| Docker not reachable | Docker daemon stopped | `docker info` | open Docker Desktop |
| API not reachable | service not running | `curl -i URL` | start service |
| CI failed | syntax/config error | GitHub Actions logs | run local CI and fix |
