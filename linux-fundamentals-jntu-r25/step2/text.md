# Step 2 — Files & Directories

## Create directories

```bash
# Single directory
mkdir ~/lab/exercise2

# Create parent and child in one command (-p flag)
mkdir -p ~/lab/exercise2/reports/2026

# Verify the structure
ls -lR ~/lab/exercise2
```

## Create and write files

```bash
# Create an empty file
touch ~/lab/exercise2/notes.txt

# Write to a file (overwrites if it exists)
echo "Linux is the foundation of modern computing." > ~/lab/exercise2/notes.txt

# Append to a file
echo "JNTU R25 Linux Fundamentals Lab" >> ~/lab/exercise2/notes.txt

# View the file
cat ~/lab/exercise2/notes.txt
```

## Copy files and directories

```bash
# Copy a single file
cp ~/lab/exercise2/notes.txt ~/lab/exercise2/notes_backup.txt

# Copy a file into a directory
cp ~/lab/exercise2/notes.txt ~/lab/exercise2/reports/

# Copy an entire directory tree (-r = recursive)
cp -r ~/lab/projects ~/lab/exercise2/projects_copy
```

## Move and rename

```bash
# Rename a file
mv ~/lab/exercise2/notes_backup.txt ~/lab/exercise2/notes_v2.txt

# Move a file into a directory
mv ~/lab/exercise2/notes_v2.txt ~/lab/exercise2/reports/
```

## Remove files and directories

```bash
# Remove a single file
rm ~/lab/exercise2/notes.txt

# Remove a directory and all its contents
rm -rf ~/lab/exercise2/projects_copy

# Remove an empty directory
rmdir ~/lab/exercise2/reports/2026
```

## Inspect files

```bash
# File type and brief info
file ~/lab/data/students.csv
file ~/lab/scripts/hello.sh

# Detailed metadata (size, permissions, timestamps)
stat ~/lab/data/server.log
```

---

## Task ✅

Run these commands exactly — the verifier will check the resulting paths and content:

```bash
mkdir -p ~/lab/jntu/sem1/unit1
echo "File System Navigation" > ~/lab/jntu/sem1/unit1/topic.txt
cp ~/lab/data/students.csv ~/lab/jntu/sem1/students_copy.csv
```
