# Permissions Table

| Permission | Symbol | Numeric value | Meaning |
|---|---|---:|---|
| Read | `r` | 4 | Read file or list directory |
| Write | `w` | 2 | Modify file or directory contents |
| Execute | `x` | 1 | Execute file or enter directory |

| Mode | Meaning |
|---|---|
| `644` | owner read/write, group read, others read |
| `600` | owner read/write only |
| `755` | owner all, group read/execute, others read/execute |
| `700` | owner all only |
| `777` | everyone all permissions; usually avoid |
