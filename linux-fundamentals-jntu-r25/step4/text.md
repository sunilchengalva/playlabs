# Step 4 — Permissions & Ownership

## Reading the permission string

```bash
ls -l ~/lab/scripts/hello.sh
```

Output: `-rw-r--r-- 1 root root 86 Jan 15 hello.sh`

```
- rw- r-- r--
│ │   │   └── other  : read only
│ │   └────── group  : read only
│ └────────── owner  : read + write
└──────────── type   : - regular file, d directory, l symlink
```

Each permission set uses three bits: **r**ead (4), **w**rite (2), e**x**ecute (1).

## `chmod` — symbolic mode

```bash
# Add execute for the owner
chmod u+x ~/lab/scripts/hello.sh

# Remove write for group and other
chmod go-w ~/lab/data/server.log

# Multiple changes in one command
chmod u+x,g-w,o-r ~/lab/secret.conf
```

## `chmod` — octal mode

Add r + w + x values for each of owner / group / other:

| Octal | Binary | Meaning |
|-------|--------|---------|
| 7 | rwx | read + write + execute |
| 6 | rw- | read + write |
| 5 | r-x | read + execute |
| 4 | r-- | read only |
| 0 | --- | no permissions |

```bash
chmod 755 ~/lab/scripts/hello.sh   # rwxr-xr-x  — executable script
chmod 644 ~/lab/data/students.csv  # rw-r--r--  — readable data file
chmod 600 ~/lab/secret.conf        # rw-------  — private file
```

After making the script executable, run it:

```bash
~/lab/scripts/hello.sh
```

## `chown` — change owner and group

```bash
# Change owner
chown root ~/lab/data/students.csv

# Change owner and group together
chown root:root ~/lab/data/server.log
```

## `chgrp` — change group only

```bash
chgrp root ~/lab/data/students.csv
```

## `umask` — default permission mask

```bash
umask          # shows current mask, typically 0022
# New file = 666 − 022 = 644
# New dir  = 777 − 022 = 755
```

## Soft and hard links

```bash
# Soft (symbolic) link — like a shortcut
ln -s ~/lab/data/students.csv ~/lab/students_link.csv
ls -l ~/lab/students_link.csv

# Hard link — another name for the same inode
ln ~/lab/data/server.log ~/lab/server_hardlink.log
```

---

## Task ✅

```bash
chmod 755 ~/lab/scripts/hello.sh
chmod 644 ~/lab/data/students.csv
chmod 600 ~/lab/secret.conf
```
