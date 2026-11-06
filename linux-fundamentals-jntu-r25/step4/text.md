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

---

## `chmod` — symbolic mode

Add execute permission for the owner:

```bash
chmod u+x ~/lab/scripts/hello.sh
```

Remove write permission for group and other:

```bash
chmod go-w ~/lab/data/server.log
```

Multiple changes in a single command (combined with commas):

```bash
chmod u+x,g-w,o-r ~/lab/secret.conf
```

---

## `chmod` — octal mode

Add r + w + x values for each of owner / group / other:

| Octal | Binary | Meaning |
|-------|--------|---------|
| 7 | rwx | read + write + execute |
| 6 | rw- | read + write |
| 5 | r-x | read + execute |
| 4 | r-- | read only |
| 0 | --- | no permissions |

Executable script (rwxr-xr-x):

```bash
chmod 755 ~/lab/scripts/hello.sh
```

Readable data file (rw-r--r--):

```bash
chmod 644 ~/lab/data/students.csv
```

Private file — owner only (rw-------):

```bash
chmod 600 ~/lab/secret.conf
```

Now run the script:

```bash
~/lab/scripts/hello.sh
```

---

## `chown` — change owner

Change owner only:

```bash
chown root ~/lab/data/students.csv
```

Change owner and group together:

```bash
chown root:root ~/lab/data/server.log
```

## `chgrp` — change group only

```bash
chgrp root ~/lab/data/students.csv
```

## `umask` — default permission mask

```bash
umask
```

Typical value is `0022`. New files get `666 − 022 = 644`, new directories get `777 − 022 = 755`.

---

## Soft and hard links

Create a soft (symbolic) link — like a shortcut:

```bash
ln -s ~/lab/data/students.csv ~/lab/students_link.csv
```

```bash
ls -l ~/lab/students_link.csv
```

Create a hard link — another name pointing to the same inode:

```bash
ln ~/lab/data/server.log ~/lab/server_hardlink.log
```

---

## Task ✅

```bash
chmod 755 ~/lab/scripts/hello.sh
```

```bash
chmod 644 ~/lab/data/students.csv
```

```bash
chmod 600 ~/lab/secret.conf
```
