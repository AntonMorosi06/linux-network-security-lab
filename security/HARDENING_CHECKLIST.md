# Hardening Checklist

## Linux host checklist

- Keep the system updated.
- Avoid running lab services as root unless required.
- Inspect listening ports regularly.
- Stop local services after tests.
- Store generated reports outside public commits unless reviewed.
- Do not commit real logs containing private information.

Useful commands:

```bash
whoami
id
uname -a
ss -tulpen
lsof -i -P -n
```

## API service checklist

- Bind local test APIs to `127.0.0.1`.
- Use explicit ports.
- Add authentication for protected endpoints.
- Validate input fields.
- Use allowlists for commands.
- Return appropriate status codes.
- Log structured events.
- Avoid leaking stack traces.
- Document cleanup steps.

## Docker checklist

- Publish ports to `127.0.0.1` when possible.
- Avoid unnecessary privileged containers.
- Remove lab containers after tests.
- Inspect published ports.
- Avoid mounting sensitive host directories.
- Keep Dockerfiles simple and readable.
- Use Compose files for repeatable stacks.

## Monitoring checklist

- Provide `/status`.
- Provide `/health`.
- Provide `/metrics` where appropriate.
- Generate controlled traffic.
- Query metrics.
- Save report evidence.
- Document expected outputs.

## Repository checklist

- Keep README updated.
- Keep lab index updated.
- Keep scripts executable when needed.
- Run local CI before push.
- Use meaningful commit messages.
- Keep `.gitignore` updated.
- Do not commit secrets.
- Review reports before publishing.
