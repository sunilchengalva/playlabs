# Step 3 — Stage B: System Prompt

Add a **system prompt** — a persistent instruction that sets the model's persona, role, and constraints before the user message arrives.

## Run Stage B

```
python3 /root/demo/harness_demo.py --stage b
```

## What to watch

- The output is now **more focused and consistent in tone**
- The model knows it is an educational content designer — it structures the response accordingly
- Language is appropriate for second-year students
- But the output is **still prose** — it cannot be machine-parsed

## The system prompt used

```
You are an educational content designer for engineering colleges.
You help faculty create high-quality, age-appropriate assessment content.
Be concise, clear, and accurate.
```

## Why this matters

A system prompt is the difference between a general-purpose chatbot and a domain-specific assistant. It is reused across every request — you write it once, it shapes every response.

---

Move to Step 4 to add structured output and make the response machine-parseable.
