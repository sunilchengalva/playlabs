# Step 5 — I/O Redirection & Pipes

## The three standard streams

Every Linux process has three streams open by default:

| Stream | File Descriptor | Default destination |
|--------|----------------|---------------------|
| stdin  | 0 | Keyboard |
| stdout | 1 | Terminal |
| stderr | 2 | Terminal |

---

## Redirecting stdout

Overwrite — creates or replaces the file:

```bash
echo "Linux Lab Report" > ~/lab/jntu/report.txt
```

Append — adds to the end without overwriting:

```bash
echo "Date: $(date)" >> ~/lab/jntu/report.txt
```

Read it back to confirm both lines are there:

```bash
cat ~/lab/jntu/report.txt
```

Redirect command output to a file:

```bash
ls -l /etc > ~/lab/jntu/etc_listing.txt
```

Confirm how many lines were written:

```bash
wc -l ~/lab/jntu/etc_listing.txt
```

---

## Redirecting stderr

Send errors to a separate file:

```bash
ls /no_such_dir 2> ~/lab/jntu/errors.txt
```

```bash
cat ~/lab/jntu/errors.txt
```

Redirect both stdout and stderr into the same file:

```bash
ls /etc /no_such_dir > ~/lab/jntu/all_output.txt 2>&1
```

```bash
cat ~/lab/jntu/all_output.txt
```

---

## Redirecting stdin

Feed a file into a command as input:

```bash
wc -l < ~/lab/data/server.log
```

```bash
sort < ~/lab/data/students.csv
```

---

## Pipes `|`

A pipe connects the stdout of one command directly to the stdin of the next — no temporary files needed. Each pipeline below is one logical unit:

Count how many ERROR lines exist in the log:

```bash
grep "ERROR" ~/lab/data/server.log | wc -l
```

List `/etc` files, sort them, show the first 8:

```bash
ls /etc | sort | head -8
```

Show unique branches from the student data:

```bash
cut -d',' -f3 ~/lab/data/students.csv | sort | uniq
```

Count how many CSE students are in the file:

```bash
cat ~/lab/data/students.csv | grep "CSE" | wc -l
```

---

## `tee` — write to a file AND keep output on screen

```bash
ls /etc | tee ~/lab/jntu/etc_list.txt | wc -l
```

---

## Task ✅

Save only the ERROR lines from server.log:

```bash
grep "ERROR" ~/lab/data/server.log > ~/lab/jntu/errors_only.txt
```

Count total characters in students.csv using stdin redirection:

```bash
wc -c < ~/lab/data/students.csv > ~/lab/jntu/char_count.txt
```
