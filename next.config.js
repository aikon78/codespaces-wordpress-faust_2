const { withFaust } = require("@faustwp/core");

/**
 * Get dynamic image domains based on environment
 */
function getImageDomains() {
  const domains = [];
  
  // Add localhost for local development
  domains.push('localhost');
  domains.push('wordpress');
  
  // Add Codespaces domain if available
  if (process.env.CODESPACE_NAME && process.env.GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN) {
    domains.push(`${process.env.CODESPACE_NAME}-8080.${process.env.GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}`);
  }
  
  // Add custom WordPress URL domain if provided
  if (process.env.NEXT_PUBLIC_WORDPRESS_URL) {
    try {
      const url = new URL(process.env.NEXT_PUBLIC_WORDPRESS_URL);
      domains.push(url.hostname);
    } catch (e) {
      console.warn('Invalid NEXT_PUBLIC_WORDPRESS_URL:', e.message);
    }
  }
  
  return [...new Set(domains)]; // Remove duplicates
}

/**
 * @type {import('next').NextConfig}
 **/
module.exports = withFaust({
  images: {
    domains: getImageDomains(),
  },
  trailingSlash: true,
});
