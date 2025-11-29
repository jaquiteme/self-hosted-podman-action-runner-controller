#!/usr/bin/env bash

# Description: A script to install podman on a host
# Author : jaquiteme

set -e

echo "====== Install Podman ======"

if command -v apt-get &> /dev/null; then
    echo "The host is Debian based distro"
    sudo apt-get update
    sudo apt-get -y install podman
elif command -v dnf &> /dev/null; then
    echo "The host is Fedora based distro"
    sudo dnf update
    sudo dnf -y install podman
elif command -v yum &> /dev/null; then
    echo "The host is RHEL based distro"
    sudo yum update
    sudo yum -y install podman
else
    echo "The package manager of this host has not been detected."
    echo "You should check on https://podman.io/docs/installation and install podman manualy."
    exit 1
fi

# Check if podman is properly installed
podman --version
echo "Podman is successfully installed."

echo "====== Podman User Socket API Service ======"
systemctl --user enable --now podman.socket
systemctl --user status podman.socket
