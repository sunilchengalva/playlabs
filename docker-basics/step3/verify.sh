#!/bin/bash
# Pass if webserver is still running (didn't get accidentally removed)
docker ps --filter "name=webserver" --filter "status=running" | grep -q webserver || exit 1
exit 0
