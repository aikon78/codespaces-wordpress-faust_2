#!/bin/bash
# Script per avviare il progetto Faust.js

echo "🚀 Avvio del progetto Faust.js..."

# Carica le variabili d'ambiente
if [ -f .env ]; then
    set -a
    source .env
    set +a
    echo "✅ Variabili d'ambiente caricate"
fi

# Avvia Next.js (invece di faust dev per evitare healthcheck issues)
echo "🌐 Avvio del server Next.js..."
echo ""
echo "📌 Il tuo sito sarà disponibile su:"
if [ -n "$CODESPACE_NAME" ]; then
    echo "   https://${CODESPACE_NAME}-3000.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
else
    echo "   http://localhost:3000"
fi
echo ""
echo "📌 WordPress Admin:"
if [ -n "$CODESPACE_NAME" ]; then
    echo "   https://${CODESPACE_NAME}-8080.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}/wp-admin"
    echo "   Username: admin"
    echo "   Password: admin"
else
    echo "   http://localhost:8080/wp-admin"
fi
echo ""

npx next dev
