# Ollama Proxy

The passthrough proxy listens on port `11434` and forwards to the same port
on the actual ollama server.
The reason for doing this is that it allows the ollama server to remain
isolated in a non-internet-connected network, only leaving the `nginx`
container touching the host network.
