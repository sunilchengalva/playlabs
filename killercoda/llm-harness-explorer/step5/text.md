# Step 5 — Stage D: Error Handling + Retry

The production-grade harness. Adds a **validation loop**: if the model returns malformed JSON, the harness catches the error, logs it, and retries with a reinforced instruction — automatically, without human intervention.

## Run Stage D

```
python3 /root/demo/harness_demo.py --stage d
```

## What to watch — carefully

**Attempt 1** is a simulated bad response — prose that ignores the JSON instruction. This is what real models occasionally return when they "forget" the schema constraint. You will see:

```
✗  Attempt 1: Parse failed → ...
→  Retrying... (1 attempt(s) left)
```

**Attempt 2** is a real API call with a reinforced instruction:

```
IMPORTANT: Your previous response was not valid JSON. Respond with ONLY a JSON object...
```

**Attempt 2 succeeds.** The harness reports which attempt succeeded and delivers validated, structured data to the caller.

## Why this matters

- In production, LLMs occasionally return malformed output — even with schema enforcement
- Without retry logic, your application silently breaks or crashes
- With retry logic, the system self-heals — the user never sees the failure

## The harness contract

> *"The caller always receives valid, typed data — or a structured error. Never a crash."*

---

**Run all 4 stages in one shot (with pause between each):**
```
python3 /root/demo/harness_demo.py
```

This is the main demo command. Press ENTER to advance between stages.
