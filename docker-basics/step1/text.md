# Step 1 — Your First Container

Let's confirm Docker is running, then pull and run the classic `hello-world` image.

## Check Docker is ready

```
docker version
```

You should see the client and server versions. If you get a "Cannot connect" error, wait 10 seconds and try again — the background setup might still be finishing.

## Run hello-world

```
docker run hello-world
```

Docker will:
1. Look for the `hello-world` image locally
2. Pull it from Docker Hub (it's tiny — a few KB)
3. Start a container, print a message, and exit

## What just happened?

```
docker ps -a
```

This lists **all** containers — including stopped ones. You'll see the `hello-world` container with status `Exited (0)`.

**Key insight:** a container is not a VM. It runs a process, and when that process exits, the container stops. `hello-world` just printed a message and quit — that's perfectly normal.

## Run it again

```
docker run hello-world
```

Now check `docker ps -a` again. You'll see **two** exited containers — each `run` creates a new container instance.

---

**Move to Step 2 when you're ready.**
