# Step 6 — Text Processing Tools

## `grep` — search for patterns

Basic match (case-sensitive):

```bash
grep "ERROR" ~/lab/data/server.log
```

Case-insensitive search:

```bash
grep -i "error" ~/lab/data/server.log
```

Show line numbers alongside matches:

```bash
grep -n "INFO" ~/lab/data/server.log
```

Count matching lines only:

```bash
grep -c "INFO" ~/lab/data/server.log
```

Invert — show lines that do NOT match:

```bash
grep -v "INFO" ~/lab/data/server.log
```

Recursive search through a directory:

```bash
grep -r "port" ~/lab/projects/
```

Match multiple patterns with `-E`:

```bash
grep -E "ERROR|WARNING" ~/lab/data/server.log
```

---

## `sort` — sort lines

Alphabetical (default):

```bash
sort ~/lab/data/students.csv
```

Reverse order:

```bash
sort -r ~/lab/data/students.csv
```

Sort by field 4 (Marks), comma-delimited, numeric:

```bash
sort -t',' -k4 -n ~/lab/data/students.csv
```

Sort descending by marks:

```bash
sort -t',' -k4 -nr ~/lab/data/students.csv
```

---

## `uniq` — remove or count duplicates

Unique branches (pipeline — must be combined):

```bash
cut -d',' -f3 ~/lab/data/students.csv | sort | uniq
```

Count how many students are in each branch:

```bash
cut -d',' -f3 ~/lab/data/students.csv | sort | uniq -c
```

---

## `cut` — extract columns

Extract field 2 (Name), comma-delimited:

```bash
cut -d',' -f2 ~/lab/data/students.csv
```

Extract fields 2 and 4 (Name and Marks):

```bash
cut -d',' -f2,4 ~/lab/data/students.csv
```

---

## `tr` — translate or delete characters

Convert to uppercase:

```bash
echo "hello jntu" | tr 'a-z' 'A-Z'
```

Delete spaces:

```bash
echo "roll no : 22CS001" | tr -d ' '
```

Replace colons with equals signs:

```bash
cat ~/lab/projects/api/config.txt | tr ':' '='
```

---

## `sed` — stream editor

Replace the first occurrence per line:

```bash
sed 's/INFO/LOG/' ~/lab/data/server.log
```

Replace ALL occurrences per line (global flag `g`):

```bash
sed 's/INFO/LOG/g' ~/lab/data/server.log
```

Delete lines that match a pattern:

```bash
sed '/WARNING/d' ~/lab/data/server.log
```

Save the result to a new file:

```bash
sed 's/ERROR/CRITICAL/g' ~/lab/data/server.log > ~/lab/jntu/server_updated.log
```

---

## `awk` — field-based processing

Print specific fields (comma-delimited):

```bash
awk -F',' '{print $1, $2}' ~/lab/data/students.csv
```

Skip the header row (`NR>1`) and filter by marks greater than 80:

```bash
awk -F',' 'NR>1 && $4 > 80 {print $2, $4}' ~/lab/data/students.csv
```

Sum all marks:

```bash
awk -F',' 'NR>1 {sum += $4} END {print "Total marks:", sum}' ~/lab/data/students.csv
```

---

## Task ✅

Save the names of students who scored more than 80 marks:

```bash
awk -F',' 'NR>1 && $4 > 80 {print $2}' ~/lab/data/students.csv > ~/lab/jntu/top_students.txt
```

Replace every occurrence of ERROR with CRITICAL in the log:

```bash
sed 's/ERROR/CRITICAL/g' ~/lab/data/server.log > ~/lab/jntu/server_updated.log
```
