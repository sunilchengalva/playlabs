# Step 2 — Run a Web Server (Port Mapping)

`hello-world` exits immediately. Real apps stay running and listen on a port. Let's serve a web page.

## Start an nginx web server

```
docker run -d --name webserver -p 8080:80 nginx:alpine
```

Flag breakdown:
| Flag | Meaning |
|------|---------|
| `-d` | Detached — run in background |
| `--name webserver` | Give the container a friendly name |
| `-p 8080:80` | Map **host port 8080** → **container port 80** |

## Check it's running

```
docker ps
```

You should see `webserver` with status `Up` and `0.0.0.0:8080->80/tcp` in the ports column.

## Fetch the web page

```
curl http://localhost:8080
```

You'll see nginx's default "Welcome to nginx!" HTML. The web server is running inside the container, but you're reaching it from outside through the port mapping.

## Why port mapping matters

The container has its own network namespace. Port 80 inside the container is **not** automatically accessible from the host. The `-p 8080:80` flag creates a bridge between the two.

## Stop and remove the container

```
docker stop webserver
docker rm webserver
```

Or in one shot:

```
docker rm -f webserver
```

---

**Verification:** leave the `webserver` container running (don't stop it yet) and click **Check** — the verify script will confirm it's up on port 8080.
