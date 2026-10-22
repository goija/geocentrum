#!/bin/bash
BASE_DIR="$HOME/VORTEX_OS"
cd "$BASE_DIR" || exit 1

echo "📦 [1/3] Automatische Tijdscapsule back-up aanmaken..."
./tijdscapsule_backup.sh

echo "🧹 [2/3] Vrijmaken van poort 8082..."
sudo fuser -k 8082/tcp 2>/dev/null

echo "🚀 [3/3] Starten van de VORTEX OS Markdown-Server op poort 8082..."
python3 server_met_markdown.py
