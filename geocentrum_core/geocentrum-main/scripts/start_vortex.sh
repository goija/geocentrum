#!/bin/bash
echo "🚀 VORTEX OS Systeem & API Lokaal Opstarten..."

# Navigeer naar de hoofdmap (één niveau boven de scripts map)
cd "$(dirname "$0")/.." || exit

# 0. Automatisch oude processen opruimen om poortconflicten te voorkomen
echo "🧹 Bezig met vrijmaken van poorten 8000 en 8080..."
fuser -k 8000/tcp 2>/dev/null
fuser -k 8080/tcp 2>/dev/null
sleep 1

# 1. Start Front-end webserver (poort 8000)
echo "🌐 Front-end webserver starten op poort 8000..."
python3 -m http.server 8000 &
sleep 1

# 2. Start Back-end API server (poort 8080)
echo "⚙️ Back-end Python API server starten op poort 8080..."
python3 rekenkernen/python_scripts/server_api.py &
sleep 1

# 3. Open de webbrowser naar het hoofdmenu
echo "🗺️ VORTEX OS Hoofdmenu openen in je browser..."
if command -v xdg-open &> /dev/null; then
    xdg-open "http://localhost:8000/"
elif command -v sensible-browser &> /dev/null; then
    sensible-browser "http://localhost:8000/"
else
    echo "🔗 Open handmatig in je browser: http://localhost:8000/"
fi

echo "✅ Beide servers (Frontend + Backend API) zijn succesvol gestart!"
