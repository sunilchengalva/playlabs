#!/bin/bash
# Pass if the compose stack is running and Flask responds with a hit count
cd /root/apps/compose-app 2>/dev/null || exit 1
docker compose ps 2>/dev/null | grep -q "running\|Up" || exit 1
curl -sf http://localhost:5000 | grep -qi "visit\|hit\|count\|#" || exit 1
exit 0
