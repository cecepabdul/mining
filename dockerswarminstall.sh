#!/bin/bash
set -e

### =========================
### VALIDASI ARGUMENT
### =========================
MANAGER_IP="$1"
SWARM_JOIN_TOKEN="$2"
SWARM_ROLE="${3:-worker}"
SWARM_MANAGER_PORT="2377"

if [[ -z "$MANAGER_IP" || -z "$SWARM_JOIN_TOKEN" ]]; then
  echo "❌ Usage:"
  echo "  $0 <manager_ip> <join_token> [worker|manager]"
  exit 1
fi

if [[ "$SWARM_ROLE" != "worker" && "$SWARM_ROLE" != "manager" ]]; then
  echo "❌ Role harus 'worker' atau 'manager'"
  exit 1
fi

### =========================
### CEK ROOT
### =========================
if [[ "$EUID" -ne 0 ]]; then
  echo "❌ Jalankan sebagai root"
  exit 1
fi

echo "🚀 Install Docker + Join Swarm"
echo "➡ Manager : $MANAGER_IP"
echo "➡ Role    : $SWARM_ROLE"

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

### =========================
### JOIN SWARM
### =========================
if docker info | grep -q "Swarm: active"; then
  echo "ℹ️ Node sudah tergabung dalam Swarm"
  docker info | grep "Swarm:"
  exit 0
fi

echo "🔗 Join Swarm sebagai $SWARM_ROLE..."

docker swarm join \
  --token "$SWARM_JOIN_TOKEN" \
  "$MANAGER_IP:$SWARM_MANAGER_PORT"

echo "🎉 Join Swarm berhasil!"
docker info | grep "Swarm:"
