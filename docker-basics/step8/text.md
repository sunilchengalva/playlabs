# Step 8 — Two Containers, One Network

Real applications are made of multiple services. In this step you'll run a Flask web app and a Redis cache together using **Docker Compose**.

## The app

The `compose-app` counts page hits — Flask serves the web page, Redis stores the counter.

```
cat /root/apps/compose-app/docker-compose.yml
```

```yaml
version: "3.9"
services:
  web:
    build: .
    ports:
      - "5000:5000"
    depends_on:
      - redis
  redis:
    image: redis:7-alpine
```

Compose automatically creates a **shared network** and lets services reach each other by their service name (`redis` in this case — no IP addresses needed).

## Stop the existing flaskapp first

```
docker rm -f flaskapp
```

## Start the compose stack

```
cd /root/apps/compose-app
docker compose up -d --build
```

Compose will:
1. Build the `web` image
2. Pull `redis:7-alpine`
3. Create a network
4. Start both containers in the right order (`depends_on`)

## Test it

```
curl http://localhost:5000
curl http://localhost:5000
curl http://localhost:5000
```

Each request increments the counter stored in Redis. The count persists between requests because Redis is running as a separate long-lived container.

## See all running containers

```
docker compose ps
```

## View logs from both services

```
docker compose logs
```

## Bring everything down

```
docker compose down
```

This stops and removes the containers **and** the network. The Redis data is gone too (it was in-memory — to persist it you'd use a volume, which is a great next topic!).

---

**Verification:** click **Check** — the script confirms the compose stack is up and the page visit counter is working.
