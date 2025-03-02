#!/bin/bash

set -eux

# See https://stackoverflow.com/a/246128/4639640
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

while read MODEL_ID; do
  ollama pull "$MODEL_ID"
done
