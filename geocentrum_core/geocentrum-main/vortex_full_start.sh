#!/bin/bash
# ======================================================================
# VORTEX OS - Complete Start- en Herstelscript
# ======================================================================

PORT=8080

echo "======================================================================"
echo "🌀 VORTEX OS - Systeembeheer & Opstartprocedure"
echo "======================================================================"

# 1. Controleer en geef poort 8080 vrij
PID=$(sudo lsof -t -i :$PORT | head -n 1)

if [ -n "$PID" ]; then
    echo "⚠️ Poort $PORT is in gebruik door proces PID: $PID."
    echo "🔄 Bezig met automatisch opschonen..."
    sudo kill -9 "$PID" 2>/dev/null
    sleep 1
    echo "✅ Poort $PORT is vrijgegeven."
else
    echo "✅ Poort $PORT is volledig vrij."
fi

# 2. Zoek automatisch de map waar server_api.py zich bevindt
echo "🔍 Zoeken naar server_api.py..."
SCRIPT_PATH=$(find "$HOME/Bureaublad" -name "server_api.py" -print -quit)

if [ -n "$SCRIPT_PATH" ]; then
    SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
    echo "📂 Gevonden in map: $SCRIPT_DIR"
    cd "$SCRIPT_DIR" || exit 1
    echo "🚀 Start server_api.py op poort $PORT..."
    python3 server_api.py "$PORT"
else
    echo "❌ Fout: Kan 'server_api.py' niet vinden op je Bureaublad!"
    exit 1
fi
