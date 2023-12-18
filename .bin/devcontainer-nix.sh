#!/usr/bin/env bash
set -euxo pipefail

cd ~/src/root/dotfiles
image=$(docker load --quiet < $(nix-build devcontainer.nix) | awk '{print $NF}')
echo nix-image: $image
docker build -f Dockerfile-nix -t acadx0/tools:devcontainer --build-arg BASE_IMAGE=$image .
docker push acadx0/tools:devcontainer
