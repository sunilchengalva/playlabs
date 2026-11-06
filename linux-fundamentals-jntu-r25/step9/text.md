# Step 9 — Shell Scripting Basics

A shell script is a text file containing a sequence of shell commands. It starts with a **shebang** line that tells the OS which interpreter to use.

## Your first script

```bash
cat > ~/lab/scripts/greet.sh << 'EOF'
#!/bin/bash
echo "Hello, $1!"
echo "Running as  : $(whoami)"
echo "Arguments   : $#"
echo "Exit status : $?"
EOF

chmod +x ~/lab/scripts/greet.sh
~/lab/scripts/greet.sh "JNTU Student"
```

## Variables

```bash
# Assign (no spaces around =)
name="Linux"
version=5.15
echo "Kernel: $name $version"

# Special variables
echo "Script name     : $0"
echo "First argument  : $1"
echo "Argument count  : $#"
echo "All arguments   : $@"
echo "Last exit code  : $?"
echo "Current PID     : $$"

# Command substitution
today=$(date +%Y-%m-%d)
echo "Today is $today"
```

## Conditionals

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

chmod +x ~/lab/scripts/check_marks.sh
~/lab/scripts/check_marks.sh 88
~/lab/scripts/check_marks.sh 45
~/lab/scripts/check_marks.sh 60
```

## `for` loop

```bash
cat > ~/lab/scripts/list_branches.sh << 'EOF'
#!/bin/bash
echo "JNTU Branches:"
for branch in CSE IT ECE MECH CIVIL; do
    echo "  - $branch"
done
echo "Total: 5 branches"
EOF

chmod +x ~/lab/scripts/list_branches.sh
~/lab/scripts/list_branches.sh
```

## `while` loop

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

chmod +x ~/lab/scripts/countdown.sh
~/lab/scripts/countdown.sh
```

## Reading user input

```bash
cat > ~/lab/scripts/ask_name.sh << 'EOF'
#!/bin/bash
echo -n "Enter your name: "
read username
echo "Welcome, $username! Ready to learn Linux."
EOF

chmod +x ~/lab/scripts/ask_name.sh
~/lab/scripts/ask_name.sh
```

---

## Task ✅

Write a final report script that processes `students.csv`:

```bash
cat > ~/lab/report.sh << 'EOF'
#!/bin/bash
CSV=~/lab/data/students.csv

echo "=== JNTU Student Report ==="
echo ""

# Count students with Grade A or A+
a_count=$(awk -F',' 'NR>1 && ($5=="A" || $5=="A+") {count++} END {print count+0}' "$CSV")
echo "Students with A/A+ grade : $a_count"

# Student with highest marks
top=$(awk -F',' 'NR>1' "$CSV" | sort -t',' -k4 -nr | head -1 | cut -d',' -f2)
echo "Top student               : $top"

# Total number of students
total=$(awk -F',' 'NR>1 {count++} END {print count+0}' "$CSV")
echo "Total students            : $total"
EOF

chmod +x ~/lab/report.sh
~/lab/report.sh
```
