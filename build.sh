#!/bin/bash

# Comprehensive Next.js Build Script with Custom Build Folder

# Exit on any error
set -e

# Create build directory if it doesn't exist
mkdir -p build

# Clean previous build
echo "🧹 Cleaning previous build..."
rm -rf build/*

# Install dependencies
echo "📦 Installing dependencies..."
npm ci

# Run type checking
echo "🕵️ Running type checks..."
npm run typecheck

# Run linting
echo "🔍 Running linter..."
npm run lint

# Run tests
echo "🧪 Running tests..."
npm test

# Build the application with custom output directory
echo "🏗️ Building application to 'build' folder..."
next build --output-dir build

# Copy additional necessary files
echo "📂 Copying additional files..."
cp -R public build/public
cp package.json build/
cp package-lock.json build/ 2>/dev/null || true

# Optional: Create a start script in the build folder
echo "#!/bin/bash
npm install --production
node server.js" > build/start.sh
chmod +x build/start.sh

echo "✅ Build completed successfully in 'build' folder!"

# Show build size
echo "📊 Build size:"
du -sh build

exit 0