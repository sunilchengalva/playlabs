# LLM Harness Explorer

**Instructor-led demo** for FDP — GenAI Foundations & Applications.

This lab runs the same education brief through **4 progressive stages** of an AI harness — from a raw prompt to a production-grade, self-healing pipeline.

| Stage | What changes | Output |
|-------|-------------|--------|
| A — Raw Prompt | Direct user message only | Freeform prose |
| B — System Prompt | Persona + constraints added | Consistent prose |
| C — Structured Output | JSON schema enforced | Machine-parseable JSON |
| D — Error Handling | Validation + retry logic | Guaranteed JSON schema |

**Brief used throughout:** *"Generate a quiz question on Python functions for second-year students"*

You can pass your own brief as an argument at any stage.

---

The Python environment is loading in the background — the Anthropic SDK will be ready by the time you reach Step 1.
