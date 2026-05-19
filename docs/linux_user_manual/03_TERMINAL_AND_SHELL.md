# Terminal and Shell

This file explains the terminal and shell layer in depth. It is one of the most important files in the Linux User Manual because almost every lab in the repository is executed through a shell. If the user understands how the shell interprets commands, arguments, quoting, variables, pipes, redirection, exit codes and scripts, most terminal errors become diagnosable instead of mysterious.

The key distinction is that the terminal is the interface, while the shell is the command interpreter. A terminal window displays input and output. The shell reads what the user types, parses it, expands variables and wildcards, connects pipes, applies redirections and launches programs.


## 1. Terminal versus shell

The terminal is the graphical or text interface where commands are typed. The shell is the program that interprets those commands. On macOS the default interactive shell is often zsh; on many Linux systems it is bash. Repository scripts may require bash even if the user's interactive shell is zsh.


## 2. Command structure

A command usually has a program name, options and arguments. For example, `ls -la docs` runs `ls` with option `-la` and argument `docs`. Understanding this structure helps diagnose wrong paths, missing flags and unexpected output.


## 3. Arguments and options

Arguments tell a command what target to operate on. Options modify behavior. Short options often use one dash, such as `-l`; long options often use two dashes, such as `--help`. Some options take values.


## 4. Quoting

Quoting controls how the shell treats spaces, variables and special characters. Single quotes preserve text literally. Double quotes allow variable expansion. Missing quotes often cause paths with spaces to break.


## 5. Variables

Shell variables store values. Environment variables are inherited by child processes. Examples include `PATH`, `HOME`, `SHELL` and custom variables used in scripts. `echo "$PATH"` prints the command search path.


## 6. PATH

PATH is a list of directories the shell searches when a command is typed. If a command gives `command not found`, the program may not be installed or may not be in PATH. Use `command -v name` to check.


## 7. Working directory

The shell has a current working directory. Relative paths depend on it. `pwd` shows it and `cd` changes it. Many repository problems happen because a script is run from the wrong folder.


## 8. Exit codes

Every command exits with a status code. In general, `0` means success and non-zero means failure. `echo $?` prints the exit code of the previous command. Scripts use exit codes to stop on errors or continue safely.


## 9. Pipes

A pipe sends stdout from one command into stdin of another. Example: `ps aux | grep python`. Pipes are central to Unix-style composition because they let small tools work together.


## 10. Redirection

Redirection sends output to files or reads input from files. `>` overwrites, `>>` appends, `2>` redirects stderr, and `2>&1` merges stderr into stdout. Redirection is powerful but can overwrite files if used carelessly.


## 11. Globs and wildcards

The shell expands patterns such as `*.md` before running a command. This is useful for selecting files, but dangerous with destructive commands if the pattern matches more than expected.


## 12. Command substitution

Command substitution inserts the output of a command into another command. It can use `$(command)` or legacy backticks. This is why Markdown backticks can be dangerous if pasted into the shell in the wrong context.


## 13. Heredocs

A heredoc passes a block of text to a command. Quoted heredocs such as `<<'EOF'` prevent shell expansion inside the block. This matters when scripts write Markdown containing backticks, dollar signs or code fences.


## 14. Bash scripts

A Bash script is a file containing shell commands. It may start with a shebang such as `#!/usr/bin/env bash`. It can be executed with `bash script.sh` or, if executable, with `./script.sh`.


## 15. zsh versus bash

zsh and bash are similar but not identical. A script written for bash should be run with bash. Do not assume that pasting a bash script into zsh is equivalent to executing it with bash.


## 16. set -euo pipefail

`set -euo pipefail` is a common Bash safety pattern. `-e` exits on errors, `-u` treats unset variables as errors, and `pipefail` makes pipelines fail if any command fails. It helps catch mistakes in automation.


## 17. chmod and execution

A script file must have execute permission to run as `./script.sh`. `chmod +x script.sh` adds that permission. However, a script can still be run with `bash script.sh` even if it is not executable.


## 18. Standard streams

The three standard streams are stdin, stdout and stderr. Normal output goes to stdout. Error messages go to stderr. Understanding streams explains logging, redirection and script diagnostics.


## 19. Interactive versus non-interactive shell

An interactive shell is used directly by the user. A non-interactive shell runs a script. Some shell configuration files are loaded only in certain modes, which can explain PATH differences.


## 20. Aliases and functions

Aliases and shell functions can change command behavior in interactive sessions. Scripts should avoid depending on aliases because they may not exist in non-interactive shells.


## 21. Command discovery

`command -v`, `which` and `type` help discover how a command is resolved. `command -v` is generally reliable in scripts. This is useful before using Docker, Python, Git or Linux-specific tools.


## 22. Shell errors

Errors such as `command not found`, `permission denied`, `no such file or directory` and `syntax error near unexpected token` usually indicate missing tools, wrong paths, bad permissions or parsing problems.


## 23. Safe script execution

For downloaded patch scripts in this repository, the safe pattern is `bash ~/Downloads/file.txt`. The user should not open the file and paste its entire content into the terminal because heredocs and Markdown can be misinterpreted.


## 24. Shell and Git workflow

Git commands are executed through the shell. Before committing, use `git status`; after generating files, review staged changes. The shell is the operational layer that connects documentation generation to repository history.


## 25. Shell and report writing

A shell command becomes useful evidence only when its output is interpreted. A report should state what command was run, why it was run, what output mattered and what conclusion was drawn.


## Command card 1: `echo`

### Purpose

Print text or variable values.

### Example

```bash
echo "hello"
```

### Expected output

```text
hello
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Safe read-style command; useful for checking variables.


## Command card 2: `echo $SHELL`

### Purpose

Show current shell path.

### Example

```bash
echo "$SHELL"
```

### Expected output

```text
/bin/zsh or /bin/bash
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Helps identify interactive shell.


## Command card 3: `command -v`

### Purpose

Check whether a command is available.

### Example

```bash
command -v python3
```

### Expected output

```text
Path to command or no output.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Safe and useful before scripts.


## Command card 4: `type`

### Purpose

Show how shell resolves a command.

### Example

```bash
type cd
```

### Expected output

```text
Shell builtin or command path.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Useful for aliases/functions/builtins.


## Command card 5: `pwd`

### Purpose

Print current working directory.

### Example

```bash
pwd
```

### Expected output

```text
Absolute path.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Essential before relative-path scripts.


## Command card 6: `cd`

### Purpose

Change current directory.

### Example

```bash
cd /Users/antonmorosi/linux-network-security-lab
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

State-changing in shell context.


## Command card 7: `export`

### Purpose

Set environment variable for child processes.

### Example

```bash
export NAME=value
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Affects commands launched from that shell.


## Command card 8: `env`

### Purpose

Print environment variables.

### Example

```bash
env
```

### Expected output

```text
List of KEY=value lines.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

May contain sensitive data; review before publishing.


## Command card 9: `set`

### Purpose

Change shell options or display variables.

### Example

```bash
set -euo pipefail
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Common in robust scripts.


## Command card 10: `bash script.sh`

### Purpose

Run a script with bash.

### Example

```bash
bash ~/Downloads/file.txt
```

### Expected output

```text
Script output.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Preferred for repository patch txt scripts.


## Command card 11: `chmod +x`

### Purpose

Make file executable.

### Example

```bash
chmod +x script.sh
```

### Expected output

```text
No output if successful.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Changes file mode.


## Command card 12: `echo $?`

### Purpose

Print previous command exit code.

### Example

```bash
echo $?
```

### Expected output

```text
0 or non-zero code.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Useful after a command fails.


## Command card 13: `pipe`

### Purpose

Connect commands.

### Example

```bash
ps aux | grep python
```

### Expected output

```text
Filtered process lines.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Safe if commands are safe.


## Command card 14: `>`

### Purpose

Redirect stdout and overwrite file.

### Example

```bash
echo hello > file.txt
```

### Expected output

```text
No terminal output.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Can overwrite files.


## Command card 15: `>>`

### Purpose

Redirect stdout and append file.

### Example

```bash
echo hello >> file.txt
```

### Expected output

```text
No terminal output.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Safer than overwrite but still modifies file.


## Command card 16: `2>`

### Purpose

Redirect stderr.

### Example

```bash
command 2> errors.txt
```

### Expected output

```text
Errors written to file.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Useful for diagnostics.


## Command card 17: `tee`

### Purpose

Write output to screen and file.

### Example

```bash
command | tee output.txt
```

### Expected output

```text
Output displayed and saved.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Good for report capture.


## Command card 18: `history`

### Purpose

Show command history.

### Example

```bash
history
```

### Expected output

```text
Previous commands.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

May contain sensitive data.


## Command card 19: `man`

### Purpose

Open manual page.

### Example

```bash
man ls
```

### Expected output

```text
Manual page.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Safe reference command.


## Command card 20: `--help`

### Purpose

Show command help.

### Example

```bash
ls --help
```

### Expected output

```text
Help text.
```

### Interpretation

This command helps understand shell behavior, command availability, environment, script execution or output control. The important point is to identify whether the shell is reading state, changing shell context, modifying a file or launching another program.

### Safety note

Some macOS commands differ.


## Terminal and shell study card 1: Terminal interface

### Concept

The terminal shows input and output, but it is not itself the command interpreter.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 2: Shell parser

### Concept

The shell parses commands before programs receive arguments.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 3: Spaces

### Concept

Spaces separate arguments unless protected by quotes.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 4: Single quotes

### Concept

Single quotes preserve literal text and prevent variable expansion.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 5: Double quotes

### Concept

Double quotes preserve spaces but still allow variable expansion.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 6: Variables

### Concept

Variables store values that scripts and commands can reuse.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 7: PATH

### Concept

PATH controls where commands are searched.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 8: Exit codes

### Concept

Exit codes communicate success or failure.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 9: Pipes

### Concept

Pipes connect stdout of one command to stdin of another.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 10: Redirection

### Concept

Redirection sends output to files or reads input from files.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 11: Heredocs

### Concept

Heredocs are used to pass multi-line text into commands.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 12: Quoted heredocs

### Concept

Quoted heredocs prevent the shell from interpreting Markdown or variables.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 13: Script permissions

### Concept

Execute permission matters for ./script.sh but not for bash script.sh.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 14: Wrong shell

### Concept

Running bash syntax in zsh can create confusing errors.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 15: Command not found

### Concept

This usually means a missing command or PATH problem.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 16: Permission denied

### Concept

This usually means missing execute bit or insufficient file permissions.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 17: No such file

### Concept

This usually means wrong path or wrong current directory.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 18: Syntax error

### Concept

This usually means parsing failed before the intended command ran.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 19: Safe patch execution

### Concept

Patch scripts should be run as files, not pasted into the terminal.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 20: Report evidence

### Concept

Shell output should be interpreted before being included in documentation.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 21: Terminal interface

### Concept

The terminal shows input and output, but it is not itself the command interpreter.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 22: Shell parser

### Concept

The shell parses commands before programs receive arguments.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 23: Spaces

### Concept

Spaces separate arguments unless protected by quotes.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 24: Single quotes

### Concept

Single quotes preserve literal text and prevent variable expansion.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 25: Double quotes

### Concept

Double quotes preserve spaces but still allow variable expansion.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 26: Variables

### Concept

Variables store values that scripts and commands can reuse.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 27: PATH

### Concept

PATH controls where commands are searched.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 28: Exit codes

### Concept

Exit codes communicate success or failure.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 29: Pipes

### Concept

Pipes connect stdout of one command to stdin of another.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 30: Redirection

### Concept

Redirection sends output to files or reads input from files.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 31: Heredocs

### Concept

Heredocs are used to pass multi-line text into commands.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 32: Quoted heredocs

### Concept

Quoted heredocs prevent the shell from interpreting Markdown or variables.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 33: Script permissions

### Concept

Execute permission matters for ./script.sh but not for bash script.sh.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 34: Wrong shell

### Concept

Running bash syntax in zsh can create confusing errors.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 35: Command not found

### Concept

This usually means a missing command or PATH problem.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 36: Permission denied

### Concept

This usually means missing execute bit or insufficient file permissions.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 37: No such file

### Concept

This usually means wrong path or wrong current directory.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 38: Syntax error

### Concept

This usually means parsing failed before the intended command ran.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 39: Safe patch execution

### Concept

Patch scripts should be run as files, not pasted into the terminal.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 40: Report evidence

### Concept

Shell output should be interpreted before being included in documentation.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 41: Terminal interface

### Concept

The terminal shows input and output, but it is not itself the command interpreter.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 42: Shell parser

### Concept

The shell parses commands before programs receive arguments.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 43: Spaces

### Concept

Spaces separate arguments unless protected by quotes.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 44: Single quotes

### Concept

Single quotes preserve literal text and prevent variable expansion.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 45: Double quotes

### Concept

Double quotes preserve spaces but still allow variable expansion.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 46: Variables

### Concept

Variables store values that scripts and commands can reuse.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 47: PATH

### Concept

PATH controls where commands are searched.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 48: Exit codes

### Concept

Exit codes communicate success or failure.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 49: Pipes

### Concept

Pipes connect stdout of one command to stdin of another.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 50: Redirection

### Concept

Redirection sends output to files or reads input from files.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 51: Heredocs

### Concept

Heredocs are used to pass multi-line text into commands.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 52: Quoted heredocs

### Concept

Quoted heredocs prevent the shell from interpreting Markdown or variables.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 53: Script permissions

### Concept

Execute permission matters for ./script.sh but not for bash script.sh.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 54: Wrong shell

### Concept

Running bash syntax in zsh can create confusing errors.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 55: Command not found

### Concept

This usually means a missing command or PATH problem.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 56: Permission denied

### Concept

This usually means missing execute bit or insufficient file permissions.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 57: No such file

### Concept

This usually means wrong path or wrong current directory.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 58: Syntax error

### Concept

This usually means parsing failed before the intended command ran.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 59: Safe patch execution

### Concept

Patch scripts should be run as files, not pasted into the terminal.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 60: Report evidence

### Concept

Shell output should be interpreted before being included in documentation.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 61: Terminal interface

### Concept

The terminal shows input and output, but it is not itself the command interpreter.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 62: Shell parser

### Concept

The shell parses commands before programs receive arguments.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 63: Spaces

### Concept

Spaces separate arguments unless protected by quotes.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 64: Single quotes

### Concept

Single quotes preserve literal text and prevent variable expansion.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 65: Double quotes

### Concept

Double quotes preserve spaces but still allow variable expansion.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 66: Variables

### Concept

Variables store values that scripts and commands can reuse.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 67: PATH

### Concept

PATH controls where commands are searched.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 68: Exit codes

### Concept

Exit codes communicate success or failure.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.


## Terminal and shell study card 69: Pipes

### Concept

Pipes connect stdout of one command to stdin of another.

### Practical check

```bash
pwd
echo "$SHELL"
command -v bash
echo $?
```

These commands help identify the current location, the active shell, whether bash is available and whether the previous command succeeded.

### Interpretation pattern

A good interpretation should explain what the shell did before the command ran. Many failures happen before the target program starts because the shell expanded, split, redirected or interpreted something unexpectedly.

### Repository connection

This concept is directly connected to the patch scripts used throughout the repository. The correct pattern is to execute the downloaded `.txt` file with `bash`, not paste its internal Markdown-producing content into the interactive shell.

### Safety note

Shell parsing mistakes can create real file changes. Be especially careful with redirection, wildcards, command substitution and destructive commands.
