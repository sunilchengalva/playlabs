# Step 2 — Stage A: Raw Prompt

The simplest possible harness: one user message, no context, no constraints.

## Run Stage A

```
python3 /root/demo/harness_demo.py --stage a
```

## What to watch

- The model answers the brief — but notice the **format**
- Output is flowing prose: a paragraph, some bullet points, maybe a heading
- There is no consistent structure — every run could look different
- You cannot reliably extract the question, the options, and the correct answer from this output programmatically

## The key question

> *"Can a database row hold this output? Can another function parse it?"*

The answer after Stage A is: **not reliably.**

---

**To use a custom brief:**
```
python3 /root/demo/harness_demo.py --stage a "Create a question about sorting algorithms for final year students"
```

Move to Step 3 when Stage A completes.
