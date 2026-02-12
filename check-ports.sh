#!/bin/bash
# Script per verificare e configurare le porte di Codespaces

echo "🔍 Verifica configurazione porte..."
echo ""

# Verifica se siamo in Codespaces
if [ -z "$CODESPACE_NAME" ]; then
    echo "⚠️  Non siamo in un Codespace"
    exit 1
fi

echo "📌 URLs del progetto:"
echo ""
echo "Frontend Faust.js:"
echo "  https://${CODESPACE_NAME}-3000.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
echo ""
echo "WordPress Admin:"
echo "  https://${CODESPACE_NAME}-8080.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}/wp-admin"
echo "  Username: admin"
echo "  Password: admin"
echo ""
echo "phpMyAdmin:"
echo "  https://${CODESPACE_NAME}-8081.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
echo ""
echo "GraphQL Endpoint:"
echo "  https://${CODESPACE_NAME}-8080.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}/index.php?graphql"
echo ""
echo "⚠️  IMPORTANTE:"
echo "Se WordPress non è accessibile, devi cambiare la visibilità della porta:"
echo "1. Apri il pannello PORTS in VS Code (in basso)"
echo "2. Click destro sulla porta 8080 (WordPress)"
echo "3. Seleziona 'Port Visibility' → 'Public'"
echo ""
