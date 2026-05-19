# Terminal and Shell

The terminal is the interface. The shell is the program that interprets commands. Common shells include `bash`, `zsh`, `fish` and `sh`.

On macOS the default shell is usually `zsh`. On many Linux systems, the default shell is often `bash`.

## Useful shell concepts

```text
command
argument
option
environment variable
working directory
exit code
pipe
redirection
script
```

## Basic examples

```bash
echo "hello"
echo "$SHELL"
echo "$PATH"
command -v python3
command -v docker
```

## Pipes

A pipe sends output from one command into another.

```bash
ps aux | grep python
```

This means:

```text
list processes -> filter lines containing python
```

## Redirection

```bash
echo "hello" > file.txt
echo "another line" >> file.txt
cat file.txt
```

`>` overwrites. `>>` appends.

## Exit codes

```bash
echo $?
```

An exit code of `0` usually means success. Non-zero usually means error.

## Script execution

```bash
chmod +x script.sh
./script.sh
```

Or:

```bash
bash script.sh
```

For `.txt` patch scripts in this repository, use:

```bash
bash ~/Downloads/script_name.txt
```

Do not paste large script contents manually into the terminal.
