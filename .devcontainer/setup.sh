#!/bin/bash

echo "🚀 Setting up WordPress + Faust.js Development Environment..."

# Create .env.local if it doesn't exist
if [ ! -f .env.local ]; then
    echo "📝 Creating .env.local file..."
    cp .env.local.sample .env.local
    sed -i 's|NEXT_PUBLIC_WORDPRESS_URL=.*|NEXT_PUBLIC_WORDPRESS_URL=http://localhost:8080|' .env.local
    sed -i 's|NEXT_PUBLIC_SITE_URL=.*|NEXT_PUBLIC_SITE_URL=http://localhost:3000|' .env.local
    echo "FAUST_SECRET_KEY=your-secret-key-here" >> .env.local
fi

# Wait for WordPress to be ready
echo "⏳ Waiting for WordPress to be ready..."
max_attempts=30
attempt=0
until curl -s http://localhost:8080 > /dev/null 2>&1; do
    attempt=$((attempt + 1))
    if [ $attempt -eq $max_attempts ]; then
        echo "❌ WordPress failed to start"
        exit 1
    fi
    echo "   Attempt $attempt/$max_attempts..."
    sleep 2
done

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Access WordPress at: http://localhost:8080"
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
echo "   - WordPress: http://localhost:8080"
echo "   - Next.js: http://localhost:3000"
echo "   - phpMyAdmin: http://localhost:8081"
echo ""
