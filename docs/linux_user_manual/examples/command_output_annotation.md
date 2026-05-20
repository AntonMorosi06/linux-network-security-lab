# Command Output Annotation Example

Command:

```bash
ls -la scripts/local_health_check.sh
```

Example output:

```text
-rwxr-xr-x  1 antonmorosi  staff  1420 May 20 02:00 scripts/local_health_check.sh
```

| Field | Value | Meaning |
|---|---|---|
| file type | `-` | regular file |
| owner permissions | `rwx` | owner can read, write and execute |
| group permissions | `r-x` | group can read and execute |
| others permissions | `r-x` | others can read and execute |
| owner | `antonmorosi` | file owner |
| group | `staff` | owning group |
| size | `1420` | file size in bytes |
| path | `scripts/local_health_check.sh` | target script |
