# Ollama Core Harness

This docker compose setup is designed to enable running ollama
with local LLMs in an untrusted fashion.
That is, the harness keeps the trusted dependencies to a minimum:

- Docker
- `nginx` container

## Quick Start

Pull a model from ollama:

```sh
docker compose run ollama-pull qwen2.5-coder:0.5b
```

Start up the ollama server:

```sh
docker compose --profile gpu --profile web-ui --profile proxy up -d
# This should show warnings.
docker exec -it ollama apt update
# This shouldn't work.
docker exec -it ollama ollama pull qwen2.5-coder:7b
```

Visit the Chat web app (provided with `--profile web-ui`) at [127.0.0.1:11380](http://127.0.0.1:11380).
