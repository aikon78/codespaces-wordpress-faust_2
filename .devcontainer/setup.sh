#!/bin/bash

echo "🚀 Setting up WordPress + Faust.js Development Environment..."

# Detect if running in Codespaces and set URLs accordingly
if [ -n "$CODESPACE_NAME" ] && [ -n "$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN" ]; then
    echo "📍 Detected GitHub Codespaces environment"
    WP_URL="https://${CODESPACE_NAME}-8080.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
    SITE_URL="https://${CODESPACE_NAME}-3000.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
    PHPMYADMIN_URL="https://${CODESPACE_NAME}-8081.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
    HEALTH_CHECK_URL="http://wordpress:80"
else
    echo "📍 Detected local development environment"
    WP_URL="http://localhost:8080"
    SITE_URL="http://localhost:3000"
    PHPMYADMIN_URL="http://localhost:8081"
    HEALTH_CHECK_URL="http://localhost:8090"
fi

# Create .env.local if it doesn't exist
if [ ! -f .env.local ]; then
    echo "📝 Creating .env.local file..."
    cp .env.local.sample .env.local
    # Use a cross-platform sed approach
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s|NEXT_PUBLIC_WORDPRESS_URL=.*|NEXT_PUBLIC_WORDPRESS_URL=${WP_URL}|" .env.local
        sed -i '' "s|NEXT_PUBLIC_SITE_URL=.*|NEXT_PUBLIC_SITE_URL=${SITE_URL}|" .env.local
    else
        sed -i "s|NEXT_PUBLIC_WORDPRESS_URL=.*|NEXT_PUBLIC_WORDPRESS_URL=${WP_URL}|" .env.local
        sed -i "s|NEXT_PUBLIC_SITE_URL=.*|NEXT_PUBLIC_SITE_URL=${SITE_URL}|" .env.local
    fi
    echo "FAUST_SECRET_KEY=your-secret-key-here" >> .env.local
fi

# Wait for WordPress to be ready
echo "⏳ Waiting for WordPress to be ready..."
max_attempts=60
attempt=0
until curl -s ${HEALTH_CHECK_URL} > /dev/null 2>&1; do
    attempt=$((attempt + 1))
    if [ $attempt -eq $max_attempts ]; then
        echo "⚠️  WordPress connection timeout (continuing anyway)"
        break
    fi
    echo "   Attempt $attempt/$max_attempts..."
    sleep 2
done

echo ""
echo "✅ WordPress is ready!"

# Update WordPress URLs in database (critical for Codespaces)
if [ -n "$CODESPACE_NAME" ]; then
    echo "🔧 Updating WordPress URLs in database..."
    
    # Install mysql-client if not present
    if ! command -v mysql &> /dev/null; then
        echo "📦 Installing MySQL client..."
        sudo apt-get update -qq && sudo apt-get install -y -qq mysql-client > /dev/null 2>&1
    fi
    
    # Update the database
    mysql -h wordpress -u wordpress -pwordpress wordpress 2>/dev/null << EOF || echo "⚠️  Database update skipped (WordPress not initialized yet)"
UPDATE wp_options SET option_value = '${WP_URL}' WHERE option_name = 'siteurl';
UPDATE wp_options SET option_value = '${WP_URL}' WHERE option_name = 'home';
EOF
    
    if [ $? -eq 0 ]; then
        echo "✅ WordPress URLs updated to: ${WP_URL}"
    fi
fi

echo ""
echo "📋 Next steps:"
echo "   1. Access WordPress at: ${WP_URL}"
echo "   2. Complete WordPress installation"
echo "   3. Install FaustWP plugin from WordPress admin:"
echo "      - Go to Plugins > Add New"
echo "      - Search for 'FaustWP'"
echo "      - Install and activate"
echo "   4. Configure FaustWP in WordPress Settings > Headless"
echo "   5. Copy the secret key to .env.local"
echo "   6. Start Next.js with: npm run dev"
echo ""
echo "🔗 Useful URLs:"
echo "   - WordPress: ${WP_URL}"
echo "   - Next.js: ${SITE_URL}"
echo "   - phpMyAdmin: ${PHPMYADMIN_URL}"
echo ""
