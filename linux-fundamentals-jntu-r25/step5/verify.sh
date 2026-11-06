#!/bin/bash
# errors_only.txt must exist and contain only ERROR lines (at least 3)
[ -f /root/lab/jntu/errors_only.txt ] || exit 1
count=$(grep -c "ERROR" /root/lab/jntu/errors_only.txt 2>/dev/null)
[ "$count" -ge 3 ] || exit 1
# char_count.txt must exist and contain a number
[ -f /root/lab/jntu/char_count.txt ] || exit 1
grep -qE "[0-9]+" /root/lab/jntu/char_count.txt || exit 1
exit 0
