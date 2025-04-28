# Ollama Proxy

This harness provides a proxy to the ollama server.
If you are going to run aider in a VM but ollama on your host,
you'll need to run the `proxy` profile in `core` on the host
to ensure that the ollama server can be reached from the host
and to run this proxy on the VM to ensure that the `ollama-server`
host is available on the non-internet-connected `ollama` network.

## Prerequisites

Run [core harness](../core/) on your host machine with profile `proxy` enabled.

```sh
docker compose ... --profile proxy ... up -d
```

You may need to set up a reverse SSH tunnel from your host machine to your VM
to get around any firewall issues.

First make sure that you have the following settings set in `/etc/ssh/sshd_config`:

```
GatewayPorts yes
AllowTcpForwarding yes
```

Then:

```sh
ssh -R 11434:127.0.0.1:11434 <SSH connection parameters>
```

## Quick Start

On your VM...

```sh
export OLLAMA_HOST=<ollama (proxy) server IP/host>
docker compose up -d
```
