#!/usr/bin/env bash

# Description: A script for building a GitHub runner image
# Author : jaquiteme

set -e

IMAGE_NAME="${1:-gh-runner:latest}"
# We will prefer using podman as its support rootless by default
CT_RUNTIME="${2:-podman}"

echo "====== Build Runner Image ======"

if command -v podman &> /dev/null && test "${CT_RUNTIME}" = "podman"; then
    echo "=> Using Podman"
    podman build -t "${IMAGE_NAME}" -f runner/Dockerfile
    podman image list --filter reference="${IMAGE_NAME}"
elif command -v docker &> /dev/null && test "${CT_RUNTIME}" == "docker"; then
    echo "=> Using Docker"
    sudo docker build -t "${IMAGE_NAME}" -f runner/Dockerfile
    sudo docker image list --filter reference="${IMAGE_NAME}"
else
    echo "No container engine found. Please consider installing podman or docker"
    exit 1
fi