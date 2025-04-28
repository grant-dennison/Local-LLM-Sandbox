#!/bin/bash

set -eux

MODEL_ID=$1
LLAMA_CPP_QUANT=${2:-auto}

# See https://stackoverflow.com/a/246128/4639640
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

GGUF_FILE="${GGUF_DIR}/${MODEL_ID}.gguf"
if [ ! -f "${GGUF_FILE}" ]; then
  if [ ! -e "${HF_DIR}/${MODEL_ID}" ]; then
    python3 "${SCRIPT_DIR}/download-hf.py" "$MODEL_ID" "$HF_DIR"
  fi
  mkdir -p "$(dirname "${GGUF_FILE}")"
  # I was using "auto" always here for the outtype, but one of the times it wasn't accepted by ollama
  python3 "convert_hf_to_gguf.py" "${HF_DIR}/${MODEL_ID}" --outfile "${GGUF_FILE}" --outtype "$LLAMA_CPP_QUANT"
else
  echo "${GGUF_FILE} already exists"
fi
