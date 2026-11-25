# Step 1 — Set Up the Claude API Connection

Before running the demo, give the lab environment your Anthropic API key.

## Activate the Python environment

```
source /root/venv/bin/activate
```

## Set your API key

Replace `YOUR_KEY_HERE` with your actual Anthropic API key:

```
export ANTHROPIC_API_KEY="YOUR_KEY_HERE"
```

## Verify the connection

```
python3 -c "import anthropic; print('✓ Anthropic SDK ready')"
```

You should see: `✓ Anthropic SDK ready`

## Confirm the demo script is in place

```
ls /root/demo/
```

You should see: `harness_demo.py`

---

> **For the instructor:** Set the key once — it persists for the duration of this terminal session. The same key works across all 4 stages.

**Move to Step 2 when you see `✓ Anthropic SDK ready`.**
