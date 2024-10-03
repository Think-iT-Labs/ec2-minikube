#!/bin/env bash

set -o errexit

while (("$#")); do
  case "$1" in
  --elastic-ip)
    if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
      ELASTIC_IP=$2
      shift 2
    else
      echo "Error: Argument for $1 is missing" >&2
      exit 1
    fi
    ;;
  -* | --*=) # unsupported flags
    echo "Error: Unsupported flag $1" >&2
    exit 1
    ;;
  *) # preserve positional arguments
    PARAMS="$PARAMS $1"
    shift
    ;;
  esac
done

sudo apt update
sudo apt install -y curl apt-transport-https

# Install kubectl
echo "Installing kubectl..."
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
echo "done installing kubectl"

# Install Docker
echo "Installing docker..."
sudo apt install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
echo "done installing docker"

# Install kind
echo "Installing kind..."
sudo snap install go --classic
go install sigs.k8s.io/kind@v0.24.0
sudo mv go/bin/kind /usr/local/bin
echo "done installing kind"

# Start cluster
echo "Starting cluster..."
sudo kind create cluster --config kindConfig.yaml --name=think
