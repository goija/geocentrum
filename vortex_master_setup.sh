#!/bin/bash
BASE_DIR="$HOME/VORTEX_OS"
cd "$BASE_DIR" || { echo "❌ Fout: map $BASE_DIR bestaat niet."; exit 1; }

echo "📂 [1/6] Aanmaken van mappenstructuur..."
mkdir -p beheercentrum docs/beheer/blue_team docs/beheer/red_team rekencentrum/tijdscapsule

echo "✨ Alle mappen en structuren zijn gereed!"
