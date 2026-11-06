#!/bin/bash
# Pass if both the slow and fast images were built
docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "hello-node:slow" || exit 1
docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "hello-node:fast\|hello-node:1.0" || exit 1
exit 0
