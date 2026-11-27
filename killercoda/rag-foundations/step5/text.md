## Step 5 — Full RAG Pipeline

Now run the complete pipeline: **Retrieve → Augment → Generate**.

```bash
python3 /root/demo/rag_pipeline.py "What is GNITS's policy on student use of AI tools in coursework?"
```

Compare the answer to Step 4. The model is identical. The question is identical. The only difference: retrieved chunks from the GNITS document were injected into the system prompt before Claude was called.

**Run the grant question from Step 4:**

```bash
python3 /root/demo/rag_pipeline.py "How much does GNITS give students for publishing at NeurIPS?"
```

**Run the contact question:**

```bash
python3 /root/demo/rag_pipeline.py "Who is the lab coordinator at the GNITS AI Research Lab?"
```

**What the pipeline did on each call:**

1. Embedded your query using `all-MiniLM-L6-v2` → 384-number vector
2. Searched the FAISS index → top-3 most relevant document chunks
3. Built a system prompt: `"Answer ONLY using the context below: [chunk1] [chunk2] [chunk3]"`
4. Called Claude with the augmented prompt → streamed a grounded answer

**Try a question the document doesn't cover:**

```bash
python3 /root/demo/rag_pipeline.py "What is the fee structure for the M.Tech programme?"
```

The model should respond: *"This information is not covered in the provided document."*

That is the RAG system working correctly — it knows what it knows, and what it doesn't.

---

**The RAG equation:**

```
Answer quality = Model capability × Retrieval precision
```

A weaker model with perfect retrieval beats a stronger model with no context. You now understand both sides.
