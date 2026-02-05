#!/bin/bash

# Connetti il socket Docker
if [ -S /var/run/docker-host.sock ]; then
    ln -sf /var/run/docker-host.sock /var/run/docker.sock 2>/dev/null || true
fi

# Installa docker CLI se non presente
if ! command -v docker &> /dev/null; then
    echo "Installazione Docker CLI..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
fi

echo "✅ Docker disponibile"
