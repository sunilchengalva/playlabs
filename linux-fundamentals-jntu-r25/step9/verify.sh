#!/bin/bash
# report.sh must exist and be executable
[ -x /root/lab/report.sh ] || exit 1
# Run it and capture output
output=$(bash /root/lab/report.sh 2>/dev/null)
# Must report on A/A+ students
echo "$output" | grep -qi "A/A+" || exit 1
# Must report the top student
echo "$output" | grep -qi "Top student" || exit 1
# Must report total students
echo "$output" | grep -qi "Total students" || exit 1
exit 0
