#!/bin/sh

docker run --rm -it --network ollama --user $(id -u):$(id -g) --volume $(pwd):/app paulgauthier/aider
