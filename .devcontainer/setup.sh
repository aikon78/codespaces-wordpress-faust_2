#!/bin/bash
set -e

echo "🚀 Faust.js + WordPress Setup"

# Determina gli URL SUBITO
if [ -n "$CODESPACE_NAME" ]; then
    WP_URL="https://${CODESPACE_NAME}-8080.app.github.dev"
    SITE_URL="https://${CODESPACE_NAME}-3000.app.github.dev"
else
    WP_URL="http://localhost:8080"
    SITE_URL="http://localhost:3000"
fi

echo "WordPress: $WP_URL"
echo "Next.js:   $SITE_URL"
echo ""

# IMPORTANTE: Crea il file .env DENTRO .devcontainer/ per docker-compose
ENV_FILE=".devcontainer/.env"
echo "📝 Creating $ENV_FILE for docker-compose..."
cat > "$ENV_FILE" << ENVEOF
WORDPRESS_URL=${WP_URL}
NEXT_PUBLIC_WORDPRESS_URL=${WP_URL}
NEXT_PUBLIC_SITE_URL=${SITE_URL}
ENVEOF

echo "✅ $ENV_FILE created"
echo ""

# IMPORTANTE: Esporta le variabili per il shell corrente
export WORDPRESS_URL="${WP_URL}"
export NEXT_PUBLIC_WORDPRESS_URL="${WP_URL}"
export NEXT_PUBLIC_SITE_URL="${SITE_URL}"

echo "📋 Environment variables exported:"
echo "   WORDPRESS_URL=${WP_URL}"
echo "   NEXT_PUBLIC_WORDPRESS_URL=${WP_URL}"
echo "   NEXT_PUBLIC_SITE_URL=${SITE_URL}"
echo ""

# Crea .env.local per il Next.js app (nella root del workspace)
ENV_LOCAL_FILE=".env.local"
cat > "$ENV_LOCAL_FILE" << ENVEOF
NEXT_PUBLIC_WORDPRESS_URL=${WP_URL}
NEXT_PUBLIC_SITE_URL=${SITE_URL}
FAUST_SECRET_KEY=your-secret-key-here
ENVEOF

echo "✅ $ENV_LOCAL_FILE created for Next.js"
echo ""

# Se la cartella wordpress è vuota, scarica i file
if [ ! -f "wordpress/index.php" ]; then
    echo "📥 Downloading WordPress files..."
    mkdir -p wordpress
    cd wordpress
    
    # Scarica WordPress 6 latest
    curl -s https://wordpress.org/latest.zip -o wp-latest.zip
    unzip -q wp-latest.zip
    
    # Sposta i file da wordpress/ alla root, ma esclude wp-content (se esiste già)
    if [ -d "wordpress/wp-content" ] && [ -d "../wordpress/wp-content" ]; then
        # wp-content esiste già, non sovrascrivere
        rm -rf wordpress/wp-content
    fi
    
    mv wordpress/* .
    rm -rf wordpress wp-latest.zip
    
    # Copia wp-config-sample.php e prepara per Docker
    cp wp-config-sample.php wp-config.php
    
    cd ..
    echo "✅ WordPress files downloaded"
    echo ""
fi

echo "✅ Setup complete - WordPress will use: $WP_URL"
