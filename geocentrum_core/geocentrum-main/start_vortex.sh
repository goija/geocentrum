#!/bin/bash
echo "🚀 VORTEX OS Geocentrum Opstarten..."

echo "[1/4] Oude processen opschonen (Poort 8000, 8080 & 8081)..."
sudo fuser -k 8000/tcp 2>/dev/null
sudo fuser -k 8080/tcp 2>/dev/null
sudo fuser -k 8081/tcp 2>/dev/null
sleep 2

echo "[2/4] Podcast RSS Server (Rust) starten (Poort 8081)..."
cd ~/podcast-rss-server || echo "❌ Podcast map niet gevonden"
cargo run &
sleep 3

echo "[3/4] Python API Backend starten (Poort 8000)..."
cd /home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main || echo "❌ Geocentrum map niet gevonden"
python3 server_api.py &
sleep 2

echo "[4/4] Statische Webserver starten (Poort 8080)..."
cd /home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main
python3 -m http.server 8080 &
sleep 2

echo "🗺️ VORTEX OS openen in je browser..."
if command -v xdg-open &> /dev/null; then
    xdg-open http://localhost:8080
else
    echo "👉 Open handmatig je browser en ga naar http://localhost:8080"
fi

echo "✅ Systeem is online. Sluit dit venster of druk op CTRL+C om te stoppen."
wait
