# Devcontainer Configuration for Faust.js

This directory contains the configuration for GitHub Codespaces and VS Code Dev Containers.

## What's Included

- **Node.js LTS**: Pre-configured with the latest LTS version of Node.js
- **VS Code Extensions**: Essential extensions for Next.js, React, GraphQL, and Faust.js development
- **Port Forwarding**: Automatic forwarding of port 3000 for the development server
- **Auto-setup**: Automatically runs `npm install` and creates `.env.local` from the sample file

## Getting Started

### Using GitHub Codespaces

1. Click the "Code" button on the GitHub repository
2. Select "Codespaces" tab
3. Click "Create codespace on [branch]"
4. Wait for the container to build and initialize
5. Once ready, update `.env.local` with your WordPress URL
6. Run `npm run dev` to start the development server

### Using VS Code Dev Containers

1. Install the "Dev Containers" extension in VS Code
2. Open the repository folder in VS Code
3. Click "Reopen in Container" when prompted (or use Command Palette: "Dev Containers: Reopen in Container")
4. Wait for the container to build
5. Once ready, update `.env.local` with your WordPress URL
6. Run `npm run dev` to start the development server

## Environment Configuration

After the container is created, you'll need to configure your environment variables in `.env.local`:

- `NEXT_PUBLIC_WORDPRESS_URL`: Your WordPress site URL
- `FAUST_SECRET_KEY`: Your Faust plugin secret (optional)
- `NEXT_PUBLIC_SITE_URL`: Your frontend URL (defaults to http://localhost:3000)

## Available Commands

- `npm run dev` - Start the development server
- `npm run build` - Build for production
- `npm run start` - Start production server
- `npm run format` - Format code with Prettier
- `npm run generate` - Generate GraphQL possible types
