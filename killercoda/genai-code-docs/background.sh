#!/bin/bash
# Runs hidden during the intro slide.
# Installs Python deps and stages both demo scripts.

set -e

# ── Python + Anthropic SDK ───────────────────────────────────────────────────
apt-get update -qq
apt-get install -y -qq python3 python3-pip python3-venv

pip3 install --quiet --break-system-packages anthropic

# ── Demo script 1: generate implementation ───────────────────────────────────
mkdir -p /root/demo

cat > /root/demo/generate_code.py <<'PYEOF'
#!/usr/bin/env python3
"""
GenAI Code Demo — Step 2
Engineering 5.0 FDP — Session 2 PlayLabs Demo

Sends a coding brief to Claude and streams a complete
Round Robin CPU scheduler implementation.
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

def run():
    key = os.environ.get("ANTHROPIC_API_KEY", "")
    if not key:
        print("\n✗  ANTHROPIC_API_KEY is not set. Run Step 1 first.\n")
        sys.exit(1)

    client = anthropic.Anthropic(api_key=key)

    prompt = """Write a complete, working Python implementation of a CPU scheduler
using the Round Robin algorithm.

Requirements:
- Use a proper class structure (a Scheduler class and a Process class)
- Include: process creation, a ready queue, the scheduling loop, and execution tracking
- Track waiting time and turnaround time for each process
- Print a clear execution log showing which process runs at each time unit
- Keep it clean, readable, and well-named

Output only the implementation code. No explanation yet."""

    sep("PROMPT SENT TO CLAUDE")
    print("  Task: Implement a CPU scheduler — Round Robin algorithm")
    print("  Format: Python class structure, execution tracking, clean code")
    sep("CLAUDE'S RESPONSE — streaming live")

    with client.messages.stream(
        model="claude-sonnet-4-6",
        max_tokens=1500,
        messages=[{"role": "user", "content": prompt}]
    ) as stream:
        for text in stream.text_stream:
            print(text, end="", flush=True)

    sep()
    print("  ✓  Implementation generated.")
    print("  → Proceed to Step 3 to generate the explanation and documentation.\n")

if __name__ == "__main__":
    run()
PYEOF

# ── Demo script 2: generate explanation + documentation ──────────────────────
cat > /root/demo/generate_docs.py <<'PYEOF'
#!/usr/bin/env python3
"""
GenAI Docs Demo — Step 3
Engineering 5.0 FDP — Session 2 PlayLabs Demo

Sends a follow-up prompt to Claude asking for plain-English
explanation and technical documentation for the Round Robin scheduler.
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

def run():
    key = os.environ.get("ANTHROPIC_API_KEY", "")
    if not key:
        print("\n✗  ANTHROPIC_API_KEY is not set. Run Step 1 first.\n")
        sys.exit(1)

    client = anthropic.Anthropic(api_key=key)

    prompt = """For the Round Robin CPU scheduler you just wrote, produce two things:

## PLAIN ENGLISH EXPLANATION
Explain each class and method as if teaching a first-year CS student.
No jargon. Use simple analogies where helpful.

## TECHNICAL DOCUMENTATION
Generate documentation in standard format for each method:
- Purpose (one sentence)
- Parameters (name, type, description)
- Returns (type and description)
- Example usage

Be thorough but concise."""

    sep("PROMPT SENT TO CLAUDE")
    print("  Task: Explain each function + generate technical documentation")
    print("  Audience: First-year CS students + professional documentation standard")
    sep("CLAUDE'S RESPONSE — streaming live")

    with client.messages.stream(
        model="claude-sonnet-4-6",
        max_tokens=1500,
        messages=[{"role": "user", "content": prompt}]
    ) as stream:
        for text in stream.text_stream:
            print(text, end="", flush=True)

    sep()
    print("  ✓  Explanation and documentation generated.")
    print("  Notice: AI produced a usable first draft of both.")
    print("  The engineer still validates correctness, adapts to audience,")
    print("  and takes responsibility for what ships.\n")

if __name__ == "__main__":
    run()
PYEOF

# ── Demo script 3: variation ──────────────────────────────────────────────────
cat > /root/demo/variation.py <<'PYEOF'
#!/usr/bin/env python3
"""
GenAI Variation Demo — Step 4
Shows how the same prompt pattern generalises to any algorithm.
Default: Priority Scheduling. Pass a name as argument to change.
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

def run(algorithm: str):
    key = os.environ.get("ANTHROPIC_API_KEY", "")
    if not key:
        print("\n✗  ANTHROPIC_API_KEY is not set.\n")
        sys.exit(1)

    client = anthropic.Anthropic(api_key=key)

    prompt = f"""Write a clean Python implementation of a CPU scheduler using the {algorithm} algorithm.
Use a proper class structure. Include execution tracking and performance metrics.
Then write a two-paragraph plain-English explanation of how {algorithm} differs from Round Robin."""

    sep(f"VARIATION: {algorithm.upper()}")
    print(f"  Changing algorithm from Round Robin → {algorithm}")
    print("  Same prompt structure. Watch how AI adapts.")
    sep("CLAUDE'S RESPONSE — streaming live")

    with client.messages.stream(
        model="claude-sonnet-4-6",
        max_tokens=1500,
        messages=[{"role": "user", "content": prompt}]
    ) as stream:
        for text in stream.text_stream:
            print(text, end="", flush=True)

    sep()
    print("  ✓  Variation complete.")
    print("  Key insight: one prompt pattern → any algorithm.")
    print("  The engineering judgment (which algorithm fits your problem)")
    print("  is still entirely human.\n")

if __name__ == "__main__":
    algorithm = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else "Priority Scheduling"
    run(algorithm)
PYEOF

chmod +x /root/demo/generate_code.py
chmod +x /root/demo/generate_docs.py
chmod +x /root/demo/variation.py

echo "background setup complete" > /tmp/background_done
