# Step 7 — Layer Caching: Fast Rebuilds

This is one of Docker's most powerful optimisations — and also the most common mistake beginners make.

## How layer caching works

Each instruction in a Dockerfile creates a layer. Docker caches every layer. When you rebuild:
- If a layer's **inputs haven't changed**, Docker reuses the cache — instant.
- If a layer **changes**, Docker rebuilds it and **every layer after it**.

## The wrong way — SLOW

The `node-app` directory has a second Dockerfile that copies everything before installing:

```
cat /root/apps/node-app/Dockerfile.slow
```

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY . .           # ← copies ALL files including source
RUN npm install    # ← this runs EVERY time ANY file changes
EXPOSE 3000
CMD ["node", "index.js"]
```

Build it and time the first build:

```
cd /root/apps/node-app
time docker build -t hello-node:slow -f Dockerfile.slow .
```

Now make a tiny change to the source and rebuild:

```
echo "// tiny change" >> index.js
time docker build -t hello-node:slow -f Dockerfile.slow .
```

Notice: `npm install` runs again even though `package.json` didn't change.

## The right way — FAST

The standard `Dockerfile` copies the manifest first:

```
cat /root/apps/node-app/Dockerfile
```

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./    # ← only the manifest
RUN npm install          # ← cached as long as package.json is unchanged
COPY . .                 # ← source changes only invalidate from here
EXPOSE 3000
CMD ["node", "index.js"]
```

Rebuild after another tiny source change:

```
echo "// another change" >> index.js
time docker build -t hello-node:fast .
```

The `npm install` step says **"Using cache"** and is skipped entirely. The rebuild takes seconds instead of tens of seconds.

## Rule of thumb

> **Put things that change rarely near the top. Put things that change often near the bottom.**

---

**Verification:** click **Check** — the script confirms both `hello-node:slow` and `hello-node:fast` images exist, proving you ran both builds.
