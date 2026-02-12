#!/bin/bash
# Setup WordPress - eseguire solo se necessario
# Non è bloccante, setup continua anche se timeout

set +e

# Determina il nome corretto del container
WP_CONTAINER=$(docker ps --format '{{.Names}}' | grep 'wordpress-1' | head -1)

if [ -z "$WP_CONTAINER" ]; then
    echo "❌ Container WordPress non trovato!"
    echo "Container attivi:"
    docker ps --format '{{.Names}}'
    exit 1
fi

echo "🚀 Configurazione WordPress per Codespaces..."
echo "📦 Container: $WP_CONTAINER"

# Attendi che WordPress sia pronto (max 30 secondi, poi continua)
echo "⏳ Attendo che WordPress sia pronto (max 30s)..."
for i in {1..15}; do
    if docker exec $WP_CONTAINER curl -s http://localhost > /dev/null 2>&1; then
        echo "✅ WordPress è pronto"
        break
    fi
    sleep 2
done

# Determina gli URL corretti
if [ -n "$CODESPACE_NAME" ]; then
    WP_URL="https://${CODESPACE_NAME}-8080.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
    SITE_URL="https://${CODESPACE_NAME}-3000.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
else
    WP_URL="http://localhost:8080"
    SITE_URL="http://localhost:3000"
fi

echo "🌐 WordPress URL: $WP_URL"
echo "🌐 Site URL: $SITE_URL"

# Installa WordPress se non è già installato
if ! docker exec $WP_CONTAINER wp core is-installed --allow-root 2>/dev/null; then
    echo "📦 Installazione WordPress..."
    docker exec $WP_CONTAINER wp core install \
        --url="$WP_URL" \
        --title="Headless WordPress" \
        --admin_user="admin" \
        --admin_password="admin" \
        --admin_email="admin@example.com" \
        --skip-email \
        --allow-root 2>/dev/null || echo "⚠️  Problema nell'installazione (forse già installato)"
    echo "✅ WordPress configurato"
else
    echo "✅ WordPress già installato"
fi

# Aggiorna gli URL
echo "🔧 Aggiornamento URL..."
docker exec $WP_CONTAINER wp option update home "$WP_URL" --allow-root 2>/dev/null
docker exec $WP_CONTAINER wp option update siteurl "$WP_URL" --allow-root 2>/dev/null

# Configura permalink
echo "🔧 Configurazione permalink..."
docker exec $WP_CONTAINER wp rewrite structure '/%postname%/' --allow-root 2>/dev/null

# Installa e attiva WPGraphQL
echo "📦 WPGraphQL..."
docker exec $WP_CONTAINER wp plugin install wp-graphql --activate --allow-root 2>/dev/null

# Installa e attiva FaustWP
echo "📦 FaustWP..."
docker exec $WP_CONTAINER wp plugin install faustwp --activate --allow-root 2>/dev/null

# Configura FaustWP con secret key
echo "🔧 Configurazione FaustWP..."
if [ -n "$FAUST_SECRET_KEY" ]; then
    docker exec $WP_CONTAINER wp option update faustwp_settings "{\"frontend_uri\":\"$SITE_URL\",\"secret_key\":\"$FAUST_SECRET_KEY\"}" --format=json --allow-root 2>/dev/null
else
    docker exec $WP_CONTAINER wp option update faustwp_settings "{\"frontend_uri\":\"$SITE_URL\"}" --format=json --allow-root 2>/dev/null
fi

echo ""
echo "✅ Setup completato!"
echo ""
echo "📌 Informazioni di accesso:"
echo "   WordPress Admin: $WP_URL/wp-admin"
echo "   Username: admin"
echo "   Password: admin"
echo ""
echo "   GraphQL Endpoint: $WP_URL/index.php?graphql"
echo "   Frontend Faust: $SITE_URL"
echo ""
echo "🎯 Prossimi passi:"
echo "   1. Esporta le variabili d'ambiente:"
if [ -n "$CODESPACE_NAME" ]; then
    echo "      export NEXT_PUBLIC_WORDPRESS_URL=\"$WP_URL\""
    echo "      export NEXT_PUBLIC_SITE_URL=\"$SITE_URL\""
fi
echo "   2. Genera i types: npm run generate"
echo "   3. Avvia il dev server: npm run dev"
echo ""
