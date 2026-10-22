#!/bin/bash
BASE_DIR="$HOME/VORTEX_OS"
cd "$BASE_DIR" || exit 1

echo "🔄 [1/3] Controleren van configuratie en mappenstructuur..."
if [ ! -f "config.json" ]; then
    echo "❌ Fout: config.json ontbreekt in de hoofdmap."
    exit 1
fi

echo "🧹 [2/3] Vrijmaken van actieve beheerpoorten (8082)..."
sudo fuser -k 8082/tcp 2>/dev/null

echo "🚀 [3/3] Starten van de real-time pipeline en webserver..."
python3 start_services.py --start-beheer
