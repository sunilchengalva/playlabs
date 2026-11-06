#!/bin/bash
# combined.txt must exist
[ -f /root/lab/jntu/sem1/combined.txt ] || exit 1
# Must contain at least 25 lines (tolerates minor variation)
lines=$(wc -l < /root/lab/jntu/sem1/combined.txt)
[ "$lines" -ge 25 ] || exit 1
exit 0
