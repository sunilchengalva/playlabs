# Step 6 — Build a Python Flask Image with a Dockerfile

Same idea as Step 5, but for a Python Flask app — a pattern used heavily in AI/ML workloads.

## Inspect the app

```
cat /root/apps/flask-app/app.py
cat /root/apps/flask-app/requirements.txt
cat /root/apps/flask-app/Dockerfile
```

The Dockerfile:

```dockerfile
FROM python:3.11-slim          # slim = smaller image, no dev tools
WORKDIR /app
COPY requirements.txt .        # copy requirements first (caching)
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]
```

Notice the same pattern as Node.js: **copy the dependency manifest first, install, then copy source.** This is the layer caching trick you'll explore in Step 7.

## Build the image

```
cd /root/apps/flask-app
docker build -t hello-flask:1.0 .
```

## Run it

```
docker run -d --name flaskapp -p 5000:5000 hello-flask:1.0
```

```
curl http://localhost:5000
```

You'll see "Hello from Python Flask inside Docker!" and the container's hostname.

## Compare the two running apps

```
docker ps
```

You now have `nodeapp` (port 3000) and `flaskapp` (port 5000) running side by side, completely isolated, on the same host.

---

**Verification:** click **Check** — the script confirms the `hello-flask:1.0` image exists and Flask responds on port 5000.
