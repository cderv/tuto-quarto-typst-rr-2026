#!/bin/bash
set -euo pipefail

# Only run in remote (Claude Code web) environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Wire up the tracked .gitconfig so commits use the correct identity
git config --local include.path ../.gitconfig

# Run remaining setup asynchronously so the session starts immediately
echo '{"async": true, "asyncTimeout": 300000}'

# Install Quarto 1.9+ if not already installed
QUARTO_VERSION="1.9.36"

if command -v quarto &> /dev/null; then
  INSTALLED_VERSION=$(quarto --version)
  if [ "$INSTALLED_VERSION" = "$QUARTO_VERSION" ]; then
    exit 0
  fi
fi

echo "Installing Quarto ${QUARTO_VERSION}..."
curl -sL "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb" -o /tmp/quarto.deb
dpkg -i /tmp/quarto.deb
rm /tmp/quarto.deb
echo "Quarto $(quarto --version) installed."
