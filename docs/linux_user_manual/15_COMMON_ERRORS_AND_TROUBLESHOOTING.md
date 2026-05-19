# Common Errors and Troubleshooting

## Command not found

Example:

```text
bash: docker: command not found
```

Meaning:

```text
The command is not installed or not in PATH.
```

Check:

```bash
command -v docker
echo "$PATH"
```

## Permission denied

Example:

```text
permission denied: ./script.sh
```

Fix:

```bash
chmod +x script.sh
./script.sh
```

Or run:

```bash
bash script.sh
```

## Port already in use

Check:

```bash
lsof -i :PORT -P -n
ss -tulpen
```

## Docker daemon not running

On macOS, open Docker Desktop.

Check:

```bash
docker info
```

## Wrong shell problem

If a patch script is a `.txt`, run it with:

```bash
bash file.txt
```

Do not paste the whole script manually into `zsh`.
