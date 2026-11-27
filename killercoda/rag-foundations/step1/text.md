## Step 1 — API Setup & Dependencies

Activate the virtual environment and configure your API key.

```bash
source /root/venv/bin/activate
```

```bash
export ANTHROPIC_API_KEY=sk-ant-YOUR-KEY-HERE
```

Verify all three packages installed correctly:

```bash
python3 -c "import sentence_transformers, faiss, anthropic; print('All packages ready')"
```

Confirm the embedding model is cached and ready:

```bash
python3 -c "
from sentence_transformers import SentenceTransformer
m = SentenceTransformer('all-MiniLM-L6-v2')
print(f'Model ready — output dimension: {m.get_sentence_embedding_dimension()}')
"
```

You should see: `Model ready — output dimension: 384`

Preview the document we'll query throughout this lab:

```bash
cat /root/demo/gnits_policy.txt
```

This is a GNITS institutional policy document — entirely fictional, never published online, and definitively absent from Claude's training data. That's what makes it the right RAG test case.
