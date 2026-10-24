#!/usr/bin/env bash
set -euo pipefail

cd ~/VORTEX_OS
echo "================================================================"
echo " VORTEX OS v161.0 // MONTE CARLO BELL + TSIRELSON + WEBRTC"
echo "================================================================"

if ! pgrep -f "http.server 8080" >/dev/null 2>&1; then
  nohup python3 -m http.server 8080 --bind 127.0.0.1 >/dev/null 2>&1 &
  echo "[OK] Localhost server gestart op http://127.0.0.1:8080"
else
  echo "[OK] Localhost poort 8080 draait al."
fi

URL="http://127.0.0.1:8080/vortex_clean_viewports_v158.html"
echo "[OPEN] $URL"
xdg-open "$URL" 2>/dev/null || xdg-open "file:///home/ontwerp/VORTEX_OS/vortex_clean_viewports_v158.html" 2>/dev/null &
