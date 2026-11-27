#!/bin/bash
[ -n "$ANTHROPIC_API_KEY" ] && \
  /root/venv/bin/python3 -c "import sentence_transformers, faiss, anthropic" 2>/dev/null
