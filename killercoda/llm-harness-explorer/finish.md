# Lab Complete — LLM Harness Explorer

You've seen the same brief run through all 4 stages of a production AI harness.

## What just happened

| Stage | Key property gained |
|-------|-------------------|
| A | Model answers — but output format is unpredictable |
| B | Tone and scope are controlled — still not machine-readable |
| C | Output can be parsed, stored, and chained to other systems |
| D | System recovers from bad model output without human intervention |

## The numbers

- Stage A → Stage D: approximately **50 extra lines of Python**
- Those 50 lines are the difference between a demo and a production feature

## Try it with your own brief

```
python3 /root/demo/harness_demo.py "Create a question on recursion for first-year students"
```

The same 4-stage pattern applies to any text generation task — not just quiz questions.

---

**Next lab:** [GenAI Code + Docs](https://killercoda.com/aigiri/scenario/genai-code-docs) — watch AI write, document, and vary a CPU scheduler implementation.
