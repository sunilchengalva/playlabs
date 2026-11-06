#!/bin/bash
# Pass if hello-flask:1.0 image exists AND Flask responds on port 5000
docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "hello-flask:1.0" || exit 1
curl -sf http://localhost:5000 | grep -qi "flask\|docker\|hello" || exit 1
exit 0
