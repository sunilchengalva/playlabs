# Step 2 — Generate the Code

This step demonstrates **code generation** — the first capability from Act 4's application landscape.

## Run the demo

```
python3 /root/demo/generate_code.py
```

## What to watch

- The output streams token by token — this is GPU-accelerated inference from Slides 13–14
- The model produces a complete, structured implementation — class design, execution loop, performance metrics
- Nobody told it *how* to structure the code — that decision came from training data
- Time from brief to working code: under 20 seconds

## The session connection

Slide 27 described code generation patterns — this is that slide made real. The model is not retrieving a memorised implementation; it is generating one from the brief. Run it twice and the output will be slightly different each time (Slide 9: LLMs are stochastic).

## What the audience sees

A working Python CPU scheduler, streamed live, from one sentence. The same brief a student might submit as a lab assignment.

---

Move to Step 3 to generate the explanation and documentation.
