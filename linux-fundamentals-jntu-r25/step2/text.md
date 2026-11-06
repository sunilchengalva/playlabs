# Step 2 — Files & Directories

## Create directories

Single directory:

```bash
mkdir ~/lab/exercise2
```

Nested — creates the parent and child in one go (`-p` flag):

```bash
mkdir -p ~/lab/exercise2/reports/2026
```

Verify the structure:

```bash
ls -lR ~/lab/exercise2
```

## Create and write files

Create an empty file:

```bash
touch ~/lab/exercise2/notes.txt
```

Write content (overwrites if the file already exists):

```bash
echo "Linux is the foundation of modern computing." > ~/lab/exercise2/notes.txt
```

Append a second line:

```bash
echo "JNTU R25 Linux Fundamentals Lab" >> ~/lab/exercise2/notes.txt
```

View the result:

```bash
cat ~/lab/exercise2/notes.txt
```

## Copy files and directories

Copy a file:

```bash
cp ~/lab/exercise2/notes.txt ~/lab/exercise2/notes_backup.txt
```

Copy a file into a directory:

```bash
cp ~/lab/exercise2/notes.txt ~/lab/exercise2/reports/
```

Copy an entire directory tree (`-r` = recursive):

```bash
cp -r ~/lab/projects ~/lab/exercise2/projects_copy
```

## Move and rename

Rename a file:

```bash
mv ~/lab/exercise2/notes_backup.txt ~/lab/exercise2/notes_v2.txt
```

Move a file into a directory:

```bash
mv ~/lab/exercise2/notes_v2.txt ~/lab/exercise2/reports/
```

## Remove files and directories

Remove a single file:

```bash
rm ~/lab/exercise2/notes.txt
```

Remove a directory and all its contents:

```bash
rm -rf ~/lab/exercise2/projects_copy
```

Remove an empty directory:

```bash
rmdir ~/lab/exercise2/reports/2026
```

## Inspect files

File type and brief description:

```bash
file ~/lab/data/students.csv
```

```bash
file ~/lab/scripts/hello.sh
```

Detailed metadata — size, permissions, timestamps:

```bash
stat ~/lab/data/server.log
```

---

## Task ✅

Run each command below, then click **Check**:

```bash
mkdir -p ~/lab/jntu/sem1/unit1
```

```bash
echo "File System Navigation" > ~/lab/jntu/sem1/unit1/topic.txt
```

```bash
cp ~/lab/data/students.csv ~/lab/jntu/sem1/students_copy.csv
```
