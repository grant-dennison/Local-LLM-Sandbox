#!/bin/bash

set -eux

GGUF_FILE=$1
OLLAMA_QUANT=${2:-auto}

MODEL_ID=$(echo "$GGUF_FILE" | sed "s/\.gguf$//")
# See https://github.com/ollama/ollama/blob/main/docs/import.md
cat > Modelfile <<EOF
FROM ${GGUF_FILE}
EOF
if [ "$OLLAMA_QUANT" = auto ]; then
  ollama create "$MODEL_ID"
else
  ollama create --quantize "$OLLAMA_QUANT" "$MODEL_ID"
fi
