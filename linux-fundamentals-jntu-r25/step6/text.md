# Step 6 — Text Processing Tools

## `grep` — search for patterns

```bash
# Basic match (case-sensitive)
grep "ERROR" ~/lab/data/server.log

# Case-insensitive
grep -i "error" ~/lab/data/server.log

# Show line numbers
grep -n "INFO" ~/lab/data/server.log

# Count matching lines
grep -c "INFO" ~/lab/data/server.log

# Invert — show lines that do NOT match
grep -v "INFO" ~/lab/data/server.log

# Recursive search through a directory
grep -r "port" ~/lab/projects/

# Multiple patterns with -E (extended regex)
grep -E "ERROR|WARNING" ~/lab/data/server.log
```

## `sort` — sort lines

```bash
# Alphabetical (default)
sort ~/lab/data/students.csv

# Reverse order
sort -r ~/lab/data/students.csv

# Sort by field 4 (Marks), comma-delimited, numeric
sort -t',' -k4 -n ~/lab/data/students.csv

# Sort descending by marks
sort -t',' -k4 -nr ~/lab/data/students.csv
```

## `uniq` — remove or count duplicates

```bash
# Extract the Branch column and count each unique value
cut -d',' -f3 ~/lab/data/students.csv | sort | uniq

# Count occurrences
cut -d',' -f3 ~/lab/data/students.csv | sort | uniq -c
```

## `cut` — extract columns

```bash
# Extract field 2 (Name), comma-delimited
cut -d',' -f2 ~/lab/data/students.csv

# Extract fields 2 and 4 (Name and Marks)
cut -d',' -f2,4 ~/lab/data/students.csv
```

## `tr` — translate or delete characters

```bash
# Convert to uppercase
echo "hello jntu" | tr 'a-z' 'A-Z'

# Delete spaces
echo "roll no : 22CS001" | tr -d ' '

# Replace colons with equals signs
cat ~/lab/projects/api/config.txt | tr ':' '='
```

## `sed` — stream editor (substitution)

```bash
# Replace first occurrence per line
sed 's/INFO/LOG/' ~/lab/data/server.log

# Replace ALL occurrences per line (global flag g)
sed 's/INFO/LOG/g' ~/lab/data/server.log

# Delete lines that match a pattern
sed '/WARNING/d' ~/lab/data/server.log

# Save result to a new file
sed 's/ERROR/CRITICAL/g' ~/lab/data/server.log > ~/lab/jntu/server_updated.log
```

## `awk` — field-based processing

```bash
# Print specific fields (comma-delimited)
awk -F',' '{print $1, $2}' ~/lab/data/students.csv

# Skip header row (NR>1) and filter by marks > 80
awk -F',' 'NR>1 && $4 > 80 {print $2, $4}' ~/lab/data/students.csv

# Sum all marks
awk -F',' 'NR>1 {sum += $4} END {print "Total marks:", sum}' ~/lab/data/students.csv
```

---

## Task ✅

```bash
# Save names of students who scored more than 80 marks
awk -F',' 'NR>1 && $4 > 80 {print $2}' ~/lab/data/students.csv > ~/lab/jntu/top_students.txt

# Replace every occurrence of ERROR with CRITICAL in the log
sed 's/ERROR/CRITICAL/g' ~/lab/data/server.log > ~/lab/jntu/server_updated.log
```
