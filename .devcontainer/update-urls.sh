#!/bin/bash

# Update WordPress URLs on every container start (for Codespaces)
if [ -n "$CODESPACE_NAME" ] && [ -n "$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN" ]; then
    WP_URL="https://${CODESPACE_NAME}-8080.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
    
    echo "🔄 Updating WordPress URLs to: ${WP_URL}"
    
    # Wait a moment for WordPress to be ready
    sleep 3
    
    # Update the database if tables exist
    mysql -h wordpress -u wordpress -pwordpress wordpress 2>/dev/null << EOF
UPDATE wp_options SET option_value = '${WP_URL}' WHERE option_name IN ('siteurl', 'home');
EOF
    
    if [ $? -eq 0 ]; then
        echo "✅ WordPress URLs updated"
    fi
fi
