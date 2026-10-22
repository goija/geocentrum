#!/bin/bash
BASE_DIR="$HOME/VORTEX_OS"
cd "$BASE_DIR" || exit 1

if [ ! -d "venv" ]; then
    echo "📦 Aanmaken van geïsoleerde Python venv (PEP 668 compliant)..."
    python3 -m venv venv
    ./venv/bin/pip install --upgrade pip
    ./venv/bin/pip install aiortc
fi

echo "🚀 Starten van WebRTC DataChannel test..."
./venv/bin/python3 test_webrtc_channel.py
