#!/bin/bash
# RAG Foundations — background setup
# Creates venv, installs deps, pre-downloads embedding model, stages all demo scripts

export DEBIAN_FRONTEND=noninteractive

# ── Python venv ───────────────────────────────────────────────────────────────
python3 -m venv /root/venv
source /root/venv/bin/activate

pip install -q --upgrade pip
pip install -q sentence-transformers faiss-cpu anthropic numpy

# ── Pre-download embedding model (~90 MB, cached to ~/.cache/huggingface) ─────
python3 - <<'PYEOF'
from sentence_transformers import SentenceTransformer
SentenceTransformer('all-MiniLM-L6-v2')
PYEOF

# ── Demo directory ────────────────────────────────────────────────────────────
mkdir -p /root/demo

# ── GNITS Policy Document ─────────────────────────────────────────────────────
cat > /root/demo/gnits_policy.txt << 'DOCEOF'
GNITS AI Research Lab — Faculty & Student Guidelines
Version 1.2 | Approved by Academic Council, August 2026

1. LAB ACCESS & HOURS
The GNITS AI Research Lab (Room 204, CSE Block) is open Monday through Friday, 9:00 AM to 6:00 PM. Weekend access is available to registered research scholars only, subject to prior booking via the lab portal at ailab.gnits.ac.in/booking. Faculty members may access the lab 24x7 using their RFID card after completing the Lab Safety Induction programme.

2. AI TOOL USAGE POLICY
Students may use AI tools including large language models such as ChatGPT, Claude, Gemini, and Copilot for coursework and research, subject to the following conditions: All AI-assisted submissions must include an AI Usage Declaration Form (Form AI-01, available at the academic office). The core reasoning, analysis, and conclusions of any submission must be the student's own work. AI tools may not be used for examination papers, lab records, or viva voce assessments. Faculty members using AI tools for research publications must follow the GNITS Research Ethics Committee guidelines issued in January 2026.

3. DATA PRIVACY & CONFIDENTIALITY
No student personal data, examination records, or institutional confidential data may be input into external AI systems. Research data classified as confidential under the GNITS Data Governance Policy must be processed only on the lab's on-premise GPU cluster (Cluster ID: GNITS-GPU-01, 8x NVIDIA A100). All processed outputs must be stored on the GNITS Research Drive and not on personal cloud accounts. Violations are subject to disciplinary action under the GNITS Academic Integrity Policy.

4. STUDENT PROJECT ELIGIBILITY
Final-year B.Tech students in CSE, ECE, and IT branches are eligible to undertake AI research projects under a faculty supervisor. Projects must be registered through the GNITS Research Portal by the end of the second week of the semester. Each supervisor may guide a maximum of four AI project groups per semester. Inter-departmental projects such as AI with Mechanical or AI with Civil engineering are encouraged and attract an additional evaluation credit of 5 marks in the final assessment.

5. RESEARCH PUBLICATION POLICY
Students who publish research papers with GNITS affiliation in IEEE, ACM, Springer, or Elsevier journals are eligible for a Research Excellence Grant of Rs. 25,000 per first-authored paper. Conference presentations at ICML, NeurIPS, AAAI, or CVPR attract a Travel Grant of Rs. 50,000, subject to availability of funds in the current financial year. All publications must acknowledge the GNITS AI Research Lab and list the faculty supervisor as co-author or corresponding author.

6. CONTACT & ESCALATION
Lab Coordinator: Dr. Priya Nair, Associate Professor, CSE Department. Email: priya.nair@gnits.ac.in, Extension 2047.
Research Grants Office: Dr. Anil Kumar, Dean of Research. Email: research@gnits.ac.in.
Lab Technical Support: Mr. Ravi Shankar, Senior Lab Technician. Extension 2048, available Monday to Friday 9AM to 5PM.
For urgent matters outside lab hours, contact the GNITS Security Desk at Extension 1001.
DOCEOF

# ── chunk_embed.py ────────────────────────────────────────────────────────────
cat > /root/demo/chunk_embed.py << 'PYEOF'
#!/usr/bin/env python3
"""Step 2 — Chunk and embed the GNITS policy document into a FAISS index."""
import json
import numpy as np
from pathlib import Path

DOC_PATH    = "/root/demo/gnits_policy.txt"
INDEX_PATH  = "/root/demo/gnits.index"
CHUNKS_PATH = "/root/demo/gnits_chunks.json"
CHUNK_WORDS = 120
OVERLAP     = 25


def load_and_chunk(filepath):
    text  = Path(filepath).read_text()
    words = text.split()
    chunks, i = [], 0
    while i < len(words):
        chunks.append(" ".join(words[i : i + CHUNK_WORDS]))
        i += CHUNK_WORDS - OVERLAP
    return chunks


def main():
    print("=" * 60)
    print("STEP 2 — Chunk & Embed")
    print("=" * 60)

    print("\n[1/3] Loading and chunking the document...")
    chunks = load_and_chunk(DOC_PATH)
    print(f"      Split into {len(chunks)} chunks (~{CHUNK_WORDS} words each, {OVERLAP}-word overlap)")
    for i, c in enumerate(chunks):
        print(f"\n  Chunk {i + 1}: \"{c[:90]}...\"")

    print("\n[2/3] Embedding each chunk with all-MiniLM-L6-v2...")
    from sentence_transformers import SentenceTransformer
    model      = SentenceTransformer("all-MiniLM-L6-v2")
    embeddings = model.encode(chunks, show_progress_bar=False)

    print(f"\n      Each chunk → a vector of {embeddings.shape[1]} numbers")
    print(f"\n      Sample — Chunk 1, first 8 values:")
    print(f"      {[round(x, 4) for x in embeddings[0][:8].tolist()]}")
    print(f"\n      ↳ 'AI tool usage policy' and 'student AI guidelines' produce")
    print(f"        vectors close together in this 384-dimensional space.")
    print(f"        That proximity IS semantic similarity — no keywords needed.")

    print("\n[3/3] Storing in FAISS index...")
    import faiss
    dim   = embeddings.shape[1]
    index = faiss.IndexFlatL2(dim)
    index.add(embeddings.astype(np.float32))
    faiss.write_index(index, INDEX_PATH)

    with open(CHUNKS_PATH, "w") as f:
        json.dump(chunks, f)

    print(f"\n      Index  → {INDEX_PATH}")
    print(f"      Chunks → {CHUNKS_PATH}")
    print("\n" + "=" * 60)
    print(f"  Knowledge base ready. {len(chunks)} chunks indexed.")
    print("=" * 60)


if __name__ == "__main__":
    main()
PYEOF

# ── retrieve.py ───────────────────────────────────────────────────────────────
cat > /root/demo/retrieve.py << 'PYEOF'
#!/usr/bin/env python3
"""Step 3 — Retrieve relevant chunks by semantic similarity. No LLM involved."""
import sys
import json
import numpy as np

INDEX_PATH  = "/root/demo/gnits.index"
CHUNKS_PATH = "/root/demo/gnits_chunks.json"
TOP_K       = 3

query = " ".join(sys.argv[1:]) if len(sys.argv) > 1 \
    else "What is the AI tool usage policy for students?"


def main():
    print("=" * 60)
    print("STEP 3 — Retrieval (no LLM)")
    print("=" * 60)
    print(f"\nQuery: \"{query}\"")

    import faiss
    from sentence_transformers import SentenceTransformer

    index = faiss.read_index(INDEX_PATH)
    with open(CHUNKS_PATH) as f:
        chunks = json.load(f)

    print("\n[1/2] Embedding the query...")
    model = SentenceTransformer("all-MiniLM-L6-v2")
    q_vec = model.encode([query]).astype(np.float32)

    print(f"[2/2] Searching {index.ntotal} chunk vectors for top {TOP_K} matches...")
    distances, indices = index.search(q_vec, k=TOP_K)

    print(f"\n── Top {TOP_K} retrieved chunks ──────────────────────────────")
    for rank, (idx, dist) in enumerate(zip(indices[0], distances[0]), 1):
        similarity = round(1 / (1 + dist), 4)
        print(f"\n  Rank {rank}  (similarity score: {similarity})")
        print(f"  \"{chunks[idx][:220]}...\"")

    print("\n" + "=" * 60)
    print("  No Claude was called. No API request was made.")
    print("  This is pure cosine geometry — maths, not language.")
    print("=" * 60)


if __name__ == "__main__":
    main()
PYEOF

# ── no_rag.py ─────────────────────────────────────────────────────────────────
cat > /root/demo/no_rag.py << 'PYEOF'
#!/usr/bin/env python3
"""Step 4 — Ask Claude directly with no document context."""
import os
import sys
import anthropic

query = " ".join(sys.argv[1:]) if len(sys.argv) > 1 \
    else "What is GNITS's policy on student use of AI tools in coursework?"


def main():
    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        print("ERROR: ANTHROPIC_API_KEY is not set.")
        print("Run:  export ANTHROPIC_API_KEY=sk-ant-...")
        sys.exit(1)

    print("=" * 60)
    print("STEP 4 — Without RAG (direct LLM call, no context)")
    print("=" * 60)
    print(f"\nQuery: \"{query}\"")
    print("\nCalling Claude — no document context provided...\n")
    print("── Claude's answer ─────────────────────────────────────\n")

    client = anthropic.Anthropic(api_key=api_key)
    with client.messages.stream(
        model="claude-sonnet-4-6",
        max_tokens=350,
        messages=[{"role": "user", "content": query}],
    ) as stream:
        for text in stream.text_stream:
            print(text, end="", flush=True)

    print("\n\n" + "=" * 60)
    print("  Claude doesn't know GNITS's specific policies.")
    print("  This document was never in its training data.")
    print("  Next: watch what changes when we give it the context.")
    print("=" * 60)


if __name__ == "__main__":
    main()
PYEOF

# ── rag_pipeline.py ───────────────────────────────────────────────────────────
cat > /root/demo/rag_pipeline.py << 'PYEOF'
#!/usr/bin/env python3
"""Step 5 — Full RAG pipeline: embed query → retrieve → augment → generate."""
import os
import sys
import json
import numpy as np
import anthropic
import faiss
from sentence_transformers import SentenceTransformer

INDEX_PATH  = "/root/demo/gnits.index"
CHUNKS_PATH = "/root/demo/gnits_chunks.json"
TOP_K       = 3

query = " ".join(sys.argv[1:]) if len(sys.argv) > 1 \
    else "What is GNITS's policy on student use of AI tools in coursework?"


def main():
    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        print("ERROR: ANTHROPIC_API_KEY is not set.")
        sys.exit(1)

    print("=" * 60)
    print("STEP 5 — Full RAG Pipeline")
    print("=" * 60)
    print(f"\nQuery: \"{query}\"")

    # ── 1. Retrieve ──────────────────────────────────────────────────────────
    print("\n[1/3] Embedding query and retrieving relevant chunks...")
    index = faiss.read_index(INDEX_PATH)
    with open(CHUNKS_PATH) as f:
        chunks = json.load(f)

    model = SentenceTransformer("all-MiniLM-L6-v2")
    q_vec = model.encode([query]).astype(np.float32)
    distances, indices = index.search(q_vec, k=TOP_K)

    retrieved = [chunks[i] for i in indices[0]]
    for rank, chunk in enumerate(retrieved, 1):
        print(f"      Chunk {rank}: \"{chunk[:80]}...\"")

    # ── 2. Augment ───────────────────────────────────────────────────────────
    context = "\n\n---\n\n".join(retrieved)
    system_prompt = (
        "You are a helpful assistant answering questions about GNITS institutional policies. "
        "Answer ONLY using the context provided below. Be specific and cite details from the context. "
        "If the context does not contain the answer, respond with: "
        "'This information is not covered in the provided document.'\n\n"
        f"CONTEXT:\n{context}"
    )

    print(f"\n[2/3] Augmenting prompt with {len(retrieved)} retrieved chunks...")
    print(f"      System prompt size: {len(system_prompt)} characters")

    # ── 3. Generate ──────────────────────────────────────────────────────────
    print("\n[3/3] Calling Claude with augmented prompt...\n")
    print("── Claude's RAG answer ─────────────────────────────────\n")

    client = anthropic.Anthropic(api_key=api_key)
    with client.messages.stream(
        model="claude-sonnet-4-6",
        max_tokens=450,
        system=system_prompt,
        messages=[{"role": "user", "content": query}],
    ) as stream:
        for text in stream.text_stream:
            print(text, end="", flush=True)

    print("\n\n" + "=" * 60)
    print("  Retrieve -> Augment -> Generate")
    print("  The LLM answered from your document, not from training data.")
    print("=" * 60)


if __name__ == "__main__":
    main()
PYEOF

chmod +x /root/demo/chunk_embed.py /root/demo/retrieve.py \
         /root/demo/no_rag.py /root/demo/rag_pipeline.py

echo "background setup complete" > /tmp/background_done
