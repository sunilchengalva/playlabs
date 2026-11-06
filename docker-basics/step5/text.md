# Step 5 — Build a Node.js Image with a Dockerfile

So far you've used images from Docker Hub. Now you'll build your own from a **Dockerfile** — a plain-text recipe that tells Docker how to create an image.

## The app is already staged

```
ls /root/apps/node-app/
cat /root/apps/node-app/index.js
cat /root/apps/node-app/Dockerfile
```

The Dockerfile looks like this:

```dockerfile
FROM node:18-alpine          # start from the official Node.js image
WORKDIR /app                 # all subsequent commands run here
COPY package*.json ./        # copy manifest first (why? — see Step 7)
RUN npm install              # install dependencies
COPY . .                     # copy the rest of the source
EXPOSE 3000                  # document which port the app uses
CMD ["node", "index.js"]     # default command to start the container
```

## Build the image

```
cd /root/apps/node-app
docker build -t hello-node:1.0 .
```

The `.` tells Docker to use the current directory as the **build context** (everything it can `COPY` from).

Watch the output — each line in the Dockerfile is a **layer**. Docker builds and caches each one separately.

## Check the image exists

```
docker images hello-node
```

## Run your image

```
docker run -d --name nodeapp -p 3000:3000 hello-node:1.0
```

```
curl http://localhost:3000
```

You'll see "Hello from Node.js inside Docker!" and the container's hostname.

---

**Verification:** click **Check** — the script confirms the `hello-node:1.0` image exists and the container responds on port 3000.
