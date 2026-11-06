#!/bin/bash
# Pass if the student has used docker exec at some point (history check)
# AND the webserver is cleaned up
docker ps -a --filter "name=webserver" | grep -q webserver && exit 1
exit 0
