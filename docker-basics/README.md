# docker-basics — Killercoda Scenario

8-step hands-on Docker lab: containers, port mapping, Dockerfiles (Node.js + Python Flask), layer caching, and Docker Compose.

---

## Directory structure

```
docker-basics/
├── index.json          Scenario metadata and step definitions
├── intro.md            Welcome screen shown before the terminal is ready
├── finish.md           Completion summary
├── background.sh       Runs hidden during intro: installs Docker, pre-pulls images, stages apps
├── step1/text.md       Your first container
├── step2/text.md       nginx web server + port mapping
├── step2/verify.sh     ✓ checks container is running on port 8080
├── step3/text.md       Inspect, logs, stats
├── step3/verify.sh     ✓ checks webserver is still running
├── step4/text.md       docker exec -it shell
├── step4/verify.sh     ✓ checks webserver was cleaned up
├── step5/text.md       Node.js Dockerfile build
├── step5/verify.sh     ✓ checks image exists + port 3000 responds
├── step6/text.md       Python Flask Dockerfile build
├── step6/verify.sh     ✓ checks image exists + port 5000 responds
├── step7/text.md       Layer caching demo
├── step7/verify.sh     ✓ checks both slow/fast images built
├── step8/text.md       Docker Compose: Flask + Redis
└── step8/verify.sh     ✓ checks compose stack up + hit counter works
```

---

## How to publish on Killercoda

### 1. Ensure scripts are executable

The `verify.sh` files and `background.sh` **must** be committed with executable permissions, otherwise Killercoda will silently fail verification.

```bash
# From the playlabs repo root:
git add killercoda/docker-basics
git update-index --chmod=+x killercoda/docker-basics/background.sh
git update-index --chmod=+x killercoda/docker-basics/step*/verify.sh
```

### 2. Push to a public GitHub repository

Killercoda pulls scenario files directly from a public GitHub repo. You have two options:

**Option A — use the playlabs repo if it's public:**
```
GitHub repo:  github.com/<your-org>/playlabs
Scenario path inside repo:  killercoda/docker-basics
```

**Option B — create a dedicated public repo:**
```bash
# Create a new public repo called 'killercoda-scenarios' on GitHub, then:
cd /path/to/playlabs
cp -r killercoda/docker-basics /path/to/killercoda-scenarios/
cd /path/to/killercoda-scenarios
git init && git add . && git commit -m "add docker-basics scenario"
git remote add origin git@github.com:<your-org>/killercoda-scenarios.git
git push -u origin main
```

### 3. Create the scenario in Killercoda

1. Log in to [killercoda.com/creators](https://killercoda.com/creators)
2. Click **New Scenario**
3. Fill in:
   - **Title:** Docker Basics — Containers from Zero to Hero
   - **GitHub repository:** `<your-org>/playlabs` (or `killercoda-scenarios`)
   - **Scenario directory path:** `killercoda/docker-basics` (or `docker-basics` if separate repo)
4. Click **Save** — Killercoda will sync and validate the files
5. Click **Preview** to run through the scenario yourself first

### 4. Get the scenario URL

After publishing, your scenario URL will be:
```
https://killercoda.com/<your-creator-username>/scenario/docker-basics
```

### 5. Wire it into PlayLabs

In the PlayLabs admin:
1. Open (or create) the Docker session
2. Set **Lab environment** → **Killercoda**
3. Paste the scenario URL into **Killercoda scenario URL**
4. Save

From this point, every attendee who registers will get the Killercoda URL in their credentials email and on their access page.

---

## Testing the scenario end-to-end

### Local dry-run (without Killercoda)

Spin up an Ubuntu container with Docker-in-Docker and run through the steps manually:

```bash
docker run -it --privileged ubuntu:22.04 bash
# inside:
apt-get update && apt-get install -y curl
bash < <(curl -fsSL https://get.docker.com)
# then follow each step manually
```

### In Killercoda (after publishing)

Use Killercoda's **Preview** mode — it spins a real Ubuntu container and runs your `background.sh`. Work through each step, click **Check** after each one, verify the green tick appears.

### Checklist before going live

- [ ] `background.sh` completes in < 90 seconds (Killercoda intro timeout)
- [ ] Each `verify.sh` returns exit 0 when the step is done correctly
- [ ] Each `verify.sh` returns exit 1 if the step is NOT done (test this)
- [ ] `intro.md` explains that Docker is installing in background
- [ ] PlayLabs admin shows the scenario URL in the Lab Environment card
- [ ] Attendee email shows "Lab environment included" section
- [ ] Attendee access page shows "Open Lab Environment →" button linking to the scenario URL
