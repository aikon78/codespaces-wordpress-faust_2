#!/bin/bash
set -e

echo "🔧 Fixing WordPress URLs..."

# Determina l'URL corretto
if [ -n "$CODESPACE_NAME" ]; then
    WP_URL="https://${CODESPACE_NAME}-8080.app.github.dev"
else
    WP_URL="http://localhost:8080"
fi

echo "Setting WordPress URL to: $WP_URL"

# Controlla se il database è accessibile
if ! command -v mysql &> /dev/null; then
    echo "❌ MySQL client not found. Installing..."
    sudo apt-get update -qq && sudo apt-get install -y -qq default-mysql-client
fi

# Aspetta che il database sia pronto
echo "⏳ Waiting for database..."
for i in {1..30}; do
    if mysql -h db -u wordpress -pwordpress -e "SELECT 1" &> /dev/null; then
        echo "✅ Database is ready"
        break
    fi
    if [ $i -eq 30 ]; then
        echo "❌ Database timeout"
        exit 1
    fi
    sleep 2
done

# Aggiorna gli URL nel database
echo "📝 Updating WordPress URLs in database..."
mysql -h db -u wordpress -pwordpress wordpress << EOF
UPDATE wp_options SET option_value = '${WP_URL}' WHERE option_name = 'siteurl';
UPDATE wp_options SET option_value = '${WP_URL}' WHERE option_name = 'home';
EOF

if [ $? -eq 0 ]; then
    echo "✅ WordPress URLs updated successfully to: ${WP_URL}"
else
    echo "⚠️  Could not update URLs (WordPress may not be installed yet)"
fi
