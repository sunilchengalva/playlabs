#!/bin/bash
# Runs hidden during the intro slide.
# Installs Docker, pre-pulls images, and stages the sample apps so
# every step starts immediately without waiting for downloads.

set -e

# ── Docker install ──────────────────────────────────────────────────────────
apt-get update -qq
apt-get install -y -qq ca-certificates curl gnupg lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -qq
apt-get install -y -qq docker-ce docker-ce-cli containerd.io docker-compose-plugin

systemctl enable docker --now 2>/dev/null || service docker start

# Give the killercoda user (root) socket access
chmod 666 /var/run/docker.sock 2>/dev/null || true

# ── Pre-pull images so steps are instant ───────────────────────────────────
docker pull hello-world       &
docker pull nginx:alpine      &
docker pull node:18-alpine    &
docker pull python:3.11-slim  &
docker pull redis:7-alpine    &
wait

# ── Stage Node.js sample app ───────────────────────────────────────────────
mkdir -p /root/apps/node-app
cat > /root/apps/node-app/package.json <<'EOF'
{
  "name": "hello-node",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": { "start": "node index.js" },
  "dependencies": { "express": "^4.18.2" }
}
EOF

cat > /root/apps/node-app/index.js <<'EOF'
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send(`
    <h1>Hello from Node.js inside Docker!</h1>
    <p>Container hostname: ${require('os').hostname()}</p>
  `);
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
EOF

# Node Dockerfile — deliberately BAD order (for step 7 caching demo)
cat > /root/apps/node-app/Dockerfile.slow <<'EOF'
FROM node:18-alpine
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000
CMD ["node", "index.js"]
EOF

# Node Dockerfile — correct order (cache-friendly)
cat > /root/apps/node-app/Dockerfile <<'EOF'
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]
EOF

# ── Stage Python Flask sample app ─────────────────────────────────────────
mkdir -p /root/apps/flask-app
cat > /root/apps/flask-app/requirements.txt <<'EOF'
flask==3.0.0
EOF

cat > /root/apps/flask-app/app.py <<'EOF'
from flask import Flask
import socket

app = Flask(__name__)

@app.route('/')
def home():
    return f"""
    <h1>Hello from Python Flask inside Docker!</h1>
    <p>Container hostname: {socket.gethostname()}</p>
    """

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

cat > /root/apps/flask-app/Dockerfile <<'EOF'
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]
EOF

# ── Stage docker-compose app (step 8) ─────────────────────────────────────
mkdir -p /root/apps/compose-app
cat > /root/apps/compose-app/app.py <<'EOF'
from flask import Flask
import redis
import socket

app = Flask(__name__)
r = redis.Redis(host='redis', port=6379)

@app.route('/')
def home():
    count = r.incr('hits')
    return f"""
    <h1>Page visit #{count}</h1>
    <p>Served by container: {socket.gethostname()}</p>
    <p><em>Reload to increment. Count stored in Redis.</em></p>
    """

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

cat > /root/apps/compose-app/requirements.txt <<'EOF'
flask==3.0.0
redis==5.0.1
EOF

cat > /root/apps/compose-app/Dockerfile <<'EOF'
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]
EOF

cat > /root/apps/compose-app/docker-compose.yml <<'EOF'
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
EOF

echo "background setup complete" > /tmp/background_done
