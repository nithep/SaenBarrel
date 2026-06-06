#!/bin/bash
# Hermes Config Sync Script
# Syncs Hermes config from SaenBarrel repo to local .hermes/
# Run this on Pi after pulling SaenBarrel updates

set -e

REPO_DIR="/home/admin/SaenBarrel"
HERMES_DIR="/home/admin/.hermes"

echo "Syncing Hermes config from SaenBarrel repo..."

# Backup current config
if [ -f "$HERMES_DIR/config.yaml" ] && [ ! -L "$HERMES_DIR/config.yaml" ]; then
    cp "$HERMES_DIR/config.yaml" "$HERMES_DIR/config.yaml.bak.$(date +%Y%m%d_%H%M%S)"
    echo "  Backed up current config"
fi

# Symlink config from repo
if [ -f "$REPO_DIR/config/hermes-pi-config.yaml" ]; then
    ln -sf "$REPO_DIR/config/hermes-pi-config.yaml" "$HERMES_DIR/config.yaml"
    echo "  Symlinked config.yaml from repo"
fi

# Sync .env if exists
if [ -f "$REPO_DIR/config/hermes-pi.env" ]; then
    ln -sf "$REPO_DIR/config/hermes-pi.env" "$HERMES_DIR/.env"
    echo "  Symlinked .env from repo"
fi

echo "Config sync complete."
echo ""
echo "Current config:"
head -5 "$HERMES_DIR/config.yaml"
