#!/bin/bash

set -eux

# See https://stackoverflow.com/a/246128/4639640
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

find "$GGUF_DIR" -type f -name "*.gguf" > /tmp/gguf-files.txt

while read GGUF_FILE; do
  MODEL_ID=$(realpath --relative-to="$GGUF_DIR" "$GGUF_FILE" | sed "s/\.gguf$//")
  # See https://github.com/ollama/ollama/blob/main/docs/import.md
#   cat > Modelfile <<EOF
# FROM $("${SCRIPT_DIR}/get-gguf-path.sh" "$MODEL_ID" "$LLAMA_CPP_QUANT" "$OLLAMA_QUANT")
# EOF
  cat > Modelfile <<EOF
FROM ${GGUF_FILE}
EOF
  if [ "${OLLAMA_QUANT:-auto}" = auto ]; then
    ollama create "$MODEL_ID"
  else
    ollama create --quantize "$OLLAMA_QUANT" "$MODEL_ID"
  fi
done < /tmp/gguf-files.txt
