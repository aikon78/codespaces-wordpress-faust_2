const { withFaust } = require("@faustwp/core");

/**
 * @type {import('next').NextConfig}
 **/
module.exports = withFaust({
  images: {
    domains: ["faustexample.wpengine.com", "localhost"],
    remotePatterns: [
      {
        protocol: "https",
        hostname: "**.githubpreview.dev",
      },
      {
        protocol: "https",
        hostname: "**.app.github.dev",
      },
    ],
  },
  trailingSlash: true,
});
