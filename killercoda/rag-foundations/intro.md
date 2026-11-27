# RAG Foundations — Build from Scratch

Large language models are powerful — but they don't know your documents.

A model trained on the entire internet still cannot answer questions about:
- Your institution's internal policies
- A patient's medical record
- A company's private knowledge base
- Yesterday's news

**Retrieval Augmented Generation (RAG)** solves this by giving the model access to relevant document fragments at query time — without retraining.

In this lab, you'll build a complete RAG system from scratch using three packages:
- **fastembed** — convert text into 384-dimensional semantic vectors
- **FAISS** — store and search those vectors (Facebook AI Similarity Search)
- **Claude (Anthropic)** — generate answers grounded in retrieved content

The document you'll query: a fictional GNITS institutional policy that Claude has never seen and cannot know.

No LangChain. No cloud vector database. Every step is explicit Python.

---

*The environment is setting up in the background. The embedding model (~90 MB) is being downloaded and cached — this takes about 60 seconds. Read ahead while it completes.*
