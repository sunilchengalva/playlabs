# Step 5 — I/O Redirection & Pipes

## The three standard streams

Every Linux process has three streams open by default:

| Stream | File Descriptor | Default destination |
|--------|----------------|---------------------|
| stdin  | 0 | Keyboard |
| stdout | 1 | Terminal |
| stderr | 2 | Terminal |

## Redirecting stdout

```bash
# Overwrite — creates or replaces the file
echo "Linux Lab Report" > ~/lab/jntu/report.txt

# Append — adds to the end without overwriting
echo "Date: $(date)" >> ~/lab/jntu/report.txt
cat ~/lab/jntu/report.txt

# Redirect command output to a file
ls -l /etc > ~/lab/jntu/etc_listing.txt
wc -l ~/lab/jntu/etc_listing.txt
```

## Redirecting stderr

```bash
# Errors go to a separate file
ls /no_such_dir 2> ~/lab/jntu/errors.txt
cat ~/lab/jntu/errors.txt

# Redirect both stdout and stderr to the same file
ls /etc /no_such_dir > ~/lab/jntu/all_output.txt 2>&1
cat ~/lab/jntu/all_output.txt
```

## Redirecting stdin

```bash
# Feed a file into a command as input
wc -l < ~/lab/data/server.log
sort < ~/lab/data/students.csv
```

## Pipes `|`

A pipe connects the stdout of one command directly to the stdin of the next. No temp files needed.

```bash
# How many ERROR lines are in the log?
grep "ERROR" ~/lab/data/server.log | wc -l

# List /etc files, sort them, show the first 8
ls /etc | sort | head -8

# What unique branches exist in the student data?
cut -d',' -f3 ~/lab/data/students.csv | sort | uniq

# Chain three commands
cat ~/lab/data/students.csv | grep "CSE" | wc -l
```

## `tee` — write to file AND keep output on screen

```bash
ls /etc | tee ~/lab/jntu/etc_list.txt | wc -l
# The file is written AND the line count appears on screen
```

---

## Task ✅

```bash
# Save only the ERROR lines from server.log to a file
grep "ERROR" ~/lab/data/server.log > ~/lab/jntu/errors_only.txt

# Count total characters in students.csv using stdin redirection
wc -c < ~/lab/data/students.csv > ~/lab/jntu/char_count.txt
```
