# Step 4 — Get a Shell Inside a Container

One of Docker's most useful debugging tools: drop into a running container and look around.

## Exec into the webserver

```
docker exec -it webserver sh
```

Flag breakdown:
| Flag | Meaning |
|------|---------|
| `-i` | Interactive — keep stdin open |
| `-t` | Allocate a pseudo-TTY (makes it feel like a real shell) |
| `sh` | The shell to run (nginx:alpine uses `sh`, not `bash`) |

## Explore the container's filesystem

You're now inside the container. Try:

```
ls /
cat /etc/nginx/nginx.conf
cat /usr/share/nginx/html/index.html
```

Notice: the container has its own isolated filesystem. You're not on the host machine.

## Check the container's hostname

```
hostname
```

That random hex string is the container ID — Docker sets it as the default hostname.

## Exit the container

```
exit
```

You're back on the host. The `webserver` container is still running — `exec` didn't stop it.

## Clean up before the next step

```
docker rm -f webserver
```

---

**Verification:** the step passes as long as the `webserver` container is gone (cleaned up). Click **Check** after running the `rm` command above.
