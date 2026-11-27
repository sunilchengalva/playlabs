## Step 2 — Chunk & Embed the Document

RAG starts before the LLM is involved. First we convert the document into a searchable vector index.

```bash
python3 /root/demo/chunk_embed.py
```

**What just happened, step by step:**

1. The document was split into overlapping ~150-word chunks
2. Each chunk was passed through `all-MiniLM-L6-v2` — a 22-million-parameter model that maps text to a point in 384-dimensional space
3. Those 384-number vectors were stored in a FAISS index on disk

**The number to remember:** `384`

That's the embedding dimension. Every chunk — regardless of length, language, or topic — becomes exactly 384 numbers. The geometry of those numbers encodes meaning:

- "Student AI tool usage guidelines" and "rules for using AI in coursework" → vectors close together
- "Lab access hours" and "research publication grants" → vectors far apart

No keyword matching. No boolean search. Pure geometry.

The FAISS index is saved at `/root/demo/gnits.index`. The chunk text is saved at `/root/demo/gnits_chunks.json`.

Next step: query the index — without calling Claude at all.
