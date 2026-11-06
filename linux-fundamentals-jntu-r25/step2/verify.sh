#!/bin/bash
# Directory was created
[ -d /root/lab/jntu/sem1/unit1 ] || exit 1
# File exists with correct content
grep -q "File System Navigation" /root/lab/jntu/sem1/unit1/topic.txt || exit 1
# CSV was copied
[ -f /root/lab/jntu/sem1/students_copy.csv ] || exit 1
exit 0
