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

---

## Build your own hierarchy first

Before exploring system directories, create a small tree of your own. This is what you will navigate in all the exercises below.

```bash
mkdir -p ~/myproject/src
```

```bash
mkdir -p ~/myproject/docs
```

```bash
mkdir -p ~/myproject/config
```

```bash
touch ~/myproject/src/app.py
```

```bash
touch ~/myproject/src/utils.py
```

```bash
touch ~/myproject/docs/notes.txt
```

```bash
touch ~/myproject/config/settings.conf
```

Verify the whole tree at once:

```bash
ls -lR ~/myproject
```

---

## Navigate your tree

```bash
pwd
```

```bash
cd ~/myproject
```

```bash
pwd
```

```bash
ls
```

```bash
ls -l
```

```bash
ls -a
```

```bash
ls -lh
```

```bash
cd src
```

```bash
pwd
```

```bash
ls
```

```bash
cd ~/myproject/docs
```

```bash
pwd
```

```bash
cd ~
```

```bash
pwd
```

```bash
cd -
```

```bash
pwd
```

---

## Explore system directories

Now that you are comfortable with navigation, take a look at the system hierarchy. Each command below is independent — run them one at a time and read the output.

```bash
ls /bin
```

```bash
ls /etc
```

```bash
ls /var/log
```

```bash
ls /tmp
```

```bash
cat /etc/os-release
```

```bash
df -h
```

This step is exploratory — no verifier. Click **Continue** when ready.
