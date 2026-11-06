#!/bin/bash
# Pass if hello-node:1.0 image exists AND container responds on port 3000
docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "hello-node:1.0" || exit 1
curl -sf http://localhost:3000 | grep -qi "node\|docker\|hello" || exit 1
exit 0
