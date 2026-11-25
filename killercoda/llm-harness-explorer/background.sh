#!/bin/bash
# Runs hidden during the intro slide.
# Installs Python deps and stages harness_demo.py.

# ── Python venv + Anthropic SDK ───────────────────────────────────────────────
if ! python3 -m venv /root/venv 2>/dev/null; then
    timeout 60 apt-get install -y -qq python3-venv 2>/dev/null || true
    python3 -m venv /root/venv
fi
/root/venv/bin/pip install --quiet anthropic
echo "source /root/venv/bin/activate" >> /root/.bashrc

# ── Demo script ───────────────────────────────────────────────────────────────
mkdir -p /root/demo

cat > /root/demo/harness_demo.py <<'PYEOF'
#!/usr/bin/env python3
"""
LLM Harness Explorer
FDP — GenAI Foundations & Applications

Brief: "Generate a quiz question on Python functions for second-year students"

Usage:
  python3 harness_demo.py               -> all 4 stages, pause between each
  python3 harness_demo.py --stage a     -> Stage A only
  python3 harness_demo.py --stage b     -> Stage B only
  python3 harness_demo.py --stage c     -> Stage C only
  python3 harness_demo.py --stage d     -> Stage D only
  python3 harness_demo.py "custom brief" -> all stages with custom brief
"""

import os
import sys
import json
import anthropic

W = 72
BRIEF_DEFAULT = "Generate a quiz question on Python functions for second-year students"

SYSTEM_BASE = (
    "You are an educational content designer for engineering colleges. "
    "You help faculty create high-quality, age-appropriate assessment content. "
    "Be concise, clear, and accurate."
)

SYSTEM_JSON = (
    "You are an educational content designer for engineering colleges. "
    "You help faculty create high-quality, age-appropriate assessment content. "
    "ALWAYS respond with valid JSON only. No prose. No markdown fences. No code blocks. "
    "Use this exact schema: "
    '{"question": "string", "options": ["A) ...", "B) ...", "C) ...", "D) ..."], '
    '"correct_index": 0, "explanation": "string"}'
)

# Simulated malformed response — what a model returns when it "forgets" the JSON rule
SIMULATED_BAD = (
    "Sure! Here is a multiple choice question about Python functions:\n\n"
    "**Question:** What does the `return` statement do in a Python function?\n\n"
    "- A) Ends the entire program\n"
    "- B) Sends a value back to the caller\n"
    "- C) Creates a new variable\n"
    "- D) Imports a module\n\n"
    "The correct answer is B. The `return` statement exits the function and "
    "passes a value back to the code that called it."
)


def sep(title=""):
    if title:
        pad = max(1, (W - len(title) - 2) // 2)
        right = max(1, W - pad - len(title) - 2)
        print(f"\n{'─' * pad} {title} {'─' * right}")
    else:
        print(f"\n{'─' * W}\n")


def get_client():
    key = os.environ.get("ANTHROPIC_API_KEY", "")
    if not key:
        print("\n✗  ANTHROPIC_API_KEY is not set. Run Step 1 first.\n")
        sys.exit(1)
    return anthropic.Anthropic(api_key=key)


def stream_call(client, user, system=None):
    """Make a streaming API call. Returns the full response text."""
    kwargs = dict(
        model="claude-sonnet-4-6",
        max_tokens=600,
        messages=[{"role": "user", "content": user}],
    )
    if system:
        kwargs["system"] = system
    collected = []
    with client.messages.stream(**kwargs) as stream:
        for text in stream.text_stream:
            print(text, end="", flush=True)
            collected.append(text)
    print()
    return "".join(collected)


# ── Stage A — Raw Prompt ──────────────────────────────────────────────────────
def stage_a(brief, client):
    sep("STAGE A — Raw Prompt")
    print("  What it does : sends the brief directly as a user message, nothing else.")
    print("  System prompt: none")
    print(f"  Brief        : \"{brief}\"")
    sep("MODEL OUTPUT")
    output = stream_call(client, user=brief)
    sep()
    print("  Observation : freeform prose — good for a human to read.")
    print("  Problem     : format varies every run. Cannot be parsed by code.\n")
    return output


# ── Stage B — System Prompt ───────────────────────────────────────────────────
def stage_b(brief, client):
    sep("STAGE B — System Prompt")
    print("  What it adds : a system prompt defining persona and constraints.")
    print(f"  System prompt: \"{SYSTEM_BASE}\"")
    print(f"  Brief        : \"{brief}\"")
    sep("MODEL OUTPUT")
    output = stream_call(client, user=brief, system=SYSTEM_BASE)
    sep()
    print("  Observation : consistent tone, domain-appropriate language.")
    print("  Problem     : still prose — cannot be machine-parsed or stored in a DB.\n")
    return output


# ── Stage C — Structured Output ───────────────────────────────────────────────
def stage_c(brief, client):
    sep("STAGE C — Structured Output")
    print("  What it adds : JSON schema enforcement in the system prompt.")
    print("  Schema       : {question, options[4], correct_index, explanation}")
    print(f"  Brief        : \"{brief}\"")
    sep("MODEL OUTPUT — raw")
    output = stream_call(client, user=brief, system=SYSTEM_JSON)
    sep("PARSING")
    try:
        data = json.loads(output.strip())
        print(f"  ✓  JSON valid.")
        print(f"  question      : {str(data.get('question', ''))[:65]}")
        print(f"  options       : {len(data.get('options', []))} options present")
        print(f"  correct_index : {data.get('correct_index')}")
        print(f"  explanation   : {str(data.get('explanation', ''))[:65]}")
    except json.JSONDecodeError as e:
        print(f"  ✗  JSON parse failed: {e}")
        print("  → This is exactly what Stage D is built to handle.\n")
    sep()
    print("  Observation : output is now machine-parseable and DB-ready.")
    print("  Remaining gap: no retry if the model ignores the JSON rule.\n")
    return output


# ── Stage D — Error Handling + Retry ─────────────────────────────────────────
def stage_d(brief, client):
    sep("STAGE D — Error Handling + Retry")
    print("  What it adds : validation loop — catch bad JSON, retry with reinforced prompt.")
    print("  Max retries  : 2")
    print(f"  Brief        : \"{brief}\"")

    MAX_RETRIES = 2

    for attempt in range(1, MAX_RETRIES + 2):
        sep(f"ATTEMPT {attempt} of {MAX_RETRIES + 1}")

        if attempt == 1:
            # Inject a simulated bad response to show the error path visibly
            print("  [simulating a response that ignored the JSON schema instruction]")
            print()
            print(SIMULATED_BAD)
            print()
            response_text = SIMULATED_BAD
        else:
            # Real API call with reinforced instruction
            print("  [calling Claude — retry with reinforced JSON instruction]")
            retry_user = (
                f"{brief}\n\n"
                "IMPORTANT: Your previous response was not valid JSON. "
                "Respond with ONLY a JSON object matching this schema exactly, "
                "no markdown, no prose, no code fences:\n"
                '{"question": "...", "options": ["A) ...", "B) ...", "C) ...", "D) ..."], '
                '"correct_index": 0, "explanation": "..."}'
            )
            response_text = stream_call(client, user=retry_user, system=SYSTEM_JSON)

        sep("VALIDATION")
        try:
            data = json.loads(response_text.strip())
            print(f"  ✓  Attempt {attempt}: JSON valid.")
            print(f"  question      : {str(data.get('question', ''))[:65]}")
            print(f"  options       : {len(data.get('options', []))} options present")
            print(f"  correct_index : {data.get('correct_index')}")
            print(f"  explanation   : {str(data.get('explanation', ''))[:65]}")
            sep()
            print(f"  ✓  Harness succeeded on attempt {attempt}.")
            print("  The caller received valid, typed data.")
            print("  The bad response was caught and corrected automatically.")
            print("  Zero human intervention required.\n")
            return data
        except (json.JSONDecodeError, ValueError) as e:
            print(f"  ✗  Attempt {attempt}: Parse failed — {e}")
            if attempt <= MAX_RETRIES:
                print(f"  → Retrying... ({MAX_RETRIES + 1 - attempt} attempt(s) left)\n")
            else:
                sep()
                print("  ✗  Max retries reached. Returning structured error.\n")
                return {"error": "max_retries_exceeded", "last_error": str(e)}


# ── Entry point ───────────────────────────────────────────────────────────────
def main():
    args = sys.argv[1:]

    # Parse --stage flag
    stage = None
    remaining = []
    i = 0
    while i < len(args):
        if args[i] == "--stage" and i + 1 < len(args):
            stage = args[i + 1].lower()
            i += 2
        else:
            remaining.append(args[i])
            i += 1

    brief = " ".join(remaining).strip() or BRIEF_DEFAULT
    client = get_client()

    print(f"\n{'═' * W}")
    print("  LLM HARNESS EXPLORER")
    if stage:
        print(f"  Running: Stage {stage.upper()} only")
    else:
        print("  Running: All 4 stages")
    print(f"  Brief  : {brief}")
    print(f"{'═' * W}")

    if stage == "a":
        stage_a(brief, client)
    elif stage == "b":
        stage_b(brief, client)
    elif stage == "c":
        stage_c(brief, client)
    elif stage == "d":
        stage_d(brief, client)
    else:
        # Run all with pause between stages
        stage_a(brief, client)
        input("  [ Press ENTER to advance to Stage B — System Prompt ] ")

        stage_b(brief, client)
        input("  [ Press ENTER to advance to Stage C — Structured Output ] ")

        stage_c(brief, client)
        input("  [ Press ENTER to advance to Stage D — Error Handling ] ")

        stage_d(brief, client)

        print(f"{'═' * W}")
        print("  ALL STAGES COMPLETE")
        print("  Stage A → D: same brief, progressively stronger harness.")
        print("  The delta from A to D is ~50 lines of Python.")
        print(f"{'═' * W}\n")


if __name__ == "__main__":
    main()
PYEOF

chmod +x /root/demo/harness_demo.py

echo "background setup complete" > /tmp/background_done
