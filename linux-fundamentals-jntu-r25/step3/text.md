# Step 3 — Viewing File Content

## `cat` — print the whole file

```bash
cat ~/lab/data/students.csv

# With line numbers
cat -n ~/lab/data/server.log
```

## `head` and `tail` — first and last lines

```bash
# First 10 lines (default)
head ~/lab/data/server.log

# First 5 lines
head -n 5 ~/lab/data/server.log

# Last 10 lines (default)
tail ~/lab/data/server.log

# Last 3 lines
tail -n 3 ~/lab/data/server.log

# Follow a live file (Ctrl+C to stop)
tail -f ~/lab/data/server.log
```

## `less` — page through a large file

```bash
less ~/lab/data/server.log
```

Inside `less`:
- Arrow keys or `j`/`k` to scroll
- `Space` for next page, `b` for previous
- `/ERROR` to search forward, `n` for next match
- `q` to quit

## `wc` — count lines, words, bytes

```bash
# Lines, words, bytes all at once
wc ~/lab/data/server.log

# Lines only
wc -l ~/lab/data/students.csv

# Words only
wc -w ~/lab/data/students.csv

# Bytes only
wc -c ~/lab/data/server.log
```

## Concatenate multiple files

`cat` can take multiple filenames and prints them one after the other:

```bash
cat ~/lab/data/students.csv ~/lab/projects/api/config.txt
```

## `more` — simple pager (older alternative to `less`)

```bash
more ~/lab/data/server.log
# Space to advance, q to quit
```

---

## Task ✅

Combine both data files into one and save it, then confirm its line count:

```bash
cat ~/lab/data/server.log ~/lab/data/students.csv > ~/lab/jntu/sem1/combined.txt
wc -l ~/lab/jntu/sem1/combined.txt
```

The combined file should contain **26 lines** (15 from server.log + 11 from students.csv).
