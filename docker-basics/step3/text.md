# Step 3 — Inspect and Debug a Running Container

The `webserver` container from Step 2 should still be running. Let's look inside it without touching the web server itself.

## View logs

```
docker logs webserver
```

You'll see nginx's access log — including the `curl` request you made in Step 2.

Follow logs live (Ctrl-C to stop):

```
docker logs -f webserver
```

In a second tab (or just run this, then check logs):

```
curl http://localhost:8080
```

## Inspect container metadata

```
docker inspect webserver
```

This dumps everything Docker knows about the container: IP address, port mappings, mounts, environment variables, restart policy. It's JSON — pipe it through `jq` to find specific fields:

```
docker inspect webserver | grep -i ipaddress
```

## Check resource usage

```
docker stats webserver --no-stream
```

Shows CPU %, memory usage, and network I/O. Remove `--no-stream` to watch it live.

## List processes inside the container

```
docker top webserver
```

---

**Verification:** run `docker stats webserver --no-stream` to confirm the container is still alive, then click **Check**.
