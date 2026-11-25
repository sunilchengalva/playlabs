# Step 4 — Run a Variation

This step demonstrates **emergent reasoning** (Act 1 · Slide 8) — the model adapts from principles, not from retrieved answers.

## Run the demo

```
python3 /root/demo/variation.py "Priority Scheduling"
```

## What to watch

- One word changed in the prompt — the model produces an entirely different algorithm
- It doesn't just swap names: it reasons about how Priority Scheduling *differs* from Round Robin and writes code that reflects those differences
- This is not retrieval. This is the model understanding the structure of scheduling algorithms and applying that understanding to a new case.

## Why this matters for your teaching

The question to bring to your students after this demo:

> *"Here is what Claude produced for Priority Scheduling. Find one thing it got right, one design decision you would change, and one edge case it missed."*

That question cannot be answered by running Claude again. It requires a student to actually understand scheduling. It is a better test of knowledge than asking them to implement it from scratch — because implementation can be done by the tool; understanding cannot.

## Try your own variation

Replace "Priority Scheduling" with any algorithm your students study:

```
python3 /root/demo/variation.py "Shortest Job First"
python3 /root/demo/variation.py "Multilevel Queue Scheduling"
```

The same prompt structure generalises to any domain — not just OS algorithms.
