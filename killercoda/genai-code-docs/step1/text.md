# Step 1 — Set Up the Claude API Connection

Before running the demos, we need to give the lab environment your Anthropic API key.

## Set your API key

Replace `YOUR_KEY_HERE` with your actual Anthropic API key and run:

```
export ANTHROPIC_API_KEY="YOUR_KEY_HERE"
```

## Verify the connection

```
python3 -c "import anthropic; print('✓ Anthropic SDK ready')"
```

You should see: `✓ Anthropic SDK ready`

## Confirm the demo scripts are in place

```
ls /root/demo/
```

You should see three scripts: `generate_code.py`, `generate_docs.py`, `variation.py`

---

> **For the instructor:** Set the key once — it persists for the duration of this terminal session.

**Move to Step 2 when you see `✓ Anthropic SDK ready`.**
