#!/bin/bash
# bg_pid.txt must exist and contain a number
[ -f /root/lab/jntu/bg_pid.txt ] || exit 1
grep -qE "^[0-9]+$" /root/lab/jntu/bg_pid.txt || exit 1
# No sleep processes should still be running
pgrep -x sleep > /dev/null 2>&1 && exit 1
# Crontab must contain the hostname job
crontab -l 2>/dev/null | grep -q "hostname" || exit 1
exit 0
