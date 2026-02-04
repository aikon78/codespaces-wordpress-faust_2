#!/bin/bash
set -e

echo "🔧 WordPress URL Fix per Codespaces"
echo "===================================="
echo ""

# Determina l'URL corretto
if [ -n "$CODESPACE_NAME" ]; then
    WP_URL="https://${CODESPACE_NAME}-8080.app.github.dev"
    SITE_URL="https://${CODESPACE_NAME}-3000.app.github.dev"
else
    WP_URL="http://localhost:8080"
    SITE_URL="http://localhost:3000"
fi

echo "WordPress URL: $WP_URL"
echo "Frontend URL:  $SITE_URL"
echo ""

# Aggiorna .env per docker-compose
echo "📝 Step 1: Aggiornamento file .env per Docker..."
cat > .devcontainer/.env << ENVEOF
WORDPRESS_URL=${WP_URL}
NEXT_PUBLIC_WORDPRESS_URL=${WP_URL}
NEXT_PUBLIC_SITE_URL=${SITE_URL}
ENVEOF
echo "✅ File .devcontainer/.env aggiornato"
echo ""

# Aggiorna .env.local per Next.js
echo "📝 Step 2: Aggiornamento .env.local per Next.js..."
if [ -f .env.local ]; then
    # Mantieni FAUST_SECRET_KEY se esiste
    SECRET_KEY=$(grep FAUST_SECRET_KEY .env.local | cut -d'=' -f2 || echo "your-secret-key-here")
else
    SECRET_KEY="your-secret-key-here"
fi

cat > .env.local << ENVEOF
NEXT_PUBLIC_WORDPRESS_URL=${WP_URL}
NEXT_PUBLIC_SITE_URL=${SITE_URL}
FAUST_SECRET_KEY=${SECRET_KEY}
ENVEOF
echo "✅ File .env.local aggiornato"
echo ""

# Crea wp-config.php personalizzato se WordPress è installato
if [ -f wordpress/wp-config.php ]; then
    echo "📝 Step 3: Aggiornamento wp-config.php..."
    
    # Backup
    cp wordpress/wp-config.php wordpress/wp-config.php.backup
    
    # Aggiungi le definizioni di URL se non ci sono già
    if ! grep -q "WP_HOME" wordpress/wp-config.php; then
        # Trova la riga con "That's all, stop editing!"
        sed -i "/That's all, stop editing/i\\
/* URL personalizzati per Codespaces */\\
define('WP_HOME', '${WP_URL}');\\
define('WP_SITEURL', '${WP_URL}');\\
" wordpress/wp-config.php
        echo "✅ wp-config.php aggiornato"
    else
        # Aggiorna gli URL esistenti
        sed -i "s|define('WP_HOME',.*|define('WP_HOME', '${WP_URL}');|" wordpress/wp-config.php
        sed -i "s|define('WP_SITEURL',.*|define('WP_SITEURL', '${WP_URL}');|" wordpress/wp-config.php
        echo "✅ wp-config.php URL aggiornati"
    fi
else
    echo "⚠️  WordPress non ancora installato (wp-config.php non trovato)"
fi
echo ""

echo "📝 Step 4: Aggiornamento database WordPress..."
echo "   (Questo funziona solo se WordPress è già installato)"
echo ""

# Installa mysql client se necessario
if ! command -v mysql &> /dev/null; then
    echo "   Installazione MySQL client..."
    sudo apt-get update -qq 2>/dev/null && sudo apt-get install -y -qq default-mysql-client 2>/dev/null
fi

# Prova ad aggiornare il database
echo "   Tentativo di connessione al database..."
if mysql -h db -u wordpress -pwordpress -e "SELECT 1" &> /dev/null 2>&1; then
    mysql -h db -u wordpress -pwordpress wordpress << EOF 2>/dev/null
UPDATE wp_options SET option_value = '${WP_URL}' WHERE option_name = 'siteurl';
UPDATE wp_options SET option_value = '${WP_URL}' WHERE option_name = 'home';
EOF
    
    if [ $? -eq 0 ]; then
        echo "✅ Database aggiornato con successo!"
    else
        echo "⚠️  Impossibile aggiornare il database (WordPress potrebbe non essere installato)"
    fi
else
    echo "⚠️  Database non raggiungibile"
    echo "   Il database verrà aggiornato automaticamente quando WordPress sarà installato"
fi

echo ""
echo "======================================"
echo "✅ Configurazione completata!"
echo ""
echo "🔗 URL configurati:"
echo "   WordPress: ${WP_URL}"
echo "   Frontend:  ${SITE_URL}"
echo ""
echo "📋 Prossimi passi:"
echo "   1. Se WordPress non è installato, aprilo e completa l'installazione:"
echo "      ${WP_URL}"
echo "   2. Installa i plugin: FaustWP e WPGraphQL"
echo "   3. In WordPress Settings → Headless, imposta Frontend URL a:"
echo "      ${SITE_URL}"
echo "   4. Copia la secret key in .env.local"
echo "   5. Avvia Next.js: npm run dev"
echo ""
