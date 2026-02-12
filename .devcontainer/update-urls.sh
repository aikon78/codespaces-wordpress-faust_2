#!/bin/bash

# Update WordPress URLs and .env.local on every container start (for Codespaces)
if [ -n "$CODESPACE_NAME" ] && [ -n "$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN" ]; then
    WP_URL="https://${CODESPACE_NAME}-8080.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
    SITE_URL="https://${CODESPACE_NAME}-3000.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
    
    echo "🔄 Updating URLs to: ${WP_URL}"
    
    # Update .env.local with current Codespace URLs
    if [ -f .env.local ]; then
        echo "📝 Updating .env.local..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "s|NEXT_PUBLIC_WORDPRESS_URL=.*|NEXT_PUBLIC_WORDPRESS_URL=${WP_URL}|" .env.local
            sed -i '' "s|NEXT_PUBLIC_SITE_URL=.*|NEXT_PUBLIC_SITE_URL=${SITE_URL}|" .env.local
        else
            sed -i "s|NEXT_PUBLIC_WORDPRESS_URL=.*|NEXT_PUBLIC_WORDPRESS_URL=${WP_URL}|" .env.local
            sed -i "s|NEXT_PUBLIC_SITE_URL=.*|NEXT_PUBLIC_SITE_URL=${SITE_URL}|" .env.local
        fi
        echo "✅ .env.local updated"
    fi
    
    # Check if mysql client is available
    if ! command -v mysql &> /dev/null; then
        echo "⚠️  MySQL client not installed, skipping database URL update"
        exit 0
    fi
    
    # Wait a moment for WordPress to be ready
    sleep 3
    
    # Update the database if tables exist
    mysql -h wordpress -u wordpress -pwordpress wordpress 2>/dev/null << EOF
UPDATE wp_options SET option_value = '${WP_URL}' WHERE option_name IN ('siteurl', 'home');
EOF
    
    if [ $? -eq 0 ]; then
        echo "✅ WordPress database URLs updated"
    else
        echo "⚠️  Database not ready yet (will retry on next start)"
    fi
fi
