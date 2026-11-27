## Step 4 — Without RAG: The Problem

Before seeing the solution, observe the problem clearly. Ask Claude the same questions — with no document context whatsoever.

```bash
python3 /root/demo/no_rag.py "What is GNITS's policy on student use of AI tools in coursework?"
```

**What you'll see:** Claude gives a generic answer about AI tool policies, or says it doesn't have information about GNITS's specific rules. It may sound plausible — but it's not grounded in the actual document.

Try the grant question:

```bash
python3 /root/demo/no_rag.py "How much does GNITS give students for publishing at NeurIPS?"
```

Try the support contact:

```bash
python3 /root/demo/no_rag.py "Who is the lab coordinator at the GNITS AI Research Lab?"
```

**Why is this happening?**

Claude's training corpus contains billions of documents — but not the GNITS Faculty & Student Guidelines. That document was written internally, never published, and never indexed by any training dataset. Claude cannot know what it was never shown.

This is the fundamental limitation RAG addresses: **LLMs are powerful but blind to your private data**.

Note the answers here. In Step 5, you'll run the identical questions through the full RAG pipeline. The comparison is the point.
