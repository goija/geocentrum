#!/bin/bash
BASE_DIR="$HOME/VORTEX_OS"
cd "$BASE_DIR" || exit 1

if [ ! -d "venv" ]; then
    echo "❌ Fout: Geen venv gevonden. Draai eerst de pipeline builder."
    exit 1
fi

echo "🚀 Starten van de beveiligde WebRTC Data Channel test..."
./venv/bin/python3 test_webrtc_channel.py
echo "✨ Test voltooid!"
