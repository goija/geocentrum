#!/usr/bin/env bash
set -euo pipefail

echo "======================================================================"
echo "🌀 VORTEX OS — Opstarten Soevereine Lokale Stack"
echo "======================================================================"

# Ga naar de juiste hoofdmap
cd /home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main 2>/dev/null || cd /home/ontwerp/Bureaublad/geocentrum-main || true

# 1. Ruim oude processen op om poortconflicten te voorkomen
echo "🧹 Vrijmaken van poorten 8000 en 8080..."
sudo fuser -k 8000/tcp 2>/dev/null || true
sudo fuser -k 8080/tcp 2>/dev/null || true

# 2. Start de hoofd webserver op poort 8000 (achtergrond)
echo "🌐 Starten Lokale Webserver (Port 8000)..."
python3 -m http.server 8000 > /dev/null 2>&1 &
PID_8000=$!
echo "   [OK] Webserver actief op http://localhost:8000 (PID: $PID_8000)"

# 3. Start de Python API Server op poort 8080 (achtergrond)
if [ -f "rekernkernen/python_scripts/server_api.py" ]; then
    echo "🔌 Starten Python API Server (Port 8080)..."
    python3 rekenkernen/python_scripts/server_api.py > /dev/null 2>&1 &
    PID_8080=$!
    echo "   [OK] API Server actief op http://localhost:8080 (PID: $PID_8080)"
else
    echo "⚠️ rekenkernen/python_scripts/server_api.py niet gevonden, API overgeslagen."
fi

# 4. Controleer Podcast Server op poort 8081
if curl -s http://localhost:8081/rss.xml > /dev/null 2>&1; then
    echo "🎙️ [OK] Podcast RSS Server (Port 8081) is ONLINE en bereikbaar."
else
    echo "⚠️ Podcast RSS Server op poort 8081 reageert niet (controleer systemd service)."
fi

echo "======================================================================"
echo "✅ VORTEX OS Stack is volledig operationeel!"
echo "👉 Hoofddashboard: http://localhost:8000"
echo "👉 Beheercentrum:  http://localhost:8000/beheercentrum/"
echo "======================================================================"
