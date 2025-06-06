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

if ! git remote | grep -q origin; then
  git remote add origin "$REPO_URL"
fi

# Checkout or create the deploy branch based on remote existence
if git ls-remote --exit-code --heads origin "$DEPLOY_BRANCH"; then
  git fetch origin "$DEPLOY_BRANCH"
  git checkout -B "$DEPLOY_BRANCH" origin/"$DEPLOY_BRANCH"
else
  git checkout -B "$DEPLOY_BRANCH"
fi

touch .nojekyll
git add .

if git diff --cached --quiet; then
  echo "No changes to deploy."
else
  git commit -m "🚀 Deploy: $(date '+%Y-%m-%d %H:%M:%S')"
  git push origin "$DEPLOY_BRANCH"
fi

# Cleanup temporary git info
rm -rf .git

# currently we are inside marketing-site/$BUILD_DIR/$DIST_DIR. ../.. takes us back up to marking-site
cd ../..  # return to project root

echo "✅ Deployed to GitHub Pages!"
echo "🌐 https://namesrhardtothinkof.github.io/marketing-site/"