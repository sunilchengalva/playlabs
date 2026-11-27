## Step 3 — Retrieval Without the LLM

This step runs the retrieval engine in complete isolation — no Claude, no API key, no generation.

```bash
python3 /root/demo/retrieve.py "What is the AI tool usage policy for students?"
```

Watch the similarity scores. The closer to 1.0, the more semantically similar the chunk is to your query.

**Try a different question — about grants:**

```bash
python3 /root/demo/retrieve.py "How much grant money can students get for publishing research?"
```

**Try a contact lookup:**

```bash
python3 /root/demo/retrieve.py "Who do I contact for lab technical support outside office hours?"
```

Notice that each query returns a completely different set of chunks. The retrieval engine is topic-aware — it doesn't match keywords, it matches meaning.

**The key observation:**

No LLM was called in any of these runs. No internet request was made. This is entirely local computation — a 384-dimension dot product between your query vector and each stored chunk vector.

This is the **R** in RAG. Pure retrieval, pure maths.

The LLM enters only in Step 5 — and when it does, it will receive exactly these retrieved chunks as context.
