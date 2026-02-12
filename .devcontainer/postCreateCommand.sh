#!/bin/bash
set -e

echo "🔧 Post-create setup..."

# Installa dipendenze npm
echo "📦 Installazione dipendenze npm..."
npm install

echo "✅ Setup iniziale completato!"
echo ""
echo "⏳ L'installazione di WordPress continuerà in background..."
echo "   Controlla il log del container con: docker logs devcontainer-wordpress-1"
echo ""
