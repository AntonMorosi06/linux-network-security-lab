# Linux Cheatsheets

## System baseline

```bash
whoami
id
hostname
uname -a
date
pwd
ls -la
```

## Files

```bash
find . -name "*.md"
du -sh .
df -h
tree -L 2
```

## Processes

```bash
ps aux
top
pgrep -fl python
```

## Network

```bash
ip addr
ip route
ss -tulpen
lsof -i -P -n
curl -i http://127.0.0.1:8080
```

## Docker

```bash
docker ps
docker logs container_name
docker inspect container_name
docker compose ps
docker compose logs
docker compose down
```

## Git

```bash
git status
git add .
git commit -m "message"
git push origin main
```

## Repo validation

```bash
./scripts/ci_local_validate.sh
./scripts/final_lab020_run_final_review.sh
```
