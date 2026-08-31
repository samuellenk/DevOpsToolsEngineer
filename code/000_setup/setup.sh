#!/usr/bin/env bash
set -euo pipefail

# Determine the non-root user running sudo
REAL_USER=${SUDO_USER:-$(whoami)}

echo "==> Updating package indices..."
apt update && apt install -y ca-certificates curl gnupg

echo "==> Setting up Docker repository..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Linux Mint 22 maps to Ubuntu Noble (noble)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu noble stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "==> Installing Docker Engine & CLI..."
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "==> Configuring Docker group for ${REAL_USER}..."
usermod -aG docker "${REAL_USER}"

echo "==> Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

echo "==> Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

echo "==> Installation complete!"
echo "NOTE: Log out and back in (or run 'newgrp docker') for docker group privileges to apply."
echo "Then start Minikube using: minikube start --driver=docker"
echo "Verify installed versions using:"
echo "docker version"
echo "minikube version"
echo "kubectl version"
