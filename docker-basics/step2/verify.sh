#!/bin/bash
# Pass if a container named 'webserver' is running AND port 8080 responds
docker ps --filter "name=webserver" --filter "status=running" | grep -q webserver || exit 1
curl -sf http://localhost:8080 | grep -qi "nginx\|welcome" || exit 1
exit 0
