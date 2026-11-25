# Step 3 — Generate Explanation + Documentation

This step demonstrates two things at once: **text generation** (Act 4 · Slide 26) and what "general-purpose" means in a foundation model (Act 1 · Slide 7).

## Run the demo

```
python3 /root/demo/generate_docs.py
```

## What to watch

- The same model that wrote code in Step 2 now explains it in plain English — no retraining, no fine-tuning
- It produces two outputs: a student-facing explanation and a professional documentation block
- The explanation adapts its language to "first-year CS student" because the prompt asked it to — this is what Slide 26 called "multi-level explanations"

## The hidden harness lesson

Notice what just happened structurally: Step 3 used Step 2's output as its input context. That is **Stage C harness chaining** — the same pattern from Act 3, Slide 20. The lab has been running a 2-step harness from the start without calling it one.

## The teaching insight

The model just did in 15 seconds what takes a faculty member 30 minutes to write from scratch — a plain-English walkthrough of an algorithm. That is not a threat to teaching; it is a first draft you can critique, correct, and adapt in front of students.

---

Move to Step 4 to see the model adapt to a completely different algorithm.
