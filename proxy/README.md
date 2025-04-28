# Ollama Proxy

This harness provides a proxy to the ollama server.
If you are going to run aider in a VM but ollama on your host,
you'll need to run the `proxy` or `tunnel` profile in `core` on the host
to ensure that the ollama server can be reached from the VM
and to run this proxy on the VM to ensure that the `ollama-server`
host is available on the non-internet-connected `ollama` network.

## Prerequisites

Run [core harness](../core/) on your host machine with profile `proxy` or `tunnel` enabled.

```sh
docker compose ... --profile proxy ... up -d
docker compose ... --profile tunnel ... up -d
```

## Quick Start

On your VM...

```sh
export OLLAMA_HOST=<ollama (proxy) server IP/host>
docker compose up -d
```
