# Step 3 — Viewing File Content

## `cat` — print the whole file

```bash
cat ~/lab/data/students.csv
```

With line numbers:

```bash
cat -n ~/lab/data/server.log
```

## `head` — first lines

First 10 lines (default):

```bash
head ~/lab/data/server.log
```

First 5 lines:

```bash
head -n 5 ~/lab/data/server.log
```

## `tail` — last lines

Last 10 lines (default):

```bash
tail ~/lab/data/server.log
```

Last 3 lines:

```bash
tail -n 3 ~/lab/data/server.log
```

Follow a live file — new lines appear as they are written (Ctrl+C to stop):

```bash
tail -f ~/lab/data/server.log
```

## `less` — page through a large file

```bash
less ~/lab/data/server.log
```

Inside `less`:
- Arrow keys or `j`/`k` to scroll line by line
- `Space` for next page, `b` for previous
- `/ERROR` to search forward, `n` for next match
- `q` to quit

## `wc` — count lines, words, bytes

Lines, words, and bytes all at once:

```bash
wc ~/lab/data/server.log
```

Lines only:

```bash
wc -l ~/lab/data/students.csv
```

Words only:

```bash
wc -w ~/lab/data/students.csv
```

Bytes only:

```bash
wc -c ~/lab/data/server.log
```

## Concatenate multiple files

`cat` accepts multiple filenames and prints them one after the other:

```bash
cat ~/lab/data/students.csv ~/lab/projects/api/config.txt
```

## `more` — simple pager

```bash
more ~/lab/data/server.log
```

Space to advance one page, `q` to quit. `less` is preferred for most work since it supports backward scrolling.

---

## Task ✅

Combine both data files into one, then check its line count:

```bash
cat ~/lab/data/server.log ~/lab/data/students.csv > ~/lab/jntu/sem1/combined.txt
```

```bash
wc -l ~/lab/jntu/sem1/combined.txt
```

The combined file should contain **26 lines** (15 from server.log + 11 from students.csv).
