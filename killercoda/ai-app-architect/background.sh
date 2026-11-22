#!/bin/bash
# Runs hidden during the intro slide.
# Installs Python deps and stages the demo script.

set -e

# ── Python + Anthropic SDK ───────────────────────────────────────────────────
apt-get update -qq
apt-get install -y -qq python3 python3-pip python3-venv

python3 -m pip install --quiet --break-system-packages anthropic

# ── Demo script ──────────────────────────────────────────────────────────────
mkdir -p /root/demo

cat > /root/demo/app_architect.py <<'PYEOF'
#!/usr/bin/env python3
"""
AI App Architect Demo
Engineering 5.0 FDP — Session 1 PlayLabs Demo

Sends a one-line product brief to Claude and streams a full
software architecture: user flow, screens, components, schema.
"""
import os
import sys
import anthropic

W = 72

def sep(title=""):
    if title:
        pad = (W - len(title) - 2) // 2
        print(f"\n{'─' * pad} {title} {'─' * (W - pad - len(title) - 2)}")
    else:
        print(f"\n{'─' * W}\n")

def run(brief: str):
    key = os.environ.get("ANTHROPIC_API_KEY", "")
    if not key:
        print("\n✗  ANTHROPIC_API_KEY is not set. Run Step 1 first.\n")
        sys.exit(1)

    client = anthropic.Anthropic(api_key=key)

    prompt = f"""You are a senior software architect. A product manager has given you this brief:

"{brief}"

Produce a structured technical design with exactly these four sections:

## 1. User Flow
The main user journey in 5–6 numbered steps.

## 2. Key Screens
List each screen with a one-line description of its purpose.

## 3. Component Architecture
List the main frontend components and their responsibilities.

## 4. Database Schema
List the main tables with their key fields and one-line relationship notes.

Be concise and precise. Use clear headings and bullet points."""

    sep("BRIEF SENT TO CLAUDE")
    print(f'  "{brief}"')
    sep("CLAUDE'S RESPONSE — streaming live")

    with client.messages.stream(
        model="claude-sonnet-4-6",
        max_tokens=1024,
        messages=[{"role": "user", "content": prompt}]
    ) as stream:
        for text in stream.text_stream:
            print(text, end="", flush=True)

    sep()
    print("  ✓  Demo complete.")
    print("  Notice: AI handled the scaffolding in seconds.")
    print("  The engineer still decides: priorities, constraints,")
    print("  real-world context, edge cases, security, compliance.\n")

if __name__ == "__main__":
    brief = " ".join(sys.argv[1:]) if len(sys.argv) > 1 \
        else "Build a student attendance tracker mobile app"
    run(brief)
PYEOF

chmod +x /root/demo/app_architect.py

echo "background setup complete" > /tmp/background_done
