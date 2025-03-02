#!/bin/bash

set -euo pipefail

MODEL_ID=$1
LLAMA_CPP_QUANT=$2

GGUF_FILE="$(echo "$MODEL_ID" | tr '/' '_').${LLAMA_CPP_QUANT}.gguf"
echo "${GGUF_DIR}/${GGUF_FILE}"
