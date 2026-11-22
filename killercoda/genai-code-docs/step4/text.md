# Step 4 — Run a Variation

Show that the same prompt pattern works for any algorithm. This is the "generalisation" moment — the AI is not memorising answers, it is reasoning.

## Run with a different algorithm

Default (Priority Scheduling):

```
python3 /root/demo/variation.py
```

Or specify your own:

```
python3 /root/demo/variation.py "Shortest Job First"
```

```
python3 /root/demo/variation.py "Multilevel Queue Scheduling"
```

## What to narrate

- **Before running** — "We've seen Round Robin. Let's change the algorithm entirely and see what happens."
- **As it generates** — "Notice it not only writes the new implementation — it also explains how this algorithm *differs* from Round Robin. The AI is making connections, not just generating boilerplate."
- **At the end** — "One prompt structure. Any algorithm. That's the difference between a tool and a collaborator."

## The accelerated computing connection

Point out to the audience:

> "This response appeared in under 20 seconds. That speed is not magic — it is the result of GPU-accelerated inference running the language model. The model itself has billions of parameters. Without the GPU infrastructure we covered in this session, this response would take minutes, not seconds. Speed of inference is what makes AI a usable collaborator in real time."

## Closing thought for the audience

> *"Every one of your students is going to work in a world where this kind of tool is as standard as a compiler. The question is not whether they use it. The question is whether they use it with the engineering judgment to know when it's right, when it's wrong, and when it's dangerous to trust."*

---

**Demo complete.**
