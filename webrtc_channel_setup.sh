#!/bin/bash
BASE_DIR="$HOME/VORTEX_OS"
cd "$BASE_DIR" || exit 1
echo "📦 Installeren van aiortc voor beveiligde WebRTC Data Channels..."
pip3 install aiortc --user
echo "✨ Klaar!"
