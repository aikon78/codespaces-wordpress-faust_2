#!/bin/bash

echo "🔄 Riavvio WordPress..."
echo ""

# Trova il container WordPress e riavvialo
CONTAINER_ID=$(docker ps -q --filter "ancestor=wordpress:6-apache" --filter "status=running" 2>/dev/null | head -n1)

if [ -n "$CONTAINER_ID" ]; then
    echo "📦 Container WordPress trovato: $CONTAINER_ID"
    echo "   Riavvio in corso..."
    docker restart "$CONTAINER_ID"
    echo "✅ WordPress riavviato!"
    echo ""
    echo "🌐 Apri WordPress: https://redesigned-space-meme-5r544rq5vhp75p-8080.app.github.dev"
    echo "   Gli URL dovrebbero ora essere corretti (niente localhost!)"
else
    echo "⚠️  Container WordPress non trovato in esecuzione"
    echo ""
    echo "Prova a riavviare il Codespace:"
    echo "   1. Chiudi questo Codespace"
    echo "   2. Riaprilo da GitHub"
    echo "   3. WordPress si avvierà con gli URL corretti"
fi

echo ""
