#!/bin/bash
# Verify ANTHROPIC_API_KEY is set and SDK is importable
if [ -z "$ANTHROPIC_API_KEY" ]; then
  echo "ANTHROPIC_API_KEY is not set. Run: export ANTHROPIC_API_KEY=\"your-key\""
  exit 1
fi
python3 -c "import anthropic" 2>/dev/null
if [ $? -ne 0 ]; then
  echo "Anthropic SDK not found. Wait a moment and try again."
  exit 1
fi
exit 0
