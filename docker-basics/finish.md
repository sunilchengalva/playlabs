# Lab Complete — You Did It!

Here's a quick summary of everything you covered:

| Step | Concept | Command(s) |
|------|---------|------------|
| 1 | Pull and run a container | `docker run hello-world` |
| 2 | Port mapping, background containers | `docker run -d -p 8080:80 nginx:alpine` |
| 3 | Logs, inspect, stats | `docker logs`, `docker inspect`, `docker stats` |
| 4 | Shell inside a container | `docker exec -it <name> sh` |
| 5 | Build a Node.js image | `docker build -t hello-node:1.0 .` |
| 6 | Build a Python Flask image | `docker build -t hello-flask:1.0 .` |
| 7 | Layer caching | Copy manifest → install → copy source |
| 8 | Multi-container apps | `docker compose up -d` |

## Key takeaways

- A **container** is an isolated process with its own filesystem, network, and process tree
- A **Dockerfile** is a recipe — `FROM`, `COPY`, `RUN`, `EXPOSE`, `CMD`
- **Layer caching** is automatic — you just need to order your COPY/RUN instructions correctly
- **Docker Compose** wires multiple containers together on a shared network, no IP addresses needed

## What's next?

- **Volumes** — persist data beyond a container's lifetime
- **Environment variables** — configure containers at runtime with `-e` or Compose's `environment:`
- **Docker Hub** — push your images so anyone can `docker pull` them
- **Kubernetes** — orchestrate hundreds of containers across multiple machines

---

*Happy shipping!* 🐳
