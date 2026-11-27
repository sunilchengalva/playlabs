#!/bin/bash
[ -n "$ANTHROPIC_API_KEY" ] && \
  source /root/venv/bin/activate 2>/dev/null && \
  python3 -c "import sentence_transformers, faiss, anthropic" 2>/dev/null
