#!/bin/bash
# top_students.txt must exist with at least 3 names (Arjun 88, Rahul 91, Meera 82, Ananya 95)
[ -f /root/lab/jntu/top_students.txt ] || exit 1
count=$(wc -l < /root/lab/jntu/top_students.txt)
[ "$count" -ge 3 ] || exit 1
# server_updated.log must contain CRITICAL and must NOT contain ERROR
[ -f /root/lab/jntu/server_updated.log ] || exit 1
grep -q "CRITICAL" /root/lab/jntu/server_updated.log || exit 1
grep -q "ERROR"    /root/lab/jntu/server_updated.log && exit 1
exit 0
