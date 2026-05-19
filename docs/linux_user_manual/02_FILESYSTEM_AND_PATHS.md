# Filesystem and Paths

Linux organizes files in a tree starting from the root directory `/`.

Unlike Windows, where drives are usually shown as `C:\` or `D:\`, Linux mounts filesystems into one unified tree. Every absolute path starts from `/`.

## Important directories

| Path | Meaning |
|---|---|
| `/` | Root of the filesystem |
| `/home` | User home directories |
| `/etc` | System configuration |
| `/var` | Variable data such as logs and caches |
| `/tmp` | Temporary files |
| `/usr` | User-space programs and libraries |
| `/bin` | Essential binaries |
| `/sbin` | System binaries |
| `/opt` | Optional third-party software |
| `/proc` | Virtual process/kernel information |
| `/dev` | Device files |

## Common commands

```bash
pwd
ls -la
cd /path/to/folder
mkdir new_folder
touch file.txt
cp source target
mv old new
rm file.txt
find . -name "*.md"
du -sh .
df -h
```

## Expected output examples

```bash
pwd
```

```text
/home/anton/projects/linux-network-security-lab
```

```bash
ls -la
```

```text
drwxr-xr-x  8 anton anton 4096 May 20 10:00 .
drwxr-xr-x 12 anton anton 4096 May 20 09:50 ..
-rw-r--r--  1 anton anton 1200 May 20 10:00 README.md
drwxr-xr-x  2 anton anton 4096 May 20 10:00 docs
```

## Safety notes

`ls`, `pwd`, `find`, `du` and `df` are generally safe.

Be careful with:

```bash
rm
rm -r
rm -rf
mv
chmod
chown
```

These commands can remove or change important files if used incorrectly.
