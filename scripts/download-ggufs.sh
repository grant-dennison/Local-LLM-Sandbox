#!/bin/bash

set -eux

# See https://stackoverflow.com/a/246128/4639640
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

while read MODEL_ID LLAMA_CPP_QUANT; do
  # GGUF_FILE=$("${SCRIPT_DIR}/get-gguf-path.sh" "$MODEL_ID" "$LLAMA_CPP_QUANT" "$OLLAMA_QUANT")
  GGUF_FILE="${GGUF_DIR}/${MODEL_ID}.gguf"
  if [ ! -f "${GGUF_FILE}" ]; then
    python3 "${SCRIPT_DIR}/download-hf.py" "$MODEL_ID" repos
    mkdir -p "$(dirname "${GGUF_FILE}")"
    # I was using "auto" always here for the outtype, but one of the times it wasn't accepted by ollama
    python3 "convert_hf_to_gguf.py" "repos/${MODEL_ID}" --outfile "${GGUF_FILE}" --outtype "$LLAMA_CPP_QUANT"
  else
    echo "${GGUF_FILE} already exists"
  fi
done
