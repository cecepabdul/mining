#!/bin/bash

### =========================
### UPDATE & DEPENDENCY
### =========================
apt update -y
apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  apt-transport-https

### =========================
### INSTALL DOCKER
### =========================
if ! command -v docker &>/dev/null; then
  echo "📦 Install Docker..."
  curl -fsSL https://get.docker.com | bash
else
  echo "✅ Docker sudah terinstall"
fi

### =========================
### ENABLE DOCKER
### =========================
systemctl enable docker
systemctl start docker

docker info >/dev/null 2>&1 || {
  echo "❌ Docker gagal dijalankan"
  exit 1
}
