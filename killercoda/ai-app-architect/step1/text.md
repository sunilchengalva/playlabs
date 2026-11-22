# Step 1 — Set Up the Claude API Connection

Before running the demo, we need to give the lab environment your Anthropic API key.

## Set your API key

Replace `YOUR_KEY_HERE` with your actual Anthropic API key and run:

```
export ANTHROPIC_API_KEY="YOUR_KEY_HERE"
```

## Verify the connection

Run this quick check to confirm Python and the Anthropic SDK are ready:

```
python3 -c "import anthropic; print('✓ Anthropic SDK ready')"
```

You should see: `✓ Anthropic SDK ready`

## Confirm the demo script is in place

```
ls /root/demo/
```

You should see `app_architect.py` listed.

---

> **For the instructor:** You only need to do this once per lab session. The API key is set for the duration of this terminal session.

**Move to Step 2 when you see `✓ Anthropic SDK ready`.**
