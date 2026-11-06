#!/bin/bash
# hello.sh must be 755
perm=$(stat -c "%a" /root/lab/scripts/hello.sh 2>/dev/null)
[ "$perm" = "755" ] || exit 1
# students.csv must be 644
perm2=$(stat -c "%a" /root/lab/data/students.csv 2>/dev/null)
[ "$perm2" = "644" ] || exit 1
# secret.conf must be 600
perm3=$(stat -c "%a" /root/lab/secret.conf 2>/dev/null)
[ "$perm3" = "600" ] || exit 1
exit 0
