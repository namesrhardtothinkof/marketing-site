#!/bin/bash

set -e  # Exit on any error

SOURCE_DIR="new-marketing-site"
BUILD_DIR="_site"
DEPLOY_BRANCH="gh-pages"
REPO_URL="git@github.com:namesrhardtothinkof/marketing-site.git"

echo "📦 Installing Ruby gems..."
cd "$SOURCE_DIR"
bundle install

echo "🏗️ Building Jekyll site..."
bundle exec jekyll build

echo "🚚 Preparing to deploy..."

cd "$BUILD_DIR"

# Initialize a temporary git repo in _site
git init > /dev/null
git remote add origin "$REPO_URL"
git checkout -b "$DEPLOY_BRANCH"

# Prevent GitHub from ignoring certain files
touch .nojekyll

git add .
git commit -m "🚀 Deploy: $(date '+%Y-%m-%d %H:%M:%S')"
git push --force origin "$DEPLOY_BRANCH"

# Cleanup temporary git info
rm -rf .git

# currently we are inside marketing-site/$BUILD_DIR/$DIST_DIR. ../.. takes us back up to marking-site
cd ../..  # return to project root

echo "✅ Deployed to GitHub Pages!"
echo "🌐 https://namesrhardtothinkof.github.io/marketing-site/"