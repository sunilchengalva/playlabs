# Step 2 — Generate the Round Robin Implementation

Run the first demo script. Watch Claude write a complete, structured CPU scheduler implementation in real time.

## Run the script

```
python3 /root/demo/generate_code.py
```

## What you will see

Claude streams a complete Python implementation with:
- A `Process` class with all relevant attributes
- A `RoundRobinScheduler` class with the scheduling loop
- Execution tracking and performance metrics
- A clean `main()` function to run it

## What to narrate while it runs

- **When the class structure appears** — "Notice it chose a class-based design without being instructed to. That's a design decision — is it the right one for your use case?"
- **When you see the scheduling loop** — "Look at the time quantum value it chose. Where did that come from? This is exactly where human judgment comes in."
- **At the end** — "Complete, runnable code in under 20 seconds. The engineer's job now is to validate, test edge cases, and decide whether these design choices fit the actual system."

---

**Move to Step 3 to generate the explanation and documentation.**
