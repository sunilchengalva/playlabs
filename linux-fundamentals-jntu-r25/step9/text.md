# Step 9 — Shell Scripting Basics

A shell script is a text file containing a sequence of shell commands. It starts with a **shebang** line that tells the OS which interpreter to use.

---

## Your first script

The heredoc below (`<< 'EOF' ... EOF`) creates the file in one shot — it must stay as one block:

```bash
cat > ~/lab/scripts/greet.sh << 'EOF'
#!/bin/bash
echo "Hello, $1!"
echo "Running as  : $(whoami)"
echo "Arguments   : $#"
echo "Exit status : $?"
EOF
```

Make it executable:

```bash
chmod +x ~/lab/scripts/greet.sh
```

Run it:

```bash
~/lab/scripts/greet.sh "JNTU Student"
```

---

## Variables

Assign variables (no spaces around `=`):

```bash
name="Linux"
```

```bash
version=5.15
```

Use them:

```bash
echo "Kernel: $name $version"
```

Special variables — run each one to see its value:

```bash
echo "Script name     : $0"
```

```bash
echo "Last exit code  : $?"
```

```bash
echo "Current PID     : $$"
```

Command substitution — the output of a command becomes the value:

```bash
today=$(date +%Y-%m-%d)
```

```bash
echo "Today is $today"
```

---

## Conditionals

Write the script (heredoc — stays as one block):

```bash
cat > ~/lab/scripts/check_marks.sh << 'EOF'
#!/bin/bash
marks=$1
if [ "$marks" -ge 90 ]; then
    echo "Grade: A+"
elif [ "$marks" -ge 75 ]; then
    echo "Grade: A"
elif [ "$marks" -ge 60 ]; then
    echo "Grade: B"
elif [ "$marks" -ge 50 ]; then
    echo "Grade: C"
else
    echo "Grade: F — Please re-appear"
fi
EOF
```

Make it executable:

```bash
chmod +x ~/lab/scripts/check_marks.sh
```

Test with different marks:

```bash
~/lab/scripts/check_marks.sh 88
```

```bash
~/lab/scripts/check_marks.sh 45
```

```bash
~/lab/scripts/check_marks.sh 60
```

---

## `for` loop

Write the script:

```bash
cat > ~/lab/scripts/list_branches.sh << 'EOF'
#!/bin/bash
echo "JNTU Branches:"
for branch in CSE IT ECE MECH CIVIL; do
    echo "  - $branch"
done
echo "Total: 5 branches"
EOF
```

Make it executable:

```bash
chmod +x ~/lab/scripts/list_branches.sh
```

Run it:

```bash
~/lab/scripts/list_branches.sh
```

---

## `while` loop

Write the script:

```bash
cat > ~/lab/scripts/countdown.sh << 'EOF'
#!/bin/bash
count=5
while [ $count -gt 0 ]; do
    echo "Countdown: $count"
    count=$((count - 1))
done
echo "Launch!"
EOF
```

Make it executable:

```bash
chmod +x ~/lab/scripts/countdown.sh
```

Run it:

```bash
~/lab/scripts/countdown.sh
```

---

## Reading user input

Write the script:

```bash
cat > ~/lab/scripts/ask_name.sh << 'EOF'
#!/bin/bash
echo -n "Enter your name: "
read username
echo "Welcome, $username! Ready to learn Linux."
EOF
```

Make it executable:

```bash
chmod +x ~/lab/scripts/ask_name.sh
```

Run it:

```bash
~/lab/scripts/ask_name.sh
```

---

## Task ✅

Write the final report script (heredoc — stays as one block):

```bash
cat > ~/lab/report.sh << 'EOF'
#!/bin/bash
CSV=~/lab/data/students.csv

echo "=== JNTU Student Report ==="
echo ""

a_count=$(awk -F',' 'NR>1 && ($5=="A" || $5=="A+") {count++} END {print count+0}' "$CSV")
echo "Students with A/A+ grade : $a_count"

top=$(awk -F',' 'NR>1' "$CSV" | sort -t',' -k4 -nr | head -1 | cut -d',' -f2)
echo "Top student               : $top"

total=$(awk -F',' 'NR>1 {count++} END {print count+0}' "$CSV")
echo "Total students            : $total"
EOF
```

Make it executable:

```bash
chmod +x ~/lab/report.sh
```

Run it:

```bash
~/lab/report.sh
```
