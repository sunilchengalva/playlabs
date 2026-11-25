# Step 4 — Stage C: Structured Output

Extend the system prompt to **enforce a JSON schema**. The model must now return a valid JSON object — no prose, no markdown fences.

## Run Stage C

```
python3 /root/demo/harness_demo.py --stage c
```

## What to watch

- The raw model response is a JSON object
- The script immediately calls `json.loads()` on it
- If parsing succeeds, it prints extracted fields: `question`, `correct_index`, `explanation`
- This output can now be inserted directly into a database, returned from an API, or rendered in a UI

## The schema enforced

```json
{
  "question": "string",
  "options": ["A) ...", "B) ...", "C) ...", "D) ..."],
  "correct_index": 0,
  "explanation": "string"
}
```

## The key shift

> Stage A and B output is for **humans to read**.  
> Stage C output is for **machines to process**.

This is the difference between a productivity tool and a production feature.

---

Move to Step 5 for the final stage — error handling and visible retry.
