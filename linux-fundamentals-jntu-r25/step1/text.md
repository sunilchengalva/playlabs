# Step 1 — The Linux File System

Linux organises everything in a single directory tree rooted at `/`. Every file, directory, device, and running process lives somewhere in this tree.

## The Filesystem Hierarchy Standard (FHS)

| Directory | Purpose |
|-----------|---------|
| `/` | Root — the top of the entire tree |
| `/bin` | Essential user commands (`ls`, `cp`, `mv`, `cat`…) |
| `/etc` | System-wide configuration files |
| `/home` | User home directories (`/home/alice`, `/home/bob`) |
| `/root` | Home directory for the root user |
| `/var` | Variable data — logs (`/var/log`), caches, spool |
| `/tmp` | Temporary files; cleared on reboot |
| `/usr` | Secondary hierarchy for installed programs |
| `/proc` | Virtual filesystem — live kernel and process info |
| `/dev` | Device files (disks, terminals, etc.) |

## Navigation commands

```bash
# Where are you right now?
pwd

# List current directory
ls
ls -l          # long format: permissions, owner, size, date
ls -a          # include hidden files (names starting with .)
ls -lh         # long format with human-readable sizes (KB, MB)
ls -lA /etc    # list /etc, skip . and ..
```

## Move around the tree

```bash
cd /etc        # go to /etc
pwd
ls

cd /var/log    # go to /var/log
ls

cd ~           # return to home directory (/root)
pwd

cd -           # toggle back to previous directory
```

## Explore the hierarchy

```bash
# Which Linux distribution is this?
cat /etc/os-release

# What is in /bin?
ls /bin | head -20

# How much disk space is used?
df -h

# What is in your lab directory?
ls -lR ~/lab
```

This step is exploratory. Spend a few minutes navigating around, then click **Continue**.
