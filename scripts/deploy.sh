#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/opt/ai-platform"

if [ ! -d "$APP_DIR/.git" ]; then
  sudo mkdir -p "$APP_DIR"
  sudo chown -R "$USER":"$USER" "$APP_DIR"
  git clone https://github.com/<YOUR_GITHUB>/<YOUR_REPO>.git "$APP_DIR"
fi

cd "$APP_DIR"
git fetch --all
git reset --hard origin/main

cd app
docker compose pull
docker compose up -d

# basic health checks
curl -fsS http://localhost:3000 >/dev/null
echo "✅ OpenWebUI is responding on localhost:3000"
