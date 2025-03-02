# Local LLM Sandbox

This is my personal work of messing around with local LLMs.

## Models

* High-speed low-end: Qwen2.5 Coder 0.5B
  * ollama `qwen2.5-coder:0.5b`
  * GGUF: https://huggingface.co/Qwen/Qwen2.5-Coder-0.5B-Instruct-GGUF
* High-speed low-end general: [tinyllama](https://ollama.com/library/tinyllama)
  * https://huggingface.co/TinyLlama/TinyLlama-1.1B-Chat-v1.0
* Popular choice: [StarCoder](https://huggingface.co/collections/bigcode/starcoder2-65de6da6e87db3383572be1a)
* Others' model comparisons:
  * https://itsfoss.com/llms-for-raspberry-pi/
  * https://www.datacamp.com/blog/top-small-language-models
  * https://www.analyticsvidhya.com/blog/2024/04/smallest-llms-that-you-can-run-on-local-devices/
* Leaderboard with helpful filtering: https://huggingface.co/spaces/open-llm-leaderboard/open_llm_leaderboard#/?params=0%2C1

`-Instruct` and `-Chat` labeled models seem to be the ones that are appropriate
for ChatGPT-style interfaces. Some other types are for lower-level stuff.
There was one I tried in Jan that didn't work right because it was another flavor.

GGUF models seem to be required for client tools, but they are not always available.
I found this article: https://www.geeksforgeeks.org/how-to-convert-any-huggingface-model-to-gguf-file-format/
(also https://github.com/ggml-org/llama.cpp/discussions/2948)
that provided a working way to get most any huggingface model as gguf.
[llama.cpp](https://github.com/ggml-org/llama.cpp) also has
[a thing on huggingface](https://huggingface.co/spaces/ggml-org/gguf-my-repo)
that apparently can do that for you?
The implementation in this repository is based on the article.

## ollama

```sh
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
docker exec -it ollama ollama pull qwen2.5-coder:0.5b
docker exec -it ollama ollama run qwen2.5-coder:0.5b
```

Extensions:

* Continue: https://continue.dev/
  * Performance seems bad.
  * Hard to figure out models to use
    * Chat models: https://docs.continue.dev/customize/model-roles/chat
    * Autocomplete models: https://docs.continue.dev/customize/deep-dives/autocomplete
  * I couldn't get live autocomplete working, though I could get *really* slow
    on-demand (with key-bind-triggered auto-complete) working,
    though the lack of feedback along the way was annoying.
  * There seemed to be some wonkiness with the edit UI, that I couldn't get working right.
* Cline: https://docs.cline.bot/running-models-locally/ollama
  * Looks cool, but I couldn't get it working with the lowest end models

Possible UIs:

* https://github.com/ollama/ollama?tab=readme-ov-file#web--desktop
* https://github.com/open-webui/open-webui was oof large (long startup; admin setup required on boot)

## llama.cpp VS Code

```sh
docker run --rm -it -v llama.cpp:/models -p 8012:8012 ghcr.io/ggml-org/llama.cpp:server -hf ggml-org/Qwen2.5-Coder-0.5B-Q8_0-GGUF --port 8012 -ub 1024 -b 1024 --ctx-size 0 --cache-reuse 256
```

Extension: https://marketplace.visualstudio.com/items?itemName=ggml-org.llama-vscode
aka: https://github.com/ggml-org/llama.vscode

I think this is the setup that worked most reliably (performantly) for inline auto-completion.

This extension is super young though, so I'm not sure it's ready to use?

## Tabby

Focused on central server approach and all-in-one.

Useful picks of models:

* https://tabby.tabbyml.com/docs/models/
* https://leaderboard.tabbyml.com

Haven't actually run this one yet, so I'm not sure how it performs.

## End User Chat-GPT-esque tools

* Jan: https://jan.ai/
* LM Studio: https://lmstudio.ai/
  * Not free for professional use
