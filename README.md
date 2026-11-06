# PlayLabs — Killercoda Scenarios

Hands-on lab scenarios for [PlayLabs](https://playlabs.aigirilabs.com) training sessions, hosted on [Killercoda](https://killercoda.com).

Each directory is an independent Killercoda scenario. Killercoda pulls directly from this repo — the scenario path is the directory name.

## Available scenarios

| Directory | Topic | Steps | Level |
|-----------|-------|-------|-------|
| [`docker-basics`](./docker-basics) | Docker containers — from zero to Docker Compose | 8 | Beginner |

## Coming soon

| Directory | Topic |
|-----------|-------|
| `kubernetes-basics` | Pods, deployments, services, Helm |
| `ai-ml-basics` | Python ML environment, Jupyter, model serving |
| `devops-basics` | CI/CD pipelines, GitHub Actions, ArgoCD |

## How Killercoda uses this repo

Each scenario directory must contain:
- `index.json` — step definitions, metadata, background script reference
- `intro.md` — welcome screen
- `finish.md` — completion summary
- `background.sh` — setup script (runs hidden during intro)
- `stepN/text.md` — step instructions
- `stepN/verify.sh` — auto-verification (must be executable)

Scenario URL pattern after publishing:
```
https://killercoda.com/<creator-username>/scenario/<directory-name>
```

## Wiring a scenario into PlayLabs

In the PlayLabs admin, create or edit a session:
1. Set **Lab environment** → **Killercoda**
2. Paste the scenario URL into **Killercoda scenario URL**
3. Save

Every attendee who registers will automatically receive the lab link in their credentials email.
