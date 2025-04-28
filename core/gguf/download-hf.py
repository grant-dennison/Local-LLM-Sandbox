import sys
from huggingface_hub import snapshot_download

if len(sys.argv) < 3:
    print("Usage: python download-model.py <model_id> <models_dir>")
    sys.exit(1)

model_id = sys.argv[1]
models_dir = sys.argv[2]
snapshot_download(repo_id=model_id, local_dir=f"{models_dir}/{model_id}")
