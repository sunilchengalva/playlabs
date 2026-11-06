#!/bin/bash
# jntustudent user must exist
id jntustudent > /dev/null 2>&1 || exit 1
# jntulab group must exist
getent group jntulab > /dev/null 2>&1 || exit 1
# jntustudent must be a member of jntulab
id jntustudent | grep -q "jntulab" || exit 1
# user_info.txt must exist
[ -f /root/lab/jntu/user_info.txt ] || exit 1
exit 0
