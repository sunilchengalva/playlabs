# Step 3 — Generate Explanation + Documentation

Now run the second script. Watch Claude explain every function in plain English and generate complete technical documentation — for the same code it just wrote.

## Run the script

```
python3 /root/demo/generate_docs.py
```

## What you will see

Two sections stream live:

**Plain English Explanation** — Each class and method described as if teaching a first-year CS student. No jargon. Simple language.

**Technical Documentation** — Standard format: purpose, parameters, returns, and example usage for each method.

## What to narrate while it runs

- **During the explanation** — "This is the kind of explanation that would take a faculty member 20 minutes to write. It's a usable first draft in seconds — but notice: the accuracy of that explanation depends entirely on whether the code it explains is correct. If the code has a bug, the explanation will confidently explain the bug."
- **During the documentation** — "Standard docstring format. Directly usable in a codebase or a lab handout. What would you change before giving this to students?"
- **At the end** — "Three deliverables from one prompt: code, explanation, documentation. The engineering value you add is validation, context, and the judgment to know what's missing."

## Teaching insight

> Ask the audience: *"If you gave students this AI-generated output and asked them to find one error, one missing edge case, and one design improvement — what skill are you testing?"*

That skill is **engineering judgment**. That is what Engineering 5.0 curricula should build.

---

**Move to Step 4 to show how this generalises to other algorithms.**
