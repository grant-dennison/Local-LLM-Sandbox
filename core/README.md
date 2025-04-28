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
docker compose --profile gpu --profile web-ui up -d
# This should show warnings.
docker exec -it ollama apt update
# This shouldn't work.
docker exec -it ollama ollama pull qwen2.5-coder:7b
```

Visit the Chat web app (optionally provided with `--profile web-ui`) at [127.0.0.1:11380](http://127.0.0.1:11380).

## GPU Setup

You can verify that your Docker installation has GPU access
(compatible with this project's setup) by running the following command:

```sh
docker run --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark
```

You should see your GPU appear in the output if it is accessible.

To enable nvidia GPU usage on a Windows PC, I ran the following setup
after installing [`docker-ce`](https://docs.docker.com/engine/install/ubuntu/)
(vs. `docker.io` or [Docker Desktop](https://docs.docker.com/desktop/))
in WSL2 Ubuntu:

```sh
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit nvidia-docker2
nvidia-smi
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
docker run --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark
```

## CPU-Only Setup

If you do not have a GPU to work with, you can use `--profile cpu-only`
instead of `--profile gpu`:

```sh
docker compose --profile cpu-only up -d
```

## Proxy

If you want to expose the ollama server on your host port `11434`,
use `--profile proxy`:

```sh
docker compose --profile gpu --profile proxy up -d
```

## Proxy

If you want to expose the ollama server on another host (e.g. a VM),
use `--profile tunnel`.
This can be particularly useful if you have firewall rules on your host
which prevent the remote host from accessing it.

First make sure that you have the following settings set in
`/etc/ssh/sshd_config` on the remote host:

```
GatewayPorts yes
AllowTcpForwarding yes
```

Before running the profile, you'll need to create a `config` file in
`.ssh/config` (relative to this directory) and `.ssh/id_rsa`
(relative to this directory).
You can get started configuring this by running `cp -r .ssh-template .ssh`.

```sh
cp -r .ssh-template .ssh

# Modify .ssh/config with IP and username of remote host.
# Modify .ssh/id_rsa with private key to SSH into remote host.

docker compose --profile gpu --profile tunnel up -d
```
